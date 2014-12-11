while (<>){
	s/\&squ;/\&square;/g;
         s/="ILLEGIBLE"/="illegible"/g;
	 #PART 1.4. FIX GAP EXTENTs
         
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



s#_(<GAP[^>]*DESC="illegible"[^>]*EXTENT="1 letter"[^>]*>)#<DECOR>$1</DECOR>#g;
s#_(<GAP[^>]*DESC="illegible"[^>]*EXTENT="1"[^>]*>)#<DECOR>$1</DECOR>#g;


# pfs:2010-03  1.4B Routine to convert most underscores to SEGs:

# pfs:2010-03  First rename underscores before letters in contexts where you do not want to convert them

s#REF="([^"_]+_[^"_]+)_#REF="$1\{templowbar\}#g;
s#(<STC[^>]+>[^<]+)_#$1\{templowbar\}#g;

# pfs:2010-03  Then change _ to DECOR when it is followed by a letter, entity, apostrophe or (some) GAPs

s#_([A-Za-z'])#<DECOR>$1</DECOR>#g;
s#_(&[a-zA-Z0-9]+;)#<DECOR>$1</DECOR>#g;

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

         s,\^\^<GAP[^>]+DESC="illegible"[^>]*>,<HI REND="sub">&bull;</HI>,g;
         s,\^<GAP[^>]+DESC="illegible"[^>]*>,<hi rend="sup">&bull;</HI>,g;
         s,\^\^<GAP[^>]+DESC="(symbol|foreign)"[^>]*>,<HI REND="sub">&ballot;</HI>,g;
         s,\^<GAP[^>]+DESC="(symbol|foreign)"[^>]*>,<hi rend="sup">&ballot;</HI>,g;
         
         s,\^\^(&[^ ;]+;),<HI REND="sub">$1</HI>,g;
         s,\^(&[^ ;]+;),<hi rend="sup">$1</HI>,g;
         
         s,\^\^([a-zA-Z0-9\(\)\*\.:;\,]),<HI REND="sub">$1</HI>,g;
         s,\^([a-zA-Z0-9\(\)\*\.:;\,]),<hi rend="sup">$1</HI>,g;


  # pfs:2010-05 Deal with sub- or superscripted letter or entities also in HI or ABBR
  
         s,\^\^(<HI[^>]*>&[^ ;]+;</HI>),<HI REND="sub">$1</HI>,g;
         s,\^(<HI[^>]*>&[^ ;]+;</HI>),<hi rend="sup">$1</HI>,g;
         s,\^\^(<HI[^>]*>[a-zA-Z0-9\(\)\*\.:;\,]</HI>),<HI REND="sub">$1</HI>,g;
         s,\^(<HI[^>]*>[a-zA-Z0-9\(\)\*\.:;\,]</HI>),<hi rend="sup">$1</HI>,g;

         s,\^\^(<ABBR[^>]*>&[^ ;]+;</ABBR>),<HI REND="sub">$1</HI>,g;
         s,\^(<ABBR[^>]*>&[^ ;]+;</ABBR>),<hi rend="sup">$1</HI>,g;
         s,\^\^(<ABBR[^>]*>[a-zA-Z0-9\(\)\*\.:;\,]</ABBR>),<HI REND="sub">$1</HI>,g;
         s,\^(<ABBR[^>]*>[a-zA-Z0-9\(\)\*\.:;\,]</ABBR>),<hi rend="sup">$1</HI>,g;

  # pfs:2010-05 End of added code.
         
         #remove sequential superscript or subscript tags
         #so that tags contain character groups
         s,</HI><hi rend="sup">,,g;
         s,</HI><HI REND="sub">,,g;
         
         #PART 1.6. ADD DISP ATTRIBUTE TO GAPS
         
         #blank
         #s/(<GAP[^>]+DESC="blank"[^>]+EXTENT=")([^"]+)("[^>]*?)>/$1$2$3 DISP="&lang;$2 left blank&rang;">/g;
         

         #blank letter
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT="1)(\+?)( letters?)("[^>]*?)>/$1$2$3$4 DISP="_$2">/g;
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT="2)(\+?)( letters?)("[^>]*?)>/$1$2$3$4 DISP="__$2">/g;
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT="3)(\+?)( letters?)("[^>]*?)>/$1$2$3$4 DISP="___$2">/g;
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT="4)(\+?)( letters?)("[^>]*?)>/$1$2$3$4 DISP="____$2">/g;
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT="5)(\+?)( letters?)("[^>]*?)>/$1$2$3$4 DISP="_____$2">/g;
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT="6)(\+?)( letters?)("[^>]*?)>/$1$2$3$4 DISP="______$2">/g;
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT=")([7-9]|[0-9]{2,})(\+? letters?)("[^>]*?)>/$1$2$3$4 DISP="&lang;$2$3 left blank&rang;">/g;

         #blank word
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT="1)(\+?)( words?)("[^>]*?)>/$1$2$3$4 DISP=" _____ ">/g;
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT="2)(\+?)( words?)("[^>]*?)>/$1$2$3$4 DISP=" _____ _____ ">/g;
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT="3)(\+?)( words?)("[^>]*?)>/$1$2$3$4 DISP=" _____ _____ _____ ">/g;
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT="4)(\+?)( words?)("[^>]*?)>/$1$2$3$4 DISP=" _____ _____ _____ _____ ">/g;
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT="5)(\+?)( words?)("[^>]*?)>/$1$2$3$4 DISP=" _____ _____ _____ _____ _____ ">/g;
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT="6)(\+?)( words?)("[^>]*?)>/$1$2$3$4 DISP=" _____ _____ _____ _____ _____ _____ ">/g;
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT=")([7-9]|[0-9]{2,})(\+? words?)("[^>]*?)>/$1$2$3$4 DISP="&lang;$2$3 left blank&rang;">/g;

         #blank span, line, page, paragraph
         s/(<GAP[^>]+DESC="blank"[^>]*?EXTENT=")([0-9]*?\+? )(spans?|lines?|pages?|paragraphs?)("[^>]*?)>/$1$2$3$4 DISP="&lang;$2$3 left blank&rang;">/g;
         
         #duplicate
         s/(<GAP[^>]+DESC="duplicate"[^>]+EXTENT=")([^"]+)("[^>]*?)>/$1$2$3 DISP="&lang;$2 duplicate&rang;">/g;
         
         #foreign
         #in the line below, Perl requires a space after the &lang; variable
         s/(<GAP[^>]+DESC="foreign"[^>]*?)>/$1 DISP="&lang; in non-Latin alphabet &rang;">/g;
         
	 # if we're adding DISP to illegible gaps, first remove any we already find.
	 s/(<GAP[^>]+DESC="illegible"[^>]*)DISP="[^>]+">/$1>/g;
         #illegible letter
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="1)(\+?)( letters?)("[^>]*?)>/$1$2$3$4 DISP="&bull;$2">/g;
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="2)(\+?)( letters?)("[^>]*?)>/$1$2$3$4 DISP="&bull;&bull;$2">/g;
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="3)(\+?)( letters?)("[^>]*?)>/$1$2$3$4 DISP="&bull;&bull;&bull;$2">/g;
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="4)(\+?)( letters?)("[^>]*?)>/$1$2$3$4 DISP="&bull;&bull;&bull;&bull;$2">/g;
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="5)(\+?)( letters?)("[^>]*?)>/$1$2$3$4 DISP="&bull;&bull;&bull;&bull;&bull;$2">/g;
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="6)(\+?)( letters?)("[^>]*?)>/$1$2$3$4 DISP="&bull;&bull;&bull;&bull;&bull;&bull;$2">/g;
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT=")([7-9]|[0-9]{2,})(\+? letters?)("[^>]*?)>/$1$2$3$4 DISP="&lang;$2$3&rang;">/g;

         #illegible word
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="1)(\+?)( words?)("[^>]*?)>/$1$2$3$4 DISP="&lang;&loz;$2&rang;">/g;
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="2)(\+?)( words?)("[^>]*?)>/$1$2$3$4 DISP="&lang;&loz;&loz;$2&rang;">/g;
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="3)(\+?)( words?)("[^>]*?)>/$1$2$3$4 DISP="&lang;&loz;&loz;&loz;$2&rang;">/g;
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="4)(\+?)( words?)("[^>]*?)>/$1$2$3$4 DISP="&lang;&loz;&loz;&loz;&loz;$2&rang;">/g;
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="5)(\+?)( words?)("[^>]*?)>/$1$2$3$4 DISP="&lang;&loz;&loz;&loz;&loz;&loz;$2&rang;">/g;
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="6)(\+?)( words?)("[^>]*?)>/$1$2$3$4 DISP="&lang;&loz;&loz;&loz;&loz;&loz;&loz;$2&rang;">/g;
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT=")([7-9]|[0-9]{2,})(\+? words?)("[^>]*?)>/$1$2$3$4 DISP="&lang;$2$3&rang;">/g;

         #illegible span
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="[0-9]*?\+? ?spans?"[^>]*?)>/$1 DISP="&lang;&hellip;&rang;">/g;

         #illegible word-chunk
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT="1 chunk"[^>]*?)>/$1 DISP="&hellip;">/g;


         #illegible line, page, paragraph
         s/(<GAP[^>]+DESC="illegible"[^>]*?EXTENT=")([0-9]*?\+? )(lines?|pages?|paragraphs?)("[^>]*?)>/$1$2$3$4 DISP="&lang;$2$3&rang;">/g;

         #TODO
         #all other illegibles without DISP value.
         #cathces anything that has not been changed.
         #notably any GAP illegible without an EXTENT including 
         #letter|line|page|paragraph|span|word
         #s/(<GAP[^>]*?DESC="illegible"[^>]*?EXTENT=")([^"]*?)("[^>]*?)(?!DISP)([^>]*?)>/$1$2$3$5 DISP="&lang;$2&rang;">/g;
         
         #intruder
         s/(<GAP[^>]+DESC="intruder"[^>]+EXTENT=")([^"]*)("[^>]*?)>/$1$2$3 DISP="&lang;$2 inserted from a different book&rang;">/g;
         
         #math
         #in the line below, Perl requires a space after the &lang; variable
         s/(<GAP[^>]+DESC="math"[^>]*)>/$1 DISP="&lang; math &rang;">/g;
         
         #missing
         s/(<GAP[^>]+DESC="missing"[^>]+EXTENT=")([^"]*)("[^>]*?)>/$1$2$3 DISP="&lang;$2 missing&rang;">/g;
         
         #music
         s/(<GAP[^>]+DESC="music"[^>]*?)>/$1 DISP="&lang;&music;&rang;">/g;
         
         #omitted
         s/<GAP([^>]+DESC="omitted"[^>]+REND=")([^"]+)">/<gap$1$2" DISP="&lang; $2 &rang;">/g;
         s/<GAP([^>]+DESC="omitted"[^>]*)>/<gap$1 DISP="&lang; ---------- &rang;">/g;
         s/<gap/<GAP/g;
         
         
         #replacement
         s/(<GAP[^>]+DESC="replacement"[^>]+EXTENT=")([^"]*)("[^>]*?)>/$1$2$3 DISP="&lang;$2 supplied later&rang;">/g;
         
         #symbol
         s/(<GAP[^>]+DESC="symbol"[^>]*?EXTENT="1)(\+?)( [^"]*?)("[^>]*?)>/$1$2$3$4 DISP="&lang;&ballot;$2&rang;">/g;
         s/(<GAP[^>]+DESC="symbol"[^>]*?EXTENT="2)(\+?)( [^"]*?)("[^>]*?)>/$1$2$3$4 DISP="&lang;&ballot;&ballot;$2&rang;">/g;
         s/(<GAP[^>]+DESC="symbol"[^>]*?EXTENT="3)(\+?)( [^"]*?)("[^>]*?)>/$1$2$3$4 DISP="&lang;&ballot;&ballot;&ballot;$2&rang;">/g;
         s/(<GAP[^>]+DESC="symbol"[^>]*?EXTENT="4)(\+?)( [^"]*?)("[^>]*?)>/$1$2$3$4 DISP="&lang;&ballot;&ballot;&ballot;&ballot;$2&rang;">/g;
         s/(<GAP[^>]+DESC="symbol"[^>]*?EXTENT="5)(\+?)( [^"]*?)("[^>]*?)>/$1$2$3$4 DISP="&lang;&ballot;&ballot;&ballot;&ballot;&ballot;$2&rang;">/g;
         s/(<GAP[^>]+DESC="symbol"[^>]*?EXTENT="6)(\+?)( [^"]*?)("[^>]*?)>/$1$2$3$4 DISP="&lang;&ballot;&ballot;&ballot;&ballot;&ballot;&ballot;$2&rang;">/g;
         s/(<GAP[^>]+DESC="symbol"[^>]*?EXTENT=")([7-9]|[0-9]{2,})(\+? [^"]*?)("[^>]*?)>/$1$2$3$4 DISP="&lang;$2$3&rang;">/g;
         
         #change plus signs of continuance in DISPs to elipsis &hellip;
       #defective:  s/(DISP="[^\+]*?)\+([^ ][^"]*?")/$1&hellip;$2/g;
       #defective:  s/(DISP="[^\+]*?)\+"/$1&hellip;$2"/g;
       #pfs replacement:

	 s/(<GAP[^>]+DISP="[^\+">]+?)\+([^">]*?")/$1&hellip;$2/g;
        
         #Convert tilde to combining character
         s/\~/&cmbAbbrStroke;/g; #&cmbmacr;=macron, &#x0303;=tilde
      
	 print;
       }
