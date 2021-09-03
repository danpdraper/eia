#!/bin/bash

function replace_bullet_point_like_characters_with_bullet_points {
  sed -E 's/\x04|\x05|\x06|\x0b/•/g'
}

function amend_errors_in_headers {
  local stdin="$(</dev/stdin)"

  if [ "$#" -ne 1 ] ; then
    echo_usage_error "$*" '<language>'
    return 1
  fi

  local header_line_prefix_regular_expression
  header_line_prefix_regular_expression="$(get_header_line_prefix_regular_expression $language)"
  local return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  echo "$stdin" | \
    sed -E "s/${header_line_prefix_regular_expression}(-)[^A-Z]+/\1 \2\3\4 /" | \
    sed -E 's/(CHAPITRE [0-9] [^\[]+) (\[•\] )?Article ([0-9]+)\/-/\1\n\n(\3)/' | \
    sed -E 's/: (TITRE I - DISPOSITIONS GENERALES)/:\n\n\1/' | \
    sed -E 's/^(TITRE III .*)EDUCATION(.*)ETABLISSEMENTS/\1ÉDUCATION\2ÉTABLISSEMENTS/' | \
    sed -E 's/^(CHAPITRE) I(.*) \[•\] Article 9\/-/\1 1\2\n\n(9)/' | \
    sed -E 's/^(CHAPITRE 2.*)Etablissements/\1Établissements/' | \
    sed -E 's/^(TITRE VI .*)EVALUATION ENVIRONNEMETALE/\1ÉVALUATION ENVIRONNEMENTALE/' | \
    sed -E 's/^(CHAPITRE 1 .*)Etudes/\1Études/' | \
    sed -E 's/^(CHAPITRE 4 .*)Etat/\1État/'
}

function remove_all_text_before_first_title_header {
  sed -n '/^TITRE I /,$p'
}

function amend_errors_in_articles {
  sed -E ':start;s/^(\(2\).*\[[0-9]+\])- ([A-Z][^,.]+)[,.]/\1 \2:/;t start' | \
    sed -E ':start;s/^(\(2\).*); (\[[0-9]+\])/\1. \2/;t start' | \
    sed -E 's/([0-9] )f( |\.)/\1F\2/' | \
    # Article 1
    amend_error_in_article 1 environment environnement | \
    # Article 2
    amend_error_in_article 2 Equilibre Équilibre | \
    amend_error_in_article 2 'par leur interaction forme' 'par leur interaction, forme' | \
    amend_error_in_article 2 'protection et au maintient' 'protection et au maintien' | \
    amend_error_in_article 2 Etude Étude | \
    amend_error_in_article 2 'sans pour au tant' 'sans pour autant' | \
    amend_error_in_article 2 'e \[21\]' 'e. [21]' | \
    amend_error_in_article 2 Etablissements Établissements | \
    amend_error_in_article 2 'agglomérations urbains et rurale' 'agglomérations urbaines et rurales' | \
    amend_error_in_article 2 'et descente\.' 'et décente.' | \
    amend_error_in_article 2 '\[•\] \[24\]' '[24]' | \
    amend_error_in_article 2 '; Font' '; font' | \
    # Article 4
    amend_error_in_article 4 Etat État | \
    # Article 6
    amend_error_in_article 6 "d'autre Etats" "d'autres États" | \
    amend_error_in_article 6 nivaux niveaux | \
    # Article 7
    amend_error_in_article 7 Etat État | \
    # Article 10
    amend_error_in_article 10 nivaux niveaux | \
    # Article 12
    amend_error_in_article 12 'sites naturelles' 'sites naturels' | \
    # Article 15
    amend_error_in_article 15 Etat État | \
    amend_error_in_article 15 encoure encourt | \
    # Article 17
    amend_error_in_article 17 ' \[•\] Article 18\/-' '.\n\n(18)' | \
    # Article 23
    amend_error_in_article 23 ' Article 24\/-' '.\n\n(24)' | \
    # Article 25
    amend_error_in_article 25 ', \[•\]' '; [•]' | \
    amend_error_in_article 25 '\. \[•\]' '; [•]' | \
    amend_error_in_article 25 ', \[•\]' '; [•]' | \
    # Article 28
    amend_error_in_article 28 'que, leurs fonctions' 'que leurs fonctions' | \
    # Article 35
    amend_error_in_article 35 périmètre périmètres | \
    amend_error_in_article 35 susceptible susceptibles | \
    # Article 36
    amend_error_in_article 36 "d'l" 'de 1' | \
    # Article 40
    amend_error_in_article 40 "d'1" 'de 1' | \
    # Article 41
    amend_error_in_article 41 '\+\+\+\+ ' '' | \
    amend_error_in_article 41 envigueur 'en vigueur' | \
    # Article 53
    amend_error_in_article 53 'e mesure' 'une mesure' | \
    amend_error_in_article 53 cidessus 'ci-dessus' | \
    # Article 60
    amend_error_in_article 60 dangereuses dangereuse | \
    # Article 61
    amend_error_in_article 61 Etats États | \
    # Article 63
    amend_error_in_article 63 'présence loi' 'présente loi' | \
    # Article 75
    amend_error_in_article 75 'interdits: \[•\]' 'interdits: [•]' | \
    # Article 77
    amend_error_in_article 77 ' Article 78\/-' '.\n\n(78)' | \
    # Article 81
    amend_error_in_article 81 ', \[•\]' '; [•]' | \
    amend_error_in_article 81 ', \[•\]' '; [•]' | \
    amend_error_in_article 81 ', \[•\]' '; [•]' | \
    # Article 84
    amend_error_in_article 84 'à sont site' 'à son site' | \
    amend_error_in_article 84 ', \[•\]' '; [•]' | \
    amend_error_in_article 84 ', \[•\]' '; [•]' | \
    amend_error_in_article 84 ', \[•\]' '; [•]' | \
    amend_error_in_article 84 ', \[•\]' '; [•]' | \
    amend_error_in_article 84 ', \[•\]' '; [•]' | \
    amend_error_in_article 84 ', \[•\]' '; [•]' | \
    amend_error_in_article 84 ', \[•\]' '; [•]' | \
    amend_error_in_article 84 'échéant, Le' 'échéant. Le' | \
    # Article 86
    amend_error_in_article 86 "projet L'étude" "projet. L'étude" | \
    # Article 93
    amend_error_in_article 93 '\. \[•\]' '; [•]' | \
    # Article 103
    amend_error_in_article 103 'des mesure requises' 'des mesures requises' | \
    # Article 105
    amend_error_in_article 105 procèsverbal 'procès-verbal' | \
    # Article 107
    amend_error_in_article 107 'Etat\..*$' 'État.'
}

function preprocess_state_and_language_input_file {
  if [ "$#" -ne 2 ] ; then
    echo_usage_error "$*" '<input_file_path> <language>'
    return 1
  fi
  local input_file_path="$1"
  local language="$2"

  cat "$input_file_path" | \
    replace_bullet_point_like_characters_with_bullet_points | \
    apply_common_transformations_to_stdin "$language" | \
    amend_errors_in_headers "$language" | \
    remove_all_text_before_first_title_header | \
    amend_errors_in_articles
}
