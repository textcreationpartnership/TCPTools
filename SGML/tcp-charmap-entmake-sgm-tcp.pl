#!\c:\apps\perl\bin\perl.exe

# Create a valid sgm charent file from the custom tcp
# characters in the charmap.sgm file.

# At the command line type:
# tcp-charmap-entmaketcp-sgm.pl > newentfile.ent


#use strict;

#include tcp character map subroutines
require "F:/MARKUP/code/Perl/Eebo/tcp-charmap-include.pm";

#file containing character map
my $charactermap = "F:/MARKUP/code/charents/charmap.sgm"; 

#put character map into a perl array
charmap_array($charactermap); 

#create sgm ent file

print "<!-- Character entity set. Typical invocation:\n";
print "   <!ENTITY % EEBOchar PUBLIC\n";
print "     \"EEBO 2000-1//ENTITIES EEB 1//EN\">\n";
print "   %EEBOchar;\n";
print "-->\n\n";
print "<!-- Generated by tcp-charmap-entmake-sgm-tcp.pl on " . localtime(time) . " -->\n\n";
print "<!-- Please make character changes to charmap.sgm, and then run tcp-charmap-entmake-sgm-tcp.pl to generate this ent file. -->\n\n";
   
foreach $entity (@entities) {
   #check if entity was created by tcp
   my $src = content_attr('ENT','SRC');
   if ($src eq "tcp") {
      #get entity name and comment, then print
      my $ent = content_attr('ENT','TCP');
      my $comment = join(" ",content_attr('EQUIV','DESC'), content_tag(COMMENT));
      #TODO check for multiple EQUIV and COMMENT tags
      print "<!ENTITY $ent SDATA \"&$ent\;\"--=$comment-->\n";
   }
}
print "\n";
