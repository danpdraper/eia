#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^\Enacted by the Parliament of Lesotho\./,$p' | \
    sed -n '/^PART I/,$p' 
}

function prefix_article_numbers_with_article_literal {
  sed -E 's/^([0-9]+\.)/Article \1/'
}

function replace_parentheses_around_article_delimiters_with_square_brackets {
  sed -E 's/^\(([A-Za-z0-9]+)\)/[\1]/'
}

function move_article_titles_after_article_numbers {
  sed -En '${p;q};N;/\nArticle/{s/^(.*)\n(Article [0-9]+\.) /\2 \1|/p;b};P;D'
}

function move_article_titles_above_articles {
  sed -E 's/^(\([0-9]+\) )([^|]+)\|/\2\n\1/'
}

function remove_all_text_after_last_article {
  sed -E '/^\(116\)/q'
}

function amend_errors_in_headers {
  sed -E 's/([^^])PART/\1\n\nPART/g' | \
    sed -E 's/^(PART .*)\[•\]/\1-/' | \
    sed -E 's/VIII- /VIII - /' | \
    sed -E 's/PART XII-/PART XII -/'
}

function amend_errors_in_articles {
  sed -E 's/ \[•\]/:/g' | \
    sed -E 's/ \(1\)/ \[1\]/g' | \
    sed -E 's/section ([0-9]+)\(([0-9]+)\)/section \1[\2]/g' | \
    sed -E 's/subsection \(([0-9]+)\)/subsection [\1]/g' | \
    sed -E 's/paragraph \(([a-z])\)/paragraph [\1]/g' | \
    #remove page numbers
    sed -E 's/ [0-9]{3} / /g' | \
    sed -E 's/([a-z]+)[0-9]{3} /\1/g' | \
    sed -E 's/M5, /M5,000 /g' | \
    #Article 1
    amend_error_in_article 1 '2008\]' '2008\].' | \
    #Article 2
    amend_error_in_article 2 'unincorporate' 'unincorporated' | \
    amend_error_in_article 2 '1997 1' '1997' | \
    #Article 5
    amend_error_in_article 5 'NonGovernmental' 'Non-Governmental' | \
    #Article 10
    amend_error_in_article 10 'of`' 'of' | \
    #Article 11
    amend_error_in_article 11 'District Environment Officer 12' '\n\nDistrict Environment Officer\n(12)' | \
    #Article 13
    amend_error_in_article 13 'to advice' 'to advise' | \
    #Article 14
    amend_error_in_article 14 '\[13\]' '13.' | \
    #Article 15
    amend_error_in_article 15 '23\(3\), 24\(3\), 50\(1\) and \(2\)' '23[3], 24[3], 50[1] and [2]' | \
    #Article 20
    amend_error_in_article 20 '19\[3\]\(a\)' '19[3][a]' | \
    #Article 27
    amend_error_in_article 27 '\(2\) and \(3\)' '[2] and [3]' | \
    #Article 38
    amend_error_in_article 38 '\(2\) and \(3\)' '[2] and [3]' | \
    #Article 39
    amend_error_in_article 39 '\(2\)' '[2]' | \
    #Article 40
    amend_error_in_article 40 'and \(3\)' 'and [3]' | \
    #Article 41
    amend_error_in_article 41 '\(3\)' '[3]' | \
    #Article 44
    amend_error_in_article 44 'fur ther' 'further' | \
    #Article 53
    amend_error_in_article 53 '\(c\)' '[c]' | \
    #Article 61
    amend_error_in_article 61 'General and specific orders, for standards for the management of river, Article \[62\] riverbanks, lake, lakeshore and wetlands\|' '\n\nGeneral and specific orders, for standards for the management of river, riverbanks, lake, lakeshore and wetlands\n(62) ' | \
    #Article 62
    amend_error_in_article 62 '\(1\)' '[1]' | \
    #Article 63
    amend_error_in_article 63 '\(4\) and \(5\)' '[4] and [5]' | \
    #Article 81
    amend_error_in_article 81 'labeling' 'labelling' | \
    #Article 82
    amend_error_in_article 82 '81\]' '81].' | \
    amend_error_in_article 82 'M20,' 'M20,000' | \
    amend_error_in_article 82 'section \[81\]' 'section 81' | \
    #Article 84
    amend_error_in_article 84 '\(6\)' '[6]' | \
    #Article 86
    amend_error_in_article 86 'Action by the Director in case of non compliance with an environmental Article \[87\] restoration notice\|' '\n\nAction by the Director in case of non compliance with an environmental restoration notice\n(87)' | \
    #Article 87
    amend_error_in_article 87 '\(1\)' ' [1]' | \
    #Article 115
    amend_error_in_article 115 ' 2 ' ' ' | \
    #Article 116
    amend_error_in_article 116 'FIRST SCHEDULE' ''  
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