#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^\[Commencement. \]/,$p' | \
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

function fix_leftover_article_literals {
  sed -E 's/Article \[1\] Goals and objectives of environmental impact assessment \| /\n\nGoals and objectives of environmental impact assessment\n(1) /' | \
    sed -E 's/Article \[13\]/\n\n(13)/' | \
    sed -E 's/Article \[26\]/\n\n(26)/' 
}

function move_article_titles_above_article_bodies {
  sed -E 's/^(\([0-9]+\)) ([^|]+)\|/\2\n\1/'
}

function remove_all_text_after_last_article {
  sed -E '/^\(62\)/q'
}

function amend_errors_in_headers {
  sed -E 's/PART /\n\nPART /g' | \
    sed -E 's/PART I /PART I - /' | \
    sed -n '/PART I -/,$p' | \
    sed -E 's/PART II /PART II - /' | \
    sed -E 's/PART III /PART III - /' 
}

function amend_errors_in_articles {
  sed -E 's/\(([a-z])\)/[\1]/g' | \
    sed -E 's/( )\(([0-9]+)\)/\1[\2]/g' | \
    sed -E 's/\(ii\)/[ii]/g' | \
    sed -E 's/([0-9]+) (\[[0-9]+\])/\1\2/g' | \
    sed -E 's/‐ \[/: [/g' | \
    #Article 1
    amend_error_in_article 1 'decision‐ making' 'decision‐making' | \
    #Article 4
    amend_error_in_article 4 '`\[g\]' '[g]' | \
    #Article 12
    amend_error_in_article 12 '\[Schedule.\] ' '' | \
    #Article 13
    amend_error_in_article 13 '\[Consolidated\]' '(Consolidated)' | \
    amend_error_in_article 13 '\[Cap. C49.\] ' '' | \
    #Article 16
    amend_error_in_article 16 '47,48' '47, 48' | \
    amend_error_in_article 16 '\[1\] \[a\]' '[1][a]' | \
    amend_error_in_article 16 '\[2\] \[b\]' '[2][b]' | \
    amend_error_in_article 16 'he Agency' 'the Agency' | \
    #Article 20
    amend_error_in_article 20 '5 \[d\]' '5[d]' | \
    #Article 21
    amend_error_in_article 21 '\[1\] \[a\]' '[1][a]' | \
    #Article 23
    amend_error_in_article 23 '5 \[d\]' '5[d]' | \
    #Article 25
    amend_error_in_article 25 'Discretionary powers' '\n\nDiscretionary powers' | \
    #Article 39
    amend_error_in_article 39 '25 \[b\]' '25[b]' | \
    amend_error_in_article 39 '\[1\] \[a\]' '[1][a]' | \
    amend_error_in_article 39 'subsection \[1\] \[a\]' 'subsection [1][a]' | \
    #Article 40
    amend_error_in_article 40 '\[1\] \[a\]' '[1][a]' | \
    #Article 42
    amend_error_in_article 42 'bye‐law' 'by‐law' | \
    #Article 43
    amend_error_in_article 43 '\[1\] \[e\]' '[1][e]' | \
    amend_error_in_article 43 ' co‐ chairman' ' co-chairman' | \
    #Article 44
    amend_error_in_article 44 '42\[1\] \[d\]' '42[1][d]' | \
    #Article 54
    amend_error_in_article 54 '15 \[b\]' '15[b]' | \
    amend_error_in_article 54 '5 \[b\]' '5[b]' | \
    #Article 57
    amend_error_in_article 57 'irregularity .' 'irregularity.' | \
    #Article 58
    amend_error_in_article 58 'section 42\[1\] \[a\]' 'section 42[1][a]' | \
    amend_error_in_article 58 '42\[1\] \[d\]' '42[1][d]' | \
    amend_error_in_article 58 '\[Schedule.\] ' '' | \
    #Article 60
    amend_error_in_article 60 'thanN100' 'than N100' | \
    #Article 61
    amend_error_in_article 61 'provides‐' 'provides:' | \
    amend_error_in_article 61 '\[Cap. F10.\] ' '' | \
    amend_error_in_article 61 '\[Cap. S4.\] ' '' | \
    amend_error_in_article 61 '\[Cap. T5.\] ' '' | \
    amend_error_in_article 61 'section 61 \[1\] \[b\]' 'section 61[1][b]' | \
    amend_error_in_article 61 '55\[1\] \[c\]' '55[1][c]' | \
    amend_error_in_article 61 'subsection 14 \[1\]' 'subsection 14[1]' | \
    amend_error_in_article 61 'section 17 \[1\]' 'section 17[1]' | \
    amend_error_in_article 61 'per cent ' 'percent ' | \
    #Article 62
    amend_error_in_article 62 'SCHEDULE.*' '' 
    
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
    fix_leftover_article_literals | \
    move_article_titles_above_article_bodies | \
    remove_all_text_after_last_article | \
    amend_errors_in_headers | \
    amend_errors_in_articles
}