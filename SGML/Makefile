test:
	osx -ccatalog -xlower -xcomment -xempty -xndata test.sgm  | xmllint --format - > test.xml

charmap:
	perl -p -e 's/\&#/%%/g' charmap.sgm | \
	osx -ccatalog -xlower -xcomment -xempty -xndata - | \
	perl -p -e 's/%%/\&#/g' | \
	perl -p -e 's/#xU/#x/' | xmllint --format - > charmap.xml
	saxon  charmap.xml charmap2tei.xsl

eebodat:
	osx -ccatalog -xlower -xcomment -xempty -xndata eebodat0.sgm  | xmllint --format - > eebodat0.xml
	saxon eebodat0.xml listyears.xsl > makejob.pl 

