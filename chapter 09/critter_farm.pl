#!/usr/bin/perl -w
# critter_farm.pl --- Critter Farm

use warnings;
use strict;

package Critter;

use Moose;

has 'name' => (
    is       => 'rw',
    isa      => 'Str',
    default  => '',
    reader   => 'get_name',
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

package Farm;

use Moose;
use MooseX::Privacy;

has 'critters' => (
    is       => 'rw',
    traits   => [qw/Private Array/],
    isa      => 'ArrayRef[Critter]',
    default  => sub { [] },
    lazy     => 1,
    handles  => {
        add => 'push',
    },
);

sub roll_call {
    my $self = shift;

    print $_->get_name(), " here.\n" for @{$self->critters};
}

no Moose;
__PACKAGE__->meta->make_immutable;

package main;

use Critter;
use Farm;

my $crit = Critter->new("Poochie");
print "My critter's name is ", $crit->get_name(), "\n";

print "\nCreating critter farm.\n";

my $farm = Farm->new;

print "\nAdding three critters to the farm.\n";
$farm->add( Critter->new("Moe") );
$farm->add( Critter->new("Larry") );
$farm->add( Critter->new("Curly") );

print "\nCalling Roll...\n";
$farm->roll_call();

__END__

=head1 DESCRIPTION

Demonstrates object containment

=cut
