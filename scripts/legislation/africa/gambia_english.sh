#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^27th May, 1994/,$p' | \
    sed -n '/^PART 1/,$p'
}

function prefix_article_numbers_with_article_literal {
  sed -E 's/^([0-9]+\.)/Article \1/'
}

function replace_parentheses_around_article_delimiters_with_square_brackets {
  sed -E 's/\(([A-Za-z0-9]+)\)/[\1]/g'
}

function move_article_titles_after_article_numbers {
  sed -En '${p;q};N;/\nArticle/{s/^(.*)\n(Article [0-9]+\.) /\2 \1|/p;b};P;D'
}

function move_article_titles_above_articles {
  sed -E 's/^(\([0-9]+\) )([^|]+)\|/\2\n\1/'
}

function remove_all_text_after_last_article {
  sed -E '/^\(65\)/,${/^\(65\)/!d}'
}

function amend_errors_in_headers {
  sed -E 's/([^^])(PART)/\1\n\n\2/g' | \
    sed -E 's/(PART [A-Z]+)/\1 -/g' | \
    sed -E 's/PART 1 /PART I - /' 
}

function amend_errors_in_articles {
  sed -E 's/\[I\] /[i] /g' | \
    sed -E 's/sub-section/subsection/g' | \
    #Article 1
    sed -E 's/This Act may be/(1) This Act may be/' | \
    amend_error_in_article 1 ', Article \[2\] Interpretation' '.' | \
    #Article 2
    sed -E 's/\(1\) In/\nInterpretation\n(2) In/' | \
    amend_error_in_article 2 ' 8' '' | \
    amend_error_in_article 2 ' 9' '' | \
    amend_error_in_article 2 'in he' 'in the' | \
    amend_error_in_article 2 'manufa cturing' 'manufacturing' | \
    amend_error_in_article 2 'in section \[20\]' 'in section 20;' | \
    amend_error_in_article 2 '10 section' 'section' | \
    amend_error_in_article 2 'segment of the environment.' 'segment of the environment;' | \
    amend_error_in_article 2 'includes \[' 'includes: [' | \
    amend_error_in_article 2 'means,' 'means:' | \
    amend_error_in_article 2 'and\[ii\]' 'and [ii]' | \
    amend_error_in_article 2 ' 11' '' | \
    amend_error_in_article 2 'indirectly;' 'indirectly:' | \
    amend_error_in_article 2 ' 12' '' | \
    amend_error_in_article 2 ' 13' '' | \
    amend_error_in_article 2 'adapted, and' 'adapted; and' | \
    amend_error_in_article 2 'section \[16\]' 'section 16.' | \
    #Article 3
    amend_error_in_article 3 'adversely. \[2\]' 'adversely: [2]' | \
    #Article 4
    amend_error_in_article 4 ' 14' '' | \
    #Article 6
    amend_error_in_article 6 'co-opt;' 'co-opt.' | \
    #Article 7 
    amend_error_in_article 7 '15 ' '' | \
    #Article 8
    amend_error_in_article 8 '16 ' '' | \
    #Article 10
    amend_error_in_article 10 'inter govern' 'inter-govern' | \
    amend_error_in_article 10 ' 17' '' | \
    amend_error_in_article 10 '\[I\] ' '[i] ' | \
    #Article 11
    amend_error_in_article 11 'removed for;' 'removed for:' | \
    amend_error_in_article 11 'other cause; Establishment of the Administration and Finance Committee' 'other cause.' | \
    #Article 12
    sed -z 's/\n18/\nEstablishment of the Administration and Finance Committee/' | \
    amend_error_in_article 12 '\[2\] \[a\]' '[2][a]' | \
    #Article 14
    amend_error_in_article 14 ' 19' '' | \
    #Article 17
    amend_error_in_article 16 'Local Environment Committees in Banjul and Kanifing Municipal Areas 20' '\n\nLocal Environment Committees in Banjul and Kanifing Municipal Areas\n(17) [1]' | \
    amend_error_in_article 17 '\[1991\]' '1991;' | \
    #Article 18
    amend_error_in_article 18 'represented.' 'represented:' | \
    amend_error_in_article 18 '; 21' '.' | \
    #Article 19
    amend_error_in_article 19 'municipalities.' 'municipalities;' | \
    amend_error_in_article 19 ' 22 ' '' | \
    amend_error_in_article 19 'decision making' 'decision making.' | \
    #Article 20
    amend_error_in_article 20 'of an sus' 'of and sus' | \
    #Article 21
    amend_error_in_article 21 ' 23' '' | \
    amend_error_in_article 21 '1991' '1991;' | \
    #Article 22
    amend_error_in_article 22 '1. A' '[1] A' | \
    amend_error_in_article 22 'stating.' 'stating:' | \
    amend_error_in_article 22 'Article \[2\] ' '' | \
    amend_error_in_article 22 '\|If after' ' [2] If after' | \
    amend_error_in_article 22 '24 Article \[3\] ' '' | \
    amend_error_in_article 22 '\|If pursuant' ' [3] If pursuant' | \
    amend_error_in_article 22 'Article \[4\] ' '' | \
    amend_error_in_article 22 '\[23\]\|The' '23. [4] The' | \
    amend_error_in_article 22 'Article \[5\] ' '' | \
    amend_error_in_article 22 '\|In' ' [5] In' | \
    sed -E 's/\(6\) No/[6] No/' | \
    sed -E 's/and \[24\]/and 24.\n\n/' | \
    #Article 23
    sed -E 's/Article \[2\] //' | \
    sed -E 's/ under section 22/Environmental impact studies and environmental impact statements\n(23) [1] under section 22/' | \
    sed -E 's/\(23\) \[1\]/(23) [1] Where the Agency has determined that an environmental impact study be conducted/' | \
    amend_error_in_article 23 '\|The Agency' ' [2] The Agency' | \
    amend_error_in_article 23 'Article \[3\] ' '' | \
    amend_error_in_article 23 '\|Without' ' [3] Without' | \
    amend_error_in_article 23 'shall state.' 'shall state:' | \
    amend_error_in_article 23 '\[I\]' '[i]' | \
    amend_error_in_article 23 'Article \[4\] ' '' | \
    amend_error_in_article 23 '\|The' ' [4] The' | \
    amend_error_in_article 23 'made:' 'made.' | \
    amend_error_in_article 23 ' 25' '' | \
    sed -z 's/\n\n(5) The/ [5] The/' | \
    #Article 24
    amend_error_in_article 24 'a\.' '[a]' | \
    amend_error_in_article 24 '26 ' '' | \
    amend_error_in_article 24 '\|The' ' [2] The' | \
    amend_error_in_article 24 'Article \[3\] ' '' | \
    amend_error_in_article 24 ';\|In' '. [3] In' | \
    #Article 25
    amend_error_in_article 25 '1.' '[1]' | \
    amend_error_in_article 25 'with.\|The developer' 'with. [2] The developer' | \
    amend_error_in_article 25 'Article \[3\] ' '' | \
    amend_error_in_article 25 '\|The Agency' ' [3] The Agency' | \
    amend_error_in_article 25 'Article \[4\] ' '' | \
    amend_error_in_article 25 '\|The developer' '. [4] The developer' | \
    amend_error_in_article 25 ' 27' '' | \
    #Article 26
    sed -E 's/commencement of this Act/\n\nMonitoring of existing projects\n(26) [1]/' | \
    sed -E 's/\(26\) \[1\]/(26) [1] The Agency shall monitor the operation of all projects in existence at the date of/' | \
    amend_error_in_article 26 'thereunder require' 'thereunder. [2] The Agency shall, where it determines that the project does not comply with this Act, or any regulations made thereunder' | \
    amend_error_in_article 26 'to prepare' '[3] The Agency shall require all operators of existing projects covered by Part A of the Schedule to prepare' | \
    #Article 28
    amend_error_in_article 28 '28 ' '' | \
    amend_error_in_article 28 '29 ' '' | \
    #Article 29
    amend_error_in_article 29 'proposals.' 'proposals:' | \
    amend_error_in_article 29 'pollution. \[b\]' 'pollution; [b]' | \
    amend_error_in_article 29 ' \[d\]' '' | \
    amend_error_in_article 29 'pollution;' 'pollution.' | \
    #Article 30
    amend_error_in_article 30 ' 30' '' | \
    amend_error_in_article 30 'wetland;' 'wetland.' | \
    amend_error_in_article 30 '31 ' '' | \
    #Article 31
    amend_error_in_article 30 'significance; Article \[1\] Management of inland zone\|' 'significance. \n\nManagement of inland zone\n(31) ' | \
    #Article 32
    amend_error_in_article 32 ' 32' '' | \
    #Article 33
    amend_error_in_article 32 'Article \[33\] diversity.\|' 'diversity. \n\n(33) ' | \
    #Article 34
    sed -E 's/ex \[•\] situ/ex-situ/' | \
    amend_error_in_article 34 ' 33' '' | \
    #Article 35
    amend_error_in_article 35 'Fees ' 'fees ' | \
    #Article 36
    amend_error_in_article 36 ' 34' '' | \
    #Article 38
    amend_error_in_article 38 ' 35' '' | \
    amend_error_in_article 38 'Complying with' 'complying with' | \
    #Article 39
    amend_error_in_article 39 'a offence' 'an offence' | \
    amend_error_in_article 39 'section \[28\]' 'section 28.' | \
    amend_error_in_article 39 'such person.' 'such person:' | \
    #Article 40
    amend_error_in_article 40 'fire;' 'fire.' | \
    #Article 42
    amend_error_in_article 42 'a warrant.' 'a warrant:' | \
    amend_error_in_article 42 ' 37' '' | \
    amend_error_in_article 42 '\[I\]' '[i]' | \
    amend_error_in_article 42 ' 38' '' | \
    #Article 43
    amend_error_in_article 43 '8 The' '[c] the' | \
    amend_error_in_article 43 'Would be ' 'would be ' | \
    #Article 44
    amend_error_in_article 44 ' 39' '' | \
    #Article 47
    amend_error_in_article 47 '\[VIII\]' 'VIII;' | \
    amend_error_in_article 47 'and 40' 'and' | \
    #Article 49
    amend_error_in_article 49 ' 41' '' | \
    #Article 51
    amend_error_in_article 51 'conviction.' 'conviction:' | \
    #Article 52
    amend_error_in_article 52 'he knowingly.' 'he knowingly:' | \
    amend_error_in_article 52 ' 42' '' | \
    #Article 53
    amend_error_in_article 53 'section \[23\]' 'section 23.' | \
    amend_error_in_article 53 ' 43' '' | \
    #Article 54
    amend_error_in_article 54 'he; \[a\]' 'he: [a]' | \
    amend_error_in_article 54 'Act;' 'Act.' | \
    amend_error_in_article 54 'conviction.' 'conviction:' | \
    #Article 55
    amend_error_in_article 55 'Offences relating to hazardous and dangerous materials, etc.' '' | \
    amend_error_in_article 55 'if he;' 'if he: [a] violates any environmental standard established in accordance with section 28;' | \
    amend_error_in_article 55 'VII;' 'VII.' | \
    amend_error_in_article 55 'conviction;' 'conviction:' | \
    #Article 56
    sed -z 's/\n44/\nOffences relating to hazardous and dangerous materials, etc/' | \
    amend_error_in_article 56 'section \[36\]' 'section 36;' | \
    amend_error_in_article 56 'Withholds information' 'withholds information' | \
    amend_error_in_article 56 'on conviction.' 'on conviction:' | \
    amend_error_in_article 56 'years.' 'years;' | \
    #Article 57
    amend_error_in_article 57 ' 45 46' '' | \
    amend_error_in_article 57 '\[39\]' '39.' | \
    amend_error_in_article 57 'conviction,' 'conviction:' | \
    #Article 60
    amend_error_in_article 60 '47 ' '' | \
    #Article 64
    amend_error_in_article 64 'Repeal' '' | \
    #Article 65
    sed -z 's/\n48/\nRepeal/' | \
    sed -z 's/Cap.72.*$//' 
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