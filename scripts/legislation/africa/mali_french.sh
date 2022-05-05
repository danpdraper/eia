function remove_all_text_before_first_header {
  sed -E 's/(CHAPITRE 1):/\n\1 -/' | \
    sed -n '/^CHAPITRE 1 /,$p'
}

function amend_errors_in_articles {
  sed -E 's/Etat/État/g' | \
    sed -E 's/^(Section .*) Article ([0-9]+):/\1\n\n(\2)/' | \
    sed -E 's/([0-9]) ([0-9])/\1.\2/g' | \
    # Article 2
    sed -E ':start;s/^(\(2\).*\[[0-9]+\] )([A-Z])/\1\L\2/;t start' | \
    sed -E ':start;s/^(\(2\).*: )([A-Z])/\1\L\2/;t start' | \
    sed -E ':start;s/^(\(2\).*\[•\] )([A-Z])/\1\L\2/;t start' | \
    amend_error_in_article 2 "a l'état" "à l'état" | \
    amend_error_in_article 2 'environnement\. \[6\]' 'environnement; [6]' | \
    amend_error_in_article 2 etude étude | \
    amend_error_in_article 2 'direction Nationale' 'Direction Nationale' | \
    # Article 19
    amend_error_in_article 19 "1'intérieur" "l'intérieur" | \
    # Article 39
    amend_error_in_article 39 'procès verbaux' 'procès-verbaux' | \
    # Article 42
    amend_error_in_article 42 'qui de par' 'qui par' | \
    # Article 45
    amend_error_in_article 45 000francs '000 francs' | \
    # Article 51
    amend_error_in_article 51 ' Bamako.*$' ''
}

function amend_errors_in_headers {
  sed -E 's/GENERAL/GÉNÉRAL/g' | \
    sed -E 's/PROCEDURE/PROCÉDURE/g' | \
    sed -E 's/ETUDE/ÉTUDE/g' | \
    sed -E 's/ACCES/ACCÈS/g' | \
    sed -E 's/DECHET/DÉCHET/g' | \
    sed -E 's/ATMOSPHERIQUE/ATMOSPHÉRIQUE/g' | \
    sed -E 's/CIMETIERE/CIMETIÈRE/g' | \
    sed -E 's/DECHARGE/DÉCHARGE/g' | \
    sed -E 's/^CHAPITRE I -l:/CHAPITRE II -/'
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
