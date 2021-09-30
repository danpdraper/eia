#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^58. Short title and commencement/,$p' | \
    sed -n '/^PART I/,$p'
}

function prefix_article_numbers_with_article_literal {
  sed -E 's/^([0-9]+\.)/Article \1/'
}

function replace_parentheses_around_article_delimiters_with_square_brackets {
  sed -E 's/^\(([A-Za-z0-9]+)\)/[\1]/'
}

function amend_errors_in_headers {
  sed -E 's/^(Section [0-9]+ - [A-Za-z,’ ]+)[^a-z]+Article ([0-9]+)(er)?/\1\n\n(\2)/' | \
    sed -E 's/^(PART )I/\1I -/' | \
    sed -E 's/^(PART I - DEFINITIONS.*) Definitions/\1\n\nDefinitions/' | \
    sed -E 's/^(PART )I -I/\1II -/' | \
    sed -E 's/^(PART II - PRINCIPLES.*) Principles/\1\n\nPrinciples/' | \
    sed -E 's/^(PART )II -I/\1III -/' | \
    sed -E 's/^(PART III - GENERAL.*) Functions/\1\n\nFunctions/' | \
    sed -E 's/^(PART )I -V/\1IV -/' | \
    sed -E 's/^(PART IV - SUSTAINABLE.*) Establishment/\1\n\nEstablishment/' | \
    sed -E 's/^(PART )V/\1V -/' | \
    sed -E 's/^(PART V - ENVIRONMENTAL.*) Appointment/\1\n\nAppointment/' | \
    sed -E 's/^(PART )V -I/\1VI -/' | \
    sed -E 's/^(PART VI - ENVIRONMENTAL.*) Objects/\1\n\nObjects/' | \
    sed -E 's/^(PART )VI -I/\1VII -/' | \
    sed -E 's/^(PART VII - ENVIRONMENTAL.*) Listing/\1\n\nListing/' | \
    sed -E 's/^(PART )VII -I/\1VIII -/' | \
    sed -E 's/^(PART VIII - ENVIRONMENTAL.*) Application/\1\n\nApplication/' | \
    sed -E 's/^(PART )I -X/\1IX -/' | \
    sed -E 's/^(PART IX - SPECIAL.*) Consultation/\1\n\nConsultation/' 
}

function remove_margin_headers {
    sed -E 's/No. 3966 Government Gazette 27 December 2007//g' | \
    sed -E 's/Act No. 7, 2007 ENVIRONMENTAL MANAGEMENT ACT, 2007//g' | \
    sed -E 's/Government Gazette 27 December 2007 No. 3966 //g' 
}

function identify_leftover_articles {
  sed -E 's/(in section Article [[]44])/in section 44/' | \
  sed -E 's/(Article )(\[[0-9]+\])/\n[\2]/g' | \
  sed -e 's/\[\[\([^]]*\)\]\]/(\1)/g' 
}

function remove_all_text_after_last_article {
  sed -E '/^\(58\)/q'
}

function amend_errors_in_articles {
  #remove incorrect bullet points
  sed -E 's/ [[]•]//g' | \
  #format subsection numbers
  sed -E 's/(subsection )\(([0-9]+)\)/\1[\2]/g' | \
  #format (a-z) t0 [a-z]
  sed -E 's/\(([a-z])\)/[\1]/g' | \
  #turn (1) to [1] in articles
  sed -E "s/^(\([0-9]+\\).*) [(]1[)] /\1 [1] /" | \
  #remove page numbers
  sed -E 's/. [0-9]+\  /. /g' | \
  sed -E 's/\.\././g' | \

  #Article 1
  amend_error_in_article 1 '1995]' '1995])' | \
  amend_error_in_article 1 '1977]' '1977])' | \
  amend_error_in_article 1 '2001]' '2001])' | \
  amend_error_in_article 1 'section 27[(]1[)]' 'section 27[1]' | \
  #Article 8
  amend_error_in_article 8 'subsections [(]4[)]' 'subsections [4]' | \
  #Article 15
  amend_error_in_article 15 '1991]' '1991])' | \
  #Article 18
  amend_error_in_article 18 '\( \[2]' '[2]' | \
  #Article 19
  amend_error_in_article 19 'To the extend that this' 'To the extent that this' | \
  #Article 22
  amend_error_in_article 22 'person [.]' 'person -' | \
  #Article 26
  amend_error_in_article 26 'Enviromental Commissionr' 'Environmental Commissioner' | \
  #Article 31
  amend_error_in_article 31 'invalid.PART' 'invalid. PART' | \
  #Article 38
  amend_error_in_article 38 '\[37]' '37.' | \
  #Article 39
  amend_error_in_article 39 'in section \[44]' 'section 44.' | \
  amend_error_in_article 39 'initiave' 'initiative' | \
  #Article 40
  amend_error_in_article 40 'under section \[42]' 'under section 42.' | \
  #Article 42
  amend_error_in_article 42 'section \[44]' 'section 44.' | \
  #Article 44
  amend_error_in_article 44 'reasonable time.Appointment' 'reasonable time. Appointment' | \
  #Article 50
  amend_error_in_article 50 'otherwise.Appeal' 'otherwise. Appeal' 
}

function move_article_titles_above_article_bodies {
  sed -E "s/^(\([0-9]+\\).*)\. /\1.\n\n/" 
}

function add_newlines_before_headers_and_articles {
  local stdin="$(</dev/stdin)"

  if [ "$#" -ne 1 ] ; then
    echo_usage_error "$*" '<language>'
    return 1
  fi
  local language="$1"

  local line_prefix_regular_expression
  line_prefix_regular_expression="$(get_line_prefix_regular_expression $language)"
  local return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  local regular_expression="([A-Z][A-Za-z]+|\.) ${line_prefix_regular_expression}"

  echo "$stdin" | sed -E ":start;s/${regular_expression}/\1\n\2 \3/;t start"
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
    add_newlines_before_headers_and_articles "$language" | \
    apply_common_transformations_to_stdin "$language" | \
    remove_margin_headers | \
    identify_leftover_articles | \
    amend_errors_in_articles | \
    move_article_titles_above_article_bodies | \
    amend_errors_in_headers | \
    remove_all_text_after_last_article
}