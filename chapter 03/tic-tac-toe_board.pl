#!/usr/bin/perl -w
# tic-tac-toe_board.pl --- Tic-Tac-Toe Board

use warnings;
use strict;

my @board = ( ['O', 'X', 'O'],
              [' ', 'X', 'X'],
              ['X', 'O', 'O'], );

print "Here's the tic-tac-toe board:\n";
for my $i ( 0 .. $#board ) {
    for my $j ( 0 .. $#{$board[$i]} ) {
        print $board[$i][$j];
    }

    print "\n";
}

print "\n'X' moves to the empty location.\n\n";
$board[1][0] = 'X';

print "Now the tic-tac-toe board is:\n";
for my $i ( 0 .. $#board ) {
    for my $j ( 0 .. $#{$board[$i]} ) {
        print $board[$i][$j];
    }

    print "\n";
}

print "\n'X' wins!";

__END__

=head1 DESCRIPTION

Demonstrates multidimensional arrays

=cut
