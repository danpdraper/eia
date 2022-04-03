#!/usr/bin/env bash

common_file_name="common.sh"
preprocessed_directory_name=preprocessed
unprocessed_directory_name=unprocessed

function preprocess_legislation {
  if [ "$#" -ne 5 ] ; then
    echo_usage_error "$*" '<state> <language> <unprocessed_raw_data_directory_path> \
      <preprocessed_raw_data_directory_path> <script_directory_path>'
    return 1
  fi
  local state="$1"
  local language="$2"
  local unprocessed_raw_data_directory_path="$3"
  local preprocessed_raw_data_directory_path="$4"
  local script_directory_path="$5"

  local error_message

  local input_file_path="$(find "$unprocessed_raw_data_directory_path" -type f -name "${state}_${language}.txt")"
  if [ ! -f "$input_file_path" ] ; then
    error_message="There is no file named ${state}_${language}.txt in "
    error_message+="${unprocessed_raw_data_directory_path}."
    echo_error "$error_message"
    return 1
  fi

  local escaped_unprocessed_raw_data_directory_path="$(
    echo "$unprocessed_raw_data_directory_path" | sed -E 's/\//\\\//g')"
  local input_file_path_suffix="$(
    echo "$input_file_path" | sed -E "s/${escaped_unprocessed_raw_data_directory_path}//")"
  local output_file_path="${preprocessed_raw_data_directory_path}${input_file_path_suffix}"
  local output_directory_path="$(dirname $output_file_path)"
  if [ ! -d "$output_directory_path" ] ; then
    echo_error "Directory $output_directory_path does not exist."
    return 1
  fi

  local state_and_language_preprocessor_file_path="$(
    find "$script_directory_path" -type f -name "${state}_${language}.sh")"
  if [ ! -f "$state_and_language_preprocessor_file_path" ] ; then
    error_message="There is no file named ${state}_${language}.sh in "
    error_message+="${script_directory_path}."
    echo_error "$error_message"
    return 1
  fi
  source "$state_and_language_preprocessor_file_path"

  echo_info "Preprocessing file $input_file_path."
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    local start_time="$(date +%s%N)"
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    local start_time="$(date +%s)"
  else 
    echo_error "os not supported"
  fi
  
  preprocess_file "$input_file_path" "$output_file_path"
  local return_code="$?"

  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    local execution_time="$((($(date +%s%N) - $start_time) / 1000000))"
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    local execution_time="$((($(date +%s) - $start_time) * 1000))"
  fi

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
  if [ "$#" -ne 3 ] ; then
    echo_usage_error "$*" '<unprocessed_raw_data_directory_path> \
      <preprocessed_raw_data_directory_path <script_directory_path>'
    return 1
  fi
  local unprocessed_raw_data_directory_path="$1"
  local preprocessed_raw_data_directory_path="$2"
  local script_directory_path="$3"

  local script_file_path
  local script_file_name
  local state_and_language
  local return_code
  for script_file_path in $(find "$script_directory_path" -type f) ; do
    script_file_name="$(basename "$script_file_path")"
    if [ "$script_file_name" = "$common_file_name" ] ; then continue ; fi
    if [ "$script_file_name" = "$(basename $BASH_SOURCE)" ] ; then continue ; fi
    if [[ "$script_file_name" =~ '.swp' ]] ; then continue ; fi

    state_and_language="$(extract_state_and_language_from_script_file_name "$script_file_name")"
    return_code="$?"
    if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi
    state_and_language=($state_and_language)

    preprocess_legislation "${state_and_language[@]}" "$unprocessed_raw_data_directory_path" \
      "$preprocessed_raw_data_directory_path" "$script_directory_path"
    return_code="$?"
    if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi
  done

  echo_info "Successfully preprocessed all legislation."
}

raw_data_directory_path="$(cd "$(dirname $BASH_SOURCE)/../../raw_data" && pwd)"
if [ ! -d "$raw_data_directory_path" ] ; then
  2>&1 echo "Unexpected directory structure. $raw_data_directory_path does not exist."
  exit 1
fi

preprocessed_raw_data_directory_path="${raw_data_directory_path}/${preprocessed_directory_name}"
if [ ! -d "$preprocessed_raw_data_directory_path" ] ; then
  2>&1 echo "Unexpected directory structure. $preprocessed_raw_data_directory_path does not exist."
  exit 1
fi

unprocessed_raw_data_directory_path="${raw_data_directory_path}/${unprocessed_directory_name}"
if [ ! -d "$unprocessed_raw_data_directory_path" ] ; then
  2>&1 echo "Unexpected directory structure. $unprocessed_raw_data_directory_path does not exist."
  exit 1
fi

script_directory_path="$(cd "$(dirname $BASH_SOURCE)" && pwd)"
if [ ! -d "$script_directory_path" ] ; then
  2>&1 echo "Unexpected directory structure. $script_directory_path does not exist."
  exit 1
fi

if [ "$#" -ne 0 ] && [ "$#" -ne 2 ] ; then
  2>&1 echo "USAGE: $(basename $0) [state language]"
  2>&1 echo "PROVIDED: $(basename $0) $*"
  2>&1 echo "Invoking $(basename $0) without any arguments will preprocess ALL legislation."
  exit 1
fi
state="$1"
language="$2"

common_file_path="${script_directory_path}/${common_file_name}"
if [ ! -f "$common_file_path" ] ; then
  2>&1 echo "File $common_file_path does not exist."
  exit 1
fi
source "$common_file_path"

if [ "$#" -eq 0 ] ; then
  preprocess_all_legislation "$unprocessed_raw_data_directory_path" \
    "$preprocessed_raw_data_directory_path" "$script_directory_path"
  return_code="$?"
fi

if [ "$#" -eq 2 ] ; then
  preprocess_legislation "$state" "$language" "$unprocessed_raw_data_directory_path" \
    "$preprocessed_raw_data_directory_path" "$script_directory_path"
  return_code="$?"
fi

exit "$return_code"
