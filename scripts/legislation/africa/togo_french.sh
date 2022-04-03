function remove_all_text_before_first_article {
  sed -E 's/Article premier:/\n(1)/' | \
    sed -En '/^\(1\)/,$p'
}

function add_newlines_after_section_headers {
  sed -E 's/^(Section .*) Article ([0-9]+):/\1\n\n(\2\)/'
}

function remove_duplicate_dashes_from_section_headers {
  sed -E 's/^(Section .*-) -/\1/'
}

function amend_errors_in_articles {
  sed -E 's/Etat/État/g' | \
    sed -E 's/article premier/article 1/g' | \
    sed -E 's/ A / À /g' | \
    sed -E 's/Etude/Étude/g' | \
    # Article 3
    amend_error_in_article 3 procèsverbal 'procès-verbal' | \
    # Article 7
    amend_error_in_article 7 ' \[9' '; [9' | \
    # Article 13
    sed -E ':start;s/^(\(13\).*)\. \[/\1; [/;t start' | \
    # Article 24
    amend_error_in_article 24 "qu'entraînerait" 'qui entraînerait' | \
    # Article 31
    amend_error_in_article 31 pourrait pourraient | \
    # Article 36
    amend_error_in_article 36 catégorie catégories | \
    # Article 39
    amend_error_in_article 39 agréés agréée | \
    # Article 41
    amend_error_in_article 41 conçu conçue | \
    # Article 56
    amend_error_in_article 56 'des diminution' 'de diminution' | \
    # Article 58
    amend_error_in_article 58 'à ne par' 'à ne pas' | \
    # Article 63
    amend_error_in_article 63 'radio-diffusion' radiodiffusion | \
    amend_error_in_article 63 autorité autorités | \
    # Article 89
    amend_error_in_article 89 Opérer opérer | \
    # Article 90
    amend_error_in_article 90 reconnu reconnus | \
    # Article 91
    amend_error_in_article 91 'de dommages' 'des dommages' | \
    # Article 94
    amend_error_in_article 94 5000 '5.000' | \
    amend_error_in_article 94 '500 000' '500.000' | \
    # Article 95
    amend_error_in_article 95 '10 000' '10.000' | \
    amend_error_in_article 95 '1 000 000' '1.000.000' | \
    # Article 96
    amend_error_in_article 96 '20 000' '20.000' | \
    amend_error_in_article 96 '2 000 000' '2.000.000' | \
    amend_error_in_article 96 contrevenue contrevient | \
    amend_error_in_article 96 'il étaient' 'ils étaient' | \
    # Article 97
    amend_error_in_article 97 '50 000' '50.000' | \
    amend_error_in_article 97 '5 000 000' '5.000.000' | \
    # Article 99
    amend_error_in_article 99 '5 000' '5.000' | \
    amend_error_in_article 99 '500 000' '500.000' | \
    # Article 103
    amend_error_in_article 103 présente présent | \
    # Article 104
    amend_error_in_article 104 ' Fait.*$' ''
}

function preprocess_state_and_language_input_file {
  if [ "$#" -ne 2 ] ; then
    echo_usage_error "$*" '<input_file_path> <language>'
    return 1
  fi
  local input_file_path="$1"
  local language="$2"

  apply_common_transformations "$input_file_path" "$language" | \
    remove_all_text_before_first_article | \
    add_newlines_after_section_headers | \
    remove_duplicate_dashes_from_section_headers | \
    amend_errors_in_articles
}
