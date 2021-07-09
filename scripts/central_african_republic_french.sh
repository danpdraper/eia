#!/bin/bash

function remove_all_text_before_first_title_header {
  sed -n '/TITRE I /,$p'
}

function remove_signatory_details {
  sed -E "s/ LE GENERAL D’ARMEE.*$//"
}

function remove_page_headers_and_footers {
  local stdin=$(</dev/stdin)
  local regular_expression="( )?J\.O\.R\.C\.A\. \/ MARS 2008 EDITION SPECIALE "
  regular_expression+="LOI PORTANT CODE DE L’ENVIRONNEMENT DE LA REPUBLIQUE "
  regular_expression+="CENTRAFRICAINE [0-9]+( )?"
  echo "$stdin" | sed -E "s/${regular_expression}//g"
}

function remove_trailing_colons_from_lines {
  sed -E 's/: ?$//'
}

function remove_spaces_from_numbers {
  sed -E 's/([0-9])(\. | \.)([0-9])/\1.\3/g'
}

function preprocess_state_and_language_input_file {
  if [ "$#" -ne 2 ] ; then
    echo_error "USAGE: ${FUNCNAME[0]} <input_file_path> <language>"
    return 1
  fi
  local input_file_path="$1"
  local language="$2"

  apply_common_transformations "$input_file_path" "$language" | \
    remove_all_text_before_first_title_header | \
    remove_signatory_details | \
    remove_page_headers_and_footers | \
    remove_trailing_colons_from_lines | \
    remove_spaces_from_numbers
}
