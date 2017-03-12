#!/usr/bin/perl -w
# score_rater2.pl --- Score Rater 2.0

use warnings;
use strict;

print "Enter your score: ";
chomp(my $score = <STDIN>);

if ( $score >= 1000) {
    print "You scored 1000 or more. Impressive!\n";
} else {
    print "You scored less than 1000.\n";
}

__END__

=head1 DESCRIPTION

Demonstrates an else clause

=cut
