#!/usr/bin/perl -w
# finicky_counter.pl --- Finicky Counter

use warnings;
use strict;

my $count = 0;
while ( 1 ) {
    $count += 1;

    # end loop if count is greater than 10
    last if $count > 10;

    # skip the number 5
    next if $count == 5;

    print "$count\n";
}

__END__

=head1 DESCRIPTION

Demonstrates break and continue statements

=cut
