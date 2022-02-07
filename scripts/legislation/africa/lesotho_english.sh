#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^Enacted by the Parliament of Lesotho\./,$p' | \
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
  sed -E '/^\(116\)/,${/^\(116\)/!d}'
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
    amend_error_in_article 1 '\[2008\]' '2008.' | \
    #Article 2
    amend_error_in_article 2 'unincorporate' 'unincorporated' | \
    amend_error_in_article 2 '1997 1' '1997' | \
    amend_error_in_article 2 'Act";' 'Act;' | \
    amend_error_in_article 2 'Act;"' 'Act;' | \
    amend_error_in_article 2 'restriction to which is subject to' 'restriction which is subject to' | \
    amend_error_in_article 2 'or degraded the carrying capacity' 'or degrade the carrying capacity' | \
    #Article 3
    amend_error_in_article 3 'to prevent, any' 'to prevent any' | \
    #Article 5
    amend_error_in_article 5 'NonGovernmental' 'Non-Governmental' | \
    #Article 8
    amend_error_in_article 8 'issue, to Line' 'issue to Line' | \
    #Article 10
    sed -E 's/of`/of/' | \
    #Article 11
    amend_error_in_article 11 'District Environment Officer 12' '\n\nDistrict Environment Officer\n(12)' | \
    #Article 12
    amend_error_in_article 12 '\[2\].' '[2]' | \
    #Article 13
    amend_error_in_article 13 'to advice' 'to advise' | \
    #Article 14
    amend_error_in_article 14 '\[13\]' '13.' | \
    #Article 15
    amend_error_in_article 15 '23\(3\), 24\(3\), 50\(1\) and \(2\)' '23[3], 24[3], 50[1] and [2]' | \
    amend_error_in_article 15 'include, \[a\]' 'include: [a]' | \
    amend_error_in_article 15 'direction, \[a\]' 'direction: [a]' | \
    #Article 20
    amend_error_in_article 20 '19\[3\]\(a\)' '19[3][a]' | \
    #Article 21
    amend_error_in_article 21 'project. \[b\]' 'project: [b]' | \
    #Article 25
    amend_error_in_article 25 'that, the Director' 'that the Director' | \
    #Article 27
    amend_error_in_article 27 '\(2\) and \(3\)' '[2] and [3]' | \
    #Article 29
    amend_error_in_article 29 '\[vi\] criteria' '[iv] criteria' | \
    amend_error_in_article 29 'from, time to time' 'from time to time' | \
    amend_error_in_article 29 'standards, established' 'standards established' | \
    #Article 32
    amend_error_in_article 32 'sonic bonus' 'sonic booms' | \
    #Article 33
    amend_error_in_article 33 'conduct an ionizing' 'conduct ionizing' | \
    #Article 37
    amend_error_in_article 37 'discharge, to' 'discharge to' | \
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
    amend_error_in_article 44 'of this sections commits' 'of this section commits' | \
    #Article 51
    amend_error_in_article 51 'liable on conviction liable' 'liable on conviction' | \
    #Article 53
    amend_error_in_article 53 '\(c\)' '[c]' | \
    #Article 61
    amend_error_in_article 61 'General and specific orders, for standards for the management of river, Article \[62\] riverbanks, lake, lakeshore and wetlands\|' '\n\nGeneral and specific orders, for standards for the management of river, riverbanks, lake, lakeshore and wetlands\n(62) ' | \
    #Article 62
    amend_error_in_article 62 '\(1\)' '[1]' | \
    #Article 63
    amend_error_in_article 63 '\(4\) and \(5\)' '[4] and [5]' | \
    #Article 67
    amend_error_in_article 67 'parks, and' 'parks; and' | \
    #Article 69
    amend_error_in_article 69 'considers appropriate' 'consider appropriate' | \
    #Article 76
    amend_error_in_article 76 'shall, apply' 'shall apply' | \
    #Article 81
    amend_error_in_article 81 'labeling' 'labelling' | \
    #Article 82
    amend_error_in_article 82 '81\]' '81].' | \
    amend_error_in_article 82 'M20,' 'M20,000' | \
    amend_error_in_article 82 'section \[81\]' 'section 81' | \
    amend_error_in_article 82 'clear-up operations' 'clean-up operations' | \
    amend_error_in_article 82 'storage facility conveyance' 'storage facility, conveyance' | \
    #Article 84
    amend_error_in_article 84 '\(6\)' '[6]' | \
    amend_error_in_article 84 'the Director my delegate' 'the Director may delegate' | \
    amend_error_in_article 84 'restoration notice, made' 'restoration notice made' | \
    #Article 86
    amend_error_in_article 86 'Action by the Director in case of non compliance with an environmental Article \[87\] restoration notice\|' '\n\nAction by the Director in case of non compliance with an environmental restoration notice\n(87)' | \
    #Article 87
    amend_error_in_article 87 '\(1\)' ' [1]' | \
    #Article 88
    amend_error_in_article 88 'brought the Director' 'brought by the Director' | \
    #Article 90
    amend_error_in_article 90 'manufacturing plant undertaking or establishment' 'manufacturing plant, undertaking or establishment' | \
    amend_error_in_article 90 'close, a manufacturing plant' 'close a manufacturing plant' | \
    #Article 95
    amend_error_in_article 95 'management of the environmental' 'management of the environment' | \
    amend_error_in_article 95 'section, on such' 'section on such' | \
    amend_error_in_article 95 'conditions, as the' 'conditions as the' | \
    #Article 96
    amend_error_in_article 96 'may, publish' 'may publish' | \
    #Article 102
    amend_error_in_article 102 'conviction, to' 'conviction to' | \
    #Article 103
    amend_error_in_article 103 'conviction, to' 'conviction to' | \
    #Article 108
    amend_error_in_article 108 'fine may impose' 'fine it may impose' | \
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