#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^Article Premier/,$p'
}

function remove_all_text_after_last_article {
  sed -E 's/ (Loi n° 1.457)/\n\1/' | \
    sed '/^Loi n° 1.457/,$d'
}

function separate_articles_from_headers {
  sed -E 's/ Article (L\.[0-9]+-[0-9]+)\.-/\n\n(\1)/g'
}

function wrap_article_delimiters_in_square_brackets {
  sed -E 's/([0-9]+)°\)?/[\1]/g'
}

function remove_journal_page_headers {
  sed -E 's/[0-9]{4} JOURNAL DE MONACO Vendredi 22 décembre 2017 ?//' | \
    sed -E 's/Vendredi 22 décembre 2017 JOURNAL DE MONACO [0-9]{4} ?//'
}

function amend_errors_in_articles {
  sed -E ':start;s/^(\(L\.[0-9]+-[0-9]+\).* )- /\1[•] /;t start' | \
    # Article 1
    sed -E 's/Article Premier\./(1)/' | \
    amend_error_in_article 1 ' Livre I' '\n\nLivre I -' | \
    amend_error_in_article 1 ' Première Partie' '\n\nPremière Partie -' | \
    # Article L.172-1
    amend_error_in_article 'L\.172-1' ' Livre II' '\n\nLivre II -' | \
    # Article L.220-3
    amend_error_in_article 'L\.220-3' ' Vendredi.*$' '' | \
    # Article L.240-1
    amend_error_in_article 'L\.240-1' ' Article L\. 240-2\.-' '\n\n(L.240-2)' | \
    # Article L.250-2
    amend_error_in_article 'L\.250-2' ' TITRE I' '\n\nTITRE I -' | \
    amend_error_in_article 'L\.250-2' ' Livre III' '\n\nLivre III -' | \
    # Article L.311-2
    amend_error_in_article 'L\.311-2' 'article L' 'article L.100-1' | \
    # Article L.324-1
    amend_error_in_article 'L\.324-1' ' Chapitre V' '\n\nChapitre V -' | \
    # Article L.325-6
    amend_error_in_article 'L\.325-6' ' TITRE I' '\n\nTITRE I -' | \
    amend_error_in_article 'L\.325-6' ' Livre IV' '\n\nLivre IV -' | \
    # Article L.421-2
    amend_error_in_article 'L\.421-2' ' Vendredi.*$' '' | \
    # Article L.433-2
    amend_error_in_article 'L\.433-2' 'article L' 'article L.434-2' | \
    # Article L.443-1
    amend_error_in_article 'L\.443-1' '\[2004\]' '2004.' | \
    # Article L.443-2
    amend_error_in_article 'L\.443-2' '\[2004\]' '2004.' | \
    # Article L.454-2
    amend_error_in_article 'L\.454-2' ' TITRE I' '\n\nTITRE I -' | \
    amend_error_in_article 'L\.454-2' ' Livre V' '\n\nLivre V -' | \
    # Article L.550-6
    amend_error_in_article 'L\.550-6' 'article L' 'article L.550-3' | \
    # Article L.560-9
    amend_error_in_article 'L\.560-9' 'article L' 'article L.451-1' | \
    # Article L.570-3
    amend_error_in_article 'L\.570-3' 'al\.' alinéa | \
    amend_error_in_article 'L\.570-3' 'article L' 'article L.560-8' | \
    # Article 2
    amend_error_in_article 2 ' Fait en.*$' ''
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
    remove_all_text_after_last_article | \
    separate_articles_from_headers | \
    wrap_article_delimiters_in_square_brackets | \
    remove_journal_page_headers | \
    amend_errors_in_articles
}
