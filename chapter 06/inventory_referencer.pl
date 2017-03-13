#!/usr/bin/perl -w
# inventory_referencer.pl --- Inventory Referencer

use warnings;
use strict;

# returns a reference to a string
sub ref_to_element($$);

my @inventory;
push @inventory, "sword";
push @inventory, "armor";
push @inventory, "shield";

# displays string that the returned reference refers to 
print "Sending the returned reference to cout:\n";   
print ${ref_to_element(\@inventory, 0)}, "\n\n";

# assigns one reference to another -- inexpensive assignment 
print "Assigning the returned reference to another reference.\n";
my $r_str = ref_to_element \@inventory, 1; 
print "Sending the new reference to cout:\n";
print "$$r_str\n\n";

# copies a string object -- expensive assignment
print "Assigning the returned reference to a string object.\n";
my $str = ref_to_element \@inventory, 2;
print "Sending the new string object to cout:\n";
print "$$str\n\n";
    
# altering the string object through a returned reference
print "Altering an object through a returned reference.\n";
$$r_str = "Healing Potion";
print "Sending the altered object to cout:\n";
print "$inventory[1]\n";

# returns a reference to a string
sub ref_to_element($$) {
    my ( $arr, $i ) = @_;
    
    \$arr->[$i];
}

__END__

=head1 DESCRIPTION

Demonstrates returning a reference

=cut
