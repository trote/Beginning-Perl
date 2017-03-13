#!/usr/bin/perl -w
# global_reach.pl --- Global Reach

use warnings;
use strict;

my $glob = 10; # global variable

sub access_global();
sub hide_global();
sub change_global();

print "In main() glob is: $glob\n\n";
access_global();
    
hide_global();
print "In main() glob is: $glob\n\n";

change_global();
print "In main() glob is: $glob\n\n";

sub access_global() {
    print "In access_global() glob is: $glob\n\n";
}

sub hide_global() {
    my $glob = 0; # hide global variable glob
    print "In hide_global() glob is: $glob\n\n";
}

sub change_global() {
    $glob = -10; # change global variable glob
    print "In change_global() glob is: $glob\n\n";
}

__END__

=head1 DESCRIPTION

Demonstrates global variables

=cut
