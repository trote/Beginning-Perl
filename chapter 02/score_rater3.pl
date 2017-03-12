#!/usr/bin/perl -w
# score_rater3.pl --- Score Rater 3.0

use warnings;
use strict;

print "Enter your score: ";
chomp(my $score = <STDIN>);

if ( $score >= 1000 ) {
    print "You scored 1000 or more. Impressive!\n";
} elsif ( $score >= 500 ) {
    print "You scored 500 or more. Nice.\n";
} elsif ( $score >= 250 ) {
    print "You scored 250 or more. Decent.\n";
} else {
    print "You scored less than 250. Nothing to brag about.\n";
}

__END__

=head1 DESCRIPTION

Demonstrates if else-if else suite

=cut
