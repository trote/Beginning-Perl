#!/usr/bin/perl -w
# hangman.pl --- Hangman

use warnings;
use strict;

use List::Util qw(shuffle);
use Readonly;

# set-up
use constant MAX_WRONG => 8; # maximum number of incorrect guesses allowed

my @words;  # collection of possible words to guess
push @words, "GUESS";
push @words, "HANGMAN";
push @words, "DIFFICULT";

srand(time ^ $$);
@words = shuffle @words;
Readonly my $THE_WORD => $words[0];   # word to guess
my $wrong = 0;                        # number of incorrect guesses
my $so_far = '-' x length($THE_WORD); # word guessed so far
my $used = "";                        # letters already guessed

print "Welcome to Hangman.  Good luck!\n";

# main loop
while ( ($wrong lt MAX_WRONG) and ($so_far ne $THE_WORD) ) {
    print "\n\nYou have ", (MAX_WRONG - $wrong);
    print " incorrect guesses left.\n";
    print "\nYou've used the following letters:\n$used\n";
    print "\nSo far, the word is:\n$so_far\n";

    print "\n\nEnter your guess: ";
    chomp(my $guess = <STDIN>);
    $guess = uc $guess; # make uppercase since secret word in uppercase
    my $offset = 0;
    while ( (my $result = index($used, $guess, $offset)) != -1 ) {
        $offset = $result + 1;
        print "\nYou've already guessed $guess\n";
        print "Enter your guess: ";
        chomp($guess = <STDIN>);
        $guess = uc $guess;
    }

    $used .= $guess;

    if ( index($THE_WORD, $guess) != -1 ) {
        print "That's right! $guess is in the word.\n";

        # update soFar to include newly guessed letter
        for my $i ( 0 .. length($THE_WORD) - 1 ) {
            if ( substr($THE_WORD, $i, 1) eq $guess ) {
                substr($so_far, $i, 1) = $guess;
            }
        }
    } else {
        print "Sorry, $guess isn't in the word.\n";
        $wrong++;
    }
}

# shut down
if ( $wrong == MAX_WRONG ) {
    print "\nYou've been hanged!";
} else {
    print "\nYou guessed it!";
}

print "\nThe word was $THE_WORD\n";

__END__

=head1 DESCRIPTION

The classic game of hangman

=cut
