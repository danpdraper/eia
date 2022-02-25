#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^economic, social, cultural and spiritual advancement;/,$p' | \
    sed -n '/^PART I – PRELIMINARY/,$p'
}

function prefix_article_numbers_with_article_literal {
  sed -E 's/^([0-9]+)/Article \1/' 
}

function append_pipe_to_article_title {
  sed -E 's/^(Article .*)$/\1|/' 
}

function replace_parentheses_around_article_delimiters_with_square_brackets {
  sed -E 's/\(([A-Za-z0-9]+)\)/[\1]/g' 
}

function move_article_titles_above_article_bodies {
  sed -E 's/^(\([0-9]+\)) ([^|]+)\|/\2\n\1/'
}

function remove_all_text_after_last_article {
  sed -E '/^\(148\)/,${/^\(148\)/!d}'
}

function amend_errors_in_articles {
  sed -E 's/— /: /g' | \
    sed -E 's/\[Issue 1\] //g' | \
    sed -E 's/ E12 \[•\] [0-9]+//g' | \
    sed -E 's/\[Issue//g' | \
    sed -E 's/CAP\. 387 Environmental Management and Co-ordination \[Rev. 2012\] //g' | \
    sed -E 's/\[Rev. 2012\] Environmental Management and Co-ordination CAP\. 387 //g' | \
    #Article 2
    amend_error_in_article 2 '\[•\] 12 ' '' | \
    amend_error_in_article 2 'microrganism' 'microorganism' | \
    amend_error_in_article 2 '\[171]' '171)' | \
    amend_error_in_article 2 'Article 108;\|' '108;' | \
    amend_error_in_article 2 'Article 37;\|' '37;' | \
    amend_error_in_article 2 ' \[•\]' ':' | \
    sed -E ':start;s/^(\(2\).*)\[371\]/\1371)/;t start' | \
    amend_error_in_article 2 '\[265\]' '371)' | \
    amend_error_in_article 2 '\[1990\]' '1990)' | \
    #Article 5
    amend_error_in_article 5 'Article \[6\] Procedure of the Council\| ' '\n\nProcedure of the Council\n(6) ' | \
    #Article 6
    amend_error_in_article 6 ' The Authority' '' | \
    #Article 21
    amend_error_in_article 21 'thirteeth' 'thirteenth' | \
    #Article 23
    amend_error_in_article 23 '\(Cap.' '(Cap. 412).' | \
    amend_error_in_article 23 '\[412\]' '412)' | \
    sed -E ':start;s/^(\(23\).*)\[Corporations\]/\1(Corporations)/;t start' | \
    #Article 28
    amend_error_in_article 28 ' Provincial and District Environment Committees' '' | \
    #Article 29
    amend_error_in_article 29 'Article \[30\] Functions of Provincial and District Environment Committees\| ' '\n\nFunctions of Provincial and District Environment Committees\n(30) ' | \
    #Article 32
    amend_error_in_article 33 'Article \[32\]\|' '32.' | \
    #Article 38
    amend_error_in_article 38 '\[Act No. 6 of 2006, s.' '\n\n[Act No. 6 of 2006, s. 77]' | \
    #Article 42
    sed -E 's/ENVIRONMENT \[1\] No/ENVIRONMENT\n\n(42) [1] No/' | \
    amend_error_in_article 42 '\[Act No. 5 of 2007, \[s\] 77, Act No. 6 of 2009, Sch.' '\n\n[Act No. 5 of 2007, s. 77, Act No. 6 of 2009, Sch.]' | \
    #Article 47
    sed -z 's/mountainous\n(/mountainous areas\n(/g' | \
    sed -E 's/\) areas/)/g' | \
    #Article 69
    amend_error_in_article 69 ' \[•\]' ':' | \
    #Article 70
    amend_error_in_article 70 'Article \[71\] Functions of Standards and Enforcement Review Committee\| ' '\n\nFunctions of Standards and Enforcement Review Committee\n(71) ' | \
    #Article 81
    amend_error_in_article 81 '\[VI\]' 'VI.' | \
    #Article 92
    amend_error_in_article 92 "Article \[93\] Prohibition of discharge of hazardous substances, chemicals and\| materials or oil into the environment and spiller's liability " "\n\nProhibition of discharge of hazardous substances, chemicals and materials or oil into the environment and spiller's liability\n(93) " | \
    amend_error_in_article 92 'the advise' 'the advice' | \
    #Article 95
    amend_error_in_article 95 's.' 's. 117.' | \
    #Article 96
    amend_error_in_article 96 's.' 's. 118.' | \
    #Article 102
    amend_error_in_article 102 '\[394\]' '394)' | \
    #Article 104
    amend_error_in_article 104 's.' 's. 78.' | \
    #Article 105
    amend_error_in_article 105 's.' 's. 79.' | \
    #Article 106
    sed -E 's/\(106\) \[Issue//' | \
    sed -z 's/Repealed by Act No. 5 of 2007, \[s\] \[80\]\n/(106) Repealed by Act No. 5 of 2007, s. 80./' | \
    #Article 107
    amend_error_in_article 107 '\[Act' '\n\n[Act' | \
    #Article 112
    amend_error_in_article 112 'Article \[116\]\|' '116.' | \
    amend_error_in_article 112 'acquifer' 'aquifer' | \
    #Article 118
    amend_error_in_article 118 'AttorneyGeneral' 'Attorney-General' | \
    #Article 120
    amend_error_in_article 120 'Article \[121\] Records to be kept\| ' '\n\nRecords to be kept\n(121) ' | \
    #Article 124
    amend_error_in_article 124 'AttorneyGeneral' 'Attorney-General' | \
    #Article 126
    amend_error_in_article 126 '\[80\]' '80)' | \
    #Article 138
    amend_error_in_article 138 'Article 58 of this Act;\|' '58 of this Act;' | \
    #Article 144
    amend_error_in_article 144 'Article \[145\] Offences by bodies corporate, Partnerships, Principals and Employers\| ' '\n\nOffences by bodies corporate, Partnerships, Principals and Employers\n(145) ' | \
    #Article 148
    amend_error_in_article 148 'FIRST SCHEDULE.*$' ''
}

function amend_errors_in_headers {
  sed -E 's/([^^])PART/\1\n\nPART/g' | \
    sed -E 's/ADMINISTRATION The National Environment Council/ADMINISTRATION/' 
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
    move_article_titles_above_article_bodies | \
    remove_all_text_after_last_article | \
    amend_errors_in_articles | \
    amend_errors_in_headers
}