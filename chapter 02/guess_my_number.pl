#!/usr/bin/perl -w
# guess_my_number.pl --- Guess My Number

use warnings;
use strict;

srand(time ^ $$);  # seed random number generator

my $secret_number = int(rand(100)) + 1;  # random number between 1 and 100
my $tries = 0;
my $guess;
    
print "\tWelcome to Guess My Number\n\n";

do {
    print "Enter a guess: ";
    chomp($guess = <STDIN>);
    $tries++;

    if ( $guess > $secret_number ) {
        print "Too high!\n\n";
    } elsif ( $guess < $secret_number ) {
        print "Too low!\n\n";
    } else {
        print "\nThat's it! You got it in $tries guesses!\n";
    }

} while ( $guess != $secret_number );

__END__

=head1 DESCRIPTION

The classic number guessing game

=cut
