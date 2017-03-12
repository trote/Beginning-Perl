#!/usr/bin/perl -w
# play_again.pl --- Play Again

use warnings;
use strict;

my $again = 'y';
while ( $again eq 'y' ) {
    print "\n**Played an exciting game**";
    print "\nDo you want to play again? (y/n): ";
    chomp($again = <STDIN>);
}

print "\nOkay, bye.";

__END__

=head1 DESCRIPTION

Demonstrates while loops

=cut
