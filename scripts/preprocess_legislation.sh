#!/bin/bash

function echo_error {
  >&2 echo "ERROR: $1"
}

function echo_info {
  echo "INFO: $1"
}

raw_data_directory_path="$(cd $(pwd $(dirname $BASH_SOURCE))/.. && pwd)/raw_data"
if [ ! -d "$raw_data_directory_path" ] ; then
  echo_error "Unexpected directory structure. $raw_data_directory_path does not exist."
  exit 1
fi

if [ "$#" -ne 2 ] ; then echo_error "USAGE: $(basename $0) <state> <language>" ; exit 1 ; fi
state="$1"
language="$2"

input_file_path="${raw_data_directory_path}/${state}_${language}.txt"
if [ ! -f "$input_file_path" ] ; then echo_error "File $input_file_path does not exist." ; exit 1 ; fi

output_file_path="${raw_data_directory_path}/preprocessed/${state}_${language}.txt"

echo_info "Preprocessing file $input_file_path."
file_preprocessed=0

# Central African Republic - French
if [ "$state" = central_african_republic ] && [ "$language" = french ] ; then
  cat $input_file_path | \
    tr '\n' ' ' | \
    sed -E 's/.(TITRE|CHAPITRE|Section|Art)/\n\n\1/g' | \
    sed -E 's/(1|I)er/\1/g' | \
    sed -E 's/ (:|;)/\1/g' | \
    sed -E 's/- //g' | \
    sed -E 's/Art\. ([0-9]+):/(\1)/' > $output_file_path
  if [ "$?" -eq 0 ] ; then file_preprocessed=1 ; fi
fi

if [ "$file_preprocessed" -ne 1 ] ; then
  echo_error "File $input_file_path was not preprocessed due to a lack of \
    corresponding preprocessing code. Please update this script."
  exit 1
fi

echo_info "Successfully preprocessed $input_file_path. Wrote result of preprocessing to $output_file_path."
