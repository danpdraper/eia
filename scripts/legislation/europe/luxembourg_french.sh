#!/bin/bash

function remove_all_text_before_first_header {
  sed -E 's/ (CHAPITRE 1)er (Objectifs)/\n\1 - \2/' | \
    sed -n '/^CHAPITRE 1 /,$p'
}

function add_newlines_between_chapter_headers_and_articles {
  sed -E 's/^(CHAPITRE .*) Art\. \[([0-9]+)\]/\1\n\n(\2)/' | \
    sed -E 's/^(CHAPITRE 1 .*) Art\. 1er\./\1\n\n(1)/'
}

function replace_forward_ticks_with_apostrophes {
  sed -E "s/´/'/g"
}

function amend_errors_in_articles {
  sed -E 's/1er/premier/g' | \
    sed -E 's/Etat/État/g' | \
    # Article 2
    amend_error_in_article 2 'premier ,' 'premier,' | \
    amend_error_in_article 2 '\[27\]' '27.' | \
    # Article 3
    amend_error_in_article 3 Minstre Ministre | \
    # Article 4
    amend_error_in_article 4 'm3 \.' 'm3.' | \
    # Article 8
    amend_error_in_article 8 '\[2\]' '2.' | \
    # Article 10
    amend_error_in_article 10 équivalant équivalents | \
    # Article 12
    amend_error_in_article 12 ' _ 1489' '' | \
    amend_error_in_article 12 Egalement Également | \
    # Article 14
    amend_error_in_article 14 'des hales' 'des haies' | \
    amend_error_in_article 14 'inter dictions' interdictions | \
    amend_error_in_article 14 'grand -ducal' 'règlement grand-ducal arrêtera' | \
    amend_error_in_article 14 modaiités modalités | \
    # Article 16
    amend_error_in_article 16 'importation ,' 'importation,' | \
    # Article 22
    amend_error_in_article 22 'règlement arrêtera 1490 ' '' | \
    # Article 24
    amend_error_in_article 24 constation constatation | \
    # Article 25
    amend_error_in_article 25 laflore 'la flore' | \
    # Article 29
    amend_error_in_article 29 inyitation invitation | \
    amend_error_in_article 29 '_ 1491 ' '' | \
    # Article 35
    amend_error_in_article 35 Mémoiral Mémorial | \
    # Article 37
    amend_error_in_article 37 '\[10\]' '10.' | \
    amend_error_in_article 37 'peines prévus' 'peines prévues' | \
    # Article 39
    amend_error_in_article 39 'attribution ' 'attributions ' | \
    # Article 43
    amend_error_in_article 43 '_ 1493 ' '' | \
    # Article 45
    amend_error_in_article 45 '1 er' premier | \
    # Article 46
    amend_error_in_article 46 '_ 1494 ' '' | \
    amend_error_in_article 46 proprietaire propriétaire | \
    # Article 47
    amend_error_in_article 47 Foêts Forêts | \
    # Article 49
    amend_error_in_article 49 'Art\. \[6\]' 'Art. 6.' | \
    amend_error_in_article 49 inserée insérée | \
    amend_error_in_article 49 ' Vorderriss.*$' ''
}

function amend_errors_in_headers {
  sed -E 's/^(CHAPITRE 5 .*) Indemnisations/\1/'
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
    add_newlines_between_chapter_headers_and_articles | \
    replace_forward_ticks_with_apostrophes | \
    amend_errors_in_articles | \
    amend_errors_in_headers
}
