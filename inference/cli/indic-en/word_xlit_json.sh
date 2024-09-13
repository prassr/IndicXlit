#!/bin/bash

# Check if the input file is provided
if [ -z "$1" ]; then
	echo "Usage: $0 metadata.json lang_id"
	echo "lang_id: hi, gu, mr, ta, te, ur, bn, pa, or en, etc."
	exit 1
fi

if [ -z "$2" ]; then
	echo "Usage: $0 metadata.json lang_id"
	echo "lang_id: hi, gu, mr, ta, te, ur, bn, pa, or en, etc."
	exit 1
fi

# Use jq to extract the desired fields and read them line by line
jq -r '[."text", ."filepath"] | @tsv' "$1" | while IFS=$'\t' read -r text filepath; do
	word=""

	# Loop through each character in the text
	for ((i = 0; i < ${#text}; i++)); do
		char="${text:i:1}" # Extract the character at position i

		# Check if the character is a space
		if [[ "$char" != " " ]]; then
			word+="$char " # Append the character to the result string
		else
			echo "$word" >>sentence.txt
			word=""
		fi
	done
	echo "$word" >>sentence.txt
	cat sentence.txt
	# till now a single sentence is processed
	# >sentence.txt
	# model support the following languages : [as, bn, brx, gom, gu, hi, kn, ks, mai, ml, mni, mr, ne, or, pa, sa, sd, si, ta, te, ur]
	# -l = language code :: str
	# -i = name of the input file :: str
	# -b = beam size :: int
	# -n = best n candidates (b>=n) :: int
	# -r = rerank :: boolean (1 or 0)
	bash transliterate_word.sh -l "$2" -i 'sentence.txt' -b 10 -n 5 -r 1
	>sentence.txt
	cat output/transliterated_sentence.txt
done
