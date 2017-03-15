#!/usr/bin/perl -w
# static_critter.pl --- Static Critter

use warnings;
use strict;

package Critter;
use Moose;
use MooseX::ClassAttribute;

class_has 'total' => (
    is       => 'rw',
    isa      => 'Int',
    default  => 0,
    init_arg => undef,
    reader   => 'get_total',
);

has 'hunger' => (
    is       => 'rw',
    isa      => 'Int',
    default  => 0,
    reader   => 'get_hunger',
    writer   => 'set_hunger',
);

around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;

    if ( @_ == 1 && !ref $_[0] ) {
        print "A new critter has been born!\n";
        return $class->$orig( hunger => $_[0] );
    } else {
        return $class->$orig(@_);
    }
};

sub BUILD {
    my $self = shift;

    print "A critter has been born!\n";
    $self->total(Critter->total() + 1);
}

around set_hunger => sub {
    my ( $orig, $self, $hunger ) = @_;

    if ( $hunger < 0 ) {
        warn "You can't set a critter's hunger to a negative number.\n\n";
    } else {
        $self->$orig($hunger);
    }
};

no Moose;
__PACKAGE__->meta->make_immutable;

package main;
use Critter;

print "The total number of critters is: ";
print Critter->total(), "\n\n";

my $crit1 = Critter->new();
my $crit2 = Critter->new();
my $crit3 = Critter->new();

print "\nThe total number of critters is: ";
print Critter->total(), "\n";

__END__

=head1 DESCRIPTION

Demonstrates static member variables and functions

=cut
