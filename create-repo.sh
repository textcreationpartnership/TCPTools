#!/bin/sh
user=$1
password=$2
scriptdir=`dirname "$0"`
APPHOME=`(cd $scriptdir; pwd)`
for i in `find /Users/rahtz/TEI/tei.oucs.ox.ac.uk/Texts-TEI/free`
do
 name=`filename $i`
 mkdir $name
 cd $name
 cp $i .
 saxon $name.xml $APPHOME/MDown/genReadme.xsl >README.md
 curl -u $user:$password https://api.github.com/orgs/textcreationpartnership/repos -d "{\"name\":\"$name\"}"
 git init
 git add $name.xml README.md
 git commit -a -m "add text file and README"
 git remote add origin "https://github.com/textcreationpartnership/$name.git"
 git push origin master
 cd ..
done
