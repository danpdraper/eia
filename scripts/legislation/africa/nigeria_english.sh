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
  sed -E 's/([^^])(PART)/\1\n\n\2/g' | \
    sed -E 's/^(PART I+)/\1 -/' 
}

function amend_errors_in_articles {
  sed -E 's/\(([a-z])\)/[\1]/g' | \
    sed -E 's/( )\(([0-9]+)\)/\1[\2]/g' | \
    sed -E 's/\(ii\)/[ii]/g' | \
    sed -E 's/([0-9]+) (\[[0-9]+\])/\1\2/g' | \
    sed -E 's/‐ \[/: [/g' | \
    #Article 1
    amend_error_in_article 1 'decision‐ making' 'decision‐making' | \
    amend_error_in_article 1 'be take into account' 'be taken into account' | \
    amend_error_in_article 1 'town and villages' 'towns and villages' | \
    #Article 4
    amend_error_in_article 4 '`\[g\]' '[g]' | \
    amend_error_in_article 4 'impacts of proposed activity' 'impacts of the proposed activity' | \
    #Article 5
    amend_error_in_article 5 'detailed commensuration' 'detail commensurate' | \
    #Article 12
    amend_error_in_article 12 '\[Schedule.\] ' '' | \
    #Article 13
    amend_error_in_article 13 '\[Consolidated\]' '(Consolidated)' | \
    amend_error_in_article 13 '\[Cap. C49.\] ' '' | \
    #Article 16
    amend_error_in_article 16 '47,48' '47, 48,' | \
    amend_error_in_article 16 '\[1\] \[a\]' '[1][a]' | \
    amend_error_in_article 16 '\[2\] \[b\]' '[2][b]' | \
    amend_error_in_article 16 'he Agency' 'the Agency' | \
    amend_error_in_article 16 'subsection \[1\] of this Act' 'subsection [1] of this section' | \
    amend_error_in_article 16 'renewal resources' 'renewable resources' | \
    amend_error_in_article 16 'that he Agency' 'that the Agency' | \
    amend_error_in_article 16 'consulting tthe Agency' 'consulting the Agency' | \
    #Article 19
    amend_error_in_article 19 'subsection \[1\] of this Act' 'subsection [1] of this section' | \
    #Article 20
    amend_error_in_article 20 '5 \[d\]' '5[d]' | \
    #Article 21
    amend_error_in_article 21 '\[1\] \[a\]' '[1][a]' | \
    #Article 23
    amend_error_in_article 23 '5 \[d\]' '5[d]' | \
    #Article 25
    amend_error_in_article 25 'Discretionary powers' '\n\nDiscretionary powers' | \
    amend_error_in_article 25 '39\[1\] \[a\]' '39[1][a]' | \
    #Article 32
    amend_error_in_article 32 'on the request of the mediation' 'on the request of the mediator' | \
    #Article 37
    amend_error_in_article 37 'and or ordering the witness' 'and order the witness' | \
    #Article 39
    amend_error_in_article 39 '25 \[b\]' '25[b]' | \
    amend_error_in_article 39 '\[1\] \[a\]' '[1][a]' | \
    amend_error_in_article 39 'subsection \[1\] \[a\]' 'subsection [1][a]' | \
    #Article 40
    amend_error_in_article 40 '\[1\] \[a\]' '[1][a]' | \
    amend_error_in_article 40 'for or in the pursuant to' 'for or pursuant to' | \
    #Article 42
    amend_error_in_article 42 'bye‐law' 'by‐law' | \
    #Article 43
    amend_error_in_article 43 '\[1\] \[e\]' '[1][e]' | \
    amend_error_in_article 43 ' co‐ chairman' ' co-chairman' | \
    amend_error_in_article 43 '\[f\] of this section' '[f] of section 42' | \
    sed -E ':start;s/^(\(43\).*)subsection 42 of this Act/\1section 42 of this Act/;t start' | \
    #Article 44
    amend_error_in_article 44 '42\[1\] \[d\]' '42[1][d]' | \
    #Article 47
    amend_error_in_article 47 'environment effects' 'environmental effects' | \
    #Article 51
    amend_error_in_article 51 'subsection 47\[1\]' 'section 47[1]' | \
    #Article 54
    amend_error_in_article 54 '15 \[b\]' '15[b]' | \
    amend_error_in_article 54 '5 \[b\]' '5[b]' | \
    #Article 57
    amend_error_in_article 57 'irregularity .' 'irregularity.' | \
    #Article 58
    amend_error_in_article 58 'section 42\[1\] \[a\]' 'section 42[1][a]' | \
    amend_error_in_article 58 '42\[1\] \[d\]' '42[1][d]' | \
    amend_error_in_article 58 '\[Schedule.\] ' '' | \
    amend_error_in_article 58 'assist m conducting' 'assist in conducting' | \
    #Article 60
    amend_error_in_article 60 'thanN100' 'than N100' | \
    #Article 61
    amend_error_in_article 61 'provides‐' 'provides:' | \
    amend_error_in_article 61 '\[Cap. F10.\] ' '' | \
    amend_error_in_article 61 '\[Cap. S4.\] ' '' | \
    amend_error_in_article 61 '\[Cap. T5.\] ' '' | \
    amend_error_in_article 61 'section 61\[1\] \[b\]' 'section 61[1][b]' | \
    amend_error_in_article 61 '55\[1\] \[c\]' '55[1][c]' | \
    amend_error_in_article 61 'subsection 14 \[1\]' 'section 14[1]' | \
    amend_error_in_article 61 'section 17 \[1\]' 'section 17[1]' | \
    amend_error_in_article 61 'per cent ' 'percent ' | \
    amend_error_in_article 61 'subsections 11\[1\]' 'sections 11[1]' | \
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