#!/usr/bin/perl -w
# die_roller.pl --- Die Roller

use warnings;
use strict;

srand(time ^ $$);  # seed random number generator based on current time

my $random_number = int(rand(6)) + 1; # generate random number between 1 and 6

print "You rolled a $random_number\n";

__END__

=head1 DESCRIPTION

Demonstrates generating random numbers

=cut
