#!/usr/bin/perl -w
# blackjack.pl --- Blackjack

use warnings;
use strict;

package Card;

use v5.10;

use Moose;
use MooseX::Privacy;

use overload
    '""' => \&to_string;

use enum qw( ACE=1 TWO THREE FOUR FIVE SIX SEVEN EIGHT NINE TEN JACK QUEEN KING );
use enum qw( CLUBS DIAMONDS HEARTS SPADES );

has 'rank' => (
    is       => 'rw',
    traits   => [qw/Private/],
    isa      => 'Int',
    default  => ACE,
);

has 'suit' => (
    is       => 'rw',
    traits   => [qw/Private/],
    isa      => 'Int',
    default  => SPADES,
);

has 'is_face_up' => (
    is       => 'rw',
    traits   => [qw/Private/],
    isa      => 'Bool',
    default  => 1,
);

around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;

    if ( @_ == 1 && !ref $_[0] ) {
        return $class->$orig( rank => $_[0] );
    } elsif ( @_ == 2 && !ref $_[0] ) {
        return $class->$orig( rank => $_[0], suit => $_[1] );
    } elsif ( @_ == 3 && !ref $_[0] ) {
        return $class->$orig( rank => $_[0], suit => $_[1], is_face_up => $_[2] );
    } else {
        return $class->$orig(@_);
    }
};

# returns the value of a card, 1 - 11
sub get_value {
    my $self = shift;
    
    # if a card is face down, its value is 0
    my $value = 0;
    if ( $self->is_face_up ) {
        # value is number showing on card
        $value = $self->rank;
        # value is 10 for face cards
        $value = 10 if $value > 10;
    }
    return $value;
}

# flips a card; if face up, becomes face down and vice versa
sub flip {
    my $self = shift;
    
    $self->is_face_up(! $self->is_face_up);
}

sub to_string {
    my $self = shift;

    state $RANKS = [ qw/ 0 A 2 3 4 5 6 7 8 9 10 J Q K / ];
    state $SUITS = [ qw/ c d h s / ];
    my $str;
    if ( $self->is_face_up ) {
        $str = $RANKS->[$self->rank] . $SUITS->[$self->suit];
    } else {
        $str = 'XX';
    }
    $str;
}

no Moose;
__PACKAGE__->meta->make_immutable;

package Hand;

use Moose;

has 'cards' => (
    is       => 'rw',
    traits   => [qw/Protected Array/],
    isa      => 'ArrayRef[Card]',
    default  => sub { [] },
    handles => {
        all_cards     => 'elements',
        add           => 'push',
        remove        => 'pop',
        clear         => 'clear',
        has_no_cards  => 'is_empty',
        get_card      => 'get',
        shuffle_cards => 'shuffle',
        find_card     => 'first',
    },
);

# gets hand total value, intelligently treats aces as 1 or 11
sub get_total {
    my $self = shift;
    
    # if no cards in hand, return 0
    return 0 if $self->has_no_cards;

    # if a first card has value of 0, then card is face down; return 0
    return 0 if $self->get_card(0)->get_value() == 0;

    # add up card values, treat each Ace as 1
    my $total;
    $total += $_->get_value for $self->all_cards;

    # determine if hand contains an Ace
    my $contains_ace = $self->find_card( sub { $_->get_value == Card->ACE } );
          
    # if hand contains Ace and total is low enough, treat Ace as 11
    $total += 10 if $contains_ace and $total <= 11; # add only 10 since we've already added 1 for the Ace

    $total;
}

no Moose;
__PACKAGE__->meta->make_immutable;

package GenericPlayer;

use Moose;
use overload
    '""' => \&to_string;

extends 'Hand';

has 'name' => (
    is       => 'rw',
    traits   => [qw/Protected/],
    isa      => 'Str',
    default  => '',
);

around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;

    if ( @_ == 1 && !ref $_[0] ) {
        return $class->$orig( name => $_[0] );
    } else {
        return $class->$orig(@_);
    }
};

# returns whether generic player has busted - has a total greater than 21
sub is_busted {
    my $self = shift;
    
    $self->get_total() > 21;
}

# announces that the generic player busts
sub bust {
    my $self = shift;
    
    print $self->name, " busts.\n";
}

sub to_string {
    my $self = shift;

    my $str;
    $str = $self->name . ":\t";
    if ( ! $self->has_no_cards ) {
        $str .= "$_\t" for $self->all_cards;
        
        if ( $self->get_total != 0 ) {
            $str .= '(' . $self->get_total . ')';
        }
    } else {
        $str .= "<empty>";
    }
    $str;
}

no Moose;
__PACKAGE__->meta->make_immutable;

package Player;

use Moose;

extends 'GenericPlayer';

around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;

    if ( @_ == 1 && !ref $_[0] ) {
        return $class->$orig( name => $_[0] );
    } else {
        return $class->$orig(@_);
    }
};

# returns whether or not the player wants another hit
sub is_hitting {
    my $self = shift;
    
    print $self->name, ", do you want a hit? (Y/N): ";
    chomp(my $response = <STDIN>);
    $response eq 'y' or $response eq 'Y';
}

# announces that the player wins
sub win {
    my $self = shift;
    
    print $self->name, " wins.\n";
}

# announces that the player loses
sub lose {
    my $self = shift;
    
    print $self->name, " loses.\n";
}

