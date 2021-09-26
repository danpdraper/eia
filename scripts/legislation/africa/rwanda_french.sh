#!/bin/bash

function remove_all_text_before_first_chapter_header {
  sed -n '/CHAPITRE PREMIER - DES DISPOSITIONS GENERALES /,$p'
}

function amend_errors_in_headers {
  sed -E 's/^(Section [0-9]+ - [A-Za-z,’ ]+)[^a-z]+Article ([0-9]+)(er)?/\1\n\n(\2)/' | \
    sed -E 's/Article premier:/\n\n(1)/' | \
    sed -E 's/^(CHAPITRE )I -l:/\1II -/' | \
    sed -E 's/^(TITRE )I -l:/\1II -/' | \
    sed -E "s/(CHAPITRE PREMIER - DE L'ENVIRONNEMENT NATUREL )/\1\n\n/" | \
    sed -E 's/^(Section première: Le sol.*) Article 11:/\1\n\n(11)/' | \
    sed -E 's/^(Section 3 - De la diversité.*) Article 20:/\1\n\n(20)/' | \
    sed -E "s/^(Section 4 - De l'atmosphère.*) Article 25:/\1\n\n(25)/" | \
    sed -E "s/^(Section 2 - Obligations.*) Article 60:/\1\n\n(60)/" | \
    sed -E 's/^(CHAPITRE )I -ll:/\1III -/' 
}

function reformat_numbering_within_articles {
  sed -E 's/([0-9])(°)/[\1]/g' 
}

function amend_errors_in_articles {   
  #Article 1
  amend_error_in_article 1 'bien être' 'bien-être' | \
  #Article 4
  amend_error_in_article 4 '; 5' ';' | \
  amend_error_in_article 4 ' 6' '' | \
  amend_error_in_article 4 ' 7' '' | \
  amend_error_in_article 4 "d'Etude" "d'Étude" | \
  amend_error_in_article 4 "A. L'environnement naturel: " "\n\nA. L'environnement naturel:\n\n" | \
  sed -E "s/(B. L'environnement humain )/\n\n\1\n\n/" | \
  sed -E "s/(B.1. Les éléments nuisibles )/\n\n\1\n\n/" | \
  sed -E "s/(13.2. Les éléments non nuisibles )/\n\n\1\n\n/" | \
  sed -E 's/(C. Autres mots utilisés )/\n\n\1\n\n/' | \
  #Article 5
  amend_error_in_article 5 'a la faune' 'à la faune' | \
  #Article 7
  amend_error_in_article 7 ' 8' '' | \
  #Article 8
  amend_error_in_article 8 ' 9' '' | \
  #Article 15
  amend_error_in_article 15 ': ' ' ' | \
  #Article 53
  amend_error_in_article 53 ' 18' '' | \
  #Article 62
  amend_error_in_article 62 ' 20' '' | \
  #Article 73 
  amend_error_in_article 73 ' 23' '' | \
  #Article 81 
  amend_error_in_article 81 ' 25' '' | \
  #Article 85 
  amend_error_in_article 85 ' 26' '' | \
  #Article 106 
  amend_error_in_article 106 ' 31' '' | \
  #Article 118
  amend_error_in_article 118 'Fait.*$' '' | \
  #All articles
  sed -E 's/Etat/État/g' | \
  sed -E 's/[[]m]/m)/g'
}


function preprocess_state_and_language_input_file {
  if [ "$#" -ne 2 ] ; then
    echo_usage_error "$*" '<input_file_path> <language>'
    return 1
  fi
  local input_file_path="$1"
  local language="$2"

  apply_common_transformations "$input_file_path" "$language" | \
  remove_all_text_before_first_chapter_header | \
  amend_errors_in_headers | \
  amend_errors_in_articles | \
  reformat_numbering_within_articles 
}