#!/usr/bin/perl -w
# word_jumble.pl --- Word Jumble

use warnings;
use strict;

use enum qw( WORD HINT NUM_FIELDS );
use constant WORDS => (
    ["wall", "Do you feel you're banging your head against something?"],
    ["glasses", "These might help you see the answer."],
    ["labored", "Going slowly, is it?"],
    ["persistent", "Keep at it."],
    ["jumble", "It's what the game is all about."],
);

srand(time ^ $$);
my $choice = rand(5);
my $the_word = (WORDS)[$choice][WORD];  # word to guess
my $the_hint = (WORDS)[$choice][HINT];  # hint for word

my $jumble = $the_word;  # jumbled version of word
my $length = length $jumble;
for ( 0 .. $length - 1 ) {
    my $index1 = rand($length);
    my $index2 = rand($length);
    my $temp = substr $jumble, $index1, 1;
    substr($jumble, $index1, 1) = substr($jumble, $index2, 1);
    substr($jumble, $index2, 1) = $temp;
}

print "\t\t\tWelcome to Word Jumble!\n\n";
print "Unscramble the letters to make a word.\n";
print "Enter 'hint' for a hint.\n";
print "Enter 'quit' to quit the game.\n\n";
print "The jumble is: $jumble";

print "\n\nYour guess: ";
chomp(my $guess = <STDIN>);

while ( ($guess ne $the_word) and ($guess ne "quit") ) {
    if ( $guess eq "hint" ) {
        print $the_hint;
    } else {
        print "Sorry, that's not it.";
    }

    print"\n\nYour guess: ";
    chomp($guess = <STDIN>);
}

if ( $guess eq $the_word ) {
    print "\nThat's it!  You guessed it!\n";
}

print "\nThanks for playing.\n";

__END__

=head1 DESCRIPTION

The classic word jumble game where the player can ask for a hint

=cut
