#!/usr/bin/perl -w
# inventory_displayer.pl --- Inventory Displayer

use warnings;
use strict;

# parameter vec is a constant reference to a vector of strings
sub display($);

my @inventory;
push @inventory, "sword";
push @inventory, "armor";
push @inventory, "shield";
    
display \@inventory;

# parameter vec is a constant reference to a vector of strings
sub display($) {
    my ( $arr ) = @_;
    
    print "Your items:\n";
    print "$_\n" for @$arr;
}


__END__

=head1 DESCRIPTION

Demonstrates constant references

=cut
