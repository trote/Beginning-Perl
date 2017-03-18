#!/usr/bin/perl -w
# overriding_boss.pl --- Overriding Boss

use warnings;
use strict;

package Enemy;

use Moose;
use MooseX::Privacy;

has 'damage' => (
    is       => 'rw',
    traits   => [qw/Private/],
    isa      => 'Int',
    default  => 10,
);

sub attack {
    my $self = shift;
    
    print "Attack inflicts ", $self->damage, " damage points.";
}

sub taunt {
    print "The enemy says he will fight you.\n";
}

no Moose;
__PACKAGE__->meta->make_immutable;

package Boss;

use Moose;
use MooseX::Privacy;

extends 'Enemy';

sub attack {
    my $self = shift;
    
    $self->SUPER::attack();  # call base class member function
    print " And laughs heartily at you.\n";
}

sub taunt {
    print "The boss says he will end your pitiful existence.\n";
}  

no Moose;
__PACKAGE__->meta->make_immutable;

package main;

print "Enemy object:\n";
my $enemy = Enemy->new;
$enemy->taunt();
$enemy->attack();

print "\n\nBoss object:\n";
my $boss = Boss->new;
$boss->taunt();
$boss->attack();

__END__

=head1 DESCRIPTION

Demonstrates calling and overriding base member functions

=cut
