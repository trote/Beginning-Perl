#!/usr/bin/perl -w
# abstract_creature.pl --- Abstract Creature

use warnings;
use strict;

package Creature;

use Moose;
use MooseX::Privacy;

has 'health' => (
    is       => 'rw',
    traits   => [qw/Protected/],
    isa      => 'Int',
    default  => 100,
);

around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;

    if ( @_ == 1 && !ref $_[0] ) {
        return $class->$orig( health => $_[0] );
    } else {
        return $class->$orig(@_);
    }
};

sub display_health {
    my $self = shift;
    
    print "Health: ", $self->health, "\n";
}

no Moose;
__PACKAGE__->meta->make_immutable;

package Orc;

use Moose;
use MooseX::Privacy;

extends 'Creature';

around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;

    if ( @_ == 0 ) {
        return $class->$orig( health => 120 );
    } elsif ( @_ == 1 && !ref $_[0] ) {
        return $class->$orig( health => $_[0] );
    } else {
        return $class->$orig(@_);
    }
};

sub greet {
    my $self = shift;
    
    print "The orc grunts hello.\n";
}

no Moose;
__PACKAGE__->meta->make_immutable;

package main;

my $p_creature = Orc->new;
$p_creature->greet();
$p_creature->display_health();

__END__

=head1 DESCRIPTION

Demonstrates abstract classes

=cut
