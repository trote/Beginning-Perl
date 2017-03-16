#!/usr/bin/perl -w
# heap_data_member.pl --- Heap Data Member

use warnings;
use strict;

package Critter;

use Moose;
use MooseX::Privacy;
use Scalar::Util qw( refaddr );

has 'name' => (
    is       => 'rw',
    traits   => [qw/Private/],
    isa      => 'Str',
    default  => '',
    reader   => 'get_name',
);

has 'age' => (
    is       => 'rw',
    traits   => [qw/Private/],
    isa      => 'Int',
    default  => 0,
    reader   => 'get_age',
);

around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;

    if ( @_ == 1 && ref $_[0] ) {
        print "Copy Constructor called\n";
        return $class->$orig( name => $_[0]->get_name, age => $_[0]->get_age );
    } elsif ( @_ == 1 && !ref $_[0] ) {
        print "Constructor called\n";
        return $class->$orig( name => $_[0] );
    } elsif ( @_ == 2 ) {
        print "Constructor called\n";
        return $class->$orig( name => $_[0], age => $_[1] );
    } else {
        print "Constructor called\n";
        return $class->$orig(@_);
    }
};

sub greet {
    my $self = shift;
    
    print "I'm ", $self->get_name(), " and I'm ", $self->get_age(), " years old. ";
    print "&m_pName: ", refaddr(\$self->name), "\n";
}

sub DEMOLISH {
    print "Destructor called\n";
}

sub clone {
    my $self = shift;
    my $other = shift;

    print "Overloaded Assignment Operator called\n";
    if ( \$self != \$other ) {
        $self->name($other->get_name);
        $self->age($other->get_age);
    }
    $self;
}

no Moose;
__PACKAGE__->meta->make_immutable;

package main;

use Critter;

sub test_destructor();
sub test_copy_constructor($);
sub test_assignment_op();

test_destructor();
print "\n";

my $crit = Critter->new("Poochie", 5);
$crit->greet();
test_copy_constructor($crit);
$crit->greet();
print "\n";
    
test_assignment_op();

sub test_destructor() {
    my $to_destroy = Critter->new("Rover", 3);
    $to_destroy->greet();
}

sub test_copy_constructor($) {
    my $a_copy = shift;  

    Critter->new($a_copy);
}

sub test_assignment_op() {
    my $crit1 = Critter->new("crit1", 7);
    my $crit2 = Critter->new("crit2", 9);
    $crit1->clone($crit2);
    $crit1->greet();  
    $crit2->greet();
    print "\n";

    my $crit3 = Critter->new("crit", 11);
    $crit3 = $crit3;
    $crit3->greet();
}

__END__

=head1 DESCRIPTION

Demonstrates an object with a dynamically allocated data member

=cut
