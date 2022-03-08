#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^\[Commencement. \]/,$p' | \
    sed -n '/^PART I/,$p'
}

function prefix_article_numbers_with_article_literal {
  sed -E 's/^([0-9]+\.)/Article \1/'
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
  sed -E '/^\(42\)/,${/^\(42\)/!d}'
}

function amend_errors_in_headers {
  sed -E 's/([^^])(PART)/\1\n\n\2/g' | \
    sed -E 's/^(PART I+)/\1 -/' 
}

function amend_errors_in_articles {
  sed -E 's/‐ /: /g' | \
    sed -E 's/\[1992 No. \[59\]\] //g' | \
    sed -E 's/\[1992 No.//g' | \
    sed -E 's/, 000/,000/g' | \
    #Article 2
    amend_error_in_article 2 '\[1999 No. \[14\]\] ' '' | \
    amend_error_in_article 2 '\[Schedule.' '' | \
    amend_error_in_article 2 '…..' '.....' | \
    #Article 3
    amend_error_in_article 3 '1S' 'is' | \
    amend_error_in_article 3 '\[i\] Health' '[iii] Health' | \
    amend_error_in_article 3 '\(ii\)' '[ii]' | \
    #Article 5
    amend_error_in_article 5 '\[1992 No. \[59\]\] ' '' | \
    amend_error_in_article 5 '\(i\)' '[i]' | \
    amend_error_in_article 5 '\(ii\)' '[ii]' | \
    #Article 6
    amend_error_in_article 6 'co: ' 'co-' | \
    #Article 9
    amend_error_in_article 9 '\[Cap. P4.\] ' '' | \
    #Article 12
    amend_error_in_article 12 '\[Cap. L5.\] ' '' | \
    #Article 13
    amend_error_in_article 12 'Article \[13\] Fund of the Agency \|' '\n\nFund of the Agency\n(13)' | \
    #Article 16
    sed -E 's/Water quality Article \[16\] Federal water quality standards \|/\n\nWater Quality\n\nFederal water quality standards\n(16)/' | \
    #Article 17
    amend_error_in_article 17 'Air quality and atmospheric protection Article \[18\] Air quality, etc. \|' '\n\nAir quality and atmospheric protection \n\nAir quality, etc.\n(18)' | \
    #Article 21
    amend_error_in_article 20 'Hazardous substances Article \[21\] Discharge of hazardous substances \|' '\n\nHazardous substances  \n\nDischarge of hazardous substances\n(21)' | \
    amend_error_in_article 21 '\[Cap. Hl.' '' | \
    amend_error_in_article 21 'N 1' 'N1' | \
    #Article 25
    sed -E 's/Article \[25\] Establishment of State and local government bodies \|/\n\nEstablishment of State and local government bodies\n(25)/' | \
    #Article 26
    sed -E 's/PART I -V /PART IV /' | \
    sed -E 's/Enforcement powers Article \[26\] Powers to inspect, etc. \|/\n\nEnforcement powers \n\nPowers to inspect, etc.\n(26)/' | \
    #Article 31
    amend_error_in_article 31 '30 \[2\]' '30[2]' | \
    #Article 35
    sed -E 's/General penalties and legal proceedings Article \[35\] Material misrepresentation and impersonation \|/\n\nGeneral penalties and legal proceedings \n\nMaterial misrepresentation and impersonation\n(35)/' | \
    #Article 36
    amend_error_in_article 36 'therefor,' 'therefore,' | \
    #Article 37
    amend_error_in_article 37 'Miscellaneous' '\n\nMiscellaneous' | \
    #Article 42
    amend_error_in_article 42 ' ___.*$' '' 
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
    amend_errors_in_headers | \
    amend_errors_in_articles
}