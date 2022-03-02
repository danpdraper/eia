#!/bin/bash

function remove_all_text_before_first_chapter_header {
  sed -n '/^TITRE I /,$p'
}

function amend_errors_in_headers {
  sed -E "s/^(Section [0-9]+ - [A-Za-z,' ]+)[^a-z]+Article ([0-9]+)(er)?:/\1\n\n(\2)/" | \
    sed -E 's/Article premier:/\n\n(1)/' | \
    sed -E 's/DISPOSITIONS GENERALES/DISPOSITIONS GÉNÉRALES/' | \
    sed -E 's/DES DEFINITIONS/DES DÉFINITIONS/' | \
    sed -E "s/DE L'ELABORATION/DE L'ÉLABORATION/" | \
    sed -E 's/^(Section 3 - De la.*) Article 52:/\1\n\n(52)/'
}

function fix_double_dash {
    sed -E 's/- –/-/g' | \
    sed -E 's/- -/-/g'
}

function amend_errors_in_articles {
    #Article 2
    sed -E ':start;s/^(\(2\).*)[[][a-z]] /\1/;t start' | \
    sed -E ':start;s/^(\(2\).*)– /\1[•] /;t start' | \
    amend_error_in_article 2 'semis-arides' 'semi-arides' | \
    amend_error_in_article 2 'Ecosystème:' 'Écosystème:' | \
    amend_error_in_article 2 'Etablissements classés' 'Établissements classés' | \
    amend_error_in_article 2 'Equilibre écologique' 'Équilibre écologique' | \
    amend_error_in_article 2 'Etablissement humain' 'Établissement humain' | \
    amend_error_in_article 2 "Etude d'impact" "Étude d'impact" | \
    amend_error_in_article 2 'ce denier' 'ce dernier' | \
    #Article 3
    sed -E ':start;s/^(\(3\).*)[[][a-z]] /\1[•] /;t start' | \
    #Article 37
    amend_error_in_article 37 'Article 38:' '\n\n(38)' | \
    sed -E ':start;s/^(\(37\).*)- /\1[•] /;t start' | \
    amend_error_in_article 37 'homme;' 'homme.' | \
    #Article 40
    amend_error_in_article 40 'audelà' 'au-delà' | \
    #Article 42
    amend_error_in_article 42 ':' '' | \
    #Article 54
    amend_error_in_article 54 'Article 55:' '\n\n(55)' | \
    #Article 56
    amend_error_in_article 56 'soussol' 'sous-sol' | \
    #Article 70
    amend_error_in_article 70 ':' '' | \
    #Article 74
    amend_error_in_article 74 ':' '' | \
    amend_error_in_article 74 'gène' 'gêne' | \
    #Article 76
    sed -E ':start;s/^(\(76\).*)- /\1[•] /;t start' | \
    #Article 78
    amend_error_in_article 78 ':' '' | \
    #Article 86
    sed -E ':start;s/^(\(86\).*)- /\1[•] /;t start' | \
    #Article 88
    amend_error_in_article 88 'contribuent' 'contribue' | \
    #Article 90
    amend_error_in_article 90 '[[][•]]' '-' | \
    amend_error_in_article 90 'agro - sylvo - pastorale' 'agro-sylvo-pastorale' | \
    #Article 98
    amend_error_in_article 98 'de un' "d'un" | \
    #Article 100
    amend_error_in_article 100 'de un' "d'un" | \
    #Article 105
    amend_error_in_article 105 'Fait.*$' '' | \
    #All articles
    sed -E 's/Etat/État/g'
}

function preprocess_state_and_language_input_file {
  if [ "$#" -ne 2 ] ; then
    echo_usage_error "$*" '<input_file_path> <language>'
    return 1
  fi
  local input_file_path="$1"
  local language="$2"

  cat "$input_file_path" | \
    apply_common_transformations "$input_file_path" "$language" | \
    remove_all_text_before_first_chapter_header | \
    fix_double_dash | \
    amend_errors_in_headers | \
    amend_errors_in_articles    
}
