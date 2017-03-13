#!/usr/bin/perl -w
# high_scores.pl --- High Scores

use warnings;
use strict;

use List::Util qw(shuffle);

my @iter;

print "Creating a list of scores.";
my @scores;
push @scores, 1500;
push @scores, 3500;
push @scores, 7500;

print "\nHigh Scores:\n";
print "$_\n" for @scores;
        
print "\nFinding a score.";
print "\nEnter a score to find: ";
chomp(my $score = <STDIN>);
if ( grep { $_ == $score } @scores ) {
    print "Score found.\n";
} else {
    print "Score not found.\n";
}

print "\nRandomizing scores.";
srand(time ^ $$);
@scores = shuffle @scores;
print "\nHigh Scores:\n";
print "$_\n" for @scores;

print "\nSorting scores.";
@scores = sort { $a <=> $b } @scores;
print "\nHigh Scores:\n";
print "$_\n" for @scores;

__END__

=head1 DESCRIPTION

Demonstrates algorithms

=cut
