#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^FINAL PROVISIONS (ARTICLES 102 to 104)/,$p' | \
    sed -n '/^PRELIMINARY PART/,$p'
}

function replace_parentheses_around_article_delimiters_with_square_brackets {
  sed -E 's/^\(([A-Za-z0-9]+)\)/[\1]/'
}

function remove_all_text_after_last_article {
  sed -z 's/EXECUTIVE REGULATION OF LAW.*$//' 
}

function amend_errors_in_headers {
  sed -E 's/(PART [A-Z]+)/\n\n\1 -/g' | \
    sed -E 's/(CHAPTER [A-Z]+)/\n\n\1 -/g' | \
    sed -E 's/(Section [A-Za-z]+)/\n\n\1 -/g' | \
    sed -z 's/PRELIMINARY \n\nPART /PRELIMINARY PART\n\n/' | \
    sed -E 's/FINAL PROVISIONS/\n\nFINAL PROVISIONS/' | \
    sed -E 's/CHAPTER - ONE/CHAPTER ONE -/'
}

function amend_errors_in_articles {
  sed -E 's/([A-Z])-/\1./g' | \
    sed -E 's/ ([A-Z])\. ([A-Z])/ [\L\1] \U\2/g' | \
    sed -E 's/([a-z])- ([A-Z])/[\1] \2/g' | \
    sed -E 's/Article/article/g' | \
    #Article 1
    amend_error_in_article 1 'efflusion' 'effusion' | \
    amend_error_in_article 1 '15: 1,000,000' '15:1,000,000' | \
    amend_error_in_article 1 '\[1977\]' '1977.' | \
    amend_error_in_article 1 '\[1992\]' '1992.' | \
    amend_error_in_article 1 'environment \.' 'environment.' | \
    amend_error_in_article 1 '\(EEAA\)' '(EEAA).' | \
    amend_error_in_article 1 'Corporation. \(EGPC\)' 'Corporation (EGPC)' | \
    amend_error_in_article 1 'environment.nd' 'environment and' | \
    amend_error_in_article 1 '\[a\] O' '[a] o' | \
    amend_error_in_article 1 '. \[b\] H' '; [b] h' | \
    amend_error_in_article 1 '. \[c\] A' '; [c] a' | \
    amend_error_in_article 1 '. \[d\] U' '; [d] u' | \
    amend_error_in_article 1 '. \[e\] Toxic' '; [e] toxic' | \
    amend_error_in_article 1 '. \[f\] S' '; [f] s' | \
    amend_error_in_article 1 '\[a\] T' '[a] t' | \
    amend_error_in_article 1 '. \[b\] T' '; [b] t' | \
    amend_error_in_article 1 '. \[c\] T' '; [c] t' | \
    amend_error_in_article 1 '. \[d\] P' '; [d] P' | \
    amend_error_in_article 1 '. \[e\] T' '; [e] t' | \
    amend_error_in_article 1 '. \[f\] E' '; [f] E' | \
    amend_error_in_article 1 '. \[g\] G' '; [g] G' | \
    amend_error_in_article 1 '. \[h\] T' '; [h] T' | \
    amend_error_in_article 1 '. \[i\] O' '; [i] o' | \
    #Article 4
    amend_error_in_article 3 'article 4:' '\n\n(4)' | \
    #Article 5
    sed -E ':start;s/^(\(5\).*)\. \[•\] ([A-Z])/\1; \L\2/;t start' | \
    amend_error_in_article 5 '\[•\] P' 'p' | \
    #Article 13
    amend_error_in_article 13 ' ,' ',' | \
    amend_error_in_article 13 'SecretaryGeneral' 'Secretary-General' | \
    amend_error_in_article 13 'the sector' 'the sector.' | \
    #Article 14
    amend_error_in_article 14 '\[1983\]' '1983.' | \
    #Article 29
    amend_error_in_article 29 'para one' 'paragraph one' | \
    #Article 33
    amend_error_in_article 33 'shall occur' 'shall occur.' | \
    #Article 48
    amend_error_in_article 48 'para \(38\) of article \(1\)' 'paragraph [38] of article 1' | \
    #Article 52
    amend_error_in_article 52 'Republic or Egypt' 'Republic of Egypt' | \
    #Article 57
    amend_error_in_article 57 'ARE' 'The competent minister shall determine the tools and equipment for reducing pollution with which all ships registered in ARE' | \
    #Article 60
    amend_error_in_article 60 'cisterns portable tanks' 'cisterns, portable tanks' | \
    #Article 69
    amend_error_in_article 69 'Egyptian' 'It is prohibited for all establishments, including public places and commercial, industrial, touristic and service establishments, to discharge or throw any untreated substances, wastes or liquids which may cause pollution along the Egyptian' | \
    #Article 77
    amend_error_in_article 77 'para' 'paragraph' | \
    #Article 81
    amend_error_in_article 81 'State Council \[•\]' 'State Council -' | \
    amend_error_in_article 81 'Lighthouses Department' 'Lighthouses Department.' | \
    #Article 87
    amend_error_in_article 87 'para 1' 'paragraph 1' | \
    amend_error_in_article 87 'para 2' 'paragraph 2' | \
    #Article 90
    amend_error_in_article 90 'Pounds.' 'Pounds:' | \
    amend_error_in_article 90 '\[1\] Discharges' '[1] discharges' | \
    amend_error_in_article 90 '. \[2\] F' '; [2] f' | \
    amend_error_in_article 90 '. \[3\] D' '; [3] d' | \
    #Article 92
    amend_error_in_article 92 '54-b' '54[b]' | \
    amend_error_in_article 92 '\(1\)' '[1]' | \
    amend_error_in_article 92 '\(2\)' '[2]' | \
    amend_error_in_article 92 '\(3\)' '[3]'
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
    replace_parentheses_around_article_delimiters_with_square_brackets | \
    apply_common_transformations_to_stdin "$language" | \
    remove_all_text_after_last_article | \
    amend_errors_in_headers | \
    amend_errors_in_articles
}