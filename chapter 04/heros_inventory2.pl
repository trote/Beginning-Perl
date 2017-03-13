#!/usr/bin/perl -w
# heros_inventory2.pl --- Hero's Inventory 2.0

use warnings;
use strict;

my @inventory;
push @inventory, "sword";
push @inventory, "armor";
push @inventory, "shield";

print "You have ", scalar(@inventory), " items.\n";

print "\nYour items:\n";
print "$_\n" for @inventory;

print "\nYou trade your sword for a battle axe.";
$inventory[0] = "battle axe";
print "\nYour items:\n";
print "$_\n" for @inventory;

print "\nThe item name '$inventory[0]' has ";
print length($inventory[0]), " letters in it.\n";

print "\nYour shield is destroyed in a fierce battle.";
pop @inventory;
print "\nYour items:\n";
print "$_\n" for @inventory;

print "\nYou were robbed of all of your possessions by a thief.";
@inventory = ();
unless ( @inventory ) {
    print "\nYou have nothing.\n";
} else {
    print "\nYou have at least one item.\n";
}

__END__

=head1 DESCRIPTION

Demonstrates vectors

=cut
