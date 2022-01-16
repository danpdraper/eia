#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^PART ONE/,$p' 
}

function prefix_article_numbers_with_article_literal {
  sed -E 's/^([0-9]+)\./Article \1/' 
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

function amend_errors_in_articles {
  #Article 1
  amend_error_in_article 1 'Dehitions ' '\n\nDefinitions\n(2) ' | \
    amend_error_in_article 1 '\[29912002\]":ral Negarit Gazeta- No. 11 3"' "" | \
    amend_error_in_article 1 "' December, 2002-Page 1952" '299\/2002."' | \
    amend_error_in_article 1 'Proclamtion' 'Proclamation' | \
    #Article 2
    amend_error_in_article 2 "1'\)" "[1]" | \
    amend_error_in_article 2 'I%.*$' '' | \
    sed -E '/APh"l7"/,/2002-Page1953 \$/d' | \
    amend_error_in_article 2 "but'" "but" | \
    amend_error_in_article 2 'whether and' 'weather and' | \
    amend_error_in_article 2 'quanitity' 'quantity' | \
    amend_error_in_article 2 'lving' 'living' | \
    amend_error_in_article 2 'whetehr' 'whether' | \
    amend_error_in_article 2 'subsequenlty' 'subsequently' | \
    amend_error_in_article 2 'ivestment' 'investment' | \
    amend_error_in_article 2 'orgnaization' 'organization' | \
    amend_error_in_article 2 '~egions' 'regions' | \
    amend_error_in_article 2 ';.' ';' | \
    amend_error_in_article 2 'things.' 'things;' | \
    #Article 3
    sed -E 's/Pro visions/Provisions/' | \
    sed -z 's/\nGeneral Provisions/General Provisions/' | \
    amend_error_in_article 3 '\|' '' | \
    amend_error_in_article 3 'I \[4\] Considerations to Determine Zmvact' '\n\nConsiderations to Determine Impact\n(4)' | \
    amend_error_in_article 3 'proponetn' 'proponent' | \
    #Article 4
    amend_error_in_article 4 'balance,is' 'balance, is' | \
    #Article 5
    sed -z 's/\n\nArticle shall, / Article [1] shall/' | \
    sed -E 's/\(1\) categoris/categories/' | \
    sed -z 's/\ncategories of/ categories of/' | \
    amend_error_in_article 5 'Projects' 'projects' | \
    #Article 6
    amend_error_in_article 6 '7% IBHBH' '\n\n7% IBHBH' | \
    sed -E 's/\[2\] The regional/\n\n[2] The regional/' | \
    sed -E '/7% IBHBH/,/mP4P4\.F/d' | \
    sed -z 's/\n\n\n\[2\]/[2]/' | \
    amend_error_in_article 6 'consuitation' 'consultation' | \
    #Article 7
    sed -E 's/Duties of a Proponent/\n\nDuties of a Proponent\n(7)/' | \
    amend_error_in_article 7 'lR PBfYB' '\n\nlR PBfYB' | \
    amend_error_in_article 7 'fulfil1' 'fulfill' | \
    #Article 8
    sed -E 's/\[I\] Environmental Impact Study Report/\n\nEnvironmental Impact Study Report\n(8)/' | \
    amend_error_in_article 8 '\[C\]' '[c]' | \
    amend_error_in_article 8 'impacts\.' 'impacts;' | \
    amend_error_in_article 8 'impelemtation' 'implementation' | \
    amend_error_in_article 8 'operatioin' 'operation' | \
    #Article 9
    sed -E 's/Review of Environmental Impact Study Report/\nReview of Environmental Impact Study Report\n(9)/' | \
    sed -E '/lR PBfYB/,/2002-Page 1955/d' | \
    amend_error_in_article 9 'stasifactoriey avoided Article 0' 'satisfactorily avoided.' | \
    amend_error_in_article 9 'limpacts' 'impacts' | \
    #Article 10
    sed -E 's/Validity of Approved Environmental Impact Study\| Report/\n\nValidity of Approved Environmental Impact Study Report\n(10)/' | \
    amend_error_in_article 10 'assessment, PART' 'assessment. PART' | \
    amend_error_in_article 10 'ageqcy' 'agency' | \
    amend_error_in_article 10 'shal1,' 'shall, ' | \
    #Article 11
    sed -E 's/Occurrence of Ne W Circumstance/\n\nOccurrence of New Circumstance\n(11)/' | \
    #Article 12
    amend_error_in_article 12 '7%-' '\n\n7%-' | \
    sed -E 's/\[2\] When the/\n[2] When the/' | \
    sed -E '/7%-/,/hAnl.1:/d' | \
    sed -z 's/\n\n\[2\] When/[2] When/' | \
    amend_error_in_article 12 ' ~' '' | \
    amend_error_in_article 12 'comrnitments' 'commitments' | \
    #Article 13
    sed -E 's/En vironmentallmpact Assessment ofpublic/Environmental Impact Assessment of public/' | \
    amend_error_in_article 13 'enail' 'entail' | \
    #Article 14
    sed -z 's/\n\n\[2\] The regional/[2] The regional/' | \
    #Article 15
    amend_error_in_article 15 'its evaluation.' 'its evaluation.\n' | \
    sed -E "/ 7% '/,/2002-Page/d" | \
    amend_error_in_article 15 'Athority' 'Authority' | \
    amend_error_in_article 15 'environemntal' 'environmental' | \
    #Article 18
    amend_error_in_article 18 '7%.*$' '' | \
    sed -E 's/damage inflicted\. /damage inflicted. \n\nPART SEVEN - MISCELLANEOUS PROVISIONS/' | \
    amend_error_in_article 18 'nbt' 'not' | \
    amend_error_in_article 18 'a in' 'a fine' | \
    amend_error_in_article 18 'liabk' 'liable' | \
    amend_error_in_article 18 'persoi' 'person' | \
    amend_error_in_article 18 'bin' 'Birr' | \
    amend_error_in_article 18 'Bin' 'Birr' | \
    amend_error_in_article 18 'fulfil1' 'fulfill' | \
    #Article 19
    sed -E 's/PO wer/Power/g' | \
    #Article 21
    amend_error_in_article 21 'implemlentation' 'implementation' | \
    #Article 23
    sed -E 's/3\*/3rd/g' | \
    sed -E 's/\[2002\]/2002./' | \
    amend_error_in_article 23 '\[2002\].*$' '2002.'
    }

function amend_errors_in_headers {
  sed -E 's/([^^])PART/\1\n\nPART/g' | \
    sed -E 's/natural resources./natural resources.\n\nPART TWO/' | \
    sed -E 's/PART THREE \. /PART THREE/' | \
    sed -E 's/PART FOUR l \[1\]/PART FOUR/' 
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
    amend_errors_in_articles | \
    amend_errors_in_headers
}