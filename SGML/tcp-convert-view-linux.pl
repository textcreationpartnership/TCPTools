#!/l/local/bin/perl
#\c:\apps\perl\bin\perl.exe
#CHANGE DECLARATION ABOVE FOR MSWIN32 OR LINUX (1 OF 4)

# FILENAME: tcp-convert-view.pl
# AUTHOR:   akuster
# CREATED:  2005-06-03
# FUNCTION: Converts valid TCP SGM files into XML.
# USE:      Call from the command line to convert all SGM files
#              in the current directory.
# RESULT:   Creates a sibling folder with converted XML files
#              and a report log.
# CHANGES:  PLEASE INITIAL, COMMENT, AND DATE ANY CHANGES  
#              IN HEADER AND IN PROGRAM
#           2005-06-06 akuster modified for use on linux
#           2005-09-09 akuster corrected GAPs for DESC illegible
#              intruder, math, and no DESC.
#           2005-11-14 akuster modified GAPs for DESC illegible
#              blank
#           2005-11-17 akuster modified MILESTONE replacement to
#              allow slashes in CDATA before xml closing slash
#           2006-12-08 pfs added lowercasing of REND attribute of FIGURE tag
#           2007-04-09 pfs repaired broken regexp that changes + to U+2026 
#              within DISP attribute of GAP tag.
#           2007-07-30 pfs added line repairing weird result of normalization
#              of STC T="T" to STC T
#           2008-08-13 pfs ripped out the heart of the character-replacement
#              engine and replaced it with a simpler model, while trying
#              to leave the surrounding code as intact as possible. See
#              comments below marked "pfs:2008-08" for details.
#           2010-03-01 pfs added routines to deal with some character-based
#              kludges in the SGML, namely EOL hyphens (literal and supplied)
#              and decorated initials, marked by underscores.
#              See lines marked pfs:2010-03
#           2010-05-18 pfs added routines to superscript characters that
#              were also tagged as <HI> or <ABBR>.
#              See lines marked pfs:2010-05
#           2010-06-15 pfs added display routine for EXTENT="1 chunk"
#           2010-09-16 pfs removed final newline from insertion of XML doctype declaration
#           2011-03-02 pfs added very basic routine to dissolve the syntactic 
#              sugar of new SGML LICENSE and FLOATEXT tags
#              See lines marked pfs:2011-03
#           2011-05-24 pfs added lines to lowercase the values of certain newly controlled attributes
#              viz. PLACE on NOTE and ROLE on CELL and ROW
#              See lines marked pfs:2011-05
#           2011-12-12 pfs added slight sophistication to LICENSE and FLOATEXT conversion
#              to accommodate REND attributes and pass them on to the contained DIV1
#              See lines marked pfs:2011-12
#           2012-10-17 pfs (1) added a simple replacement of PLACE="margin" with PLACE="marg"
#              since some older SGML files still have 'margin'; and (2) added refinements to
#              the dissolution of FLOATEXT into its sugary components by accommodating optional
#              @N attribute and passing it on to the contained DIV1. See lines marked 2012-10.
#           2014-03-28 pfs added cursory treatment of OMITTED gaps




use Cwd;
#use strict;

#
# REQUIRED FILES CONTAINING SUBROUTINES
#

#CHANGE FOR MSWIN32 OR LINUX (2 OF 4)
#include tcp character map subroutines
#require "F:/MARKUP/code/Perl/Eebo/tcp-charmap-include.pm"; #MSWin32
require "/l1/bin/t/text/tcp-charmap-include.pm"; #linux

#CHANGE FOR MSWIN32 OR LINUX (3 OF 4)
#include tcp number conversion subroutines
#require "F:/MARKUP/code/Perl/Eebo/tcp-convertnum.pm"; #MSWin32
require "/l1/bin/t/text/tcp-convertnum.pm"; #linux

#
# STRING DECLARATION
#

#CHANGE FOR MSWIN32 OR LINUX (4 OF 4)
#file containing character map
#my $charactermap = "F:/MARKUP/code/charents/charmap.sgm"; #MSWin32
my $charactermap = "/l1/prep/e/eebo/incoming/extras/charmap.sgm"; #linux

#name new directory to write xml files.
#first get name of current directory.
#workaround using getcwd() since cwd() doesn't seem to work.
my @currentdirarray = (split /[\\\/]/,getcwd());
my $cwd = $currentdirarray[$#currentdirarray];

#finally, name new directory
my $newdir = "../xml-$cwd"; #sibling to current directory

#name of report log file
my $reportfile = "xml-$cwd-log.txt";

#delimiters for GAP DISP substitutions
#CAREFUL: if you change these strings, then please also replace the actual 
#         string value throughout this script, since it is sometimes hard-
#         coded in order to acommodate how perl strings work.
my $lbrace = "&#x3008;"; #left angle bracket (&#x2308;=left ceiling)
my $rbrace = "&#x3009;"; #right angle bracket  (&#x2309;=right ceiling)

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

#  pfs:2008-08
#  The following lines have been removed, since they appear to reflect
#  an incorrect assumption. In the process of populating the hash that
#  maps sgm entity (entsgm) to viewable XML equivalent (entview), this
#  bit of code appears to assume that an entview that contains a numeric
#  character entity contains nothing else, not even a second such entity.
#  It then proceeds to reduce it to the hex value. However many entviews
#  consist of multiple numeric entities (e.g. character + diacritic), and
#  some consist of one or more numeric entities embedded in a text string.
#  In the former case, this code reduced the entview to the hex value of
#  the first entity in the string; in the second case, it reduced it to
#  the hex value of the first entity and abandoned the surrounding text
#  altogether. Not good. With this code removed, the entview should now
#  consist of the text derived from charmap.sgm literally and unmodified.
#  I.e., even those entviews that consist of or contain numeric entities
#  will retain the remainder of the text, including the entity delimiters.
#
#    if ($entview =~ m,&\#x([^;]*?);,) {
#       $entview = $1;
#    }
#

   $TcpToUnicodeHash{$entsgm} = $entview;

#  pfs:2008-08
#  This line for diagnostic purposes only:
#  print "\n$entview";

}

