#!/bin/bash

function remove_all_text_before_first_chapter_header {
  sed -n '/^TITRE I /,$p'
}

function amend_errors_in_headers {
  sed -E 's/^(Section [0-9]+ - [A-Za-z,’ ]+)[^a-z]+Article ([0-9]+)(er)?/\1\n\n(\2)/' | \
    sed -E 's/Article premier:/\n\n(1)/' | \

    #identify articles preceded by sections
    sed -E 's/^(Section 2 - Des.*) Article 31:/\1\n\n(31)/' | \
    sed -E 's/^(Section 1 - De la.*) Article 37:/\1\n\n(37)/' | \
    sed -E 's/^(Section 3 - De la.*) Article 52:/\1\n\n(52)/' | \
    sed -E 's/^(Section 4 - De la.*) Article 59:/\1\n\n(59)/' | \
    sed -E 's/^(Section 5 - Des déchets.*) Article 62:/\1\n\n(62)/' | \
    sed -E 's/^(Section 10 - De la.*) Article 86:/\1\n\n(86)/'     

}

function fix_double_dash {
    sed -E 's/- –/-/g' | \
    sed -E 's/- -/-/g'
}

function amend_errors_in_articles {
    #identify articles in articles
    amend_error_in_article 37 'Article 38:' '\n\n(38)' | \
    amend_error_in_article 54 'Article 55:' '\n\n(55)' | \

    #remove text after last article
    amend_error_in_article 105 'Fait à Niamey, le 29 décembre 1998 Signé: Le président de la République IBRAHIM MAÏNASSARA BARE Pour ampliation: Le Secrétaire Général du Gouvernement Sadé ELHADJI MAHAMAN' '' | \

    #remove extra colon
    amend_error_in_article 42 ':' '' | \
    amend_error_in_article 70 ':' '' | \
    amend_error_in_article 74 ':' '' | \
    amend_error_in_article 78 ':' '' | \

    #correct spelling and grammar
    amend_error_in_article 2 'semis-arides' 'semi-arides' | \
    amend_error_in_article 2 'Ecosystème:' 'Écosystème:' | \
    amend_error_in_article 2 'Etablissements classés' 'Établissements classés' | \
    amend_error_in_article 2 'Equilibre écologique' 'Équilibre écologique' | \
    amend_error_in_article 2 'Etablissement humain' 'Établissement humain' | \
    amend_error_in_article 2 'Etude d’impact' 'Étude d’impact' | \
    amend_error_in_article 10 'oeuvrant' 'œuvrant' | \
    amend_error_in_article 11 'oeuvrant' 'œuvrant' | \
    amend_error_in_article 40 'audelà' 'au-delà' | \
    amend_error_in_article 56 'soussol' 'sous-sol' | \
    amend_error_in_article 74 'gène' 'gêne' | \
    amend_error_in_article 88 'contribuent' 'contribue' | \
    amend_error_in_article 98 'de un' "d'un" | \
    amend_error_in_article 100 'de un' "d'un" | \
    sed -E 's/l’Etat/l’État/g' | \
    sed -E 's/L’Etat/L’État/g' 

}

function preprocess_state_and_language_input_file {
  if [ "$#" -ne 2 ] ; then
    echo_usage_error "$*" '<input_file_path> <language>'
    return 1
  fi
  local input_file_path="$1"
  local language="$2"

  cat "$input_file_path" | \
    apply_common_transformations_to_stdin "$language" | \
    remove_all_text_before_first_chapter_header | \
    fix_double_dash | \
    amend_errors_in_headers | \
    amend_errors_in_articles 
    
    
}




 
#/Users/matthkli/projects/eia/scripts/legislation/preprocess_legislation.sh niger french && cat /Users/matthkli/projects/eia/raw_data/preprocessed/africa/niger_french.txt