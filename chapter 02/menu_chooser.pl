#!/usr/bin/perl -w
# menu_chooser.pl --- Menu Chooser

use warnings;
use strict;

use Switch;

print "Difficulty Levels\n\n";
print "1 - Easy\n";
print "2 - Normal\n";
print "3 - Hard\n\n";

print "Choice: ";
chomp(my $choice = <STDIN>);

switch ( $choice ) {
    case 1 { print "You picked Easy.\n"; }
    case 2 { print "You picked Normal.\n"; }
    case 3 { print "You picked Hard.\n"; }
    else   { print "You made an illegal choice.\n"; }
}

__END__

=head1 DESCRIPTION

Demonstrates the switch statement

=cut
