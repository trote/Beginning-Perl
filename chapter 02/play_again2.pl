#!/usr/bin/perl -w
# play_again2.pl --- Play Again 2.0

use warnings;
use strict;

my $again = 'y';
do {
    print "\n**Played an exciting game**";
    print "\nDo you want to play again? (y/n): ";
    chomp($again = <STDIN>);
} while ( $again eq 'y' );

print "\nOkay, bye.";

__END__

=head1 DESCRIPTION

Demonstrates do loops

=cut
