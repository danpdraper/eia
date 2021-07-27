#!/bin/bash

function replace_bullet_point_like_characters_with_bullet_points {
  sed -E 's/\x01 /• /g'
}

function remove_all_text_before_first_title_header {
  sed -n '/^TITRE I /,$p'
}

function replace_list_item_leading_character_parentheses_with_brackets {
  sed -E 's/(.)\(([0-9]+|[a-z])\) ([A-Z"])/\1[\2] \3/g'
}

function amend_typos_in_articles {
  # Article 4
  amend_typo_in_article 4 'environnement\. \[k\]' 'environnement; [k]' | \
    # Article 9
    amend_typo_in_article 9 ' TITIRE II' '\n\nTITRE II -' | \
    # Article 12
    amend_typo_in_article 12 'internationaux \[•\]' 'internationaux; [•]' | \
    # Article 13
    amend_typo_in_article 13 '\. ARITCLE \[14\]' '.\n\n(14) ' | \
    # Article 15
    amend_typo_in_article 15 'et tien ' 'et tient ' | \
    # Article 22
    amend_typo_in_article 22 en-deça en-deçà | \
    amend_typo_in_article 22 "de d’administration" "de l’administration" | \
    # Article 30
    amend_typo_in_article 30 'ne doit nuire' 'ne doivent nuire' | \
    # Article 31
    amend_typo_in_article 31 'Sans préjudicie' 'Sans préjudice' | \
    amend_typo_in_article 31 '\(1\)' '[1]' | \
    # Article 35
    amend_typo_in_article 35 côtés côtes | \
    # Article 37
    amend_typo_in_article 37 'tires miniers' 'titres miniers' | \
    amend_typo_in_article 37 'réservées au Fonds' 'réservés au Fonds' | \
    # Article 38
    amend_typo_in_article 38 '\(1\)' '[1]' | \
    # Article 43
    amend_typo_in_article 43 ellemême 'elle-même' | \
    # Article 47
    amend_typo_in_article 47 'loI; \[2\]' 'loi. [2]' | \
    # Article 49
    amend_typo_in_article 49 camerounaises camerounaise | \
    # Article 51
    amend_typo_in_article 51 '\(1\)' '[1]' | \
    # Article 55
    amend_typo_in_article 55 '\(1\)' '[1]' | \
    # Article 59
    amend_typo_in_article 59 '\(1\)' '[1]' | \
    amend_typo_in_article 59 '\(1\)' '[1]' | \
    # Article 65
    amend_typo_in_article 65 Rion Rio | \
    # Article 77
    amend_typo_in_article 77 '\(1\)' '[1]' | \
    # Article 82
    amend_typo_in_article 82 soussols 'sous-sols' | \
    # Article 83
    amend_typo_in_article 83 "testes d’application" "textes d'application" | \
    # Article 88
    amend_typo_in_article 88 '\(1\)' '[1]' | \
    # Article 90
    amend_typo_in_article 90 '\(1\)' '[1]' | \
    # Article 98
    amend_typo_in_article 98 '4\(1\) premier tirer' '4[1] premier titre' | \
    amend_typo_in_article 98 n° 'numéro ' | \
    # Article 99
    amend_typo_in_article 99 'anglais\..*$' 'anglais.'
}

function amend_typos_in_headers {
  sed -E 's/^(TITRE I.*)GENERALES/\1GÉNÉRALES/' | \
    sed -E 's/^(CHAPITRE I - DES )DEFINITIONS/\1DÉFINITIONS/' | \
    sed -E 's/^(CHAPITRE II - DES OBLIGATIONS )GENERALES/\1GÉNÉRALES/' | \
    sed -E "s/^(TITRE II - DE L’)ELABORATION/\1ÉLABORATION/" | \
    sed -E 's/^(CHAPITRE II - DES )ETUDES/\1ÉTUDES/' | \
    sed -E 's/^(CHAPITRE III .*)RECEPTEURS/\1RÉCEPTEURS/' | \
    sed -E "s/^(SECTION I .*L’)ATMOSPHERE/\1ATMOSPHÈRE/" | \
    sed -E 's/^(SECTION V .*)ETABLISSEMENTS/\1ÉTABLISSEMENTS/' | \
    sed -E 's/^(CHAPITRE IV .*)CLASSEES(.*)ACTIVITES/\1CLASSÉES\2ACTIVITÉS/' | \
    sed -E 's/^(SECTION I .*)DECHETS/\1DÉCHETS/' | \
    sed -E 's/^(SECTION II .*)CLASSES/\1CLASSÉS/' | \
    sed -E 's/^(SECTION III .*)CHIMQIES/\1CHIMIQUES/' | \
    sed -E 's/^(CHAPITRE V .*)DIVERSITE/\1DIVERSITÉ/' | \
    sed -E 's/^(TITRE IV .*) ETU /\1 ET /' | \
    sed -E 's/^(TITRE VI .*)RESPONSABILITE/\1RESPONSABILITÉ/' | \
    sed -E 's/^(CHAPITRE I .*)RESPONSABILITE/\1RESPONSABILITÉ/' | \
    sed -E 's/^(CHAPITRE II .*)PENALES/\1PÉNALES/'
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
    remove_all_text_before_first_title_header | \
    replace_list_item_leading_character_parentheses_with_brackets | \
    amend_typos_in_articles | \
    amend_typos_in_headers
}
