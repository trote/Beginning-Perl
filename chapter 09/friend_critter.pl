#!/usr/bin/perl -w
# friend_critter.pl --- Friend Critter

use warnings;
use strict;

package Critter;

use Moose;
use Moose::Exporter;
use MooseX::Privacy;
use overload
    q/""/ => sub { $_[0]->get_name() };

Moose::Exporter->setup_import_methods(
    as_is => [ qw/ peek / ],
);

has 'name' => (
    is       => 'rw',
    traits   => [qw/Private/],
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

sub peek {
    my $obj = shift;
    
    print $obj->get_name(), "\n";
}

no Moose;
__PACKAGE__->meta->make_immutable;

package main;

use Critter;

my $crit = Critter->new("Poochie");

print "Calling Peek() to access crit's private data member, m_Name: \n";
peek $crit;
    
print "\nSending crit object to cout with the << operator: ";
print $crit;

__END__

=head1 DESCRIPTION

Demonstrates friend functions and operator overloading

=cut
