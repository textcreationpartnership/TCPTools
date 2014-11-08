#!/bin/sh
TEXTS=/Volumes/Repo/TEI

validate-jing: 
	-(for i in $(TEXTS)/Texts-TEI/???; do time jing tcp.rng Texts/$$i/*.xml; done)

epub:
	./makeEpub --threads=3

convert:
	./makeConvert --threads=3

analyze:
	find eebo-p5 -name "*.xml" -exec xsltproc --stringparam File {} milestones.xsl {}  \; > milestones.txt

summary:
	EEBO=`ls eebo-p5 | wc -l`;ECCO=`ls ecco-p5 | wc -l`;echo ECCO: $$ECCO texts, `grep ecco LOG.tei | sed 's/:.*//' | sort -u | wc -l` invalid;echo EEBO: $$EEBO texts, `grep eebo LOG.tei | sed 's/:.*//' | sort -u | wc -l` invalid


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

