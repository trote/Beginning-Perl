#!/usr/bin/perl -w
# swap.pl --- Swap

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
    my ( $x, $y ) = @_;

    ( $$x, $$y ) = ( $$y, $$x );
}

__END__

=head1 DESCRIPTION

Demonstrates passing references to alter argument variables

=cut
