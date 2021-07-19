#!/bin/bash

function remove_all_text_before_first_chapter_header {
  sed -n '/CHAPITRE 1 /,$p'
}

function remove_signatory_details {
  sed -E 's/ Fait à Kisangani.*$//'
}

function remove_all_text_after_last_article {
  sed -E '/^\(89\)/q'
}

function remove_page_headers_and_footers {
  sed -E 's/ ?Journal officiel Numéro Spécial 16 juillet 2011 [0-9]+//g'
}

function expand_ordinal_abbreviations {
  sed -E 's/1er/premier/g'
}

function format_definitions_article {
  sed -E ':start;s/^(\(2\).* )([0-9]+)\./\1(\2)/;t start'
}

function preprocess_state_and_language_input_file {
  if [ "$#" -ne 2 ] ; then
    echo_error "USAGE: ${FUNCNAME[0]} <input_file_path> <language>"
    return 1
  fi
  local input_file_path="$1"
  local language="$2"

  apply_common_transformations "$input_file_path" "$language" | \
    remove_all_text_before_first_chapter_header | \
    remove_signatory_details | \
    remove_all_text_after_last_article | \
    remove_page_headers_and_footers | \
    expand_ordinal_abbreviations | \
    format_definitions_article
}
