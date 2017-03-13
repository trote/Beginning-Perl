#!/usr/bin/perl -w
# taking_damage.pl --- Taking Damage

use warnings;
use strict;

my $radiation = sub { $_[0] / 2 };

my $health = 80;
print "Your health is $health\n\n";
    
$health = $radiation->($health);
print "After radiation exposure your health is $health\n\n";
    
$health = $radiation->($health);
print "After radiation exposure your health is $health\n\n";
    
$health = $radiation->($health);
print "After radiation exposure your health is $health\n\n";


__END__

=head1 DESCRIPTION

Demonstrates function inlining

=cut
