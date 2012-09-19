#!/usr/bin/env perl

use strict;
use warnings;

my $lastline = undef;

while( my $line = <> ) {
    chomp( $line );
    $line =~ s/\t/ /go;
    if ( $line =~ /\x01/o ) {
        if ( defined $lastline ) {
	    my @tmp = split( /\x01/, $lastline );
	    print join( "\t", @tmp ) ."\n";
	}
        $lastline = $line
    } elsif ( defined $lastline ) {
        $lastline .= " ".$line;
    }
}
my @tmp = split( /\x01/, $lastline );
print join( "\t", @tmp ) ."\n";
