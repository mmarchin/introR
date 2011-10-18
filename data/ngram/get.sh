#!/bin/bash

for i in {1..9}
do
	echo "wget -q http://commondatastorage.googleapis.com/books/ngrams/books/googlebooks-eng-all-1gram-20090715-$i.csv.zip && unzip -p googlebooks-eng-all-1gram-20090715-$i.csv.zip | grep -w -f mywords.txt > mywords.$i.txt &&\\"
done

#note, this isn't perfect, because it gets stuff with &, ' , etc. 

