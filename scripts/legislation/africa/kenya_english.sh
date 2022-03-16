#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/ NOW THEREFORE/,$p' | \
    sed -n '/^PART I - PRELIMINARY/,$p'
}

function prefix_article_numbers_with_article_literal {
  sed -E 's/^([0-9]+)/Article \1/' 
}

function replace_parentheses_around_article_delimiters_with_square_brackets {
  sed -E 's/\(([A-Za-z0-9]+)\)/[\1]/g' 
}

function remove_all_text_after_last_article {
  sed -E '/^\(148\)/,${/^\(148\)/!d}'
}

function amend_errors_in_articles {
  sed -E 's/ –/:/g' | \
    sed -E 's/ 1\]/ [1]/g' | \
    sed -E 's/Article [0-9]+ //g' | \
    sed -E 's/:-/:/g' | \
    sed -E 's/ section \[([0-9]+)\]/ section \1/g' | \
    #Article 1
    amend_error_in_article 1 'Article' '1999.' | \
    #Article 2
    amend_error_in_article 2 'become adapted;' 'become adapted.' | \
    amend_error_in_article 2 'Article 24' '24' | \
    #Article 3
    amend_error_in_article 3 'had the duty' 'has the duty' | \
    amend_error_in_article 3 'public officer \[c\]' 'public officer; [c]' | \
    amend_error_in_article 3 'and \[f\]' 'and; [f]' | \
    amend_error_in_article 3 'sustainable development;' 'sustainable development:' | \
    #Article 4
    amend_error_in_article 4 '- ' ': ' | \
    #Article 6
    amend_error_in_article 6 ' The Authority' '' | \
    #Article 9
    amend_error_in_article 9 '\[2\] \[p\]' '[2][p]' | \
    #Article 10
    amend_error_in_article 10 'authourity' 'authority' | \
    amend_error_in_article 10 ' \[•\]' ':' | \
    amend_error_in_article 10 'section 1 ' 'section 1' | \
    amend_error_in_article 10 '. \[c\]' '; [c]' | \
    amend_error_in_article 10 ': \[d\]' '; [d]' | \
    amend_error_in_article 10 '\(c \)' '[c]' | \
    #Article 23
    sed -E 's/\[Corporations\]/(Corporations)/g' | \
    amend_error_in_article 23 '\[5\]' '[3]' | \
    #Article 24
    sed -z 's/\n\n(12) 4]/ [4]/' | \
    #Article 28
    amend_error_in_article 28 'Provincial and District.*$' '' | \
    #Article 29
    amend_error_in_article 29 'NonGovernmental' 'Non-Governmental' | \
    amend_error_in_article 29 '\[1\] Every' '[3] Every' | \
    #Article 31
    amend_error_in_article 31 '\[1\] \[b\]' '[1][b]' | \
    amend_error_in_article 31 '\[6\]' '[5]' | \
    #Article 32
    amend_error_in_article 32 '9 \[3\]' '9[3]' | \
    #Article 33
    amend_error_in_article 33 'section 32 \[' 'section 32. \[' | \
    #Article 35
    amend_error_in_article 35 '\[1\]If' '[1] If' | \
    #Article 37
    sed -z 's/\n\n(15) 2]/ [2]/' | \
    #Article 41
    amend_error_in_article 41 '38 \[a\]' '38[a]' | \
    #Article 42
    sed -z 's/\n\n(16) 3]/ [3]/' | \
    amend_error_in_article 42 'resources;' 'resources.' | \
    #Article 46
    amend_error_in_article 46 'section 45 \[1\]' 'section 45[1]' | \
    #Article 52
    amend_error_in_article 52 ' Article' '' | \
    amend_error_in_article 52 '. \[c\]' '; [c]' | \
    #Article 58
    amend_error_in_article 58 'fee..' 'fee.' | \
    #Article 81
    amend_error_in_article 81 '\[VI\]' 'VI.' | \
    #Article 87
    amend_error_in_article 87 '\[4\]' '[3]' | \
    amend_error_in_article 87 '\[5\]' '[4]' | \
    amend_error_in_article 87 '\[6\]' '[5]' | \
    #Article 85
    amend_error_in_article 84 'do; Article \[85\]' 'do.\n\n(85)' | \
    #Article 95
    amend_error_in_article 94 'substances; Article \[95\]' 'substances. \n\n(95) ' | \
    #Article 99
    amend_error_in_article 99 '\[2\]' '[2] ' | \
    amend_error_in_article 99 '\[8\]' '[3]' | \
    amend_error_in_article 99 '\[9\]' '[4]' | \
    #Article 108
    amend_error_in_article 108 ' Article' '' | \
    #Article 112
    amend_error_in_article 112 'acquifer' 'aquifer' | \
    sed -z 's/\n\n(30) 5]/ [5]/' | \
    amend_error_in_article 112 'section 116' 'section 116.' | \
    #Article 117
    amend_error_in_article 117 'DirectorGeneral' 'Director-General' | \
    #Article 118
    amend_error_in_article 118 'AttorneyGeneral' 'Attorney-General' | \
    #Article 127
    amend_error_in_article 127 '; \[2\]' '. [2]' | \
    amend_error_in_article 127 '\[1\] \[a\]' '[1][a]' | \
    sed -z 's/\n\n(33) Tribunal;/; [ii] willfully interrupts the proceedings or commits any contempt of the Tribunal;/' | \
    #Article 132
    amend_error_in_article 132 '\[1\]When' '[1] When' | \
    #Article 133
    amend_error_in_article 133 '\[1\] It' '[2] It' | \
    #Article 141
    amend_error_in_article 141 'Kenya' 'Kenya; [g] withholds information or provides false information about the management of hazardous wastes, chemicals or radioactive substances;' | \
    amend_error_in_article 141 'substances;' 'substances; commits an offence and shall, on conviction, be liable to a fine of not less than one million shillings, or to imprisonment for a term of not less than two years, or to both.' | \
    sed -z 's/both.\n\n(35)/both./' | \
    #Article 142
    amend_error_in_article 142 'subsection \[1\]' 'subsections [1].' | \
    amend_error_in_article 142 '\[1\] \[2\]' '[1] and [2]' | \
    #Article 143
    amend_error_in_article 143 'Fails' 'fails' | \
    #Article 148
    amend_error_in_article 148 'FIRST SCHEDULE.*$' '' 
}

function amend_errors_in_headers {
  sed -E 's/(PART [A-Z]+): /\n\n\1 - /g' 
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
    amend_errors_in_articles | \
    amend_errors_in_headers
}