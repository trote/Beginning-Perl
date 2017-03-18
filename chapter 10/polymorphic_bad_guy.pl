#!/usr/bin/perl -w
# polymorphic_bad_guy.pl --- Polymorphic Bad Guy

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

around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;

    if ( @_ == 1 && !ref $_[0] ) {
        return $class->$orig( damage => $_[0] );
    } else {
        return $class->$orig(@_);
    }
};


sub DEMOLISH {
    my $self = shift;
    
    print "In Enemy destructor, deleting m_pDamage.\n";
}

sub attack {
    my $self = shift;
    
    print "An enemy attacks and inflicts ", $self->damage, " damage points.";
}

no Moose;
__PACKAGE__->meta->make_immutable;

package Boss;

use Moose;
use MooseX::Privacy;

extends 'Enemy';

has 'multiplier' => (
    is       => 'rw',
    traits   => [qw/Private/],
    isa      => 'Int',
    default  => 3,
);

around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;

    if ( @_ == 1 && !ref $_[0] ) {
        return $class->$orig( multiplier => $_[0] );
    } else {
        return $class->$orig(@_);
    }
};

sub DEMOLISH {
    my $self = shift;

    print "In Boss destructor, deleting m_pMultiplier.\n";
}

sub attack {
    my $self = shift;
    
    print "A boss attacks and inflicts ", $self->damage * $self->multiplier, " damage points.";
}

no Moose;
__PACKAGE__->meta->make_immutable;

package main;

print "Calling Attack() on Boss object through pointer to Enemy:\n";
my $p_bad_guy = Boss->new();
$p_bad_guy->attack();
   
print "\n\nDeleting pointer to Enemy:\n";
undef $p_bad_guy;

__END__

=head1 DESCRIPTION

Demonstrates calling member functions dynamically

=cut
