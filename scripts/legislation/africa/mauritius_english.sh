#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^ENACTED by the Parliament of Mauritius, as follows -/,$p' | \
    sed -n '/^PART I/,$p'
}

function prefix_article_numbers_with_article_literal {
  sed -E 's/^([0-9]+\.)/Article \1/'
}

function append_pipe_to_article_title {
  sed -E 's/\r//g' | \
    sed -E 's/^(Article .*)$/\1|/'
}

function replace_parentheses_around_article_delimiters_with_square_brackets {
  sed -E 's/\(([A-Za-z0-9]+)\)/[\1]/g'
}

function move_article_titles_above_article_bodies {
  sed -E 's/^(\([0-9]+\)) ([^|]+)\|/\2\n\1/'
}

function remove_all_text_after_last_article {
  sed -z 's/_____________.*$//' 
}

function amend_errors_in_articles {
  sed -E 's/ –/:/g' | \
    sed -E 's/ \[•\]/:/g' | \
    sed -E 's/shall \[/shall: [/g' | \
    sed -E 's/([a-z])- /\1: /g' | \
    sed -E 's/5000/5,000/g' | \
    sed -E 's/ 000/,000/g' | \
    #Article 2
    amend_error_in_article 2 'means public' 'means a public' | \
    amend_error_in_article 2 ',means' ', means' | \
    amend_error_in_article 2 'liquid from' 'liquid form' | \
    amend_error_in_article 2 'measurement sampling' 'measurement, sampling' | \
    #Article 6
    amend_error_in_article 6 'Act-' 'Act:' | \
    amend_error_in_article 6 'non-governmental organisation' 'non-governmental organisations' | \
    #Article 10
    amend_error_in_article 10 '\[72\]' '72.' | \
    #Article 12
    sed -E 's/Part IV/PART IV/' | \
    amend_error_in_article 12 'management \[b\]' 'management; [b]' | \
    #Article 13
    amend_error_in_article 13 'proponent \[a\]' 'proponent: [a]' | \
    #Article 14
    amend_error_in_article 13 '14 Contents of EIA' '\n\nContents of EIA\n(14)' | \
    amend_error_in_article 14 'environment people' 'environment, people' | \
    #Article 15
    amend_error_in_article 15 'section 13 \[3\]' 'section 13[3]' | \
    #Article 16
    amend_error_in_article 16 '\[l\]' '[1]' | \
    amend_error_in_article 16 '\[1\]\[a\]' '[1][a]' | \
    #Article 17
    amend_error_in_article 17 'may \[a\]' 'may: [a]' | \
    #Article 19
    amend_error_in_article 19 '3\[b\]' '3[b]' | \
    amend_error_in_article 19 '. \[c\]' '; [c]' | \
    amend_error_in_article 19 '\[3\] \[c\]' '[3][c]' | \
    amend_error_in_article 19 'effects. \[c\]' 'effects; [c]' | \
    amend_error_in_article 19 '\[3; \[c\]' '[3][c]' | \
    #Article 23
    amend_error_in_article 23 '\[19\] \[5\]' '[19][5].' | \
    #Article 24
    amend_error_in_article 24 'Director \[b\]' 'Director, [b]' | \
    #Article 27
    amend_error_in_article 27 ' l of' ' 1 of' | \
    amend_error_in_article 27 'or"la' 'or "la' | \
    amend_error_in_article 27 'alinea' 'alinéa' | \
    #Article 33
    amend_error_in_article 33 'health,welfare' 'health, welfare' | \
    #Article 35
    amend_error_in_article 35 'generating station' 'generating stations' | \
    #Article 41
    amend_error_in_article 41 'Minister, shall' 'Minister shall' | \
    #Article 42
    amend_error_in_article 42 'zone,and' 'zone, and' | \
    amend_error_in_article 42 'and include' 'and includes' | \
    #Article 44
    amend_error_in_article 44 'subsection\[1\]' 'subsection [1]' | \
    #Article 45
    amend_error_in_article 45 'as may appointed' 'as may be appointed' | \
    #Article 46
    amend_error_in_article 46 '\[66\] \[2\]' '66. [2]' | \
    amend_error_in_article 46 '\[a\]. \[b\]' '[a]; [b]' | \
    #Article 47
    amend_error_in_article 47 '\[l\]' '[1]' | \
    #Article 48
    amend_error_in_article 48 '\[46\]' '46.' | \
    #Article 54
    sed -z 's/\n\n(910)/ [3] Article 910/' | \
    #Article 56A-E
    sed -E 's/56A. Interpretation/\n\nInterpretation\n(56A)/' | \
    sed -E "s/manager'/manager\”/" | \
    sed -E 's/56B. Charge to environment protection fee/\n\nCharge to environment protection fee\n(56B)/' | \
    amend_error_in_article 56B 'Fifth Schedule \[3\]' 'Fifth Schedule. [3]' | \
    sed -E 's/month; \[b\] Where/month. [b] Where/' | \
    sed -E 's/56C. Registration of enterprise or activity/\n\nRegistration of enterprise or activity\n(56C)/' | \
    sed -E 's/56D. Surcharge for late payment of fee/\n\nSurcharge for late payment of fee\n(56D)/' | \
    amend_error_in_article 56D 'per cent' 'percent' | \
    sed -E 's/56E. Recovery of fee/\n\nRecovery of fee\n(56E)/' | \
    #Article 57
    amend_error_in_article 57 'stating \[a\]' 'stating: [a]' | \
    #Article 62
    sed -E 's/; Article \[62\] Variation notice.\|/. \n\nVariation notice.\n(62)/' | \
    #Article 63
    amend_error_in_article 63 'enforcement noticed' 'enforcement notice' | \
    #Article 64 
    amend_error_in_article 64 'equipments' 'equipment' | \
    amend_error_in_article 64 'records documents' 'records, documents' | \
    #Article 66
    amend_error_in_article 66 'subsection\[2\]' 'subsection [2]' | \
    #Article 75
    amend_error_in_article 75 '\[2\]\[l\]' '[2][1]' | \
    amend_error_in_article 75 ' A\[8\]' '[A][8]' | \
    amend_error_in_article 75 ' A\[5\]' '[A][5]' | \
    amend_error_in_article 75 '\[150\] \[13\]' '150[13]' | \
    amend_error_in_article 75 '" Subject ' '"Subject ' | \
    amend_error_in_article 75 '14 A' '14A' | \
    amend_error_in_article 75 'subsection \[2\]; \[8\] The Local Government Act' 'subsection [2]. [8] The Local Government Act' | \
    amend_error_in_article 75 'Regulations 1939; \[11\]' 'Regulations 1939. [11]' | \
    amend_error_in_article 75 '"nuisance" \[c\] by deleting' '"nuisance"; [c] by deleting' | \
    amend_error_in_article 75 'section 150\[13\]' 'section 150. [13]' | \
    amend_error_in_article 75 '91; \[14\]' '91. [14]' | \
    sed -E 's/PART IV of/Part IV - of/' | \
    sed -E 's/Article \[42\] Immunity of Authority. \|/(42) Immunity of Authority./' | \
    sed -E 's/156A. Control of waste./(156A) Control of waste./'
}

function amend_errors_in_headers {
  sed -E 's/([^^])PART/\1\n\nPART/g' | \
    sed -E 's/^(PART [A-Z]+)/\1 -/g' | \
    sed -z 's/\n\nPART X - (/Part X (/' | \
    sed -E 's/the provisions of Part IV -/the provisions of Part IV/' 
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