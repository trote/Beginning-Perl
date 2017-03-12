#!/usr/bin/perl -w
# game_stats2.pl --- Game Stats 2.0

use warnings;
use strict;

my $score = 5000;
print "score: $score\n";

# altering the value of a variable
$score = $score + 100;
print "score: $score\n";

# combined assignment operator
$score += 100;
print "score: $score\n";

# increment operators
my $lives = 3;
++$lives;
print "lives: $lives\n";

$lives = 3;
$lives++;
print "lives: $lives\n";

$lives = 3;
my $bonus = ++$lives * 10;
print "lives, bonus = $lives, $bonus\n";

$lives = 3;
$bonus = $lives++ * 10;
print "lives, bonus = $lives, $bonus\n";

# integer wrap around
$score = 4294967295;
print "\nscore: $score\n";
++$score;
print "score: $score\n";

__END__

=head1 DESCRIPTION

Demonstrates arithmetic operations with variables

=cut
