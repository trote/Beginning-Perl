#!/usr/bin/perl -w
# referencing.pl --- Referencing

use warnings;
use strict;

my $my_score = 1000;
my $mikes_score = \$my_score; # create a reference
    
print "myScore is: $my_score\n";
print "mikesScore is: $$mikes_score\n\n";
    
print "Adding 500 to myScore\n";
$my_score += 500;
print "myScore is: $my_score\n";
print "mikesScore is: $$mikes_score\n\n";

print "Adding 500 to mikesScore\n";
$$mikes_score += 500;
print "myScore is: $my_score\n";
print "mikesScore is: $$mikes_score\n\n";

__END__

=head1 DESCRIPTION

Demonstrates using references

=cut
