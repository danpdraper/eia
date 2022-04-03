function remove_l_between_article_literal_and_number {
  sed -E 's/(ARTICLE|article) L (PREMIER|[[0-9]+)/\1 \2/g'
}

function remove_all_text_before_first_header {
  sed -E 's/ (TITRE I )/\n\1/' | \
    sed -n '/^TITRE I /,$p'
}

function remove_all_text_after_last_article {
  sed -E '/^\(110\)/,${/^\(110\)/!d}'
}

function add_newlines_between_headers_and_articles {
  sed -E 's/(TITRE I)(.*) ARTICLE PREMIER:/\1 -\2\n\n(1)/' | \
    sed -E ':start;s/(TITRE .*) (CHAPITRE [IVX]+)/\1\n\n\2 -/;t start' | \
    sed -E ':start;s/(TITRE .*) ARTICLE ([0-9]+):/\1\n\n(\2)/;t start' | \
    sed -E ':start;s/(CHAPITRE .*) ARTICLE ([0-9]+):/\1\n\n(\2)/;t start'
}

function amend_errors_in_articles {
  sed -E 's/Etat/État/g' | \
    sed -E 's/Emission/Émission/g' | \
    sed -E 's/Equilibre/Équilibre/g' | \
    sed -E 's/Etablissement/Établissement/g' | \
    sed -E 's/Etude/Étude/g' | \
    sed -E 's/Economie/Économie/g' | \
    # Article 2
    sed -E ':start;s/^(\(2\).*) ([0-9]+) (\[•\]|–)/\1 [\2]/;t start' | \
    sed -E ':start;s/^(\(2\).*) [0-9]+ \[/\1 [/;t start' | \
    amend_error_in_article 2 'situ": c' 'situ": C' | \
    amend_error_in_article 2 'devant être éliminée' 'devant être éliminées' | \
    sed -E ':start;s/^(\(2\).*\[•\] )D/\1d/;t start' | \
    amend_error_in_article 2 'Environnement": l' 'Environnement": L' | \
    amend_error_in_article 2 'Nuisance": t' 'Nuisance": T' | \
    amend_error_in_article 2 'populations": e' 'populations": E' | \
    amend_error_in_article 2 'individuels; \[26' 'individuels. \[26' | \
    # Article 4
    sed -E ':start;s/^(\(4\).*\] )L/\1l/;t start' | \
    amend_error_in_article 4 '7 \[' '[' | \
    # Article 6
    amend_error_in_article 6 'conformer, aux' 'conformer aux' | \
    # Article 8
    sed -E ':start;s/^(\(8\).*)- L/\1[•] l/;t start' | \
    sed -E ':start;s/^(\(8\).*[^;:]) \[/\1; [/;t start' | \
    amend_error_in_article 8 ' TITRE II' '.\n\nTITRE II -' | \
    # Article 10
    amend_error_in_article 10 'soit, à' 'soit à' | \
    amend_error_in_article 10 ' ARTICLE 11:' '.\n\n(11)' | \
    # Article 11
    amend_error_in_article 11 '\[9\]' '9.' | \
    amend_error_in_article 11 '9 L' L | \
    # Article 23
    amend_error_in_article 23 'Ministres chargé' 'Ministres chargés' | \
    # Article 24
    amend_error_in_article 24 '\[9\]' '9.' | \
    # Article 27
    amend_error_in_article 27 ' a\/ ' ' [a] ' | \
    amend_error_in_article 27 1ère première | \
    amend_error_in_article 27 2ème deuxième | \
    amend_error_in_article 27 '12 b\/' '[b]' | \
    amend_error_in_article 27 'Taxes superficiaires' 'Taxes superficiaires:' | \
    amend_error_in_article 27 'an \[' 'an; [' | \
    amend_error_in_article 27 'an c\/' 'an. [c]' | \
    amend_error_in_article 27 'DESIGNATION TAUX EN FCFA OBSERVATIONS ' '' | \
    amend_error_in_article 27 'Générateur [•] V' 'Générateur: \[•\] v' | \
    sed -E ':start;s/^(\(27\).*) m 2 /\1 m2 /;t start' | \
    sed -E ':start;s/^(\(27\).*) m 3 /\1 m3 /;t start' | \
    sed -E ':start;s/^(\(27\).*000) ([^F])/\1 F \2/;t start' | \
    amend_error_in_article 27 ' 100 13 ' ' 100 F ' | \
    amend_error_in_article 27 'DESIGNATION TAUX EN FCFA OBSERVATIONS ' '' | \
    amend_error_in_article 27 '0 A 5' '0 à 5' | \
    amend_error_in_article 27 '6 A 10' '6 à 10' | \
    amend_error_in_article 27 '11 A 20' '11 à 20' | \
    amend_error_in_article 27 'supérieur A 20' 'supérieur à 20' | \
    amend_error_in_article 27 Epreuve Épreuve | \
    amend_error_in_article 27 '100 \[d' '100. [d' | \
    # Article 31
    amend_error_in_article 31 ellemême 'elle-même' | \
    # Article 35
    amend_error_in_article 35 '15 ' '' | \
    # Article 47
    amend_error_in_article 47 '17 ' '' | \
    # Article 50
    amend_error_in_article 50 'environnement Tout' 'environnement. Tout' | \
    # Article 51
    amend_error_in_article 51 cellesci 'celles-ci' | \
    # Article 55
    amend_error_in_article 55 '\[1981\] 19' '1981.' | \
    # Article 60
    amend_error_in_article 60 chargé chargée | \
    # Article 61
    sed -E ':start;s/^(\(61\).*)([0-9]) – L/\1[\2] l/;t start' | \
    # Article 62
    sed -E ':start;s/^(\(62\).*)([0-9]) – L/\1[\2] l/;t start' | \
    sed -E ':start;s/^(\(62\).*)\. \[/\1; [/;t start' | \
    amend_error_in_article 62 'charge polluant' 'charge polluante' | \
    # Article 66
    amend_error_in_article 66 'propriétaire ,' 'propriétaire,' | \
    # Article 73
    amend_error_in_article 73 '27 \[' '27[' | \
    # Article 78
    amend_error_in_article 78 ' 25 ARTICLE 79:' '.\n\n(79)' | \
    # Article 80
    amend_error_in_article 80 ' ARTICLE 81:' '.\n\n(81)' | \
    amend_error_in_article 80 ' CHAPIRE III' '\n\nCHAPITRE III -' | \
    # Article 82
    amend_error_in_article 82 'récepteurs;' 'récepteurs.' | \
    # Article 86
    amend_error_in_article 86 ' CFA' ' FCFA' | \
    amend_error_in_article 86 1ère première | \
    amend_error_in_article 86 2e deuxième | \
    amend_error_in_article 86 '27 ' '' | \
    amend_error_in_article 86 'de un' "d'un" | \
    # Article 91
    amend_error_in_article 91 2ème deuxième | \
    # Article 97
    amend_error_in_article 97 'F ' 'FCFA ' | \
    # Article 98
    amend_error_in_article 98 'francs CFA' FCFA | \
    # Article 99
    amend_error_in_article 99 'F ' 'FCFA ' | \
    # Article 100
    amend_error_in_article 100 'F ' 'FCFA ' | \
    # Article 101
    amend_error_in_article 101 'F ' 'FCFA ' | \
    # Article 102
    amend_error_in_article 102 procèsverbal 'procès-verbal' | \
    # Article 103
    amend_error_in_article 103 ' 30' '.' | \
    # Article 104
    amend_error_in_article 104 '\] O' '] o' | \
    amend_error_in_article 104 '\] F' '] f' | \
    amend_error_in_article 104 '\] S' '] s' | \
    # Article 105
    amend_error_in_article 105 '\[104\] 31' '104.' | \
    # Article 108
    amend_error_in_article 108 '\[103\]' '103.' | \
    # Article 109
    amend_error_in_article 109 'n°' 'numéro ' | \
    # Article 110
    amend_error_in_article 110 ' 33 R.*$' ''
}

function amend_errors_in_headers {
  sed -E 's/^(CHAPITRE III .*)\./\1/'
}

function preprocess_state_and_language_input_file {
  if [ "$#" -ne 2 ] ; then
    echo_usage_error "$*" '<input_file_path> <language>'
    return 1
  fi
  local input_file_path="$1"
  local language="$2"

  cat "$input_file_path" | \
    remove_l_between_article_literal_and_number | \
    apply_common_transformations_to_stdin "$language" | \
    remove_all_text_before_first_header | \
    remove_all_text_after_last_article | \
    add_newlines_between_headers_and_articles | \
    amend_errors_in_articles | \
    amend_errors_in_headers
}
