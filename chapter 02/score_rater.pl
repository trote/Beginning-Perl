#!/usr/bin/perl -w
# score_rater.pl --- Score Rater

use warnings;
use strict;

if ( 1 ) {
    print "This is always displayed.\n\n";
}

if ( 0 ) {
    print "This is never displayed.\n\n";
}

my $score = 1000;

if ( $score ) {
    print "At least you didn't score zero.\n\n";
}
	
if ( $score >= 250 ) {
    print "You scored 250 or more. Decent.\n\n";
}

if ( $score >= 500 ) {
    print "You scored 500 or more. Nice.\n\n";

    if ( $score >= 1000 ) {
        print "You scored 1000 or more. Impressive!\n";
    }
}

__END__

=head1 DESCRIPTION

Demonstrates the if statement

=cut
