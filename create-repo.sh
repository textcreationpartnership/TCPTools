#!/bin/sh
name=$1
user=$2
password=$3
test -z $name && echo "Repo name required." 1>&2 && exit 1
scriptdir=`dirname "$0"`
APPHOME=`(cd $scriptdir; pwd)`
mkdir $name
cd $name
D=`echo $name | sed 's/\(...\).*/\1/'`
cp /Users/rahtz/TEI/tei.oucs.ox.ac.uk/Projects/EEBO/Texts-TEI/free/$D/$name.xml .
saxon $name.xml $APPHOME/MDown/genReadme.xsl >README.md
curl -u $user:$password https://api.github.com/orgs/textcreationpartnership/repos -d "{\"name\":\"$name\"}"
git init
git add $name.xml README.md
git commit -a -m "add text file and README"
git remote add origin "https://github.com/textcreationpartnership/$name.git"
git push origin master
