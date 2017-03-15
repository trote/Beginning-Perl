#!/usr/bin/perl -w
# inventory_displayer_pointer_ver.pl --- Inventory Displayer Pointer

use warnings;
use strict;

sub display($);

my @inventory;
push @inventory, "sword";
push @inventory, "armor";
push @inventory, "shield";

display \@inventory;

# receive the address of inventory into the pointer pInventory
# pInventory can be a constant pointer because the address it stores doesn't change
# inventory can be accepted as a constant object because the function won't change it
sub display($) {
    my $p_inventory = shift;

    print "Your items:\n";
    print "$p_inventory->[$_]\n" for 0 .. $#$p_inventory;
}

__END__

=head1 DESCRIPTION

Demonstrates passing constant pointers to constant objects

=cut
