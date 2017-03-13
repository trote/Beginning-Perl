#!/usr/bin/perl -w
# scoping.pl --- Scoping

use warnings;
use strict;

sub func();

my $var = 5; # local variable in main()
print "In main() var is: $var\n\n";

func();

print "Back in main() var is: $var\n\n";

{
    print "In main() in a new scope var is: $var\n\n";

    print "Creating new var in new scope.\n";
    my $var = 10; # variable in new scope, hides other variable named var
    print "In main() in a new scope var is: $var\n\n";
}

print "At end of main() var created in new scope no longer exists.\n";
print "At end of main() var is: $var\n";

sub func() {
    my $var = -5; # local variable in func()
    print "In func() var is: $var\n\n";
}

__END__

=head1 DESCRIPTION

Demonstrates scopes

=cut
