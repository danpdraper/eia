#!/bin/bash

function remove_all_text_before_first_title_header {
  sed -n '/TITRE I /,$p'
}

function remove_signatory_details {
  sed -E 's/\.\/YAOUNDE, LE LE PRESIDENT.*$//'
}

function remove_bullet_points {
  sed -E 's/\x01 //g'
}

function amend_typo_in_title_header {
  sed -E 's/ TITIRE II/\n\nTITRE II -/'
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
    remove_bullet_points | \
    amend_typo_in_title_header | \
    rearrange_article_and_subarticle_numbers
}