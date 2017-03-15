#!/usr/bin/perl -w
# inventory_pointer.pl --- Inventory Pointer

use warnings;
use strict;

# returns a pointer to a string element
sub ptr_to_element($$);

my @inventory;
push @inventory, "sword";
push @inventory, "armor";
push @inventory, "shield";

# displays string object that the returned pointer points to
print "Sending the object pointed to by returned pointer to cout:\n";       
print ${ptr_to_element(\@inventory, 0)}, "\n\n";

# assigns one pointer to another -- inexpensive assignment
print "Assigning the returned pointer to another pointer.\n";
my $p_str = ptr_to_element \@inventory, 1;
print "Sending the object pointed to by new pointer to cout:\n";
print "$$p_str\n\n";

# copies a string object -- expensive assignment
print "Assigning object pointed to by pointer to a string object.\n";
my $str = ${ptr_to_element(\@inventory, 2)};
print "Sending the new string object to cout:\n";
print "$str\n\n";
    
# altering the string object through a returned pointer
print "Altering an object through a returned pointer.\n";
$$p_str = "Healing Potion";
print "Sending the altered object to cout:\n";
print "$inventory[1]\n";

chomp(my $x = <STDIN>);

sub ptr_to_element($$) {
    my ( $p_arr, $i ) = @_;

    # returns address of the string in position i of vector that pVec points to
    \$p_arr->[$i];
}

__END__

=head1 DESCRIPTION

Demonstrates returning a pointer

=cut
