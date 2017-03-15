#!/usr/bin/perl -w
# swap_pointer_ver.pl --- Swap Pointer

use warnings;
use strict;

sub bad_swap($$);
sub good_swap($$);

my $my_score = 150;
my $your_score = 1000;
print "Original values\n";
print "myScore: $my_score\n";
print "yourScore: $your_score\n\n";

print "Calling badSwap()\n";
bad_swap $my_score, $your_score;
print "myScore: $my_score\n";
print "yourScore: $your_score\n\n";

print "Calling goodSwap()\n";
good_swap \$my_score, \$your_score;
print "myScore: $my_score\n";
print "yourScore: $your_score\n";

sub bad_swap($$) {
    my ( $x, $y ) = @_;

    ( $x, $y ) = ( $y, $x );
}

sub good_swap($$) {
    my ( $p_x, $p_y ) = @_;

    # store value pointed to by pX in temp
    my $temp = $$p_x;
    # store value pointed to by pY in address pointed to by pX
    $$p_x = $$p_y;
    # store value originally pointed to by pX in address pointed to by pY   
    $$p_y = $temp;  
}

__END__

=head1 DESCRIPTION

Demonstrates passing constant pointers to alter argument variables

=cut
