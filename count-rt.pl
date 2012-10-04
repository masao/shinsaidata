#!/usr/bin/env perl
# $Id$

use warnings;
use strict;

my %count = ();

while (my $line = <> ){
    chomp( $line );
    my ( $tweet_id, $user_id, $timestamp, $tweet ) = split( /\t/, $line );
    if ( $tweet =~ /^RT\b/o ) {
	$count{ $tweet }++;
	# print STDERR $line;
	while( $tweet =~ s/^RT[\s:]*\@\w+?[\s:]*//o ) {
	    $count{ $tweet }++ if $tweet =~ /^RT\b/o;
	}
    }
}
my @sorted = map  { $_->[0] }
    sort { $b->[1] <=> $a->[1] }
    map  { [ $_, $count{$_} ] } keys %count;
foreach my $tw ( @sorted ) {
    print join( "\t", $count{$tw}, $tw ),"\n";
}