#
# MAIN PROGRAM:
# Process every sgm file in the current directory
#

#make new directory sibling of current directory
mkdir("$newdir", 0774);

#create report log file
open REPORTFILE, ">$newdir/$reportfile";

#point handle to current directory
opendir(DIRHANDLE,"./");

#put list of filenames in DIRHANDLE into an array
my @directory = readdir(DIRHANDLE);

#determine total number of sgm files
#to show on user's command line during process
my $totalfiles = 0;
foreach my $file (@directory) {
   if ($file =~ m/sgm$/ ) {
      $totalfiles++;
   }
}

#to show on user's command line during process
my $currentfile = 1;

#loop through each file in the directory
foreach my $file (@directory) {

   #perform conversion only on files ending with sgm.
   if ($file =~ m/sgm$/ ) {
   
      #name tmp and final xml files
      my $filetemp = substr($file,0,-3) . "tmp";
      my $filefinal = substr($file,0,-3) . "xml";
      
      #report to user
      print STDERR "$file ($currentfile of $totalfiles) ";
      print REPORTFILE "***TCP***\n$file ";
      
      #
      # MAIN LOOP PART 1 OF 2:
      # ensure sgm tags and attributes are correctly formatted
      # and add xml headers, closing tags, etc.
      #
            
      open READFILE, "<$file";
      open WRITEFILE, ">$newdir/$filetemp";
      
      while (<READFILE>) {
      
         #PART 1.1. ADD XML DECLARATION IN HEADER
         
         s,<!DOCTYPE[^>]*?>,<?xml version="1.0" encoding="utf-8"?>\n<!DOCTYPE ETS SYSTEM "http://www.textcreationpartnership.org/docs/code/eebo2prf.xml.dtd">,gis;
         
         #PART 1.2. GENERAL CLEAN UP
         
         #remove multpile spaces from all lines
         until (! m/  /g) {
            s/  / /g;
         }

         #repair 'normalized' contracted form of STC T="T" to STC T
         s#<STC T>#<STC T="T">#g;
         
         #remove returns
         s/\r//g;
         
         #PART 1.3. GENERAL CASE SENSITIVITY ISSUES
         
         #change case of selected attribute contents
         #so that they validate in XML
         s/(<EEBO[^>]*TYPE=")([^"]*")/$1\U$2/g;
         s/(<IDG[^>]*S=")([^"]*")/$1\L$2/g;
         s/(<IDG[^>]*R=")([^"]*")/$1\U$2/g;
         s/(<STC[^>]*T=")([^"]*")/$1\U$2/g;
         s/(<BIBNO[^>]*T=")([^"]*")/$1\L$2/g;
         s/(<ITEM[^>]*ROLE=")([^"]*")/$1\L$2/g;
         s/(<LABEL[^>]*ROLE=")([^"]*")/$1\L$2/g;
         s/(<NOTE[^>]*ANCHORED=")([^"]*")/$1\L$2/g;
         s/(<PB[^>]*MS=")([^"]*")/$1\L$2/g;
         s/(<GAP[^>]*DESC=")([^"]*")/$1\L$2/g;
         s/(<GAP[^>]*RESP=")([^"]*")/$1\L$2/g;         
         s/(<FIGURE[^>]*REND=")([^"]*")/$1\L$2/g;

# pfs:2011-05

         s/(<NOTE[^>]*PLACE=")([^"]*")/$1\L$2/g;
         s/(<CELL[^>]*ROLE=")([^"]*")/$1\L$2/g;
         s/(<ROW[^>]*ROLE=")([^"]*")/$1\L$2/g;

# pfs:2012-10

         s,PLACE="[mM][aA][rR][gG][iI][nN]",PLACE="marg",g;

         
         
         #capitalize selected tag and attribute names
         s/<gap /<GAP /gi;
         s/type="/TYPE="/gi;
         s/reason="/REASON="/gi;
         s/desc="/DESC="/gi;
         s/extent="/EXTENT="/gi;
         s/ n="/ N="/gi;
         
         #fix duplicate tag delimiter < and > characters
         #s/\<\</</g;
         #s/\>\>/>/g;
      
         #PART 1.4. FIX GAP EXTENTs
         
         #ensure DESC attributes are before EXTENT attributes
         s/(<GAP[^>]*?)( EXTENT="[^"]*?")([^>]*?)( DESC="[^"]*?")([^>]*?>)/$1$4$2$3$5/g;
         
         #remove superfluous spaces from start and end of EXTENT
         s/EXTENT="[ ']+([^"]*?)"/EXTENT="$1"/g;
         s/EXTENT="([^"]*?)[ ']+"/EXTENT="$1"/g;
         
         #fix misordered EXTENTs where word comes before number
         s/EXTENT="([A-Za-z\+ ]*?)[ ']*?([0-9\+]*?)"/EXTENT="$2 $1"/g;
         
         #lowercase contents of EXTENT attributes
         #remove intrusive spaces and aposts
         #and move misplaced plus sign from end to front
         s/EXTENT="([0-9]*?)[ ']?(\+?)[ ']?([A-Za-z ]*?)[ ']?(\+?)"/EXTENT="$1$2$4 \L$3"/g;
         
         #fix accidentally joined EXTENT number and word
         s/EXTENT="([0-9\+]*?)([a-z]*?)(\+?)"/EXTENT="$1$3 $2"/g;
         
         #remove any double plusses
         s/(EXTENT="[^"]*?)(\+)\+ /$1$2 /g;
         
         #change selected spelled out values to numeric
         s/EXTENT="1 or more([^"]*?)"/EXTENT="1+ $1"/g;
         s/EXTENT="1 plus([^"]*?)"/EXTENT="1+ $1"/g;
         #TODO: WHY DONT THESE WORK?
         s/EXTENT="few([^"]*?)"/EXTENT="1+ $1"/g;       #TODO
         s/EXTENT="several([^"]*?)"/EXTENT="2+ $1"/g;   #TODO
         s/EXTENT="three([^"]*?)"/EXTENT="3 $1"/g;      #TODO
         s/EXTENT="0\.5([^"]*?)"/EXTENT="half a $1"/g;  #TODO
         
         #assume unspecified DESC duplicates, intruders, missing, or 
         #replacements have an EXTENT of 1 page
         #plural taken care of below
         s/(<GAP DESC=")(duplicate|intruder|missing|replacement)">/$1$2" EXTENT="1 page">/g;
         s/(<GAP DESC=")(duplicate|intruder|missing|replacement)(" EXTENT="[0-9\+]*?)"/$1$2$3 page"/g;
         
         #assume unspecified EXTENTs for some common GAPs
         #plural taken care of below
         s/(<GAP DESC="blank)">/$1" EXTENT="1 word">/g;
         s/(<GAP DESC="illegible)">/$1" EXTENT="1 span">/g;
         s/(<GAP DESC="symbol)">/$1" EXTENT="1 letter">/g;
         
         #assume all EXTENTs of a plain number are letters
         #plural taken care of below
         s/EXTENT="([0-9\+]*?) ?"/EXTENT="$1 letter"/g;
         
         #put value of 1 in front of plain character EXTENTs
         s/EXTENT=" ?([a-z]*?)"/EXTENT="1 $1"/g;
         
         #correct common misspellings
         #plural taken care of below
         s/EXTENT="([0-9\+]*?) number"/EXTENT="$1 letter"/g;
         s/EXTENT="([0-9\+]*?) l"/EXTENT="$1 line"/g;
         s/EXTENT="([0-9\+]*?) para"/EXTENT="$1 paragraph"/g;
         s/EXTENT="([0-9\+]*?) p"/EXTENT="$1 page"/g;
         s/EXTENT="([0-9\+]*?) (lspan|note|s|san|sspan)"/EXTENT="$1 span"/g;
         s/EXTENT="([0-9\+]*?) (w|wprd)"/EXTENT="$1 word"/g;
         
         #correct DESC missing EXTENT not page
         #to DESC illegible
         #plural taken care of below
         s/<GAP DESC="missing"([^>]*?)(letter|line|paragraph|span|word)([^>]*?>)/<GAP DESC="illegible" REASON="missing"$1$2$3/g;
         #remove rare double REASONs added by line above
         s/REASON="[^"]*?" (REASON="[^"]*?")/$1/g;
         
         #correct singular and plural cases
         #wrong plural to singular
         s/EXTENT="1 ([a-z]*?)s"/EXTENT="1 $1"/g;
         #wrong singular to plural
         s/EXTENT="([2-9]|[0-9]{2})(\+?) ([a-z]*?[^s])"/EXTENT="$1$2 $3s"/g;

# pfs:2011-03  1.4A Routine to convert syntactic sugar tags FLOATEXT and LICENSE

s,</FLOATEXT>,</DIV1></BODY></TEXT></Q>,g;  #pfs:2011-03
s,</LICENSE>,</DIV1></BODY></TEXT></Q>,g;  #pfs:2011-03

# pfs:2011-12 modification to accommodate REND values in floating texts

s,<LICENSE([^>]*)( REND="[^"]+")([^>]*)>,<LICENSE$1$3><REND>$2</REND>,g;
s,<FLOATEXT([^>]*)( REND="[^"]+")([^>]*)>,<FLOATEXT$1$3><REND>$2</REND>,g;

# pfs:2011-03  1.4A Routine to convert syntactic sugar tags FLOATEXT and LICENSE

s,<LICENSE( LANG="[^"]+")>,<Q><TEXT$1><BODY><DIV1 TYPE="license">,g;  #pfs:2011-03
s,<LICENSE( LANG="[^"]+") SUBTYPE="([^"]+)">,<Q><TEXT$1><BODY><DIV1 TYPE="license" SUBTYPE="$2">,g;  #pfs:2011-03
s,<LICENSE SUBTYPE="([^"]+)"( LANG="[^"]+")>,<Q><TEXT$2><BODY><DIV1 TYPE="license" SUBTYPE="$1">,g;  #pfs:2011-03

# with required @LANG before required @TYPE

s,<FLOATEXT LANG="([^"]+)" TYPE="([^"]+)">,<Q><TEXT LANG="$1"><BODY><DIV1 TYPE="$2">,g;  #pfs:2011-03

# and with optional @N first, second, or third

s,<FLOATEXT N="([^"]+)" LANG="([^"]+)" TYPE="([^"]+)">,<Q><TEXT LANG="$2"><BODY><DIV1 TYPE="$3" N="$1">,g;  #pfs:2012-10
s,<FLOATEXT LANG="([^"]+)" N="([^"]+)" TYPE="([^"]+)">,<Q><TEXT LANG="$1"><BODY><DIV1 TYPE="$3" N="$2">,g;  #pfs:2012-10
s,<FLOATEXT LANG="([^"]+)" TYPE="([^"]+)" N="([^"]+)">,<Q><TEXT LANG="$1"><BODY><DIV1 TYPE="$2" N="$3">,g;  #pfs:2012-10

