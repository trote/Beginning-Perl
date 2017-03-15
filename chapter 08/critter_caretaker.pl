#!/usr/bin/perl -w
# critter_caretaker.pl --- Critter Caretaker

use warnings;
use strict;

package Critter;
use Moose;
use MooseX::Privacy;

has 'hunger' => (
    is       => 'rw',
    isa      => 'Int',
    default  => 0,
    traits => [qw/Private/],
);

has 'boredom' => (
    is       => 'rw',
    isa      => 'Int',
    default  => 0,
    traits => [qw/Private/],
);


around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;

    if ( @_ == 1 && !ref $_[0] ) {
        return $class->$orig( hunger => $_[0] );
    } elsif ( @_ == 2 ) {
        return $class->$orig( hunger => $_[0], boredom => $_[1] );
    } else {
        return $class->$orig(@_);
    }
};

private_method get_mood => sub {
    my $self = shift;

    $self->hunger + $self->boredom;
};

private_method pass_time => sub {
    my ( $self, $time ) = @_;
    $time //= 1;

    $self->hunger($self->hunger + $time);
    $self->boredom($self->boredom + $time);
};

sub talk {
    my $self = shift;
    
    print "I'm a critter and I feel ";

    my $mood = $self->get_mood();
    if ( $mood > 15 ) {
        print "mad.\n";
    } elsif ( $mood > 10 ) {
        print "frustrated.\n";
    } elsif ( $mood > 5 ) {
        print "okay.\n";
    } else {
        print "happy.\n";
    }

    $self->pass_time();
}

sub eat {
    my ( $self, $food ) = @_;
    $food //= 4;

    print "Brruppp.\n";

    $self->hunger($self->hunger - $food);
    $self->hunger(0) if $self->hunger < 0;

    $self->pass_time();
}

sub play {
    my ( $self, $fun ) = @_;
    $fun //= 4;

    print "Wheee!\n";

    $self->boredom($self->boredom - $fun);
    $self->boredom(0) if $self->boredom < 0;

    $self->pass_time();
}

no Moose;
__PACKAGE__->meta->make_immutable;

package main;

use Switch;
use Critter;

my $crit = Critter->new;
$crit->talk();

my $choice;
do {
    print "\nCritter Caretaker\n\n";
    print "0 - Quit\n";
    print "1 - Listen to your critter\n";
    print "2 - Feed your critter\n";
    print "3 - Play with your critter\n\n";

    print "Choice: ";
    chomp($choice = <STDIN>);

    switch ( $choice ) {
        case 0 { print "Good-bye.\n" }
        case 1 { $crit->talk() }
        case 2 { $crit->eat() }
        case 3 { $crit->play() }
        else   { print "\nSorry, but $choice isn't a valid choice.\n" }
    }
} while ( $choice != 0 );

__END__

=head1 DESCRIPTION

Simulates caring for a virtual pet

=cut
