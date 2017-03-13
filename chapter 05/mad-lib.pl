#!/usr/bin/perl -w
# mad-lib.pl --- Mad-Lib

use warnings;
use strict;

sub ask_text($);
sub ask_number($);
sub tell_story($$$$$);

print "Welcome to Mad Lib.\n\n";
print "Answer the following questions to help create a new story.\n";
    
my $name = ask_text "Please enter a name: ";
my $noun = ask_text "Please enter a plural noun: ";
my $number = ask_number "Please enter a number: ";
my $body_part = ask_text "Please enter a body part: ";
my $verb = ask_text "Please enter a verb: ";
    
tell_story $name, $noun, $number, $body_part, $verb;

sub ask_text($) {
    my $prompt = shift;
    
    print $prompt;
    chomp(my $text = <STDIN>);
    $text;
}

sub ask_number($) {
    my $prompt = shift;

    print $prompt;
    chomp(my $num = <STDIN>);
    int($num);
}

sub tell_story($$$$$) {
    my ( $name, $noun, $number, $body_part, $verb ) = @_;
    
    print "\nHere's your story:\n";
    print "The famous explorer ";
    print $name;
    print " had nearly given up a life-long quest to find\n";
    print "The Lost City of ";
    print $noun;
    print " when one day, the ";
    print $noun;
    print " found the explorer.\n";
    print "Surrounded by ";
    print $number;
    print " $noun";
    print ", a tear came to ";
    print "${name}'s ";
    print "$body_part.\n";
    print "After all this time, the quest was finally over. ";
    print "And then, the ";
    print "$noun\n";
    print "promptly devoured ";
    print "$name. ";
    print "The moral of the story? Be careful what you ";
    print $verb;
    print " for.";
}

__END__

=head1 DESCRIPTION

Creates a story based on user input

=cut
