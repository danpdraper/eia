#!/bin/bash

function replace_line_leading_stars_and_dashes_with_bullet_points {
  sed -E 's/^[\t ]+[-*]/•/g'
}

function remove_all_text_before_first_article_header {
  sed -E 's/ ARTICLE 1ER\. -/\n(1)/' | \
    sed -En '/^\(1\)/,$p'
}

function amend_typos_in_articles {
  # Article 1
  amend_typo_in_article 1 'I et II' 'I et II).' | \
    # Article 2
    amend_typo_in_article 2 1er 1 | \
    # Article 3
    amend_typo_in_article 3 rèspect respect | \
    # Article 4
    amend_typo_in_article 4 'choix; Des' 'choix. Des' | \
    # Article 11
    amend_typo_in_article 11 résulterait résulteraient | \
    # Article 15
    amend_typo_in_article 15 ' ANNEX 1' '\n\nANNEXE I' | \
    amend_typo_in_article 15 ' Fait à Brazzaville.*$' ''
}

function amend_typos_in_annexes {
  local stdin="$(</dev/stdin)"

  local annex_i_line_prefix='ANNEXE I '
  local annex_ii_line_prefix='ANNEXE II'

  echo "$stdin" | \
    # ANNEX I
    sed -E ":start;s/^(${annex_i_line_prefix}.*\[[0-9]\]) -/\1/;t start" | \
    sed -E "s/^(${annex_i_line_prefix}.*)forêts \[•\]/\1forêts: [•]/" | \
    sed -E "s/^(${annex_i_line_prefix}.*engrais)\./\1/" | \
    sed -E "s/^(${annex_i_line_prefix}.*ports)\./\1/" | \
    sed -E "s/^(${annex_i_line_prefix}.*mer)\./\1/" | \
    sed -E "s/^(${annex_i_line_prefix}.*eau)\./\1/" | \
    sed -E "s/^(${annex_i_line_prefix}.*)transport aériens/\1transports aériens/" | \
    sed -E "s/^(${annex_i_line_prefix}.*)gazodues/\1gazoducs/" | \
    sed -E "s/^(${annex_i_line_prefix}.*)oléodues/\1oléoducs/" | \
    sed -E "s/^(${annex_i_line_prefix}.*chimiques) etc\.\.\./\1, etc./" | \
    sed -E "s/^(${annex_i_line_prefix}.*)1ère et 2ème classe/\1première et deuxième classe/" | \
    sed -E "s/^(${annex_i_line_prefix}.*)Etablissements/\1Établissements/" | \
    sed -E "s/^(${annex_i_line_prefix}.*eau)\./\1/" | \
    sed -E "s/^(${annex_i_line_prefix}.*Lotissement) etc \.\.\./\1, etc./" | \
    sed -E "s/^(${annex_i_line_prefix}.*) \[1\]/\1\n\n[1]/" | \
    sed -E "s/^(${annex_i_line_prefix}).*(Liste des Travaux)/\1- \2/" | \
    sed -E "s/^(${annex_i_line_prefix}.*)Etude/\1Étude/" | \
    # ANNEX II
    sed -E ":start;s/^(${annex_ii_line_prefix}.*\[[0-9]\]) -/\1/;t start" | \
    sed -E "s/^(${annex_ii_line_prefix}.*Impact),/\1/" | \
    sed -E "s/^(${annex_ii_line_prefix}.*marécages),/\1/" | \
    sed -E "s/^(${annex_ii_line_prefix}.*rendement),/\1/" | \
    sed -E "s/^(${annex_ii_line_prefix}.*flore)\./\1/" | \
    sed -E "s/^(${annex_ii_line_prefix}.*)Innondation/\1Inondation/" | \
    sed -E "s/^(${annex_ii_line_prefix}.*salubrité publique),/\1/" | \
    sed -E "s/^(${annex_ii_line_prefix}.*)Emissions/\1Émissions/" | \
    sed -E "s/^(${annex_ii_line_prefix}.*)Emission/\1Émission/" | \
    sed -E "s/^(${annex_ii_line_prefix}.*)Ecoulement/\1Écoulement/" | \
    sed -E "s/^(${annex_ii_line_prefix}.*rejet)\./\1/" | \
    sed -E "s/^(${annex_ii_line_prefix}.*découlant)\./\1/" | \
    sed -E "s/^(${annex_ii_line_prefix}.*)listères/\1lisières/" | \
    sed -E "s/^(${annex_ii_line_prefix}.*astoréicole),/\1/" | \
    sed -E "s/^(${annex_ii_line_prefix}.*remarquables),/\1/" | \
    sed -E "s/^(${annex_ii_line_prefix}.*)historistiques/\1historiques/" | \
    sed -E "s/^(${annex_ii_line_prefix}.*renouvelables)\./\1/" | \
    sed -E "s/^(${annex_ii_line_prefix}.*tourisme);/\1/" | \
    sed -E "s/^(${annex_ii_line_prefix}.*sportifs)\./\1/" | \
    sed -E "s/^(${annex_ii_line_prefix}.*) \[1\]/\1\n\n[1]/" | \
    sed -E "s/^(${annex_ii_line_prefix}).*(Liste Indicative)/\1 - \2/" | \
    sed -E "s/^(${annex_ii_line_prefix}.*)Etudes/\1Études/"
}

function preprocess_state_and_language_input_file {
  if [ "$#" -ne 2 ] ; then
    echo_usage_error "$*" '<input_file_path> <language>'
    return 1
  fi
  local input_file_path="$1"
  local language="$2"

  cat "$input_file_path" | \
    replace_line_leading_stars_and_dashes_with_bullet_points | \
    apply_common_transformations_to_stdin "$language" | \
    remove_all_text_before_first_article_header | \
    amend_typos_in_articles | \
    amend_typos_in_annexes
}
