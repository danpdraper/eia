#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^Swaziland Environment Authority/,$p' | \
    sed -n '/^PART I - INTRODUCTORY PROVISIONS/,$p' 
}

function prefix_article_numbers_with_article_literal {
  sed -E 's/^([0-9]+\.)/Article \1/'
}

function replace_parentheses_around_article_delimiters_with_square_brackets {
  sed -E 's/\(([A-Za-z0-9]+)\)/[\1]/g'
}

function move_article_titles_after_article_numbers {
  sed -En '${p;q};N;/\nArticle/{s/^(.*)\n(Article [0-9]+\.) /\2 \1|/p;b};P;D'
}

function move_article_titles_above_articles {
  sed -E 's/^(\([0-9]+\) )([^|]+)\|/\2\n\1/'
}

function remove_all_text_after_last_article {
  sed -E '/^\(90\) /,${/^\(90\)/!d}' 
}

function amend_errors_in_headers {
  sed -E 's/(PART [A-Z]+ )\[•\]/\n\n\1-/g' 
}

function amend_errors_in_articles {
  sed -E 's/ \[•\]/:/g' | \
    sed -E 's/([a-z])- /\1: /g' | \
    sed -E 's/ section \[([0-9]+)\] / section \1. /' | \
    #Article 2
    amend_error_in_article 2 ', “' '; “' | \
    amend_error_in_article 2 '“Ministry “' '“Ministry”' | \
    amend_error_in_article 2 '. “regulations,”' '; “regulations”' | \
    amend_error_in_article 2 '; \[2\]' '. [2]' | \
    #Article 11
    amend_error_in_article 11 'Schedule \[1\]' 'Schedule 1.' | \
    #Article 15
    amend_error_in_article 15 '\[b\] work' '[d] work' | \
    #Article 32
    amend_error_in_article 32 'aim\[s\]' 'aim(s)' | \
    #Article 33
    amend_error_in_article 32 'Article \[33\] Regulations\|' '\n\nRegulations\n(33) ' | \
    #Article 41
    amend_error_in_article 41 'shall,on' 'shall, on' | \
    #Article 51
    amend_error_in_article 51 'natural resources' 'natural resources.' | \
    #Article 52
    amend_error_in_article 52 ',:' ':' | \
    amend_error_in_article 52 '\[s\]' '(s)' | \
    #Article 44
    amend_error_in_article 44 ' and and' ' and' | \
    #Article 63
    amend_error_in_article 63 'sub-section\[3\]' 'sub-section [3]' | \
    #Article 64
    amend_error_in_article 64 'resulting is' 'resulting or is' | \
    #Article 69
    amend_error_in_article 69 'shall,on' 'shall, on' | \
    #Article 73
    amend_error_in_article 73 '\[s\]' '(s)' | \
    #Article 89
    amend_error_in_article 89 '10 000' '10,000' 
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
    prefix_article_numbers_with_article_literal | \
    replace_parentheses_around_article_delimiters_with_square_brackets | \
    move_article_titles_after_article_numbers | \
    apply_common_transformations_to_stdin "$language" | \
    move_article_titles_above_articles | \
    remove_all_text_after_last_article | \
    amend_errors_in_headers | \
    amend_errors_in_articles
}