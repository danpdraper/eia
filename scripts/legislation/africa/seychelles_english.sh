#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^----------------------/,$p' | \
    sed -n '/^PART I/,$p'
}

function prefix_article_numbers_with_article_literal {
  sed -E 's/^([0-9]+\.)/Article \1/'
}

function replace_parentheses_around_article_delimiters_with_square_brackets {
  sed -E 's/\(([A-Za-z0-9]+)\)/[\1]/g' 
}

function remove_all_text_after_last_article {
  sed -E '/^\(40\) /,${/^\(40\)/!d}' 
}

function amend_errors_in_headers {
  sed -E 's/([^^])PART/\1\n\nPART/g' | \
    sed -E 's/^(PART [A-Z]+)/\1 -/g' | \
    sed -E 's/PART \[•\] IV/PART IV -/' | \
    sed -E 's/II - 5/II -/' 
}

function amend_errors_in_articles {
  sed -E 's/ \[•\]/:/g' | \
    sed -E 's/ 1\]/ \[1\]/g' | \
    sed -E 's/.000/,000/g' | \
    sed -E 's/R5000/R5,000/g' | \
    sed -E 's/([a-z])- /\1: /g' | \
    sed -E 's/\] \[/][/g' | \
    sed -E 's/sub-section/subsection/g' | \
    #Article 2
    amend_error_in_article 2 'commercial ,' 'commercial,' | \
    amend_error_in_article 2 '" Administrator' '"Administrator' | \
    amend_error_in_article 2 '; 4' ';' | \
    amend_error_in_article 2 'handling ,' 'handling,' | \
    amend_error_in_article 2 'injurious to ' 'injurious to the ' | \
    sed -E ':start;s/^(\(2\).*)\. "/\1; "/;t start' | \
    #Article 4
    amend_error_in_article 4 '; 6' ';' | \
    sed -E ':start;s/^(\(4\).*)\. \[i/\1; \[i/;t start' | \
    amend_error_in_article 4 '\. \[x' '; [x' | \
    amend_error_in_article 4 'environment –' 'environment:' | \
    #Article 5
    amend_error_in_article 5 ' 7 ' ' ' | \
    #Article 6
    sed -E ':start;s/^(\(6\).*)\. \[/\1; \[/;t start' | \
    #Article 7
    amend_error_in_article 7 'throw ,' 'throw,' | \
    amend_error_in_article 7 '8 ' '' | \
    amend_error_in_article 7 'into in' 'into' | \
    amend_error_in_article 7 'co -opted' 'co-opted' | \
    amend_error_in_article 7 '\[2\]\[a\]' '[2] [a]' | \
    amend_error_in_article 7 '\[3\]\[a\]' '[3] [a]' | \
    amend_error_in_article 7 '\[4\]\[a\] No' '[4] [a] No' | \
    #Article 8
    amend_error_in_article 8 'Authority ,' 'Authority,' | \
    amend_error_in_article 8 ' 9' '' | \
    #Article 9
    amend_error_in_article 9 'Authority ,' 'Authority,' | \
    #Article 10
    amend_error_in_article 10 '10 ' '' | \
    #Article 11
    amend_error_in_article 11 '11 ' '' | \
    amend_error_in_article 11 'Act\. 12' 'Act. \n\n(12)' | \
    amend_error_in_article 11 '\[2\]\[a\]' '[2] [a]' | \
    amend_error_in_article 11 '\[5\]\[a\]' '[5] [a]' | \
    #Article 12
    amend_error_in_article 12 'prescribe –' 'prescribe:' | \
    amend_error_in_article 12 'hazardous waste;' 'hazardous waste.' | \
    amend_error_in_article 12 'the Agency:' 'the Agency.' | \
    amend_error_in_article 12 '\. 12' '.' | \
    amend_error_in_article 12 'bin: \[ii\]' 'bin; [ii]' | \
    amend_error_in_article 12 '\[8\]\[a\] No' '[8] [a] No' | \
    #Article 13
    amend_error_in_article 13 'Section' 'section' | \
    #Article 14
    amend_error_in_article 14 'substance ,' 'substance,' | \
    #Article 15
    amend_error_in_article 15 'times .' 'times.' | \
    amend_error_in_article 15 'with ,' 'with,' | \
    amend_error_in_article 15 '14 ' '' | \
    amend_error_in_article 15 'issued if,' 'issued if:' | \
    amend_error_in_article 15 '15 ' '' | \
    amend_error_in_article 15 'environment. \[i\]' 'environment; [i]' | \
    amend_error_in_article 15 '\[4\]\[a\]' '[4] [a]' | \
    amend_error_in_article 15 '\[5\]\[a\]' '[5] [a]' | \
    #Article 16
    amend_error_in_article 16 'case may be and \[d\]' 'case may be; and [d]' | \
    #Article 17
    amend_error_in_article 17 '16 ' '' | \
    amend_error_in_article 17 'implemented;' 'implemented.' | \
    #Article 23
    amend_error_in_article 23 'unforseen' 'unforeseen' | \
    amend_error_in_article 23 'environment. in' 'environment. In' | \
    #Article 24
    amend_error_in_article 24 '18 ' '' | \
    #Article 25
    amend_error_in_article 25 '::' ':' | \
    amend_error_in_article 25 '19 ' '' | \
    amend_error_in_article 25 ':-' ':' | \
    #Article 29
    amend_error_in_article 29 '\[4\] \[a\]' '[4][a]' | \
    amend_error_in_article 29 'Rs\. \[,000\]' 'R5,000. ' | \
    amend_error_in_article 29 '\[4\] \[a\]' '[4][a]' | \
    amend_error_in_article 29 '20 ' '' | \
    amend_error_in_article 29 'R \[100\]' 'R100. ' | \
    #Article 30
    amend_error_in_article 30 'sections 7' 'section 7' | \
    amend_error_in_article 30 '\[6\] section' '[6] or section' | \
    sed -E 's/R,000/R5,000/g' | \
    #Article 31
    amend_error_in_article 31 '21 ' '' | \
    amend_error_in_article 31 'destroys , pulls' 'destroys, pulls' | \
    amend_error_in_article 31 'Authority, or \[d\]' 'Authority; or [d]' | \
    amend_error_in_article 31 'Act, or \[e\]' 'Act; or [e]' | \
    amend_error_in_article 31 'Authority, or \[f\]' 'Authority; or [f]' | \
    amend_error_in_article 31 'particular, is' 'particular; is' | \
    #Article 33
    amend_error_in_article 33 'the time of offence' 'the time the offence' | \
    amend_error_in_article 33 'accordingly: Provided' 'accordingly, provided' | \
    #Article 35
    amend_error_in_article 35 '\( ' '(' | \
    amend_error_in_article 35 ' ,' ',' | \
    #Article 37 
    amend_error_in_article 37 'person ,' 'person,' | \
    #Article 40
    amend_error_in_article 40 '_____________.*' '' 
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
    apply_common_transformations_to_stdin "$language" | \
    remove_all_text_after_last_article | \
    amend_errors_in_headers | \
    amend_errors_in_articles
}