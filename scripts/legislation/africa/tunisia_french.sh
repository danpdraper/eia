#!/bin/bash

function remove_all_text_before_first_header {
  sed -E 's/(CHAPITRE )PREMIER(.*) ARTICLE PREMIER:/\n\1I -\2\n\n(1)/' | \
    sed -n '/^CHAPITRE I /,$p'
}

function amend_errors_in_headers {
  sed -E 's/^(CHAPITRE )IV(.*)ARTICLE 14:/\1III\2\n\n(14)/'
}

function amend_errors_in_articles {
  sed -E 's/\(NOUVEAU\) //' | \
    sed -E 's/Etat/État/g' | \
    # Article 3
    sed -E ':start;s/^(\(3\).*)[,.] \[/\1; [/;t start' | \
    # Article 7
    sed -E ':start;s/^(\(7\).*)\. \[/\1; [/;t start' | \
    amend_error_in_article 7 '\] S' '] s' | \
    amend_error_in_article 7 '\] S' '] s' | \
    amend_error_in_article 7 '\] A' '] a' | \
    amend_error_in_article 7 '\] F' '] f' | \
    # Article 9
    amend_error_in_article 9 ' ARTICLE 10:' '\n\n(10)' | \
    amend_error_in_article 9 ' CHAPITRE DEUX' '\n\nCHAPITRE II -' | \
    # Article 10
    amend_error_in_article 10 statutes statuts | \
    # Article 14
    sed -E ':start;s/^(\(14\).*), -/\1; [•]/;t start' | \
    amend_error_in_article 14 ': -' ': [•]' | \
    # Article 18
    amend_error_in_article 18 ' Tunis.*$' ''
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
    amend_errors_in_headers | \
    amend_errors_in_articles
}
