#!/usr/bin/perl -w
# constructor_critter.pl --- Constructor Critter

use warnings;
use strict;

package Critter;
use Moose;

has 'hunger' => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
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

sub greet {
    my $self = shift;

    print "Hi. I'm a critter. My hunger level is ", $self->hunger, ".\n";
}

no Moose;
__PACKAGE__->meta->make_immutable;

package main;
use Critter;

my $crit = Critter->new(7);

$crit->greet();

__END__

=head1 DESCRIPTION

Demonstrates constructors

=cut
