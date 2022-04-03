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
    amend_error_in_article 2 'or natural resource;' 'or natural resources;' | \
    amend_error_in_article 2 'humanity "burdened' 'humanity; "burdened' | \
    #Article 3
    amend_error_in_article 3 'had the duty' 'has the duty' | \
    amend_error_in_article 3 'public officer \[c\]' 'public officer; [c]' | \
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
    amend_error_in_article 10 'Secretary. \[c\]' 'Secretary; [c]' | \
    amend_error_in_article 10 '\[1\] \[a\]' '[1][a]' | \
    amend_error_in_article 10 'section 1' 'subsections [1]' | \
    amend_error_in_article 10 'at least four time' 'at least four times' | \
    #Article 11  
    amend_error_in_article 11 '\[e\]' '[f]' | \
    amend_error_in_article 11 '\[d\]' '[e]' | \
    amend_error_in_article 11 '\[c\]' '[d]' | \
    amend_error_in_article 11 '\[b\]' '[c]' | \
    amend_error_in_article 11 '\[a\]' '[b]' | \
    amend_error_in_article 11 'to: control' 'to: [a] control' | \
    #Article 19
    amend_error_in_article 19 'or any works' 'of any works' | \
    #Article 20
    amend_error_in_article 20 'from other source' 'from other sources' | \
    #Article 23
    sed -E 's/\[Corporations\]/(Corporations)/g' | \
    amend_error_in_article 23 '\[5\]' '[3]' | \
    amend_error_in_article 23 '29\[2\] \[b\]' '29[2][b]' | \
    #Article 24
    sed -z 's/\n\n(12) 4]/ [4]/' | \
    amend_error_in_article 24 'least post-graduate' 'least a post-graduate' | \
    #Article 25
    amend_error_in_article 25 'other projects proponents' 'other project proponents' | \
    #Article 26
    amend_error_in_article 26 'may, invest' 'may invest' | \
    #Article 28
    amend_error_in_article 28 'Provincial and District.*$' '' | \
    amend_error_in_article 28 'breach if the provisions' 'breach of the provisions' | \
    #Article 29
    amend_error_in_article 29 'NonGovernmental' 'Non-Governmental' | \
    amend_error_in_article 29 '\[1\] Every' '[3] Every' | \
    amend_error_in_article 29 'National Council of Non-Governmental Organisation;' 'National Council of Non-Governmental Organisations;' | \
    #Article 30
    amend_error_in_article 30 'appointed. \[b\]' 'appointed; [b]' | \
    #Article 31
    amend_error_in_article 31 '\[1\] \[b\]' '[1][b]' | \
    amend_error_in_article 31 '\[6\]' '[5]' | \
    amend_error_in_article 31 'reappointment: Provided' 'reappointment, provided' | \
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
    amend_error_in_article 42 'optimism sustainable yield' 'optimum sustainable yield' | \
    #Article 46
    amend_error_in_article 46 'section 45 \[1\]' 'section 45[1]' | \
    #Article 52
    amend_error_in_article 52 ' Article' '' | \
    amend_error_in_article 52 '. \[c\]' '; [c]' | \
    #Article 58
    amend_error_in_article 58 'fee\.\.' 'fee.' | \
    amend_error_in_article 58 'proceeding with, carried out' 'proceeding with, carrying out' | \
    amend_error_in_article 58 'his own expense and environmental' 'his own expense an environmental' | \
    #Article 67
    sed -z 's/\n\n(21) 3/ [3/' | \
    #Article 71
    amend_error_in_article 71 'use. \[c\]' 'use; [c]' | \
    amend_error_in_article 71 'environment. \[d\]' 'environment; [d]' | \
    amend_error_in_article 71 'protection. \[e\]' 'protection; [e]' | \
    amend_error_in_article 71 'human beings flora' 'human beings, flora' | \
    #Article 72
    amend_error_in_article 72 'discharge or applies' 'discharges or applies' | \
    #Article 78
    amend_error_in_article 78 'him; \[a\]' 'him: [a]' | \
    #Article 79
    amend_error_in_article 79 'Minister, may on' 'Minister may, on' | \
    #Article 81
    amend_error_in_article 81 '\[VI\]' 'VI.' | \
    #Article 86
    amend_error_in_article 86 'environment; issue' 'environment; [2] issue' | \
    amend_error_in_article 86 '\[3\]' '[4]' | \
    amend_error_in_article 86 '\[2\]' '[3]' | \
    #Article 87
    amend_error_in_article 87 '\[4\]' '[3]' | \
    amend_error_in_article 87 '\[5\]' '[4]' | \
    amend_error_in_article 87 '\[6\]' '[5]' | \
    #Article 85
    amend_error_in_article 84 'do; Article \[85\]' 'do.\n\n(85)' | \
    #Article 94
    amend_error_in_article 94 'Authority. \[f\]' 'Authority; [f]' | \
    #Article 95
    amend_error_in_article 94 'substances; Article \[95\]' 'substances. \n\n(95) ' | \
    #Article 95
    amend_error_in_article 95 'such pesticides or toxic substance' 'such pesticide or toxic substance' | \
    #Article 96
    amend_error_in_article 96 'such pesticides or toxic substance' 'such pesticide or toxic substance' | \
    #Article 99
    amend_error_in_article 99 '\[2\]' '[2] ' | \
    amend_error_in_article 99 '\[8\]' '[3]' | \
    amend_error_in_article 99 '\[9\]' '[4]' | \
    #Article 101
    amend_error_in_article 101 'sonic bonus' 'sonic booms' | \
    #Article 106
    amend_error_in_article 106 'possess' 'possesses' | \
    #Article 108
    amend_error_in_article 108 ' Article' '' | \
    amend_error_in_article 108 'order; \[c\] levy' 'order; [d] levy' | \
    amend_error_in_article 108 'environment; \[b\]' 'environment; [c]' | \
    amend_error_in_article 108 'order; prevent' 'order; [b] prevent' | \
    amend_error_in_article 108 'order; \[5\]' 'order. [5]' | \
    #Article 112
    amend_error_in_article 112 'acquifer' 'aquifer' | \
    sed -z 's/\n\n(30) 5]/ [5]/' | \
    amend_error_in_article 112 'section 116' 'section 116.' | \
    amend_error_in_article 112 'enhancement if the environment' 'enhancement of the environment' | \
    amend_error_in_article 112 'prevents or restrict' 'prevent or restrict' | \
    amend_error_in_article 112 'As environmental easement' 'An environmental easement' | \
    #Article 117
    amend_error_in_article 117 'DirectorGeneral' 'Director-General' | \
    #Article 118
    amend_error_in_article 118 'AttorneyGeneral' 'Attorney-General' | \
    #Article 120
    amend_error_in_article 120 'under section' 'under section 119' | \
    #Article 125
    amend_error_in_article 125 'their, terms of office' 'their terms of office' | \
    #Article 127
    amend_error_in_article 127 '; \[2\]' '. [2]' | \
    amend_error_in_article 127 '\[1\] \[a\]' '[1][a]' | \
    sed -z 's/\n\n(33) Tribunal;/; [ii] willfully interrupts the proceedings or commits any contempt of the Tribunal;/' | \
    #Article 132
    amend_error_in_article 132 '\[1\]When' '[1] When' | \
    amend_error_in_article 132 'direction. Where' 'direction. [2] Where' | \
    amend_error_in_article 132 'Advocate. \[2\]' 'Advocate. [3]' | \
    #Article 133
    amend_error_in_article 133 '\[1\] It' '[2] It' | \
    #Article 141
    amend_error_in_article 141 'Kenya' 'Kenya; [g] withholds information or provides false information about the management of hazardous wastes, chemicals or radioactive substances;' | \
    amend_error_in_article 141 'substances;' 'substances; commits an offence and shall, on conviction, be liable to a fine of not less than one million shillings, or to imprisonment for a term of not less than two years, or to both.' | \
    sed -z 's/both.\n\n(35)/both./' | \
    #Article 142
    amend_error_in_article 142 '\[1\] \[2\]' '[1] and [2]' | \
    amend_error_in_article 142 'subsections \[1\].' 'subsection [1] ' | \
    amend_error_in_article 142 'of subsection' 'of subsections' | \
    #Article 143
    amend_error_in_article 143 'Fails' 'fails' | \
    #Article 147
    amend_error_in_article 147 'from time' 'from time to time' | \
    #Article 148
    amend_error_in_article 148 'FIRST SCHEDULE.*$' '' 
}

function amend_errors_in_headers {
  sed -E 's/(PART [A-Z]+): /\n\n\1 - /g' | \
    sed -E 's/ADMINISTRATION The/ADMINISTRATION\n\nThe/'
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
