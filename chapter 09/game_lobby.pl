#!/usr/bin/perl -w
# game_lobby.pl --- Game Lobby

use warnings;
use strict;

package Player;

use Moose;

has 'name' => (
    is       => 'rw',
    isa      => 'Str',
    default  => '',
    reader   => 'get_name',
);

has 'next' => (
    is        => 'rw',
    isa       => 'Player',
    reader    => 'get_next',
    writer    => 'set_next',
    clearer   => 'clear_next',
    predicate => 'has_next',
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

no Moose;
__PACKAGE__->meta->make_immutable;

package Lobby;

use Moose;
use overload
    q/""/ => \&to_string;

has 'head' => (
    is      => 'rw',
    isa     => 'Player',
    reader  => 'get_head',
    writer  => 'set_head',
    clearer => 'clear_head',
);

sub add_player {
    my $self = shift;
    
    # create a new player node
    print "Please enter the name of the new player: ";
    chomp(my $name = <STDIN>);
    my $new_player = Player->new($name);

    # if list is empty, make head of list this new player
    if ( ! defined $self->get_head ) {
        $self->set_head($new_player);
    } else { # otherwise find the end of the list and add the player there
        my $p_iter = $self->get_head;
        while ( $p_iter->get_next ) {
            $p_iter = $p_iter->get_next;
        }
        $p_iter->set_next($new_player);
    }
}

sub remove_player {
    my $self = shift;
    
    if ( ! defined $self->get_head ) {
        print "The game lobby is empty.  No one to remove!\n";
    } else {
        my $p_temp = $self->get_head;
        if ( $p_temp->has_next ) {
            $self->set_head($self->get_head->get_next);
        } else {
            $p_temp->clear_next;
            $self->clear_head;
        }
    }
}

sub clear {
    my $self = shift;
    
    while ( defined $self->get_head ) {
        $self->remove_player;
    }
}

sub to_string {
    my $a_lobby = shift;

    my $p_iter = $a_lobby->get_head;

    my $str = "\nHere's who's in the game lobby:\n";
    if ( ! defined $p_iter ) {
        $str .= "The lobby is empty.\n";
    } else {
        while ( defined $p_iter ) {   
            $str .= $p_iter->get_name . "\n";
            $p_iter = $p_iter->get_next;
        }
    }
    $str;
}

no Moose;
__PACKAGE__->meta->make_immutable;

package main;

use Lobby;
use Switch;

my $lobby = Lobby->new();
my $choice;

do {
    print $lobby;
    print "\nGAME LOBBY\n";
    print "0 - Exit the program.\n";
    print "1 - Add a player to the lobby.\n";
    print "2 - Remove a player from the lobby.\n";
    print "3 - Clear the lobby.\n";
    print "\nEnter choice: ";
    chomp($choice = <STDIN>);

    switch ($choice) {
        case 0 { print "Good-bye.\n" }
        case 1 { $lobby->add_player() } 
        case 2 { $lobby->remove_player() }
        case 3 { $lobby->clear() }
        else   { print "That was not a valid choice.\n" }
    }
} while ( $choice != 0 );

__END__

=head1 DESCRIPTION

Simulates a game lobby where players wait

=cut
