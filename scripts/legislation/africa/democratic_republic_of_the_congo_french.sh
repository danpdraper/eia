function remove_all_text_before_first_chapter_header {
  sed -E 's/ (CHAPITRE 1)er: (DES DISPOSITIONS GENERALES)/\n\1 - \2/' | \
  sed -n '/^CHAPITRE 1 /,$p'
}

function remove_all_text_after_last_article {
  sed -E '/^\(89\)/q'
}

function amend_errors_in_headers {
  sed -E "s/^(Section [0-9]+ - [[:alpha:],' ]+)[^[:lower:]]+Article ([0-9]+)(er)?/\1\n\n(\2)/" | \
    sed -E 's/^(CHAPITRE 1 - DES DISPOSITIONS )GENERALES/\1GÉNÉRALES/' | \
    sed -E 's/^(CHAPITRE 3 - DES )MECANISMES PROCEDURAUX/\1MÉCANISMES PROCÉDURAUX/' | \
    sed -E 's/^(CHAPITRE 4 - DES )MECANISMES/\1MÉCANISMES/' | \
    sed -E 's/^(CHAPITRE 6 - DE LA )PREVENTION/\1PRÉVENTION/' | \
    sed -E 's/^(CHAPITRE 7 - DE LA )RESPONSABILITE/\1RESPONSABILITÉ/'
}

function amend_errors_in_articles {
  local stdin="$(</dev/stdin)"

  local page_header_regular_expression='Journal officiel (\[•\]|-) Numéro '
  page_header_regular_expression+='Spécial (\[•\]|-) 16 juillet 2011 [0-9]+'
  
  echo "$stdin" | \
    sed -E "s/${page_header_regular_expression} //g" | \
    sed -E 's/Etat/État/g' | \
    # Article 2
    amend_error_in_article 2 entrainer entraîner | \
    amend_error_in_article 2 'les micro- organismes' 'les micro-organismes' | \
    amend_error_in_article 2 'présente isolement' 'présente isolément' | \
    # Article 11
    amend_error_in_article 11 'moment ne' 'moment, ne' | \
    # Article 14
    amend_error_in_article 14 ' CHAPITRE 2:' '\n\nCHAPITRE 2 -' | \
    # Article 23
    amend_error_in_article 23 1er 1 | \
    # Article 31
    amend_error_in_article 31 ' Article 32' '\n\n(32)' | \
    # Article 33
    amend_error_in_article 33 '1er ' 1 | \
    # Article 43
    amend_error_in_article 42 ' Article 43' '\n\n(43)' | \
    # Article 61
    amend_error_in_article 61 ' Article 62' '\n\n(62)' | \
    amend_error_in_article 61 ' Section 5:' '\n\nSection 5 -' | \
    # Article 67
    amend_error_in_article 67 1er 1 | \
    # Article 79
    amend_error_in_article 79 ' Article 80' '.\n\n(80)' | \
    # Article 84
    amend_error_in_article 84 1er 1 | \
    # Article 89
    amend_error_in_article 89 ' Fait à Kisangani.*$' ''
}

function preprocess_state_and_language_input_file {
  if [ "$#" -ne 2 ] ; then
    echo_usage_error "$*" '<input_file_path> <language>'
    return 1
  fi
  local input_file_path="$1"
  local language="$2"

  apply_common_transformations "$input_file_path" "$language" | \
    remove_all_text_before_first_chapter_header | \
    remove_all_text_after_last_article | \
    amend_errors_in_headers | \
    amend_errors_in_articles
}
