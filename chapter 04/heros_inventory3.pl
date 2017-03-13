#!/usr/bin/perl -w
# heros_inventory3.pl --- Hero's Inventory 3.0

use warnings;
use strict;

my @inventory;
push @inventory, "sword";
push @inventory, "armor";
push @inventory, "shield";

print "Your items:\n";
for ( my $i = 0; $i <= $#inventory; $i++ ) {
    print "$inventory[$i]\n";
}

print "\nYou trade your sword for a battle axe.";
splice @inventory, 0, 1, "battle axe";
print "\nYour items:\n";
for ( my $i = 0; $i <= $#inventory; $i++ ) {
    print "$inventory[$i]\n";
}

print "\nThe item name '$inventory[0]' has ";
print length($inventory[0]), " letters in it.\n";

print "\nYou recover a crossbow from a slain enemy.";
unshift @inventory, "crossbow";
print "\nYour items:\n";
for ( my $i = 0; $i <= $#inventory; $i++ ) {
    print "$inventory[$i]\n";
}

print "\nYour armor is destroyed in a fierce battle.";
splice @inventory, 2, 1;
print "\nYour items:\n";
for ( my $i = 0; $i <= $#inventory; $i++ ) {
    print "$inventory[$i]\n";
}

__END__

=head1 DESCRIPTION

Demonstrates iterators

=cut
