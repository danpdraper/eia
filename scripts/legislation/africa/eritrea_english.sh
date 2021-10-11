#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^CHAPTER I/,$p'
}

function add_square_brackets_to_list_numbers {
  sed -E 's/\(([0-9]+)\)/[\1]/g'
}

function append_pipe_to_article_title {
  sed -E 's/Article: 37/Article 37/' | \
    sed -E 's/^(Article .*)$/\1|/'
}

function move_article_titles_above_article_bodies {
  sed -E 's/^(\([0-9]+\)) ([^|]+)\|/\2\n\1/'
}

function amend_errors_in_articles {
  sed -E 's/\(([a-z])\)/[\1]/g' | \
    #Article 1
    amend_error_in_article 1 'No' 'No\. 179\/2017"' | \
    #Article 2
    amend_error_in_article 2 'Land, Water and Environment' 'Land, Water and Environment\.' | \
    amend_error_in_article 2 'environment;' 'environment\.' | \
    amend_error_in_article 2 'and lor' 'and\\or' | \
    amend_error_in_article 2 "'Bio safety" '"Bio safety' | \
    #Article 3
    amend_error_in_article 3 'OBJECTIVES' '\n\nCHAPTER II - OBJECTIVES' | \
    #Article 5
    amend_error_in_article 5 'gevelopment planning' 'development planning' | \
    amend_error_in_article 5 'management approach' 'management approach:' | \
    amend_error_in_article 5 'and management' 'and management.' | \
    amend_error_in_article 5 'development planning' 'development planning:' | \
    amend_error_in_article 5 'isolation from it' 'isolation from it.' | \
    amend_error_in_article 5 '\[3\] Human wellbeing' '[3] Human wellbeing:' | \
    amend_error_in_article 5 'protection of the environment \[4\]' 'protection of the environment. [4]' | \
    amend_error_in_article 5 'State to exploit natural resources' 'State to exploit natural resources:' | \
    amend_error_in_article 5 'to the environment' 'to the environment.' | \
    amend_error_in_article 5 'and Equity' 'and Equity:' | \
    amend_error_in_article 5 'duties of persons' 'duties of persons:' | \
    amend_error_in_article 5 'Sustainable use of natural resources' 'Sustainable use of natural resources:' | \
    amend_error_in_article 5 '\[8\] Preventive and precautionary approach' '[8] Preventive and precautionary approach:' | \
    amend_error_in_article 5 'environment \[9\]' 'environment. [9]' | \
    amend_error_in_article 5 'health effects' 'health effects.' | \
    amend_error_in_article 5 'polluter pays' 'polluter pays:' | \
    amend_error_in_article 5 '\[10\] Public participation' '[10] Public participation:' | \
    amend_error_in_article 5 'environment \[11\]' 'environment. [11]' | \
    amend_error_in_article 5 'International obligations' 'International obligations:' | \
    #Article 6
    amend_error_in_article 6 'manageme\.!\}t' 'management' | \
    #Article 7
    amend_error_in_article 7 '\[d\]promote' '[d] promote' | \
    #Article 11
    amend_error_in_article 11 'regulation·' 'regulation' | \
    #Article 14
    amend_error_in_article 14 'funetions' 'functions' | \
    #Article 15
    amend_error_in_article 15 '; and \[4\]' '. [4]' | \
    #Article 21
    amend_error_in_article 21 'assess \-to' 'assess to' | \
    #Article 23
    amend_error_in_article 23 '\[•\]' '\-' | \
    amend_error_in_article 23 'include;' 'include:' | \
    #Article 28
    sed -E 's/Sio-safety/Bio-safety/' | \
    #Article 30
    sed -E 's/\(30\) Policy Incentives\/Disincentives/Policy Incentives\/Disincentives\n(30)/' | \
    #Article 31
    amend_error_in_article 31 'effluent\.' 'effluent,' | \
    #Article 37
    amend_error_in_article 37 'compHance' 'compliance' | \
    #Article 40
    amend_error_in_article 40 '34 ' '' | \
    #Article 42
    amend_error_in_article 42 'Done at.*$' '' 
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
    add_square_brackets_to_list_numbers | \
    append_pipe_to_article_title | \
    apply_common_transformations_to_stdin "$language" | \
    move_article_titles_above_article_bodies | \
    amend_errors_in_articles 
}