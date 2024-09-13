#!/bin/bash

function usage() {
	echo "Usage: $0 metadata.json lang_id output_path"
	echo "lang_id: hi, gu, mr, ta, te, ur, bn, pa, or en, etc."
	echo "output_path: output.txt"
	exit 1
}

# Check if the input file is provided
if [ -z "$1" ]; then
	usage
fi

if [ -z "$2" ]; then
	usage
fi

if [ -z "$3" ]; then
	usage
fi

if [ -s "$3" ]; then
	echo "The file '$3' is not empty. Pleae make sure it is empty"
	exit 1
fi

# Define the output directory
output="output"
if [ ! -d "$output" ]; then
	mkdir "$output"
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
	# till now a single sentence is processed
	# >sentence.txt
	# model support the following languages : [as, bn, brx, gom, gu, hi, kn, ks, mai, ml, mni, mr, ne, or, pa, sa, sd, si, ta, te, ur]
	# -l = language code :: str
	# -i = name of the input file :: str
	# -b = beam size :: int
	# -n = best n candidates (b>=n) :: int
	# -r = rerank :: boolean (1 or 0)
	bash transliterate_word.sh -l "$2" -i 'sentence.txt' -b 10 -n 5 -r 1 2>error.log 1>out.log
	>sentence.txt
	echo -en "${filepath}\t" >>"$3" # new
	cat output/final_transliteration.txt >>"$3"
	echo "" >>"$3"
	echo -n "${text}: "
	cat output/final_transliteration.txt
	echo ""
done

# cleanup
# rm sentence.txt
