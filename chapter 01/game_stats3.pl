#!/usr/bin/perl -w
# game_stats3.pl --- Game Stats 3.0

use warnings;
use strict;

use constant ALIEN_POINTS => 150;
my $aliens_killed = 10;
my $score = $aliens_killed * ALIEN_POINTS;
print "score: $score\n";

use enum qw( NOVICE EASY NORMAL HARD UNBEATABLE );
my $my_difficulty = EASY;

use enum qw( FIGHTER_COST=25 BOMBER_COST CRUISER_COST=50 );
my $my_ship_cost = BOMBER_COST;
print "\nTo upgrade my ship to a Cruiser will cost ",
    (CRUISER_COST - $my_ship_cost), " Resource Points.\n";

__END__

=head1 DESCRIPTION

Demonstrates constants

=cut
