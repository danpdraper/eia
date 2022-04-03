function remove_all_text_before_first_header {
  sed -n '/^TITRE 1 /,$p'
}

function amend_errors_in_articles {
  sed -E 's/Economie/Économie/g' | \
    sed -E 's/Chargé/chargé/g' | \
    sed -E 's/([0-9]) ([0-9])/\1.\2/g' | \
    sed -E 's/Etat/État/g' | \
    sed -E 's/1ère/première/g' | \
    sed -E 's/2ème/deuxième/g' | \
    sed -E 's/Energie/Énergie/g' | \
    sed -E 's/0F/0 F/g' | \
    # Article 18
    amend_error_in_article 18 'Forestière, dressent' 'Forestière dressent' | \
    # Article 22
    amend_error_in_article 22 établissement établissements | \
    # Article 41
    amend_error_in_article 41 '\[39\]' '39.' | \
    # Article 42
    # Article 46
    amend_error_in_article 46 classée classées | \
    amend_error_in_article 46 fixés fixées | \
    # Article 66
    amend_error_in_article 66 '\. Cette' '; cette' | \
    amend_error_in_article 66 '\[1\] ' '1.' | \
    amend_error_in_article 66 'au delà' 'au-delà' | \
    # Article 76
    amend_error_in_article 76 'F\.' 'F,' | \
    amend_error_in_article 76 'deux\(2\)' 'deux (2)' | \
    amend_error_in_article 76 'six\(6\)' 'six (6)' | \
    # Article 87
    sed -E ':start;s/^(\(87\).*\] )L/\1l/;t start' | \
    # Article 91
    amend_error_in_article 91 présent présente | \
    amend_error_in_article 91 journal Journal | \
    amend_error_in_article 91 ' Fait.*$' ''
}

function amend_errors_in_headers {
  sed -E 's/GENERAL/GÉNÉRAL/g' | \
    sed -E 's/ETABLISSEMENT/ÉTABLISSEMENT/g' | \
    sed -E 's/ATMOSPHERE/ATMOSPHÈRE/g' | \
    sed -E 's/^(TITRE 6 -)\./\1/' | \
    sed -E 's/CLASSEE/CLASSÉE/g' | \
    sed -E 's/DECHET/DÉCHET/g' | \
    sed -E 's/NUCLEAIRE/NUCLÉAIRE/g' | \
    sed -E 's/MEME/MÊME/g' | \
    sed -E 's/STUPEFIANT/STUPÉFIANT/g' | \
    sed -E 's/^(TITRE 14 -)\./\1/' | \
    sed -E 's/^(TITRE 15 -)\./\1/'
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
