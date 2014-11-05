#!/l/local/bin/perl
#\c:\apps\perl\bin\perl.exe
#package tcp-charmap-include;

# ------------------------------------------------------------
#
# This module contains several subroutines for TCP character
# mapping and translation of TCP files from SGM to XML.
#
# akuster 2005-06-06
#
# ------------------------------------------------------------

# ------------------------------------------------------------
# NAME    : charmap_array
# PURPOSE : Take character elements from the TCP character
#           catalog file and put each of them into a Perl
#           array element.
# CALLS   :
# INPUT   : String containing path and name of character 
#           catalog file.
# RETURNS :
# NOTES   : Initialize @entities before calling this 
#           subroutine.
# ------------------------------------------------------------

sub charmap_array {
   
   my $catalog = $_[0]; #file that contains the character catalog
   
   open READFILE, "<$catalog" or die "$catalog not found.\n";
   
   #put each character element into an array element
   $/= "</CHAR>"; #set delimiter
   while (<READFILE>) {
      if (m,(<CHAR>.*?</CHAR>),gi) {
         push(@entities,$1);
      }
   }
   close READFILE;
}

# ------------------------------------------------------------
# NAME    : content_tag
# PURPOSE : Returns the contents of a given XML/SGML/HTML tag.
# CALLS   :
# INPUT   : A string containing the name of the tag.
# RETURNS : A string containing the tag's contents.
# NOTES   : Initialize @entities before calling this 
#           subroutine.
# ------------------------------------------------------------

sub content_tag {

   my $tagname = $_[0];  #name of tag containing content to return
   my $content = "";     #string to return content of tag
   
   for ($entity) {
     if (m,<$tagname[^>]*?>([^<]*?)</$tagname>,is) {
        $content = $1;
     }
   }
   return $content;
}

# ------------------------------------------------------------
# NAME    : content_attr
# PURPOSE : Returns the contents of an attribute in a given 
#           XML/SGML/HTML tag.
# CALLS   :
# INPUT   : A string containing the name of the tag.
#           A string containing the name of the attribute.
# RETURNS : A string containing the attribute's contents.
# NOTES   : Initialize @entities before calling this 
#           subroutine.
# ------------------------------------------------------------

sub content_attr {

   my $tagname = $_[0];  #name of tag containing attribute to return
   my $attname = $_[1];  #name of attribute to find content
   my $content = "";     #string to return content of attribute
   
   for ($entity) {
     if (m/<$tagname[^>]*? $attname="([^"]*?)"/is) {
        $content = $1;
     }
   }
   return $content;
}

# ------------------------------------------------------------
# NAME    : content_attr_known
# PURPOSE : Returns the contents of one attribute in a given 
#           XML/SGML/HTML tag when the contents of another of 
#           the tag's attributes is known.
# CALLS   :
# INPUT   : A string containing the name of the tag.
#           A string containing the name of the unknonwn attribute.
#           A string containing the name of the known attribute.
#           A string containing the contents of the known attribute.
# RETURNS : A string containing the unknown attribute's contents.
# NOTES   : Initialize @entities before calling this 
#           subroutine.
# ------------------------------------------------------------

sub content_attr_known {
   
   my $tagname = $_[0];      #name of tag containing attribute to return
   my $attname = $_[1];      #name of attribute to find content
   my $knownattname = $_[2]; #name of attribute with known content
   my $knownatt = $_[3];     #content of known attribute
   my $content = "";         #string to return content of unknown attribute
   
   for ($entity) {
     if (m/(<$tagname[^>]*?$attname="([^"]*?)"[^>]*?$knownattname="$knownatt[^"]*?")|(<$tagname[^>]*?$knownattname="$knownatt[^"]*?"[^>]*?$attname="([^"]*?)")/gis) {
        $content = $2;
     }
   }
   return $content;
}

1; #return true when loaded as a Perl require file
