#!/usr/bin/perl -w
# yes_or_no.pl --- Yes or No

use warnings;
use strict;

sub ask_yes_no1();
sub ask_yes_no2($);

my $answer1 = ask_yes_no1();
print "Thanks for answering: $answer1\n\n";

my $answer2 = ask_yes_no2("Do you wish to save your game?");
print "Thanks for answering: $answer2\n";

sub ask_yes_no1() {
    my $response1;
    do {
        print "Please enter 'y' or 'n': ";
        chomp($response1 = <STDIN>);
    } while ( $response1 ne 'y' and $response1 ne 'n' );

    $response1;
}

sub ask_yes_no2($) {
    my $question = shift;
    
    my $response2;
    do {
        print "$question (y/n): ";
        chomp($response2 = <STDIN>);
    } while ( $response2 ne 'y' and $response2 ne 'n' );

    $response2;
}

__END__

=head1 DESCRIPTION

Demonstrates return values and parameters

=cut
