#!/usr/bin/perl -w
# array_passer.pl --- Array Passer

use warnings;
use strict;

sub increase($$);
sub display($$);

print "Creating an array of high scores.\n\n";
my @high_scores = ( 5000, 3500, 2700 );
    
print "Displaying scores using array name as a constant pointer.\n";
print "$high_scores[0]\n";
print "$high_scores[1]\n";
print "$high_scores[2]\n\n";
    
print "Increasing scores by passing array as a constant pointer.\n\n";
increase \@high_scores, scalar(@high_scores);
    
print "Displaying scores by passing array as a constant pointer to a constant.\n";
display \@high_scores, scalar(@high_scores);

sub increase($$) {
    my ( $array, $num_elements ) = @_;

    $array->[$_] += 500 for 0 .. $num_elements - 1;
}

sub display($$) {
    my ( $array, $num_elements ) = @_;

    print "$array->[$_]\n" for 0 .. $num_elements - 1;
}

__END__

=head1 DESCRIPTION

Demonstrates relationship between pointers and arrays

=cut