# with required @TYPE before required @LANG

s,<FLOATEXT TYPE="([^"]+)" LANG="([^"]+)">,<Q><TEXT LANG="$2"><BODY><DIV1 TYPE="$1">,g;  #pfs:2011-03

# and with optional @N first, second, or third

s,<FLOATEXT N="([^"]+)" TYPE="([^"]+)" LANG="([^"]+)">,<Q><TEXT LANG="$3"><BODY><DIV1 TYPE="$2" N="$1">,g;  #pfs:2012-10
s,<FLOATEXT TYPE="([^"]+)" N="([^"]+)" LANG="([^"]+)">,<Q><TEXT LANG="$3"><BODY><DIV1 TYPE="$1" N="$2">,g;  #pfs:2012-10
s,<FLOATEXT TYPE="([^"]+)" LANG="([^"]+)" N="([^"]+)">,<Q><TEXT LANG="$2"><BODY><DIV1 TYPE="$1" N="$3">,g;  #pfs:2012-10


# pfs:2011-12 modification to accommodate REND values in floating texts

s,><REND>([^<]+)</REND>,$1>,g;

# Experimental bit to merge subtypes into types
#
# s,( SUBTYPE="[^"]+")([^>]*)( TYPE="[^"]+"),$3$1$2,g;
# s, TYPE="([^"]+)"([^>]*) SUBTYPE="([^"]+)", TYPE="$1 ($3)"$2,g;


