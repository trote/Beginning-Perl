#!/usr/bin/perl -w
# private_critter.pl --- Private Critter

use warnings;
use strict;

package Critter;
use Moose;

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

my $crit = Critter->new(5);
print "Calling GetHunger(): ", $crit->get_hunger(), "\n\n";
   
print "Calling SetHunger() with -1.\n";
$crit->set_hunger(-1);
    
print "Calling SetHunger() with 9.\n";    
$crit->set_hunger(9);
print "Calling GetHunger(): ", $crit->get_hunger(), "\n\n";

__END__

=head1 DESCRIPTION

Demonstrates setting member access levels

=cut
