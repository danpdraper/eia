function remove_all_text_before_first_header {
  sed -E 's/ (TITRE )PREMIER( GENERALITES) Article premier:/\n\1I -\2\n\n(1)/' | \
  sed -n '/^TITRE I /,$p'
}

function remove_all_text_after_last_article {
  sed -E '/^\(13\)/,${/^\(13\)/!d}'
}

function amend_errors_in_articles {
  sed -E 's/Etat/État/g' | \
    # Article 6
    amend_error_in_article 6 'biodiversité \[' 'biodiversité; [' | \
    # Article 13
    amend_error_in_article 13 'Prom.*$' ''
}

function amend_errors_in_headers {
  sed -E 's/^(TITRE I - )GENERALITES/\1GÉNÉRALITÉS/'
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
    amend_errors_in_articles | \
    amend_errors_in_headers
}
