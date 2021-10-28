#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^\[Date of Commencement: 27th May, 2005\]/,$p' | \
    sed -n '/^PART I/,$p'
}

function prefix_article_numbers_with_article_literal {
  sed -E 's/^([0-9]+\.)/Article \1/'
}

function append_pipe_to_article_title {
  sed -E 's/^(Article .*)$/\1|/'
}

function replace_parentheses_around_article_delimiters_with_square_brackets {
  sed -E 's/^\(([A-Za-z0-9]+)\)/[\1]/' 
}

function remove_all_text_after_last_article {
  sed -E '/^\(32\) /,${/^\(32\)/!d}' | \
    sed -E '/^\(32\) Articles deemed.*/d'
}

function amend_errors_in_headers {
  sed -E 's/PART I Preliminary /PART I - Preliminary /' | \
    sed -E 's/PART II Preparation/\n\nPART II - Preparation/' | \
    sed -E 's/PART III Review/\n\nPART III - Review/' | \
    sed -E 's/PART IV Authorisation/\n\nPART IV - Authorisation/' | \
    sed -E 's/PART V Post/\n\nPART V - Post/' | \
    sed -E 's/PART VI Miscellaneous/\n\nPART VI - Miscellaneous/' 
}

function amend_errors_in_articles {
  sed -E 's/Article \[([0-9]+)\]/\n\n(\1)/g' | \
    sed -E 's/(subsection )\(([0-9]+)\)/\1[\2]/g' | \
    sed -E "s/^(\([0-9]+\).*) \(1\) /\1 [1] /" | \
    sed -E 's/ Copyright Government of Botswana//g' | \
    sed -E 's/,000/000/g' | \
    sed -E "s/^(\([0-9]+\).*)- /\1 /" | \
    sed -E 's/\[•\] //g' | \
    #Article 2
    amend_error_in_article 2 'requires "' 'requires: "' | \
    #Article 3
    amend_error_in_article 3 '\(a\)' '[a]' | \
    amend_error_in_article 3 "screening''" '"screening"' | \
    #Article 4
    amend_error_in_article 4 '\[14\]' '14.' | \
    amend_error_in_article 4 '\(5\)' '\[5\]' | \
    #Article 5
    amend_error_in_article 5 '3\]' '3].' | \
    amend_error_in_article 5 '\[3\].' '3.' | \
    #Article 6
    amend_error_in_article 6 '\[1\] \(a\)' '[1][a]' | \
    #Article 12
    amend_error_in_article 12 '\[10\] \[2\]' '10[2].' | \
    amend_error_in_article 12 '\(i\)' '[i]' | \
    amend_error_in_article 12 '\(ii\)' '[ii]' | \
    amend_error_in_article 12 '\(iii\)' '[iii]' | \
    amend_error_in_article 12 '\(iv\)' '[iv]' | \
    #Article 14
    amend_error_in_article 14 '\(a\)' '[a]' | \
    amend_error_in_article 14 '\(b\)' '[b]' | \
    amend_error_in_article 14 '\[1\] \[a\]' '[1][a]' | \
    sed -E ':start;s/^(\(14\).*)\(i\)/\1[i]/;t start' | \
    sed -E ':start;s/^(\(14\).*)\(ii\)/\1[ii]/;t start' | \
    sed -E ':start;s/^(\(14\).*)-/\1/;t start' | \
    #Article 16
    amend_error_in_article 16 ' \[1\] \(a\)' '[1][a]' | \
    #Article 17
    amend_error_in_article 17 'to-' 'to' | \
    #Article 18
    amend_error_in_article 18 '\(1\)' '[1]' | \
    amend_error_in_article 18 ' \[1\] \(a\)' '[1][a]' | \
    #Article 26
    amend_error_in_article 26 'subsection\(1\)' 'subsection [1]' | \
    amend_error_in_article 26 '\(b\)' '[b]' 
}

function move_article_titles_above_article_bodies {
  sed -E 's/^(\([0-9]+\)) ([^|]+)\|/\2\n\1/' 
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
    append_pipe_to_article_title | \
    replace_parentheses_around_article_delimiters_with_square_brackets | \
    apply_common_transformations_to_stdin "$language" | \
    remove_all_text_after_last_article | \
    amend_errors_in_headers | \
    amend_errors_in_articles | \
    move_article_titles_above_article_bodies 
}