#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^FINAL PROVISIONS (ARTICLES 102 to 104).*$/,$p' | \
    sed -n '/^PRELIMINARY PART/,$p'
}

function replace_parentheses_around_article_delimiters_with_square_brackets {
  sed -E 's/^\(([A-Za-z0-9]+)\)/[\1]/'
}

function remove_all_text_after_last_article {
  sed -z 's/EXECUTIVE REGULATION OF LAW.*$//' 
}

function amend_errors_in_headers {
  sed -E 's/(PART )([A-Z]+)/\n\n\1\2 -/g' | \
    sed -E 's/(CHAPTER )([A-Z]+)/\n\n\1\2 -/g' | \
    sed -E 's/(Section )([A-Za-z]+)/\n\n\1\2 -/g' | \
    sed -z 's/PRELIMINARY \n\nPART /PRELIMINARY PART\n\n/' | \
    sed -E 's/FINAL PROVISIONS/\n\nFINAL PROVISIONS/' | \
    sed -E 's/CHAPTER - ONE/CHAPTER ONE -/'
}

function amend_errors_in_articles {
  sed -E 's/([A-Z])-/\1./g' | \
    sed -E 's/ ([A-Z])\. ([A-Z])/ [\L\1] \U\2/g' | \
    sed -E 's/([a-z])- ([A-Z])/[\1] \2/g' | \
    sed -E 's/Article/article/g' | \
    #Article 1
    amend_error_in_article 1 'efflusion' 'effusion' | \
    amend_error_in_article 1 '15: 1,000,000' '15:1,000,000' | \
    amend_error_in_article 1 '\[1977\]' '1977.' | \
    amend_error_in_article 1 '\[1992\]' '1992.' | \
    amend_error_in_article 1 'environment .' 'environment.' | \
    amend_error_in_article 1 '\(EEAA\)' '(EEAA).' | \
    amend_error_in_article 1 'Corporation. \(EGPC\)' 'Corporation (EGPC)' | \
    amend_error_in_article 1 'environment.nd' 'environment and' | \
    #Article 13
    amend_error_in_article 13 ' ,' ',' | \
    amend_error_in_article 13 'SecretaryGeneral' 'Secretary-General' | \
    #Article 14
    amend_error_in_article 14 '\[1983\]' '1983.' | \
    #Article 33
    amend_error_in_article 33 'shall occur' 'shall occur.' | \
    #Article 48
    amend_error_in_article 48 'para \(38\) of article \(1\)' 'para [38] of article 1' | \
    #Article 81
    amend_error_in_article 81 'State Council \[•\]' 'State Council -' | \
    amend_error_in_article 81 'Lighthouses Department' 'Lighthouses Department.' | \
    #Article 92
    amend_error_in_article 92 '54-b' '54[b]' | \
    amend_error_in_article 92 '\(1\)' '[1]' | \
    amend_error_in_article 92 '\(2\)' '[2]' | \
    amend_error_in_article9 2' \(3\)' '[3]'
}

function preprocess_state_and_language_input_file {
  if [ "$#" -ne 2 ] ; then
    echo_usage_error "$*" '<input_file_path> <language>'
    return 1
  fi
  local input_file_path="$1"
  local language="$2"

  cat "$input_file_path" | \
    remove_all_text_before_first_header | \
    replace_parentheses_around_article_delimiters_with_square_brackets | \
    apply_common_transformations_to_stdin "$language" | \
    remove_all_text_after_last_article | \
    amend_errors_in_headers | \
    amend_errors_in_articles
}