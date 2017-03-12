#!/usr/bin/perl -w
# string_tester.pl --- String Tester

use warnings;
use strict;

my $word1 = "Game";
my $word2 = "Over";
my $word3 = '!' x 3;

my $phrase = $word1 . " " . $word2 . $word3;
print "The phrase is: $phrase\n\n";

print "The phrase has ", length($phrase), " characters in it.\n\n";

print "The character at position 0 is: ", substr($phrase, 0, 1), "\n\n";

print "Changing the character at position 0.\n";
$phrase =~ s/^./L/;
print "The phrase is now: $phrase\n\n";

for ( 0 .. length($phrase) - 1 ) {
    print "Character at position $_ is: ", substr($phrase, $_, 1), "\n";
}

print "\nThe sequence 'Over' begins at location "; 
print index($phrase, "Over"), "\n";

if ( index($phrase, "eggplant") == -1 ) {
    print "'eggplant' is not in the phrase.\n\n";
}

substr($phrase, 4, 5) = '';
print "The phrase is now: $phrase\n";

substr($phrase, 4) = '';
print "The phrase is now: $phrase\n";

$phrase = '';
print "The phrase is now: $phrase\n";

unless ( $phrase ) {
    print "\nThe phrase is no more.\n";
}

__END__

=head1 DESCRIPTION

Demonstrates string objects

=cut
