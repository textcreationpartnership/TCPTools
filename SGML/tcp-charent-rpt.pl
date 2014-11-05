#!\c:\apps\perl\bin\perl.exe

# FILENAME: tcp-charent-rpt.pl
# AUTHOR:   akuster
# CREATED:  2005-11-18
# FUNCTION: Counts character entities in sgm files in current directory
#              and all its subdirectories.
# USE:      Call from the command line to count all entities in sgm files
#              in the current directory and all its subdirectories.
# RESULT:   Creates a report log listing the entity and the number of
#              times it is used.
# CHANGES:  PLEASE INITIAL, COMMENT, AND DATE ANY CHANGES  
#              IN HEADER AND IN PROGRAM
#           2005-11-18 akuster created
#

use File::Find;

#
# REQUIRED FILES CONTAINING SUBROUTINES
#

#include tcp character map subroutines
require "F:/MARKUP/code/Perl/Eebo/tcp-charmap-include.pm"; #MSWin32

#include tcp number conversion subroutines
require "F:/MARKUP/code/Perl/Eebo/tcp-convertnum.pm"; #MSWin32

#
# STRING DECLARATION
#

#file containing character map
my $charactermap = "F:/MARKUP/code/charents/charmap.sgm"; #MSWin32

#name of report log file
my $reportfile = "charent-log.txt";

#
# PRE-PROCESS:
# load character map into memory for entity replacement
#

charmap_array($charactermap); #put character map into a perl array

#create replacement hashes

my %TcpToUnicodeHash = ();

foreach $entity (@entities) {
   my $entview;
   my $entsgm = content_attr('ENT','TCP');
      
   #use Arial Unicode MS entity
   my $entview = content_attr_known('REPL','TXT','SUP','Arial Unicode MS');
   #if no Arial entry, use default entity
   if (! $entview) {
      $entview = content_attr_known('REPL','TXT','SUP','default');
   }
   if ($entview =~ m,&\#x([^;]*?);,) {
      $entview = $1;
   }
   $TcpToUnicodeHash{$entsgm} = $entview;
}

#
# MAIN PROGRAM:
#

my $currentfile = 1;
my @filelist = ();
my %replHash = ();


#populate @filelist array with all files in current or 
#recursive directories
print STDERR "Finding character entities in sgm files.\n";
print STDERR "Looking for sgm files in this directory and its subdirectories.\n";
sub wanted {
   push(@filelist,$File::Find::name);
}
find \&wanted, ".";

my $totalfiles = scalar(@filelist);

#loop through each file in the directory
foreach my $file (@filelist) {

   #perform conversion only on files ending with sgm.
   if ($file =~ m/sgm$/ ) {
   
      print STDERR "$file ($currentfile of $totalfiles) ";
      
      my $line = "";
      $/ = "\n"; #make sure delimiter is new line.
      
      open READFILE, "<$file";
      
      while ($line = <READFILE>) {
         while ( $line =~ m,&([A-Za-z0-9\#\.\-]+)[;:< \,\"\'\n\t],g ) {
          
              #special characters should end with semicolon ;
              #however, we include the following as possible errors:
              #:<,"' space newline tab
              #this does not find badly constructed chars without 
              #close in the middles of words.
              
	    #count entities.
              my $entsgm = $1;
              
              if ( $entsgm =~ "\#x" ) {
                 my $entview = substr($entsgm,2);
                 $replHash{$entview}++;
              } else {
                 $replHash{$entsgm}++;
              }
         }
      }
      print STDERR "done.\n";
   } else {
      print STDERR "$file is not an sgm file. Skipping.\n";
   }
   $currentfile++;
}   
close READFILE;

#create report log file
open REPORTFILE, ">$reportfile";
      
if ( scalar( keys %replHash ) == 0 ) {
   print STDERR "No character entities found.\n";
} else {
   foreach my $entsgm ( sort keys %replHash ) {
      my $count = $replHash{$entsgm};
      if ( $count > 0 ) {
         print REPORTFILE "$entsgm\t$count\n";
      } else {
         $count = -1*$count;
         print REPORTFILE "$entsgm\t$count ERROR: No corresponding Unicode code point for this entity.\n";
      }
   }
}

close REPORTFILE;

print STDERR "Complete.\n"; #DEBUG
