#!/bin/bash

function remove_all_text_before_first_header {
  sed -E 's/(CHAPITRE I):/\n\1 -/' | \
    sed -n '/^CHAPITRE I /,$p'
}

function amend_errors_in_articles {
  sed -E 's/Energie/Énergie/g' | \
    # Article 1
    amend_error_in_article 1 'physique, chimique, biologique' 'physiques, chimiques, biologiques' | \
    # Article 10
    amend_error_in_article 10 'domestiques comprennent' 'domestiques, comprennent' | \
    # Article 14
    amend_error_in_article 14 1er 1 | \
    # Article 15
    amend_error_in_article 15 'le présente' 'la présente' | \
    amend_error_in_article 15 'Agriculture de' 'Agriculture, de' | \
    amend_error_in_article 15 Agents agents | \
    amend_error_in_article 15 'procès verbal' 'procès-verbal' | \
    amend_error_in_article 15 'le fermeture' 'la fermeture' | \
    # Article 16
    amend_error_in_article 16 "200,000 à 1,200,000 F QU'A" '200.000 à 1.200.000 F CFA' | \
    amend_error_in_article 16 'une des peines' 'une de ces peines' | \
    # Article 17
    amend_error_in_article 17 'le présente' 'la présente' | \
    amend_error_in_article 17 '500,000 à 1,000,000' '500.000 à 1.000.000' | \
    # Article 18
    amend_error_in_article 18 '20,000 à 300,000' '20.000 à 300.000' | \
    # Article 19
    amend_error_in_article 19 '500,000 à 2,500,000' '500.000 à 2.500.000' | \
    # Article 20
    amend_error_in_article 20 astreint astreinte | \
    amend_error_in_article 20 '200,000 à 1 200 000' '200.000 à 1.200.000' | \
    # Article 22
    amend_error_in_article 22 ' KOULOUBA.*$' ''
}

function amend_errors_in_headers {
  sed -E 's/DEFINITION/DÉFINITION/g' | \
    sed -E 's/ELIMINATION/ÉLIMINATION/g' | \
    sed -E 's/DECHET/DÉCHET/g' | \
    sed -E 's/EMISSION/ÉMISSION/g'
}

function preprocess_state_and_language_input_file {
  if [ "$#" -ne 2 ] ; then
    echo_usage_error "$*" '<input_file_path> <language>'
    return 1
  fi
  local input_file_path="$1"
  local language="$2"

  apply_common_transformations "$input_file_path" "$language" | \
    remove_all_text_before_first_header | \
    amend_errors_in_articles | \
    amend_errors_in_headers
}
