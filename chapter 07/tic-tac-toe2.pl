#!/usr/bin/perl -w
# tic-tac-toe2.pl --- Tic-Tac-Toe 2.0

use warnings;
use strict;
use v5.10;

use boolean;
use List::Util qw(none);

# global constants
use constant {
    X      => 'X',
    O      => 'O',
    EMPTY  => ' ',
    TIE    => 'T',
    NO_ONE => 'N',
};
use constant NUM_SQUARES => 9;

# function prototypes
sub instructions();
sub ask_yes_no($);
sub ask_number($$;$);
sub human_piece();
sub opponent($);
sub display_board($);
sub winner($);
sub is_legal($$);
sub human_move($$);
sub computer_move($$);
sub announce_winner($$$);

my $move;
my $board = [ (EMPTY) x NUM_SQUARES ];

instructions();
my $human = human_piece();
my $computer = opponent($human);
my $turn = X;
display_board($board);

while ( winner($board) eq NO_ONE ) {
    if ( $turn eq $human ) {
        $move = human_move $board, $human;
        $board->[$move] = $human;
    } else {
        $move = computer_move $board, $computer;
        $board->[$move] = $computer;
    }
    display_board $board;
    $turn = opponent $turn;
}

announce_winner winner($board), $computer, $human;

# functions
sub instructions() {
    print <<'EOF';
Welcome to the ultimate man-machine showdown: Tic-Tac-Toe.
--where human brain is pit against silicon processor

Make your move known by entering a number, 0 - 8.  The number
corresponds to the desired board position, as illustrated:

       0 | 1 | 2
       ---------
       3 | 4 | 5
       ---------
       6 | 7 | 8

Prepare yourself, human.  The battle is about to begin.

EOF
}

sub ask_yes_no($) {
    my $question = shift;
    
    my $response;
    do {
        print "$question (y/n): ";
        chomp($response = <STDIN>);
    } while ( $response ne 'y' and $response ne 'n' );

    $response;
}

sub ask_number($$;$) {
    my ( $question, $high, $low ) = @_;
    $low //= 0;
    
    my $number;
    do {
        print "$question ($low - $high): ";
        chomp($number = <STDIN>);
    } while ( $number > $high or $number < $low );

    $number;
}

sub human_piece() {
    my $go_first = ask_yes_no("Do you require the first move?");
    if ( $go_first eq 'y' ) {
        print "\nThen take the first move.  You will need it.\n";
        X;
    } else {
        print "\nYour bravery will be your undoing... I will go first.\n";
        O;
    }
}

sub opponent($) {
    my $piece = shift;
    
    $piece eq X ? O : X;
}

sub display_board($) {
    my $board = shift;
    
    print "\n\t$board->[0] | $board->[1] | $board->[2]";
    print "\n\t---------";
    print "\n\t$board->[3] | $board->[4] | $board->[5]";
    print "\n\t---------";
    print "\n\t$board->[6] | $board->[7] | $board->[8]";
    print "\n\n";
}

sub winner($) {
    my $board = shift;
    
    # all possible winning rows
    state $WINNING_ROWS = [ [0, 1, 2],
                            [3, 4, 5],
                            [6, 7, 8],
                            [0, 3, 6],
                            [1, 4, 7],
                            [2, 5, 8],
                            [0, 4, 8],
                            [2, 4, 6] ];

    # if any winning row has three values that are the same (and not EMPTY),
    # then we have a winner
    for my $row ( @$WINNING_ROWS ) {
        if ( ($board->[$row->[0]] ne EMPTY) and
             ($board->[$row->[0]] eq $board->[$row->[1]]) and
             ($board->[$row->[1]] eq $board->[$row->[2]]) ) {
            return $board->[$row->[0]];
        }
    }

    # since nobody has won, check for a tie (no empty squares left)
    return TIE if none { $_ eq EMPTY } @$board;

    # since nobody has won and it isn't a tie, the game ain't over
    NO_ONE;
}

sub is_legal($$) {
    my ( $move, $board ) = @_;
    
    $board->[$move] eq EMPTY;
}

sub human_move($$) {
    my ( $board, $human ) = @_;
    
    my $move = ask_number "Where will you move?", @$board - 1;
    while ( ! is_legal($move, $board) ) {
        print "\nThat square is already occupied, foolish human.\n";
        $move = ask_number "Where will you move?", @$board - 1;
    }
    print "Fine...\n";

    $move;
}

sub computer_move($$) {
    my ( $board, $computer ) = @_;

    my $move = 0;
    my $found = false;

    # if computer can win on next move, that’s the move to make
    while ( ! $found and $move < @$board ) {
        if ( is_legal($move, $board) ) {
            # try move
            $board->[$move] = $computer;
            # test for winner
            $found = (winner($board) eq $computer);
            # undo move
            $board->[$move] = EMPTY;
        }

        $move++ unless $found;
    }
  
    # otherwise, if opponent can win on next move, that's the move to make
    unless ( $found ) {
        $move = 0;
        my $human = opponent $computer;

        while ( ! $found and $move < @$board ) {
            if ( is_legal($move, $board) ) {
                # try move
                $board->[$move] = $human;  
                # test for winner
                $found = (winner($board) eq $human);     
                # undo move
                $board->[$move] = EMPTY;        
            }

            $move++ unless $found;
        }
    }

    # otherwise, moving to the best open square is the move to make
    unless ( $found ) {
        $move = 0;
        my $i = 0;

        state $BEST_MOVES = [ 4, 0, 2, 6, 8, 1, 3, 5, 7 ];
        # pick best open square
        while ( ! $found and $i < @$board ) {
            $move = $BEST_MOVES->[$i];
            $found = true if is_legal($move, $board);

            $i++;
        }
    }

    print "I shall take square number $move\n";
    $move;
}

sub announce_winner($$$) {
    my ( $winner, $computer, $human ) = @_;
    
    if ( $winner eq $computer ) {
        print "${winner}'s won!\n";
        print "As I predicted, human, I am triumphant once more -- proof\n";
        print "that computers are superior to humans in all regards.\n";
    } elsif ( $winner eq $human ) {
        print "${winner}'s won!\n";
        print "No, no!  It cannot be!  Somehow you tricked me, human.\n";
        print "But never again!  I, the computer, so swear it!\n";
    } else {
        print "It's a tie.\n";
        print "You were most lucky, human, and somehow managed to tie me.\n";
        print "Celebrate... for this is the best you will ever achieve.\n";
    }
}

__END__

=head1 DESCRIPTION

Plays the game of tic-tac-toe against a human opponent
Uses pointers instead of refernces for function parameters

=cut
