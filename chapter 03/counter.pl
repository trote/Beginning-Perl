#!/usr/bin/perl -w
# counter.pl --- Counter

use warnings;
use strict;

use constant {
    ROWS    => 5,
    COLUMNS => 3,
};

print "Counting forward:\n";
print "$_ " for 0 .. 9;

print "\n\nCounting backward:\n";
for ( my $i = 9; $i >= 0; $i-- ) {
    print "$i ";
}

print "\n\nCounting by fives:\n";
for ( my $i = 0; $i <= 50; $i += 5) {
    print "$i ";
}

print "\n\nCounting with null statements:\n";
my $count = 0;
for ( ; $count < 10; ) {
    print "$count ";
    $count++;
}

print "\n\nCounting with nested for loops:\n";
for my $i ( 0 .. ROWS - 1 ) {
    for my $j ( 0 .. COLUMNS - 1 ) {
        print "$i,$j  ";
    }
    print "\n";
}

__END__

=head1 DESCRIPTION

Demonstrates for loops

=cut
