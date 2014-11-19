#!/bin/sh
repo_name=$1
user=$2
password=$3
test -z $repo_name && echo "Repo name required." 1>&2 && exit 1
curl -u $user:$password https://api.github.com/orgs/textcreationpartnership/repos -d "{\"name\":\"$repo_name\"}"
git init
git add $repo_name.xml
git commit -a -m "add text file"
git remote add origin "https://github.com/textcreationpartnership/$repo_name.git"
git push origin master
