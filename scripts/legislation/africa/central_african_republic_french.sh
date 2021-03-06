function replace_line_leading_dashes_with_bullet_points {
  sed -E 's/^-/•/g'
}

function remove_all_text_before_first_title_header {
  sed -n '/TITRE I /,$p'
}

function amend_errors_in_headers {
  sed -E "s/^(Section [0-9]+ - [[:alpha:],' ]+)[^[:lower:]]+Art\. ([0-9]+):/\1\n\n(\2)/" | \
    sed -E 's/^(Section) I(.*) Art\. 103:/\1 1\2\n\n(103)/' | \
    sed -E 's/^(TITRE I .*)GENERALES/\1GÉNÉRALES/' | \
    sed -E 's/^(CHAPITRE I - DES )DEFINITIONS/\1DÉFINITIONS/' | \
    sed -E 's/^(Section 2 - Des substances et )Produits/\1produits/' | \
    sed -E 's/^(Section 7 - Des )Etudes/\1Études/' | \
    sed -E "s/^(Section 9 - De l')Evaluation/\1Évaluation/" | \
    sed -E 's/^(TITRE IV .*)REPRESSION/\1RÉPRESSION/'
}

function amend_errors_in_articles {
  local stdin="$(</dev/stdin)"

  local footer_regular_expression='J\.O\.R\.C\.A\. \/ MARS 2008 EDITION '
  footer_regular_expression+="SPECIALE LOI PORTANT CODE DE L'ENVIRONNEMENT DE "
  footer_regular_expression+='LA REPUBLIQUE CENTRAFRICAINE [0-9]+ '

  echo "$stdin" | \
    sed -E "s/${footer_regular_expression}//g" | \
    # Article 3
    amend_error_in_article 3 'AIRE PROTEGEE' 'AIRE PROTÉGÉE' | \
    amend_error_in_article 3 'micros organismes' microorganismes | \
    amend_error_in_article 3 'DECHET:' 'DÉCHET:' | \
    amend_error_in_article 3 "DEGRADATION DE L'ENVIRONNEMENT" "DÉGRADATION DE L'ENVIRONNEMENT" | \
    amend_error_in_article 3 "DEGRADATION DE L'ESTHETIQUE" "DÉGRADATION DE L'ESTHÉTIQUE" | \
    amend_error_in_article 3 'DEVELOPPEMENT DURABLE' 'DÉVELOPPEMENT DURABLE' | \
    amend_error_in_article 3 DIVERSITE DIVERSITÉ | \
    amend_error_in_article 3 'EDUCATION ENVIRONNEMENTALE' 'ÉDUCATION ENVIRONNEMENTALE' | \
    amend_error_in_article 3 ECOLOGIE ÉCOLOGIE | \
    amend_error_in_article 3 ECOSYSTEME ECOSYSTÈME | \
    amend_error_in_article 3 'interac- tion' interaction | \
    amend_error_in_article 3 'ELIMINATION DES DECHETS' 'ÉLIMINATION DES DÉCHETS' | \
    amend_error_in_article 3 'EQUILIBRE ECOLOGIQUE' 'ÉQUILIBRE ÉCOLOGIQUE' | \
    amend_error_in_article 3 ETABLISSEMENTS ÉTABLISSEMENTS | \
    amend_error_in_article 3 "ETUDES D'IMPACT" "ÉTUDES D'IMPACT" | \
    amend_error_in_article 3 'ECOLOGIQUEMENT RATIONNELLE DES DECHETS' 'ÉCOLOGIQUEMENT RATIONNELLE DES DÉCHETS' | \
    amend_error_in_article 3 'INSTALLATIONS CLASSEES' 'INSTALLATIONS CLASSÉES' | \
    amend_error_in_article 3 'VIVANTS MODIFIES' 'VIVANTS MODIFIÉS' | \
    amend_error_in_article 3 'GENETIQUEMENT MODIFIES' 'GÉNÉTIQUEMENT MODIFIÉS' | \
    amend_error_in_article 3 '\[•\] Les aires' '[•] les aires' | \
    amend_error_in_article 3 'courantes ou douce\.' 'courante ou douce.' | \
    # Article 7
    amend_error_in_article 7 Elus Élus | \
    # Article 16
    amend_error_in_article 16 ', dressent' ', dresse' | \
    # Article 28
    amend_error_in_article 28 'zones de protections' 'zones de protection' | \
    amend_error_in_article 28 'au dessus' 'au-dessus' | \
    # Article 30
    amend_error_in_article 30 'mobile, \[•\]' 'mobile; [•]' | \
    # Article 35
    amend_error_in_article 35 cidessus 'ci-dessus' | \
    # Article 37
    amend_error_in_article 37 'espèces; Art\. 38:' 'espèces.\n\n(38)' | \
    # Article 48
    amend_error_in_article 48 'pénalités\..*$' 'pénalités.' | \
    # Article 63
    amend_error_in_article 63 cidessus 'ci-dessus' | \
    # Article 64
    amend_error_in_article 64 'biens\. Art 65:' 'biens.\n\n(65)' | \
    # Article 73
    amend_error_in_article 73 'exploitation\..*$' 'exploitation.' | \
    # Article 75
    amend_error_in_article 75 '\[77\]' '77.' | \
    # Article 88
    amend_error_in_article 88 "L'Etude" "L'Étude" | \
    # Article 89
    amend_error_in_article 89 Etudes Études | \
    # Article 90
    amend_error_in_article 90 Etude Étude | \
    # Article 91
    amend_error_in_article 91 Etude Étude | \
    # Article 92
    amend_error_in_article 92 Etude Étude | \
    # Article 101
    amend_error_in_article 101 Evaluation Évaluation | \
    # Article 102
    amend_error_in_article 102 standard standards | \
    # Article 106
    amend_error_in_article 106 'procès \[•\] verbaux' 'procès-verbaux' | \
    amend_error_in_article 106 'procès \[•\] verbaux' 'procès-verbaux' | \
    # Article 107
    amend_error_in_article 107 'procès – verbaux' 'procès-verbaux' | \
    # Article 108
    amend_error_in_article 108 'procès – verbaux' 'procès-verbaux' | \
    amend_error_in_article 108 cidessus 'ci-dessus' | \
    # Article 109
    amend_error_in_article 109 'procès – verbal' 'procès-verbal' | \
    # Article 116
    amend_error_in_article 116 cidessus 'ci-dessus' | \
    # Article 117
    amend_error_in_article 117 '\[5\] 000\.000' '5.000.000' | \
    # Article 120
    amend_error_in_article 120 '500\.000\. 000' '500.000.000' | \
    amend_error_in_article 120 évènement événement | \
    amend_error_in_article 120 'publique\..*$' 'publique.' | \
    # Article 121
    amend_error_in_article 121 '1an' '1 an' | \
    # Article 123
    amend_error_in_article 123 '\[2\] 000\.000' '2.000.000' | \
    amend_error_in_article 123 'F\.CFA' 'FCFA' | \
    amend_error_in_article 123 'F\.CFA' 'FCFA' | \
    # Article 124
    amend_error_in_article 124 'F\.CFA' 'FCFA' | \
    amend_error_in_article 124 'reboisement\..*$' 'reboisement.' | \
    # Article 129
    amend_error_in_article 129 '\[5\] 000\.002' '5.000.002' | \
    # Article 130
    amend_error_in_article 130 '\[100\] 002' '100.002' | \
    amend_error_in_article 130 '2\.000\. 000' '2.000.000' | \
    # Article 135
    amend_error_in_article 135 '\[5\] 000\.002 à 20\.000\.000F ' '5.000.002 à 20.000.000 F' | \
    amend_error_in_article 135 '\[5\] 000\.000 F ' '5.000.000 F' | \
    # Article 136
    amend_error_in_article 136 'F CFA' FCFA | \
    # Article 137
    amend_error_in_article 137 '\[5\] 000\. 000' '5.000.000' | \
    # Article 138
    amend_error_in_article 138 '85,86' '85, 86' | \
    # Article 146
    amend_error_in_article 146 'Officiel\..*$' 'Officiel.'
}

function preprocess_state_and_language_input_file {
  if [ "$#" -ne 2 ] ; then
    echo_usage_error "$*" '<input_file_path> <language>'
    return 1
  fi
  local input_file_path="$1"
  local language="$2"

  cat "$input_file_path" | \
    replace_line_leading_dashes_with_bullet_points | \
    apply_common_transformations_to_stdin "$language" | \
    remove_all_text_before_first_title_header | \
    amend_errors_in_headers | \
    amend_errors_in_articles
}
