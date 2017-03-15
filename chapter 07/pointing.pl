#!/usr/bin/perl -w
# pointing.pl --- Pointing

use warnings;
use strict;

use Scalar::Util qw(refaddr);

my $p_apointer; # declare a pointer

my $p_score = 0; # declare and initialize a pointer

my $score = 1000;
$p_score = \$score; # assign pointer pScore address of a variable score

print "Assigning &score to pScore\n";
print "&score is: ", refaddr(\$score), "\n"; # address of score variable
print "pScore is: ", refaddr($p_score), "\n"; # address stored in pointer
print "score is: $score\n";
print "*pScore is: $$p_score\n\n"; # value pointed to by pointer 
   
print "Adding 500 to score\n";
$score += 500;
print "score is: $score\n";
print "*pScore is: $$p_score\n\n";

print "Adding 500 to *pScore\n";
$$p_score += 500;
print "score is: $score\n";
print "*pScore is: $$p_score\n\n";

print "Assigning &newScore to pScore\n";
my $new_score = 5000;
$p_score = \$new_score;
print "&newScore is: ", refaddr(\$new_score), "\n";
print "pScore is: ", refaddr($p_score), "\n"; 
print "newScore is: $new_score\n";
print "*pScore is: $$p_score\n\n";  

print "Assigning &str to pStr\n";
my $str = "score";
my $p_str = \$str;   # pointer to string object
print "str is: $str\n";
print "*pStr is: $$p_str\n";
print "(*pStr).size() is: ", length($str), "\n";
print "pStr->size() is: ", length($$p_str), "\n";  

__END__

=head1 DESCRIPTION

Demonstrates using pointers

=cut
