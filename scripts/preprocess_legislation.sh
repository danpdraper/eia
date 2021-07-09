#!/bin/bash

raw_data_directory_path="$(cd $(pwd $(dirname $BASH_SOURCE))/.. && pwd)/raw_data"
if [ ! -d "$raw_data_directory_path" ] ; then
  echo_error "Unexpected directory structure. $raw_data_directory_path does not exist."
  exit 1
fi

if [ "$#" -ne 2 ] ; then
  echo_error "USAGE: $(basename $0) <state> <language>"
  exit 1
fi
state="$1"
language="$2"

input_file_path="${raw_data_directory_path}/${state}_${language}.txt"
if [ ! -f "$input_file_path" ] ; then
  echo_error "File $input_file_path does not exist."
  exit 1
fi

output_file_path="${raw_data_directory_path}/preprocessed/${state}_${language}.txt"

script_directory_path="$(pwd $(dirname $BASH_SOURCE))"

common_file_path="${script_directory_path}/common.sh"
if [ ! -f "$common_file_path" ] ; then
  echo_error "File $script_file_path does not exist."
  exit 1
fi
source "$common_file_path"

state_and_language_preprocessor_file_path="${script_directory_path}/${state}_${language}.sh"
if [ ! -f "$state_and_language_preprocessor_file_path" ] ; then
  echo_error "File $state_and_language_preprocessor_file_path does not exist."
  exit 1
fi
source "$state_and_language_preprocessor_file_path"

echo_info "Preprocessing file $input_file_path."
preprocess_file "$input_file_path" "$output_file_path"

if [ "$?" -ne 0 ] ; then
  echo_error "Failed to preprocess $input_file_path."
  exit 1
fi
echo_info "Successfully preprocessed $input_file_path. Wrote result of preprocessing to $output_file_path."
