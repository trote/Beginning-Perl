#!/usr/bin/perl -w
# give_me_a_number.pl --- Give Me a Number

use warnings;
use strict;

sub ask_number($;$);

my $number = ask_number(5);
print "Thanks for entering: $number\n\n";
    
$number = ask_number(10, 5);
print "Thanks for entering: $number\n\n";

sub ask_number($;$) {
    my ( $high, $low ) = @_;

    $low //= 1;
    
    my $num;
    do {
        print "Please enter a number ($low - $high): ";
        chomp($num = <STDIN>);
    } while ( $num > $high or $num < $low );

    $num;
}

__END__

=head1 DESCRIPTION

Demonstrates default function arguments

=cut