# pfs:2010-03  1.4B Routine to convert most underscores to SEGs:

# pfs:2010-03  First rename underscores before letters in contexts where you do not want to convert them

s#REF="([^"_]+_[^"_]+)_#REF="$1\{templowbar\}#g;
s#(<STC[^>]+>[^<]+)_#$1\{templowbar\}#g;

# pfs:2010-03  Then change _ to DECOR when it is followed by a letter, entity, apostrophe or (some) GAPs

s#_([A-Za-z'])#<DECOR>$1</DECOR>#g;
s#_(&[a-zA-Z0-9]+;)#<DECOR>$1</DECOR>#g;
s#_(<GAP[^>]*DESC="illegible"[^>]*EXTENT="1 letter"[^>]*>)#<DECOR>$1</DECOR>#g;
s#_(<GAP[^>]*DESC="illegible"[^>]*EXTENT="1"[^>]*>)#<DECOR>$1</DECOR>#g;


# pfs:2010-03  combine multiple DECORs

s#</DECOR><DECOR>##g;

# pfs:2010-03  convert DECOR to HI or SEG

s#<DECOR>#<SEG REND="decorInit">#g;
s#</DECOR>#</SEG>#g;

# pfs:2010-03  restore temporarily removed underscores

s#\{templowbar\}#_#g;

# pfs:2010-03  END of underscore routine

 # 1.4C Tidy hyphens
 # pfs:2010-03   Remove inexplicable combinations
 
 s#-\|#-#g;
 s#\|-#-#g;
 s#\+\|#+#g;
 s#\|\+#+#g;
 s#\|\|#|#g;
 
 
#  pfs:2010-03  Change selected pipes to &EOLhyphen;
 
 s#\|#\{pfseol\}#g;
 s#\+#\{pfsEOL\}#g;
 
