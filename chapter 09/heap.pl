#!/usr/bin/perl -w
# heap.pl --- Heap

use warnings;
use strict;

sub int_on_heap();  # returns an int on the heap
sub leak1();        # creates a memory leak
sub leak2();        # creates another memory leak

my $val = 10;
my $p_heap;
$p_heap = \$val;
print "*pHeap: $$p_heap\n\n";
    
my $p_heap2 = int_on_heap();
print "*pHeap2: $$p_heap2\n\n";
    
print "Freeing memory pointed to by pHeap.\n\n";
undef $$p_heap;

print "Freeing memory pointed to by pHeap2.\n\n";
undef $$p_heap2;
    
# get rid of dangling pointers
$p_heap = 0;
$p_heap2 = 0;

sub int_on_heap() {
    my $p_temp = 20;
    \$p_temp;
}

sub leak1() {
    my $drip1 = 30;
}

sub leak2() {
    my $drip2 = 50;
    $drip2 = 100;
    undef $drip2;
}

__END__

=head1 DESCRIPTION

Demonstrates dynamically allocating memory

=cut
