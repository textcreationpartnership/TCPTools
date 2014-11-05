#!/bin/sh
ECCO="/Users/rahtz/GoogleDrive/TCP_common_files/ECCO_TCP_update/all-texts/texts-XML/"
ECCOHEADERS="/Users/rahtz/GoogleDrive/TCP_common_files/ECCO_TCP_update/headers/"

EEBO="/Users/rahtz/GoogleDrive/TCP/eebo1/XML /Users/rahtz/GoogleDrive/TCP/eebo2/XML"
EEBOHEADERS="/Users/rahtz/GoogleDrive/TCP/eebo1/headers/ /Users/rahtz/GoogleDrive/TCP/eebo2/headers/"

EVANS="/Users/rahtz/GoogleDrive/TCP/evans/XML"
EVANSHEADERS="/Users/rahtz/GoogleDrive/TCP/evans/headers/"

ANT=ANT_OPTS="-Xss2m -Xmx752m" ant -lib /usr/share/java/jing.jar:/usr/share/saxon/saxon9he.jar -Dtrang=/usr/share/trang/trang.jar

go:  unpack epub 

unpack: unpackecco unpackeebo unpackevans
	rm Texts/A40/A40724.*

fix:
	cp A00005.xml.new eebo/A00005.xml
	rm eebo/A25384.* eebo/A59854.* eebo/A71303.*
	perl -p -i -e 's/ \& / &amp; /' eebo/A97358.hdr


