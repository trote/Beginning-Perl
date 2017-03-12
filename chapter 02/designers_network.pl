#!/usr/bin/perl -w
# designers_network.pl --- Designers Network

use warnings;
use strict;

my $success;

print "\tGame Designer's Network\n";

do {
    print "\nUsername: ";
    chomp(my $username = <STDIN>);

    print "Password: ";
    chomp(my $password = <STDIN>);

    if ( $username eq "S.Meier" and $password eq "civilization" ) {
        print "\nHey, Sid.";
        $success = 1;
    } elsif ( $username eq "S.Miyamoto" and $password eq "mariobros" ) {
        print "\nWhat's up, Shigeru?";
        $success = 1;
    } elsif ( $username eq "W.Wright" and $password eq "thesims" ) {
        print "\nHow goes it, Will?";
        $success = 1;
    } elsif ( $username eq "guest" or $password eq "guest" ) {
        print "\nWelcome, guest.";
        $success = 1;
    } else {
        print "\nYour login failed.";
       $ success = 0;
    }
} until ( $success );

__END__

=head1 DESCRIPTION

Demonstrates logical operators

=cut