# announces that the player pushes
sub push {
    my $self = shift;
    
    print $self->name, " pushes.\n";
}

no Moose;
__PACKAGE__->meta->make_immutable;

package House;

use Moose;

extends 'GenericPlayer';

around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;

    if ( @_ == 0 ) {
        return $class->$orig( name => 'House' );
    } elsif ( @_ == 1 && !ref $_[0] ) {
        return $class->$orig( name => $_[0] );
    } else {
        return $class->$orig(@_);
    }
};

# indicates whether house is hitting - will always hit on 16 or less
sub is_hitting {
    my $self = shift;
    
    $self->get_total <= 16;
}   

# flips over first card
sub flip_first_card {
    my $self = shift;
    
    if (! $self->has_no_cards )	{
        $self->get_card(0)->flip();
    } else {
        print "No card to flip!\n";
    }
}

no Moose;
__PACKAGE__->meta->make_immutable;

package Deck;

use Moose;

extends 'Hand';

sub BUILD {
    my $self = shift;

    $self->populate();
}

sub populate {
    my $self = shift;
    
    $self->clear();
    # create standard deck
    for my $s ( Card->CLUBS .. Card->SPADES ) {
        for my $r ( Card->ACE .. Card->KING ) {
            $self->add(Card->new($r, $s));
        }
    }
}

# shuffle cards
sub shuffle {
    my $self = shift;

    $self->cards($self->shuffle_cards);
}

# deal one card to a hand
sub deal {
    my ( $self, $a_hand ) = @_;

    if (! $self->has_no_cards ) {
        $a_hand->add($self->remove);
    } else {
        print "Out of cards. Unable to deal.";
    }
}

# give additional cards to a generic player
sub additional_cards {
    my ( $self, $a_generic_player ) = @_;

    print "\n";
    # continue to deal a card as long as generic player isn't busted and
    # wants another hit
    while ( !( $a_generic_player->is_busted()) and $a_generic_player->is_hitting() ) {
        $self->deal($a_generic_player);
        print $a_generic_player, "\n";
        
        $a_generic_player->bust() if $a_generic_player->is_busted();
    }
} 

no Moose;
__PACKAGE__->meta->make_immutable;

package Game;

use Moose;

has 'deck' => (
    is       => 'rw',
    traits   => [qw/Private/],
    isa      => 'Deck',
    default  => sub { Deck->new },
);

has 'house' => (
    is       => 'rw',
    traits   => [qw/Private/],
    isa      => 'House',
    default  => sub { House->new },
);

has 'players' => (
    is       => 'rw',
    traits   => [qw/Protected Array/],
    isa      => 'ArrayRef[Player]',
    default  => sub { [] },
    handles => {
        all_players => 'elements',
    },
);

around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;

    if ( @_ == 1 && ref $_[0] eq "ARRAY" ) {
        # create a vector of players from a vector of names
        my $names = [];
        for my $name ( @{ $_[0] } ) {
            push @$names, Player->new($name);
        }
        return $class->$orig( players => $names );
    } else {
        return $class->$orig(@_);
    }
};

sub BUILD {
    my $self = shift;

    
    $self->deck->populate();
    $self->deck->shuffle();
}

# plays the game of blackjack
sub play {
    my $self = shift;

    # deal initial 2 cards to everyone
    print "deal initial 2 cards to everyone\n";
    for ( 0 .. 1 ) {
        $self->deck->deal($_) for $self->all_players;
        $self->deck->deal($self->house);
    }
    
    # hide house's first card
    $self->house->flip_first_card();    

    # display everyone's hand
    print "$_\n" for $self->all_players;
    print $self->house, "\n";

    # deal additional cards to players
    $self->deck->additional_cards($_) for $self->all_players;

    # reveal house's first card
    $self->house->flip_first_card();
    print "\n", $self->house;
  
    # deal additional cards to house
    $self->deck->additional_cards($self->house);

    if ( $self->house->is_busted() ) {
        # everyone still playing wins
        for my $p_player ( $self->all_players ) {
            $p_player->win() unless $p_player->is_busted();
        }
    } else {
        # compare each player still playing to house
        for my $p_player ( $self->all_players ) {
            unless ( $p_player->is_busted() ) {
                if ( $p_player->get_total() > $self->house->get_total() ) {
                    $p_player->win();
                } elsif ( $p_player->get_total() < $self->house->get_total() ) {
                    $p_player->lose();
                } else {
                    $p_player->push();
                }
            }
        }
    }

    # remove everyone's cards
    $_->clear() for $self->all_players;
    $self->house->clear();
}

no Moose;
__PACKAGE__->meta->make_immutable;

package main;

print "\t\tWelcome to Blackjack!\n\n";

my $num_players = 0;

while ( $num_players < 1 or $num_players > 7 ) {
    print "How many players? (1 - 7): ";
    chomp($num_players = <STDIN>);
}

my @names;
for ( 1 .. $num_players ) {
    print "Enter player name: ";
    chomp(my $name = <STDIN>);
    push @names, $name;
}
print "\n";

my $a_game = Game->new(\@names);
my $again = 'y';
while ( lc $again ne 'n' ) {
    $a_game->play();
    print "\nDo you want to play again? (Y/N): ";
    chomp($again = <STDIN>);
}

__END__

=head1 DESCRIPTION

Plays a simple version of the casino game of blackjack; for 1 - 7 players

=cut
