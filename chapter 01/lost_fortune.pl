#!/usr/bin/perl -w
# lost_fortune.pl --- Lost Fortune

use warnings;
use strict;

use constant GOLD_PIECES => 900;

# get the information
print "Welcome to Lost Fortune\n\n";
print "Please enter the following for your personalized adventure\n";

print "Enter a number: "; 
chomp(my $adventurers = <STDIN>);

print "Enter a number, smaller than the first: ";
chomp(my $killed = <STDIN>);

my $survivors = $adventurers - $killed;

print "Enter your last name: ";
chomp(my $leader = <STDIN>);

# tell the story
print "\nA brave group of $adventurers set out on a quest ";
print "-- in search of the lost treasure of the Ancient Dwarves. ";
print "The group was led by that legendary rogue, $leader.\n";

print "\nAlong the way, a band of marauding ogres ambushed the party. ";
print "All fought bravely under the command of $leader";
print ", and the ogres were defeated, but at a cost. ";
print "Of the adventurers, $killed were vanquished, ";
print "leaving just $survivors in the group.\n";

print "\nThe party was about to give up all hope. "; 
print "But while laying the deceased to rest, ";
print "they stumbled upon the buried fortune. ";
print "So the adventurers split ", GOLD_PIECES, " gold pieces.";
print "$leader held on to the extra ", GOLD_PIECES % $survivors;
print " pieces to keep things fair of course.\n";

__END__

=head1 DESCRIPTION

A personalized adventure

=cut
