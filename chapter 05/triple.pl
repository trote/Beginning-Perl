#!/usr/bin/perl -w
# triple.pl --- Triple

use warnings;
use strict;

use Scalar::Util qw(looks_like_number);

sub triple($);

print "Tripling 5: ", triple(5), "\n\n";
print "Tripling 'gamer': ", triple("gamer");

sub triple($) {
    my $val = shift;
    
    if ( looks_like_number($val) ) {
        $val * 3;
    } else {
        $val x 3;
    }
}
          
__END__

=head1 DESCRIPTION

Demonstrates function overloading

=cut
