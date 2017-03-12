#!/usr/bin/perl -w
# heros_inventory.pl --- Hero's Inventory

use warnings;
use strict;

use constant MAX_ITEMS => 10;
my @inventory;

my $num_items = 0;
$inventory[$num_items++] = "sword";
$inventory[$num_items++] = "armor";
$inventory[$num_items++] = "shield";

print "Your items:\n";
print "$_\n" for @inventory;

print "\nYou trade your sword for a battle axe.";
$inventory[0] = "battle axe";
print "\nYour items:\n";
print "$_\n" for @inventory;

print "\nThe item name '$inventory[0]' has ";
print length($inventory[0]), " letters in it.\n";

print "\nYou find a healing potion.";
if ( $num_items < MAX_ITEMS ) {
    $inventory[$num_items++] = "healing potion";
} else {
    print "You have too many items and can't carry another.";
}
print "\nYour items:\n";
print "$_\n" for @inventory;

__END__

=head1 DESCRIPTION

Demonstrates arrays

=cut
