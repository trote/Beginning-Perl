#!/usr/bin/perl -w
# game_stats.pl --- Game Stats

use warnings;
use strict;

my $score;
my $distance;
my $play_again;
my $shields_up;	

my ( $lives, $aliens_killed );

$score = 0;
$distance = 1200.76;
$play_again = 'y';
$shields_up = 1;
$lives = 3;
$aliens_killed = 10;
		
my $engine_temp = 6572.89;

print "\nscore: $score\n";
print "distance: $distance\n";
print "playAgain: $play_again\n";
# skipping shields_up since you don't generally print Boolean values
print "lives: $lives\n";
print "aliensKilled: $aliens_killed\n";
print "engineTemp: $engine_temp\n";

print "\nHow much fuel? ";
chomp(my $fuel = <STDIN>);
print "fuel: $fuel\n";

my $bonus = 10;
print "\nbonus: $bonus\n";

__END__

=head1 DESCRIPTION

Demonstrates declaring and initializing variables

=cut
