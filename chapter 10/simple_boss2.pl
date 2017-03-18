#!/usr/bin/perl -w
# simple_boss2.pl --- Simple Boss 2.0

use warnings;
use strict;

package Enemy;

use Moose;
use MooseX::Privacy;

has 'damage' => (
    is       => 'rw',
    traits   => [qw/Protected/],
    isa      => 'Int',
    default  => 10,
);

sub attack {
    my $self = shift;
    
    print "Attack inflicts ", $self->damage, " damage points!\n";
}

no Moose;
__PACKAGE__->meta->make_immutable;

package Boss;

use Moose;
use MooseX::Privacy;

extends 'Enemy';

has 'damage_multiplier' => (
    is       => 'rw',
    traits   => [qw/Private/],
    isa      => 'Int',
    default  => 3,
);

sub special_attack {
    my $self = shift;
    
    print "Special Attack inflicts ", $self->damage_multiplier * $self->damage; 
    print " damage points!\n";
}

no Moose;
__PACKAGE__->meta->make_immutable;

package main;

print "Creating an enemy.\n";
my $enemy1 = Enemy->new;
$enemy1->attack();

print "\nCreating a boss.\n";
my $boss1 = Boss->new;
$boss1->attack();
$boss1->special_attack();

__END__

=head1 DESCRIPTION

Demonstrates access control under inheritance

=cut
