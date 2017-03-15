#!/usr/bin/perl -w
# simple_critter.pl --- Simple Critter

use warnings;
use strict;

package Critter;
use Moose;

has 'hunger' => (is => 'rw', isa => 'Int');

sub greet {
    my $self = shift;

    print "Hi. I'm a critter. My hunger level is ", $self->hunger, ".\n";
}

no Moose;
__PACKAGE__->meta->make_immutable;

package main;
use Critter;

my $crit1 = Critter->new;
my $crit2 = Critter->new;

$crit1->hunger(9);
print "crit1's hunger level is ", $crit1->hunger, ".\n";

$crit2->hunger(3);
print "crit2's hunger level is ", $crit2->hunger, ".\n\n";

$crit1->greet();
$crit2->greet();

__END__

=head1 DESCRIPTION

Demonstrates creating a new type

=cut
