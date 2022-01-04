#!/bin/bash

function remove_all_text_before_first_header {
  sed '0,/^TITRE I /d' | \
    sed -n '/^TITRE I /,$p'
}

function remove_chapter_lists {
  local output="$(</dev/stdin)"
  for title_number in I II III IV V VI ; do
    output="$(
      echo "$output" | \
        sed -E "/^TITRE ${title_number} /,/^\([0-9]+\)/{/^CHAPITRE II /,/^\([0-9]+\)/{/^\([0-9]+\)/!d;};}"
    )"
  done
  echo "$output"
}

function remove_footer_text {
  sed -E "s/Loi n° 98 – 030 portant loi cadre sur l'environnement en République du Bénin( [0-9]+ )?//g"
}

function amend_errors_in_articles {
  sed -E 's/Etat/État/g' | \
    # Article 2
    amend_error_in_article 2 '\. Elle' '; elle' | \
    # Article 5
    amend_error_in_article 5 '\. Ces' '; ces' | \
    # Article 18
    amend_error_in_article 18 "‘‘sol''" '"sol"' | \
    # Article 45
    sed -E ':start;s/^(\(45\).*)‘‘/\1"/;t start' | \
    sed -E ":start;s/^(\(45\).*)''/\1\"/;t start" | \
    # Article 54
    amend_error_in_article 54 'ci- dessous' 'ci-dessous' | \
    # Article 57
    amend_error_in_article 57 "‘‘établissements humains''" '"établissements humains"' | \
    # Article 61
    amend_error_in_article 61 'classé, doit' 'classé doit' | \
    # Article 66
    amend_error_in_article 66 "‘‘déchet''" '"déchet"' | \
    # Article 74
    sed -E 's/^(\(74\).*)‘‘/\1"/' | \
    sed -E "s/^(\(74\).*)''/\1\"/" | \
    # Article 77
    amend_error_in_article 77 '\[76\]' '76.' | \
    # Article 82
    amend_error_in_article 82 arêt arrêt | \
    # Article 87
    amend_error_in_article 87 L '"L' | \
    sed -E "s/^(\(87\).*)''/\1\"/" | \
    # Article 94
    sed -E 's/^(\(94\).*)‘‘/\1"/' | \
    sed -E "s/^(\(94\).*)''/\1\"/" | \
    # Article 96
    sed -E 's/^(\(96\).*)‘‘/\1"/' | \
    sed -E "s/^(\(96\).*)''/\1\"/" | \
    # Article 102
    amend_error_in_article 102 "ad'hoc" 'ad hoc' | \
    # Article 113
    amend_error_in_article 113 'ving-cinq' 'vingt-cinq' | \
    # Article 116
    amend_error_in_article 116 'roues ,' 'roues,' | \
    # Article 120
    amend_error_in_article 120 'vingt- cinq' 'vingt-cinq' | \
    amend_error_in_article 120 '\[I\]' 'I.' | \
    # Article 122
    amend_error_in_article 122 ' Signatures' '' | \
    # Article 123
    sed -E 's/^(TITRE VII.*) ARTICLE 123/\1\n\n(123)/' | \
    amend_error_in_article 123 'État Fait.*$' 'État.'
}

function amend_errors_in_headers {
  sed -E 's/GENERAL/GÉNÉRAL/g' | \
    sed -E 's/DEFINITION/DÉFINITION/g' | \
    sed -E 's/DEVELOPPEMENT/DÉVELOPPEMENT/g' | \
    sed -E 's/BENIN/BÉNIN/g' | \
    sed -E 's/RECEPT/RÉCEPT/g' | \
    sed -E 's/ETABLISSEMENT/ÉTABLISSEMENT/g' | \
    sed -E 's/DECHET/DÉCHET/g' | \
    sed -E 's/ETUDE/ÉTUDE/g' | \
    sed -E 's/PROCEDURE/PROCÉDURE/g' | \
    sed -E 's/PENAL/PÉNAL/g' | \
    sed -E 's/^(CHAPITRE I .*OBJECTIFS,)(DES)/\1 \2/' | \
    sed -E 's/^(CHAPITRE IV -)(DE)/\1 \2/' | \
    sed -E 's/^(CHAPITRE II .*)CLASSES/\1CLASSÉS/' | \
    sed -E 's/^(CHAPITRE I .*IMPACT)\./\1/' | \
    sed -E 's/^(TITRE VII - ).*$/\1DES DISPOSITIONS FINALES/'
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
    remove_chapter_lists | \
    remove_footer_text | \
    amend_errors_in_articles | \
    amend_errors_in_headers
}
