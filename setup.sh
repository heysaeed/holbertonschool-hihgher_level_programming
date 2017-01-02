#!/bin/bash
echo "Enter the file name of your HTML page."
read INPUT
ls $INPUT
if [[ $? != 0 ]]; then
	exit 1
fi
DIR=$(grep Directory: $INPUT | head -1 | cut -d \> -f3 | cut -d \< -f1)
mkdir $DIR
cp $INPUT $DIR
cd $DIR
echo -e "a.out\n*.swp\n~*\n_betty-s\n_betty-d\n" >> .gitignore
#Create the files
touch $(grep File: $INPUT | cut -d \> -f3 | cut -d \< -f1)
echo '#!/usr/bin/python3' > py_template
echo '#!/bin/bash' > sh_template
find . -type f -empty -exec cp sh_template '{}' \; -exec chmod u+x '{}' \;
find . -type f -name "*.py" -exec cp py_template '{}' \; -exec chmod u+x '{}' \;
rm *template
#README.md
echo "#Holberton School - "$DIR > README.md
echo "Description" >> README.md
echo "## New commands / functions used:" >> README.md
echo "\`\`gcc\`\`" >> README.md
echo "## Helpful Links" >> README.md
A=$(grep -n "<h2>" $INPUT | grep -A1 "Readme" | cut -d : -f 1 | head -1)
B=$(grep -n "<h2>" $INPUT | grep -A1 "Readme" | cut -d : -f 1 | tail -1)
tail -n +$A $INPUT | head -n $(($B-$A)) | grep "<a href=" | sed 's/<a href=\"/\n/g' | grep "http" | cut -d \" -f1 | sed 's/^/* [link](/;s/$/)/' >> README.md
echo "## Description of Files" >> README.md
head -8 README.md > README.md.tmp
ls -1 | grep "[0-9]-" | sort -h | sed 's/^/<h6>/g;s/$/<\/h6>\n/g' >> README.md.tmp
mv README.md.tmp README.md
find . -depth -type f -empty -exec rm '{}' \;
rm ../$INPUT

