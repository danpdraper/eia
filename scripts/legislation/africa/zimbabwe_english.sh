#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^ENACTED by the President and Parliament of Zimbabwe./,$p' | \
    sed -n '/^PART I/,$p'
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
  sed -z 's/First Schedule (.*$//' 
}

function fix_chapter_reference_formatting { 
  sed -z 's/\n\nChapter/ [Chapter/g' | \
    sed -E 's/(Chapter [0-9]+) -/\1:/g'
}

function amend_errors_in_headers {
  sed -E 's/([^^])(PART)/\1\n\n\2/g' | \
    sed -E 's/OFMINISTER/OF MINISTER/' | \
    sed -E 's/^(PART [A-Z]+)/\1 -/g' | \
    sed -E 's/OF MINISTER./OF MINISTER/' | \
    sed -E 's/ENVIRONMENTALIMPACT/ENVIRONMENTAL IMPACT/' | \
    sed -E 's/quality STANDARDS/QUALITY STANDARDS/' | \
    sed -E 's/V -i/VI/' 
}

function amend_errors_in_articles {
  sed -E 's/—/:/g' | \
    sed -E 's/¾¾/:/g' | \
    sed -E 's/ \[•\]/:/g' | \
    sed -E 's/ ,/,/g' | \
    sed -E 's/ ”/”/g' | \
    sed -E 's/\( f \)/[f]/g' | \
    sed -E 's/:Editor/—Editor/g' | \
    sed -E 's/a invasive/an invasive/g' | \
    sed -E 's/Board: Provided/Board, provided/g' | \
    #Article 1
    amend_error_in_article 1 '\[S.I. 103.*$' '' | \
    #Article 2
    amend_error_in_article 2 'flowing,fresh,brackish' 'flowing, fresh, brackish' | \
    #ARTICLE 4
    amend_error_in_article 4 ' .' '.' | \
    #Article 10
    amend_error_in_article 10 'Act. \[xvii\]' 'Act; [xvii]' | \
    amend_error_in_article 10 'subsection \[3\]' 'subsection [3].' | \
    #Article 14
    amend_error_in_article 14 'appointed: Provided' 'appointed, provided' | \
    #Article 16
    amend_error_in_article 16 'vacancy: Provided' 'vacancy, provided' | \
    #Article 19
    amend_error_in_article 19 'vicechairman' 'vice-chairman' | \
    amend_error_in_article 19 'chairman \.' 'chairman.' | \
    amend_error_in_article 19 'fit: Provided' 'fit, provided' | \
    #Article 20
    amend_error_in_article 20 'fit: Provided' 'fit, provided' | \
    #Article 21
    amend_error_in_article 21 '\] .' '].' | \
    #Article 23
    amend_error_in_article 23 'specify: Provided' 'specify, provided' | \
    #Article 27
    amend_error_in_article 27 'subjectmatter' 'subject matter' | \
    #Article 29
    sed -z 's/\n(29) documents/ documents\n(29)/' | \
    #Article 34
    amend_error_in_article 34 'Agency: Provided' 'Agency, provided' | \
    #Article 36
    sed -E 's/Director- General/Director-General/' | \
    amend_error_in_article 36 'mangaged' 'managed' | \
    amend_error_in_article 36 'actions,situations' 'actions, situations' | \
    #Article 37
    amend_error_in_article 37 'Act: Provided' 'Act, provided' | \
    amend_error_in_article 37 'environment,do' 'environment, do' | \
    amend_error_in_article 37 'following :' 'following:' | \
    #Article 41
    sed -z 's/\n\n07], other/ 10:07], other/' | \
    sed -z 's/\n(10) sections/ sections/' | \
    #Article 44
    amend_error_in_article 44 ' .\|' '.' | \
    amend_error_in_article 44 'Article 45 Accounts of Agency\|' '\n\nAccounts of Agency\n(45)' | \
    #Article 46
    amend_error_in_article 46 'AuditorGeneral' 'Auditor-General' | \
    amend_error_in_article 46 'Act .' 'Act.' | \
    amend_error_in_article 46 'theconduct' 'the conduct' | \
    amend_error_in_article 46 'qhalified' 'qualified' | \
    #Article 47
    sed -z 's/(47) Internal Auditor\n\n/Internal Auditor\n(47) /' | \
    amend_error_in_article 47 '19 - of' '19 of' | \
    #Article 50
    amend_error_in_article 50 'collected: Provided' 'collected, provided' | \
    amend_error_in_article 50 'it: Provided' 'it, provided' | \
    #Article 54
    amend_error_in_article 54 'AuditorGeneral' 'Auditor-General' | \
    #Article 55
    amend_error_in_article 55 '\[Wording altered to make grammatical sense—Editor.\] ' '' | \
    #Article 56
    amend_error_in_article 56 'purposes \[iv\]' 'purposes; [iv]' | \
    amend_error_in_article 56 'use. \[c\]' 'use; [c]' | \
    #Article 68
    amend_error_in_article 68 'Any person' 'any person' | \
    amend_error_in_article 68 'three; the' 'three; [c] the' | \
    sed -E 's/Agency Provided/Agency, provided/' | \
    #Article 70
    amend_error_in_article 70 'the Board \[3\]' 'the Board. [3]' | \
    amend_error_in_article 70 'llicensed' 'licensed' | \
    amend_error_in_article 70 'subsection \[1\]' 'subsection [2]' | \
    #Article 72
    amend_error_in_article 72 '\[The paragraph numbering has been altered into sequence—Editor.\] ' '' | \
    #Article 73
    sed -z 's/\n(73) oil into the environment/ oil into the environment\n(73)/' | \
    amend_error_in_article 73 'directions Board' 'directions the Board' | \
    #Article 77
    amend_error_in_article 77 'seventyfour' 'seventy-four' | \
    amend_error_in_article 77 '\[a\]; \[2\]' '[a]. [2]' | \
    #Article 79
    amend_error_in_article 79 '\[ ' '[' | \
    amend_error_in_article 79 ' \[“bonus“ changed to read “booms“ –Editor\]' '' | \
    #ARticle 83
    amend_error_in_article 83 '\( ' '(' | \
    amend_error_in_article 83 ' \)' ')' | \
    #Article 84-86
    sed -E 's/ Article 85/(85)/' | \
    sed -E 's/\[2005\]\]\| Article 86/2005]\n(86)/' | \
    sed -E 's/\[2005\]\]\|/2005]/' | \
    sed -E 's/\(84\) July, \[2005\]\]//' | \
    sed -z 's/\nRepealed by the Radiation Protection Act 5\/2004 with effect from the 1st/\n(84) [Repealed by the Radiation Protection Act 5\/2004 with effect from the 1st 2005]/' | \
    #Article 90
    amend_error_in_article 90 'eighty- nine' 'eighty-nine' | \
    #Article 92
    sed -z 's/\n\n12]; and\n(29)/ 29:12]; and/' | \
    #Article 97
    amend_error_in_article 97 ' .' '.' | \
    #Article 98
    amend_error_in_article 98 'DirectorGeneral' 'Director-General' | \
    #Article 100
    sed -z 's/\n(100) certificate/ certificate\n(100)/' | \
    amend_error_in_article 100 'DirectorGeneral' 'Director-General' | \
    #Article 101
    amend_error_in_article 101 'issue: Provided' 'issue, provided' | \
    amend_error_in_article 101 ' .' '.' | \
    #Article 103
    amend_error_in_article 103 'Director-General: Provided' 'Director-General, provided' | \
    #Article 108
    amend_error_in_article 108 'any: Provided' 'any, provided' | \
    #Article 109
    sed -z 's/\n(109) purposes/ purposes\n(109)/' | \
    #Article 110
    amend_error_in_article 110 'supplies: Provided' 'supplies, provided' | \
    #Article 112
    amend_error_in_article 112 'rate: Provided' 'rate, provided' | \
    #Article 114
    amend_error_in_article 114 'Part \[XIV\]' 'PART XIV.' | \
    #Article 118
    amend_error_in_article 118 ' is situate.' ' is situated.' | \
    #Article 119
    sed -z 's/\n\nSection 356 -/ [5] Section 356/g' | \
    amend_error_in_article 119 'Agency: Provided' 'Agency, provided' | \
    #Article 123
    sed -z 's/\n(123) road/ road\n(123)/' | \
    #Article 124
    sed -z 's/\n(124) for sale/ for sale\n(124)/' | \
    #Article 126
    sed -z 's/\n(126) alien species/ alien species\n(126)/' | \
    #Article 129 
    amend_error_in_article 129 'against: Provided' 'against, provided' | \
    #Article 130
    amend_error_in_article 130 '\[The.*$' '' | \
    amend_error_in_article 130 'prescribed: Provided' 'prescribed, provided' | \
    #Article 132
    amend_error_in_article 132 '\[k\] any' '[j] any' | \
    amend_error_in_article 132 'shall\(' 'shall (' | \
    amend_error_in_article 132 ' \)' ')' | \
    #Article 133
    amend_error_in_article 133 'jurisdiction: Provided' 'jurisdiction, provided' | \
    #Article 137
    amend_error_in_article 137 ' \[The subsection referred to above has been changed—Editor.\]' '' | \
    #Article 139
    sed -E 's/; Article 139 Additional penalties for contraventions of this Act\|/.\n\nAdditional penalties for contraventions of this Act\n(139)/' | \
    #Article 140
    amend_error_in_article 140 'whatsoever: Provided' 'whatsoever, provided' | \
    amend_error_in_article 140 'dust. \[' 'dust; [' | \
    amend_error_in_article 140 'provisions: Provided' 'provisions, provided' | \
    #Article 144
    amend_error_in_article 144 '19:.07' '19:07' | \
    amend_error_in_article 144 '\[This section.*$' '' | \
    #Article 145
    amend_error_in_article 145 '\[1992\]' '1992)' | \
    amend_error_in_article 145 '\[Pensions\]' '(Pensions)' | \
    #Article 146
    sed -E 's/\(6146\)/(146)/'

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
    fix_chapter_reference_formatting | \
    amend_errors_in_headers | \
    amend_errors_in_articles 
}