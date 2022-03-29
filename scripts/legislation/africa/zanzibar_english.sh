#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^ENACTED by the House of Representatives of Zanzibar/,$p' | \
    sed -n '/^1/,$p' 
}

function prefix_article_numbers_with_article_literal {
  sed -E 's/^([0-9]+\.)/Article \1/'
}

function replace_parentheses_around_article_delimiters_with_square_brackets {
  sed -E 's/\(([A-Za-z0-9]+)\)/[\1]/g'
}

function amend_errors_in_articles {
  sed -E 's/ 1\]/ [1]/g' | \
    sed -E 's/ –/:/g' | \
    sed -E "s/‘([A-z]+|[A-z]+ [A-z]+|[A-z]+ [A-z]+ [A-z]+)'/|\1|/g" | \
    sed -E 's/\|([A-z]+|[A-z]+ [A-z]+|[A-z]+ [A-z]+ [A-z]+)\|/"\1"/g' | \
    sed -E 's/ [0-9]{3} Law, Environment and Development Journal//g' | \
    sed -E 's/ [0-9]{3} The Environmental Management for Sustainable Development Act, 1996//g' | \
    #Article 2
    amend_error_in_article 2 "‘institution responsible for the environment'" '"institution responsible for the environment"' | \
    amend_error_in_article 2 "‘institution responsible for the national protected areas system'" '"institution responsible for the national protected areas system"' | \
    amend_error_in_article 2 "‘institution responsible for nonrenewable natural resources'" '"institution responsible for nonrenewable natural resources"' | \
    amend_error_in_article 2 'substance. "' 'substance; "' | \
    amend_error_in_article 2 'resources. "' 'resources; "' | \
    amend_error_in_article 2 '‘Minister ' '"Minister"' | \
    #Article 11
    amend_error_in_article 11 'meeting \[3\]' 'meeting. [3]' | \
    #Article 17
    amend_error_in_article 17 'sub section' 'subsection' | \
    #Article 21
    amend_error_in_article 21 'Article \[113\]' '113.' | \
    #Article 27
    amend_error_in_article 27 'the Act;' 'the Act.' | \
    #Article 26
    amend_error_in_article 25 'Article \[26\]-' '\n\n(26) ' | \
    #Article 34
    amend_error_in_article 34 'a appropriate' 'an appropriate' | \
    #Article 35
    amend_error_in_article 35 'section \[116\]' 'section 116.' | \
    #Article 37
    amend_error_in_article 37 'shall \[a\]' 'shall: [a]' | \
    amend_error_in_article 37 'institution\[s\]' 'institution(s)' | \
    amend_error_in_article 37 '\[37\]' '37.' | \
    #Article 38
    amend_error_in_article 38 '\[95\]' '95.' | \
    #Article 40
    amend_error_in_article 40 'short-' 'short' | \
    #Article 44
    amend_error_in_article 44 '\[20\]' '(20)' | \
    amend_error_in_article 44 '\[30\]' '(30)' | \
    #Article 45
    amend_error_in_article 45 '\[30\]' '(30)' | \
    #Article 50
    amend_error_in_article 50 '48 \[c\]' '48[c]' | \
    amend_error_in_article 50 '48 \[a\]' '48[a]' | \
    amend_error_in_article 50 '\[7\]' '(7)' | \
    #Article 53
    amend_error_in_article 53 '\[he\]' '(he)' | \
    amend_error_in_article 53 '\[his\]' '(his)' | \
    #Article 54
    amend_error_in_article 54 '\[have\]' '(have)' | \
    #Article 56
    sed -E 's/\[56\]-/\n\n(56) /' | \
    amend_error_in_article 56 '\[41\]' '41.' | \
    #Article 59
    amend_error_in_article 58 '\[59\]' '\n\n(59)' | \
    amend_error_in_article 59 'and Article' 'and 51.' | \
    #Article 60
    amend_error_in_article 60 'Schedule \[4\]' 'Schedule 4.' | \
    #Article 68
    amend_error_in_article 67 'Article \[68\]-' '\n\n(68) ' | \
    amend_error_in_article 68 'section \[98\]' 'section 98.' | \
    #Article 73
    amend_error_in_article 73 'categories–' 'categories:' | \
    #Article 76
    amend_error_in_article 76 '\[45\]' '(45)' | \
    #Article 79
    amend_error_in_article 79 'Schedule' 'Schedule 3.' | \
    #Article 84
    amend_error_in_article 84 'Schedule' 'Schedule 3.' | \
    #Article 85
    amend_error_in_article 85 'shall-' 'shall:' | \
    amend_error_in_article 85 'in Schedule' 'in Schedule 3.' | \
    #Article 88
    amend_error_in_article 88 '\[71\]' '71.' | \
    #Article 90
    amend_error_in_article 90 ', \[•\]' ':' | \
    #Article 93
    amend_error_in_article 93 '\[to\]' '(to)' | \
    #Article 95
    amend_error_in_article 95 'Commits' 'commits' | \
    #Article 104
    amend_error_in_article 104 'by–' 'by:' | \
    #Article 106
    amend_error_in_article 106 'shall appoints' 'shall appoint' | \
    amend_error_in_article 106 '\[be\]' '(be)' | \
    #Article 107
    amend_error_in_article 107 '. \[d\]' '; [d]' | \
    amend_error_in_article 107 '. \[e\]' '; [e]' | \
    amend_error_in_article 107 '. \[f\]' '; [f]' | \
    amend_error_in_article 107 '. \[g\]' '; [g]' | \
    #Article 109
    amend_error_in_article 109 'Subject' 'subject' | \
    #Article 112
    amend_error_in_article 112 'section \[39\]' 'section 39.' | \
    #Article 117
    amend_error_in_article 117 '\[give\]' '(give)' | \
    amend_error_in_article 117 '\[of\]' '(of)' | \
    #Article 121
    amend_error_in_article 121 'Zanzibar,:' 'Zanzibar:' | \
    #Article 123
    amend_error_in_article 123 '\[1995\]' '1995.' | \
    #Article 124
    amend_error_in_article 124 'Originally printed.*$' '' 
}

function amend_errors_in_headers {
  sed -E 's/([0-9]) ([A-Z]{2}+)/\n\nPART \1 - \2/g' | \
    sed -z 's/\n\nPART 1/PART 1/' 
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
    amend_errors_in_articles | \
    amend_errors_in_headers
}