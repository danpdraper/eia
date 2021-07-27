#!/bin/bash

common_file_name="common.sh"

function preprocess_legislation {
  if [ "$#" -ne 4 ] ; then
    echo_usage_error "$*" '<state> <language> <raw_data_directory_path> <script_directory_path>'
    return 1
  fi
  local state="$1"
  local language="$2"
  local raw_data_directory_path="$3"
  local script_directory_path="$4"

  input_file_path="${raw_data_directory_path}/${state}_${language}.txt"
  if [ ! -f "$input_file_path" ] ; then
    echo_error "File $input_file_path does not exist."
    return 1
  fi

  output_file_path="${raw_data_directory_path}/preprocessed/${state}_${language}.txt"

  state_and_language_preprocessor_file_path="${script_directory_path}/${state}_${language}.sh"
  if [ ! -f "$state_and_language_preprocessor_file_path" ] ; then
    echo_error "File $state_and_language_preprocessor_file_path does not exist."
    return 1
  fi
  source "$state_and_language_preprocessor_file_path"

  echo_info "Preprocessing file $input_file_path."
  local start_time="$(date +%s%N)"
  preprocess_file "$input_file_path" "$output_file_path"
  local return_code="$?"
  local execution_time="$((($(date +%s%N) - $start_time) / 1000000))"

  if [ "$return_code" -ne 0 ] ; then
    echo_error "Failed to preprocess $input_file_path."
    return 1
  fi
  echo_info "Successfully preprocessed $input_file_path in $execution_time milliseconds."
  echo_info "Wrote result of preprocessing to $output_file_path."
}

function extract_state_and_language_from_script_file_name {
  if [ "$#" -ne 1 ] ; then
    echo_usage_error "$*" '<script_file_name>'
    return 1
  fi
  local script_file_name="$1"

  local script_file_name_words="$(echo ${script_file_name%.*} | tr '_' ' ')"
  script_file_name_words=($script_file_name_words)
  local language="${script_file_name_words[-1]}"
  unset script_file_name_words[-1]
  local state="$(echo ${script_file_name_words[@]} | tr ' ' '_')"
  echo "$state" "$language"
}

function preprocess_all_legislation {
  if [ "$#" -ne 2 ] ; then
    echo_usage_error "$*" '<raw_data_directory_path> <script_directory_path>'
    return 1
  fi
  local raw_data_directory_path="$1"
  local script_directory_path="$2"

  local script_file_path
  local script_file_name
  local state_and_language
  local return_code
  for script_file_path in "$script_directory_path"/* ; do
    script_file_name="$(basename $script_file_path)"
    if [ "$script_file_name" = "$common_file_name" ] ; then continue ; fi
    if [ "$script_file_name" = "$(basename $BASH_SOURCE)" ] ; then continue ; fi

    state_and_language="$(extract_state_and_language_from_script_file_name $script_file_name)"
    return_code="$?"
    if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi
    state_and_language=($state_and_language)

    preprocess_legislation "${state_and_language[@]}" "$raw_data_directory_path" "$script_directory_path"
    return_code="$?"
    if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi
  done

  echo_info "Successfully preprocessed all legislation."
}

raw_data_directory_path="$(cd $(pwd $(dirname $BASH_SOURCE))/.. && pwd)/raw_data"
if [ ! -d "$raw_data_directory_path" ] ; then
  echo_error "Unexpected directory structure. $raw_data_directory_path does not exist."
  exit 1
fi

script_directory_path="$(pwd $(dirname $BASH_SOURCE))"
if [ ! -d "$script_directory_path" ] ; then
  echo_error "Unexpected directory structure. $script_directory_path does not exist."
  exit 1
fi

if [ "$#" -ne 0 ] && [ "$#" -ne 2 ] ; then
  echo_error "USAGE: $(basename $0) [state language]"
  echo_error "PROVIDED: $(basename $0) $*"
  echo_error "Invoking $(basename $0) without any arguments will preprocess ALL legislation."
  exit 1
fi
state="$1"
language="$2"

common_file_path="${script_directory_path}/${common_file_name}"
if [ ! -f "$common_file_path" ] ; then
  echo_error "File $script_file_path does not exist."
  exit 1
fi
source "$common_file_path"

if [ "$#" -eq 0 ] ; then
  preprocess_all_legislation "$raw_data_directory_path" "$script_directory_path"
  return_code="$?"
fi

if [ "$#" -eq 2 ] ; then
  preprocess_legislation "$state" "$language" "$raw_data_directory_path" "$script_directory_path"
  return_code="$?"
fi

exit "$return_code"
