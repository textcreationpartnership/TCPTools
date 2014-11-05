#!/l/local/bin/perl
#\c:\apps\perl\bin\perl.exe
#package tcp-convertnum;

# ------------------------------------------------------------
#
# This module contains several subroutines for UTF8 (Unicode)
# character translation for conversion of TCP files from SGM to 
# XML format.
#
# akuster 2005-06-06
#
# ------------------------------------------------------------

#use strict;

# ------------------------------------------------------------
# NAME    : hex2utf8
# PURPOSE : 
# CALLS   :
# INPUT   : 
# RETURNS :
# NOTES   : 
# ------------------------------------------------------------

sub hex2utf8 {
    num2utf8( hex( $_[0] ) );
}

# ------------------------------------------------------------
# NAME    : num2utf8
# PURPOSE : 
# CALLS   :
# INPUT   : 
# RETURNS :
# NOTES   : 
# ------------------------------------------------------------

sub num2utf8 {
    my ( $t ) = @_;
    my ( $trail, $firstbits, @result );

    if    ($t<0x00000080) { $firstbits=0x00; $trail=0; }
    elsif ($t<0x00000800) { $firstbits=0xC0; $trail=1; }
    elsif ($t<0x00010000) { $firstbits=0xE0; $trail=2; }
    elsif ($t<0x00200000) { $firstbits=0xF0; $trail=3; }
    elsif ($t<0x04000000) { $firstbits=0xF8; $trail=4; }
    elsif ($t<0x80000000) { $firstbits=0xFC; $trail=5; }
    else {
        die "Too large scalar value, cannot be converted to UTF-8.\n";
    }
    for (1 .. $trail) {
        unshift (@result, ($t & 0x3F) | 0x80);
        $t >>= 6;         # slight danger of non-portability
    }
    unshift (@result, $t | $firstbits);
    pack ("C*", @result);
}

1; #return true when loaded as a Perl require file