validate-jing: 
	-(for i in TCP/???; do time jing tcp.rng Texts/$$i/*.xml; done)

validate:
	find TCP -name "*.xml" -exec xmllint --noout --dtdvalid tcp.dtd {} \;

validate-all:
	find TCP -name "*.xml" -exec rnv tei_all.rnc {} \;

epub:
	./makeEpub --threads=3

convert:
	./makeConvert --threads=3

analyze:
	find eebo-p5 -name "*.xml" -exec xsltproc --stringparam File {} milestones.xsl {}  \; > milestones.txt

differentschemas:
	rm -f List.* Results.*
	find Texts -name "*.xml" > XMLFILES
	(cat XMLFILES | xargs rnv tei_all.rnc  >& Results.tei ; grep -i " error:" Results.tei | sed 's/.xml:.*//' | sort -u > List.tei) &
	for i in 0 1 2 3 4 7;   do  ( (cat XMLFILES | xargs rnv tcp$$i.rnc >& Results.$$i  ;  grep -i " error:" Results.$$i | grep -v "some documents are invalid" | sed 's/.xml:.*//' | sort -u > List.$$i) & );  done


unpackecco:
	rm -rf tcp
	curl -O http://www.textcreationpartnership.org/docs/code/eebo2prf.xml.dtd
	mkdir -p tcp
	for i in `echo $(ECCOHEADERS)`; do for j in $$i/*tgz; do echo unpack $$j; tar zxf $$j -C tcp;  done; done
	for i in `echo $(ECCO)`; do for j in $$i/*tgz;  do echo unpack $$j; tar zxf $$j -C tcp; done; done
	find tcp -name "*.xml" -exec ./changedtd {}  \;
	rm -rf tcp

unpackeebo:
	rm -rf tcp
	mkdir -p tcp
	curl -O http://www.textcreationpartnership.org/docs/code/eebo2prf.xml.dtd
	for i in `echo ${EEBOHEADERS}`; do for j in $$i/*tgz; do echo unpack $$j; tar zxf $$j --strip-components=1 -C tcp;  done; done
	for i in `echo ${EEBO}`; do for j in $$i/*-xml-*tgz;  do echo unpack $$j; tar zxf $$j -C tcp; done; done
	rm -rf tcp/redelivered
	find tcp -name "*.xml" -exec ./changedtd {}  \;
	rm -rf tcp
	-rm Texts/A40/A40724.tcp

unpackevans:
	rm -rf tcp
	mkdir -p tcp
	curl -O http://www.textcreationpartnership.org/docs/code/eebo2prf.xml.dtd
	for i in `echo ${EVANSHEADERS}`; do for j in $$i/*tgz; do echo unpack $$j; tar zxf $$j --strip-components=1 -C tcp;  done; done
	for i in `echo ${EVANS}`; do for j in $$i/*tgz;  do echo unpack $$j;  tar zxf $$j -C tcp; done; done
	find tcp -name "*.xml" -exec ./changedtd {}  \;
	rm -rf tcp

summary:
	EEBO=`ls eebo-p5 | wc -l`;ECCO=`ls ecco-p5 | wc -l`;echo ECCO: $$ECCO texts, `grep ecco LOG.tei | sed 's/:.*//' | sort -u | wc -l` invalid;echo EEBO: $$EEBO texts, `grep eebo LOG.tei | sed 's/:.*//' | sort -u | wc -l` invalid

errs: 
	grep xml LOG.tei | sed 's/;.*//' > errs.txt
	saxon -it:main errors.xsl > errs.xml

schema:

	teitornc --localsource=/Users/rahtz/TEI/Sourceforge/tei-code/P5/p5subset.xml --schema=tcp  tcp.odd tcp0.rnc
	teitornc --localsource=/Users/rahtz/TEI/Sourceforge/tei-code/P5/p5subset.xml --schema=tcp1 tcp.odd tcp1.rnc
	teitornc --localsource=/Users/rahtz/TEI/Sourceforge/tei-code/P5/p5subset.xml --schema=tcp2 tcp.odd tcp2.rnc
	teitornc --localsource=/Users/rahtz/TEI/Sourceforge/tei-code/P5/p5subset.xml --schema=tcp3 tcp.odd tcp3.rnc
	teitornc --localsource=/Users/rahtz/TEI/Sourceforge/tei-code/P5/p5subset.xml --schema=tcp4 tcp.odd tcp4.rnc
	teitornc --localsource=/Users/rahtz/TEI/Sourceforge/tei-code/P5/p5subset.xml --schema=tcp5 tcp.odd tcp7.rnc
	cp tcp0.rnc tcp.rnc

demofiles:
	teitoepub --profile=ota test1.xml demo/test1.epub
	teitoepub3 --profile=ota test1.xml demo/test1_3.epub
	sed 's/pb rend=.none./pb/' < test1.xml > test1-fixed.xml
	teitoepub --profile=otapages test1-fixed.xml demo/test1-fixed.epub
	teitoepub3 --profile=otapages test1-fixed.xml demo/test1_3-fixed.epub
	teitoepub --profile=ota test2.xml demo/test2.epub
	teitoepub3 --profile=ota test2.xml demo/test2_3.epub
	sed 's/pb rend=.none./pb/' < test2.xml > test2-fixed.xml
	teitoepub --profile=otapages test2-fixed.xml demo/test2-fixed.epub
	teitoepub3 --profile=otapages test2-fixed.xml demo/test2_3-fixed.epub
	teitodocx test1.xml demo/test1.docx
	teitodocx test2.xml demo/test2.docx
	-(cd demo;kindlegen test1.epub)
	-(cd demo;kindlegen test2.epub)
	teitolatex test1.xml ;xelatex test1;xelatex test1;xelatex test1
	teitolatex test2.xml ;xelatex test2;xelatex test2;xelatex test2
	mv test*pdf demo
	-rm *.aux *.tex *.out *.log

csv:
	java -Xmx40000m -jar /Users/rahtz/Dropbox/bin/saxon9he.jar -it:main -xsl:extract.xsl > TCP.csv

slides:
	saxon talk.xml slides.xsl > talk.tex && xelatex talk && xelatex talk

clean:
	rm -f *.aux *.log *.out *.snm *.nav *.tex *.toc *.vrb	
	rm -f List.* Results.* job_* tcp*rnc tcp*rng
	rm -f      eeboheaders.list
	rm -f      test1-fixed.xml
	rm -f      test2.xml.rdf
	rm -f      eccoheaders.list
	rm -f      TCP.csv
	rm -f      XMLFILES
	rm -f      errs.txt
	rm -f      test.epub
	rm -f      errs.xml
	rm -f      list
	rm -f      ecco.list
	rm -f      eebo.list
	rm -f      epubs.xml
	rm -f testrun.xml