#  pfs:2010-03  Set aside plus in extent values
 
 s#(EXTENT="[0-9]+)\{pfsEOL\}#$1\{pfsplus\}#g;
 
 s#([a-zA-Z~\;>'\]])\{pfseol\}([a-zA-Z&< \(\^\[])#$1&EOLhyphen;$2#g;
 
 #  pfs:2010-03  Change selected plusses to &EOLunhyphen;
 
 s#([a-zA-Z~\;>'])\{pfsEOL\}([a-zA-Z&< \(\[\^])#$1&EOLunhyphen;$2#g;
 
 #  pfs:2010-03  Restore set-aside plusses and hyphens
 
 s#\{pfsplus\}#+#g;
 s#\{pfsEOL\}#+#g;
 s#\{pfseol\}#|#g;
 
 #  pfs:2010-03   END OF HYPHEN ROUTINE


         #PART 1.5 FIX SUB and SUPERSCRIPTS
         
         #fill in some superscripts automatically. do away with superscripted words
         
         s/(\^<GAP DESC="illegible"[^>]+EXTENT="1) word("[^>]*>)/$1 letter$2/g;
         s# w\^<GAP DESC="illegible[^>]+> # w^t #g;
         s# w\^<GAP DESC="illegible[^>]+>$# w^t #g;
         s#^w\^<GAP DESC="illegible[^>]+> # w^t #g;
         
         s# w\^<GAP DESC="illegible[^>]+>out# w^tout#g;
         s#^w\^<GAP DESC="illegible[^>]+>out# w^tout#g;
         s# w\^<GAP DESC="illegible[^>]+>stand# w^tstand#g;
         s#^w\^<GAP DESC="illegible[^>]+>stand#w^tstand#g;
         s#notw\^<GAP DESC="illegible[^>]+>stand#notw^tstand#g;
         
         s# w\^<GAP DESC="illegible[^>]+>in# w^tin#g;
         s#^w\^<GAP DESC="illegible[^>]+>in#w^tin#g;
         s# w\^<GAP DESC="illegible[^>]+>al# w^tal#g;
         s#^w\^<GAP DESC="illegible[^>]+>al#w^tal#g;

         # Deal with super- and sub-scripted characters by assuming that they are always one character as they are supposed to be and treating illegible, foreign, and symbol gaps as one character and charents as one character

         s,\^\^<GAP[^>]+DESC="illegible"[^>]*>,<SUB>&#x2022;</SUB>,g;
         s,\^<GAP[^>]+DESC="illegible"[^>]*>,<SUP>&#x2022;</SUP>,g;
         s,\^\^<GAP[^>]+DESC="(symbol|foreign)"[^>]*>,<SUB>&#x2610;</SUB>,g;
         s,\^<GAP[^>]+DESC="(symbol|foreign)"[^>]*>,<SUP>&#x2610;</SUP>,g;
         
         s,\^\^(&[^ ;]+;),<SUB>$1</SUB>,g;
         s,\^(&[^ ;]+;),<SUP>$1</SUP>,g;
         
         s,\^\^([a-zA-Z0-9\(\)\*\.:;\,]),<SUB>$1</SUB>,g;
         s,\^([a-zA-Z0-9\(\)\*\.:;\,]),<SUP>$1</SUP>,g;


  # pfs:2010-05 Deal with sub- or superscripted letter or entities also in HI or ABBR
  
         s,\^\^(<HI[^>]*>&[^ ;]+;</HI>),<SUB>$1</SUB>,g;
         s,\^(<HI[^>]*>&[^ ;]+;</HI>),<SUP>$1</SUP>,g;
         s,\^\^(<HI[^>]*>[a-zA-Z0-9\(\)\*\.:;\,]</HI>),<SUB>$1</SUB>,g;
         s,\^(<HI[^>]*>[a-zA-Z0-9\(\)\*\.:;\,]</HI>),<SUP>$1</SUP>,g;

         s,\^\^(<ABBR[^>]*>&[^ ;]+;</ABBR>),<SUB>$1</SUB>,g;
         s,\^(<ABBR[^>]*>&[^ ;]+;</ABBR>),<SUP>$1</SUP>,g;
         s,\^\^(<ABBR[^>]*>[a-zA-Z0-9\(\)\*\.:;\,]</ABBR>),<SUB>$1</SUB>,g;
         s,\^(<ABBR[^>]*>[a-zA-Z0-9\(\)\*\.:;\,]</ABBR>),<SUP>$1</SUP>,g;

  # pfs:2010-05 End of added code.


         
         #remove sequential superscript or subscript tags
         #so that tags contain character groups
         s,</SUP><SUP>,,g;
         s,</SUB><SUB>,,g;
         
         #PART 1.6. ADD DISP ATTRIBUTE TO GAPS
         
         #blank
         #s/(<GAP[^>]+DESC="blank"[^>]+EXTENT=")([^"]+)("[^>]*?)>/$1$2$3 DISP="$lbrace$2 left blank$rbrace">/g;
         
         #blank letter
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT="1)(\+?)( letters?)("[^>]*?)>/$1$2$3$4 DISP="_$2">/g;
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT="2)(\+?)( letters?)("[^>]*?)>/$1$2$3$4 DISP="__$2">/g;
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT="3)(\+?)( letters?)("[^>]*?)>/$1$2$3$4 DISP="___$2">/g;
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT="4)(\+?)( letters?)("[^>]*?)>/$1$2$3$4 DISP="____$2">/g;
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT="5)(\+?)( letters?)("[^>]*?)>/$1$2$3$4 DISP="_____$2">/g;
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT="6)(\+?)( letters?)("[^>]*?)>/$1$2$3$4 DISP="______$2">/g;
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT=")([7-9]|[0-9]{2,})(\+? letters?)("[^>]*?)>/$1$2$3$4 DISP="$lbrace$2$3 left blank$rbrace">/g;

         #blank word
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT="1)(\+?)( words?)("[^>]*?)>/$1$2$3$4 DISP=" _____ ">/g;
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT="2)(\+?)( words?)("[^>]*?)>/$1$2$3$4 DISP=" _____ _____ ">/g;
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT="3)(\+?)( words?)("[^>]*?)>/$1$2$3$4 DISP=" _____ _____ _____ ">/g;
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT="4)(\+?)( words?)("[^>]*?)>/$1$2$3$4 DISP=" _____ _____ _____ _____ ">/g;
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT="5)(\+?)( words?)("[^>]*?)>/$1$2$3$4 DISP=" _____ _____ _____ _____ _____ ">/g;
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT="6)(\+?)( words?)("[^>]*?)>/$1$2$3$4 DISP=" _____ _____ _____ _____ _____ _____ ">/g;
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT=")([7-9]|[0-9]{2,})(\+? words?)("[^>]*?)>/$1$2$3$4 DISP="$lbrace$2$3 left blank$rbrace">/g;

         #blank span, line, page, paragraph
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT=")([0-9]*?\+? )(spans?|lines?|pages?|paragraphs?)("[^>]*?)>/$1$2$3$4 DISP="$lbrace$2$3 left blank$rbrace">/g;
         
         #duplicate
         s/(<GAP[^>]+DESC="duplicate"[^>]+EXTENT=")([^"]+)("[^>]*?)>/$1$2$3 DISP="$lbrace$2 duplicate$rbrace">/g;
         
         #foreign
         #in the line below, Perl requires a space after the $lbrace variable
         s/(<GAP[^>]+DESC="foreign"[^>]*?)>/$1 DISP="$lbrace in non-Latin alphabet $rbrace">/g;
         
         #illegible letter
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="1)(\+?)( letters?)("[^>]*?)>/$1$2$3$4 DISP="&#x2022;$2">/g;
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="2)(\+?)( letters?)("[^>]*?)>/$1$2$3$4 DISP="&#x2022;&#x2022;$2">/g;
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="3)(\+?)( letters?)("[^>]*?)>/$1$2$3$4 DISP="&#x2022;&#x2022;&#x2022;$2">/g;
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="4)(\+?)( letters?)("[^>]*?)>/$1$2$3$4 DISP="&#x2022;&#x2022;&#x2022;&#x2022;$2">/g;
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="5)(\+?)( letters?)("[^>]*?)>/$1$2$3$4 DISP="&#x2022;&#x2022;&#x2022;&#x2022;&#x2022;$2">/g;
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="6)(\+?)( letters?)("[^>]*?)>/$1$2$3$4 DISP="&#x2022;&#x2022;&#x2022;&#x2022;&#x2022;&#x2022;$2">/g;
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT=")([7-9]|[0-9]{2,})(\+? letters?)("[^>]*?)>/$1$2$3$4 DISP="$lbrace$2$3$rbrace">/g;

         #illegible word
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="1)(\+?)( words?)("[^>]*?)>/$1$2$3$4 DISP="$lbrace&#x25CA;$2$rbrace">/g;
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="2)(\+?)( words?)("[^>]*?)>/$1$2$3$4 DISP="$lbrace&#x25CA;&#x25CA;$2$rbrace">/g;
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="3)(\+?)( words?)("[^>]*?)>/$1$2$3$4 DISP="$lbrace&#x25CA;&#x25CA;&#x25CA;$2$rbrace">/g;
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="4)(\+?)( words?)("[^>]*?)>/$1$2$3$4 DISP="$lbrace&#x25CA;&#x25CA;&#x25CA;&#x25CA;$2$rbrace">/g;
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="5)(\+?)( words?)("[^>]*?)>/$1$2$3$4 DISP="$lbrace&#x25CA;&#x25CA;&#x25CA;&#x25CA;&#x25CA;$2$rbrace">/g;
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="6)(\+?)( words?)("[^>]*?)>/$1$2$3$4 DISP="$lbrace&#x25CA;&#x25CA;&#x25CA;&#x25CA;&#x25CA;&#x25CA;$2$rbrace">/g;
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT=")([7-9]|[0-9]{2,})(\+? words?)("[^>]*?)>/$1$2$3$4 DISP="$lbrace$2$3$rbrace">/g;

         #illegible span
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="[0-9]*?\+? ?spans?"[^>]*?)>/$1 DISP="$lbrace&#x2026;$rbrace">/g;

         #illegible word-chunk
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="1 chunk"[^>]*?)>/$1 DISP="&#x2026;">/g;


         #illegible line, page, paragraph
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT=")([0-9]*?\+? )(lines?|pages?|paragraphs?)("[^>]*?)>/$1$2$3$4 DISP="$lbrace$2$3$rbrace">/g;

         #TODO
         #all other illegibles without DISP value.
         #cathces anything that has not been changed.
         #notably any GAP illegible without an EXTENT including 
         #letter|line|page|paragraph|span|word
         #s/(<GAP[^>]*?DESC="illegible"[^>]*?EXTENT=")([^"]*?)("[^>]*?)(?!DISP)([^>]*?)>/$1$2$3$5 DISP="$lbrace$2$rbrace">/g;
         
         #intruder
         s/(<GAP[^>]+DESC="intruder"[^>]+EXTENT=")([^"]*)("[^>]*?)>/$1$2$3 DISP="$lbrace$2 inserted from a different book$rbrace">/g;
         
         #math
         #in the line below, Perl requires a space after the $lbrace variable
         s/(<GAP[^>]+DESC="math"[^>]*)>/$1 DISP="$lbrace math $rbrace">/g;
         
         #missing
         s/(<GAP[^>]+DESC="missing"[^>]+EXTENT=")([^"]*)("[^>]*?)>/$1$2$3 DISP="$lbrace$2 missing$rbrace">/g;
         
         #music
         s/(<GAP[^>]+DESC="music"[^>]*?)>/$1 DISP="$lbrace&#x266B;$rbrace">/g;
         
         #omitted
         s/<GAP([^>]+DESC="omitted"[^>]+REND=")([^"]+)">/<gap$1$2" DISP="$lbrace $2 $rbrace">/g;
         s/<GAP([^>]+DESC="omitted"[^>]*)>/<gap$1 DISP="$lbrace ---------- $rbrace">/g;
         s/<gap/<GAP/g;
         
         
         #replacement
         s/(<GAP[^>]+DESC="replacement"[^>]+EXTENT=")([^"]*)("[^>]*?)>/$1$2$3 DISP="$lbrace$2 supplied later$rbrace">/g;
         
         #symbol
         s/(<GAP[^>]+DESC="symbol"[^>]*?EXTENT="1)(\+?)( [^"]*?)("[^>]*?)>/$1$2$3$4 DISP="$lbrace&#x2610;$2$rbrace">/g;
         s/(<GAP[^>]+DESC="symbol"[^>]*?EXTENT="2)(\+?)( [^"]*?)("[^>]*?)>/$1$2$3$4 DISP="$lbrace&#x2610;&#x2610;$2$rbrace">/g;
         s/(<GAP[^>]+DESC="symbol"[^>]*?EXTENT="3)(\+?)( [^"]*?)("[^>]*?)>/$1$2$3$4 DISP="$lbrace&#x2610;&#x2610;&#x2610;$2$rbrace">/g;
         s/(<GAP[^>]+DESC="symbol"[^>]*?EXTENT="4)(\+?)( [^"]*?)("[^>]*?)>/$1$2$3$4 DISP="$lbrace&#x2610;&#x2610;&#x2610;&#x2610;$2$rbrace">/g;
         s/(<GAP[^>]+DESC="symbol"[^>]*?EXTENT="5)(\+?)( [^"]*?)("[^>]*?)>/$1$2$3$4 DISP="$lbrace&#x2610;&#x2610;&#x2610;&#x2610;&#x2610;$2$rbrace">/g;
         s/(<GAP[^>]+DESC="symbol"[^>]*?EXTENT="6)(\+?)( [^"]*?)("[^>]*?)>/$1$2$3$4 DISP="$lbrace&#x2610;&#x2610;&#x2610;&#x2610;&#x2610;&#x2610;$2$rbrace">/g;
         s/(<GAP[^>]+DESC="symbol"[^>]*?EXTENT=")([7-9]|[0-9]{2,})(\+? [^"]*?)("[^>]*?)>/$1$2$3$4 DISP="$lbrace$2$3$rbrace">/g;
         
         #change plus signs of continuance in DISPs to elipsis &#x2026;
       #defective:  s/(DISP="[^\+]*?)\+([^ ][^"]*?")/$1&#x2026;$2/g;
       #defective:  s/(DISP="[^\+]*?)\+"/$1&#x2026;$2"/g;
       #pfs replacement:
         s/(<GAP[^>]+DESC="illegible"[^>]+)DISP="/$1disp="/g;
	 s/(<GAP[^>]+DESC="symbol"[^>]+)DISP="/$1disp="/g;
	 s/(<GAP[^>]+disp="[^\+">]+?)\+([^">]*?")/$1&#x2026;$2/g;
         s/(<GAP[^>]+)disp="/$1DISP="/g;
 
         
         #TODO (done in XSLT)
         #all remaining GAPs without DISP value.
         #with EXTENT
         #s/(<GAP[^>]*?EXTENT=")([^"]*?)("[^>]*?)(?!DISP)([^>]*?)>/$1$2$3$5 DISP="$lbrace$2$rbrace">/g;
         #without EXTENT
         #s/(<GAP[^>]*?)(?!DISP)([^>]*?)>/$1 DISP="$lbrace gap $rbrace"$3>/g;
         
         #PART 1.7. ADD CLOSING SLASHES AND TAGS
         
         s,<GAP([^>/]+)>,<GAP$1/>,g;
         s,<MILESTONE([^>]*?)>,<MILESTONE$1/>,g;
         s,<PB([^>/]*?)>,<PB$1/>,g;
         s,<LB([^>/]*?)>,<LB$1/>,g;
         s,<PTR([^>/]+)>,<PTR$1/>,g;
      
         s,</ETS>,,g;
         s,</EEBO>,</EEBO>\n</ETS>,g;
         
         #PART 1.8. PREPARE CHARACTER ENTITIES FOR PART 2
         
         #Change unusual special decimal entities to unicode.
         s/&#34;/&quot;/g; # &#x0022; quotation mark
         s/&#38;/&amp;/g;  # &#x0026; ampersand
         s/&#39;/&apos;/g; # &#x0027; apostrophe
         s/&#60;/&lt;/g;   # &#x003C; less-than sign
         s/&#62;/&gt;/g;   # &#x003E; greater-than sign
         
         #Convert tilde to combining character
         s/\~/&#x0304;/g; #&#x0304;=macron, &#x0303;=tilde
      
         #substitute preferred character entities
         #in pairs that map to identical unicode characters
         s/&chacek;/&ccaron;/g;
         s/&ehacek;/&ecaron;/g;
         s/&shacek;/&scaron;/g;
         s/&male;/&Mars;/g;
         s/&female;/&Venus;/g;
         s/&half;/&frac12;/g;
         s/&mldr;/&hellip;/g;
         s/&rdquor;/&ldquo;/g;
         s/&rsquor;/&lsquo;/g;
         s/&bottom;/&perp;/g;
         s/&squ;/&square;/g;
         s/&die;/&uml;/g;
         s/&Dot;/&uml;/g;
         
         #substitute tcp spacing diacritical marks
         #for indistinct isodia entities
         s/&acute;/&spcacute;/g;
         s/&breve;/&spcbreve;/g;
         s/&caron;/&spccaron;/g;
         s/&cedil;/&spccedil;/g;
         s/&circ;/&spccirc;/g;
         s/&dblac;/&spcdblac;/g;
         s/&dot;/&spcdot;/g;
         s/&dotb;/&spcdotb;/g;
         s/&grave;/&spcgrave;/g;
         s/&macr;/&spcmacr;/g;
         s/&ogon;/&spcogon;/g;
         s/&ring;/&spcring;/g;
         s/&tilde;/&spctilde;/g;
         s/&uml;/&spcuml;/g;
         
         #PART 1.9. WRITE CONVERTED FILE
         
         print WRITEFILE $_;
      }
      
      close READFILE;
      close WRITEFILE;
      
      #
      # MAIN LOOP PART 2 OF 2:
      # change sgm entities and numbered entites
      # to Unicode characters
      #
      
      open READFILE, "<$newdir/$filetemp";
      open WRITEFILE, ">$newdir/$filefinal";
      
      $/ = "\n"; #make sure delimiter is new line.
      
      my %replHash = ();
      my $line = "";
      my $linect = 0;
      
      while ($line = <READFILE>) {
          while ( $line =~ m,&([A-Za-z0-9\#\.\-]+)[; :\,<\"\'\n\t],g ) {
          
              #special characters should end with semicolon ;
              #however, we include the following as possible errors:
              # TODO: EXAMINE IRREGULAR ENTITY ENDINGS AND TEST IN DETAIL
              # :,"' substitute &xxx;
              # <, space, tab, newline substitute &xxx;[character]
              # this does not find chars without close in the middles of words.
              



#    pfs:2008-08
#    The following lines, the heart of the character replacement engine,
#    have been removed and replaced by those that follow them. The problem
#    with the original code is that it assumed the (overly constrained)
#    entsgm-entview hash described at the head of this script. It assumed
#    that the entsgm found in the file would be either (1) a numeric entity
#    (in which case it would convert it to UTF8); or (2) a reserved XML
#    entity (amp, etc.) (in which case it would do nothing); or (3) an
#    SDATA entity listed in the entsgm-entview hash with a single numeric
#    Unicode entity as its entview target (in which case it would
#    replace it with the UTF8 equivalent of the hex value of the entview);
#    or (4) an SDATA entity listed in the entsgm-entview has with its
#    entview being a text string containing curly braces (in which case it would
#    insert the entview literally). It did not allow for entviews containing
#    multiple numeric entities, or entviews consisting of text strings 
#    containing numeric entities, or entviews consisting of
#    text strings that did not include curly braces.
#    
#              my $entsgm = $1;
#              if ( $entsgm =~ "\#x" ) {
#                 #replace unicode entities.
#                 my $entview = substr($entsgm,2);
#                 $line =~ s,&$entsgm;,hex2utf8($entview),ges;
#                 $replHash{$entview}++;
#              } else {
#                 if ( $entsgm !~ m,^(amp|quot|lt|gt|apos)$, ) {
#                     my $sub = $TcpToUnicodeHash{$entsgm};
#                     if ( ! $sub ) {
#                         $replHash{$entsgm}--;
#                     } elsif ($sub =~ "[{}]") {
#                         $line =~ s,\&$entsgm;,$sub,ges;
#                         $replHash{$entsgm}++;
#                     } else {
#                         $line =~ s,\&$entsgm;,hex2utf8($sub),ges;
#                         $replHash{$entsgm}++;
#                     }
#                 }
#              }
#          }
#      
#
#
#
#    These replacement lines, though they borrow much of the actual 
#    language of the original code, are much more simple minded.
#
#    As before, they define entsgm as an alphanumeric string beginning
#    with an ampersand and variously terminated (to allow for defective,
#    yet valid, SGML entities):
#
              my $entsgm = $1;

#    Then they replace entsgm with its entview partner from the TcpToUnicodeHash,
#    UNLESS it is a reserved entity or a numeric. Reserved entities and numerics
#    are left alone. Remember that entview is now a literal, and usually consists
#    of or at least includes at least one numeric entity (including delimiters),
#    but may contain other text, such as curly braces.
#
                 if ( $entsgm !~ m,^(amp|quot|lt|gt|apos|\#x[0-9A-G]+)$, ) {
                     my $sub = $TcpToUnicodeHash{$entsgm};
                     $line =~ s,\&$entsgm;,$sub,ges;
                     $replHash{$entsgm}++;
                     
                 }


          }

#    Then, via a clumsy additional WHILE loop, we replace all numeric
#    entities, including those added by the previous step, as well as
#    all the other numeric entities added at various stages to the file
#    (GAP displays, macrons, etc.) or resident in the file to begin with,
#    to their UTF-8 equivalents:

          while ( $line =~ m,&#x([0-9A-Z]+);,g ) {
          
             my $nument = $1 ;

             #replace numeric unicode entities.
             $line =~ s,&\#x$nument;,hex2utf8($nument),ges;
          }
      
#          $linect++;
      
          print WRITEFILE $line;
          #print REPORTFILE "$linect lines processesd\n" if (( $linect % 1000 ) == 0 );
      }
      
      #report to user
      print REPORTFILE "Character entities replaced:\n";

#   pfs:2008-08: This would seem to report the number of lines containing
#   a given replaced entity rather than the number of entities,
#   but no matter. As far as I can see, it always worked that way.

      
      if ( scalar( keys %replHash ) == 0 ) {
          print REPORTFILE "None replaced.\n";
      } else {
          foreach my $entsgm ( sort keys %replHash ) {
              my $count = $replHash{$entsgm};
              if ( $count > 0 ) {
                  print REPORTFILE "$entsgm $count\n";
              } else {
                  $count = -1*$count;
                  print REPORTFILE "$entsgm $count ERROR: No corresponding Unicode code point for this entity\n";
              }
          }
      }
      print STDERR "done.\n";
      
      close READFILE;
      close WRITEFILE;
      unlink("$newdir/$filetemp"); #delete tempfile.
      
      $currentfile++;
   }
}

close REPORTFILE;

print STDERR "Complete.\n"; #DEBUG
