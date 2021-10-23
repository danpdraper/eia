#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^TITRE I /,$p'
}

function amend_errors_in_articles {
  local stdin="$(</dev/stdin)"

  local article_27_text="Les conditions d'ouverture et de fonctionnement des établissements visés à l'article"

  echo "$stdin" | \
    sed -E 's/Etude/Étude/g' | \
    sed -E 's/Ecologique/Écologique/g' | \
    sed -E 's/Education/Éducation/g' | \
    sed -E 's/Etat/État/g' | \
    sed -E 's/Elevage/Élevage/g' | \
    # Article 2
    amend_error_in_article 2 présevation préservation | \
    # Article 5
    amend_error_in_article 5 'biolo-giques' biologiques | \
    amend_error_in_article 5 simplifée simplifiée | \
    amend_error_in_article 5 'environnement future' 'environnement futur' | \
    amend_error_in_article 5 desetablissents 'des établissements' | \
    amend_error_in_article 5 '\.\.\.\.' 'jardins privés,' | \
    amend_error_in_article 5 évacution évacuation | \
    amend_error_in_article 5 évactuation évacuation | \
    amend_error_in_article 5 santitaires sanitaires | \
    amend_error_in_article 5 '\[•\] Les produits' '[•] les produits' | \
    amend_error_in_article 5 'sols consistent en' 'sols consiste en' | \
    # Article 12
    amend_error_in_article 12 'l-Environnement' "l'Environnement" | \
    # Article 14
    amend_error_in_article 14 condidtions conditions | \
    amend_error_in_article 14 '\(F\.I\.E\.' '(F.I.E.).' | \
    # Article 20
    amend_error_in_article 20 aménagementes aménagements | \
    # Article 21
    amend_error_in_article 21 resours recours | \
    amend_error_in_article 21 ' fon ' ' font ' | \
    # Article 26
    amend_error_in_article 26 sélectionées sélectionnées | \
    # Article 27
    amend_error_in_article 27 26 "$article_27_text 26" | \
    # Article 36
    amend_error_in_article 36 contract contact | \
    # Article 37
    amend_error_in_article 37 '1ère et 2ème' 'première et deuxième' | \
    # Article 49
    amend_error_in_article 49 exigence exigences | \
    amend_error_in_article 49 'des autorité' 'des autorités' | \
    amend_error_in_article 49 rrequis requis | \
    amend_error_in_article 49 réseve réserve | \
    # Article 51
    amend_error_in_article 51 réseve réserve | \
    # Article 52
    amend_error_in_article 52 alinéa "l'alinéa" | \
    # Article 55
    amend_error_in_article 55 'détermine en outre' 'détermine, en outre' | \
    # Article 65
    amend_error_in_article 65 Fortêts Forêts | \
    amend_error_in_article 65 Hygiè Hygiène | \
    amend_error_in_article 65 Assainisement Assainissement | \
    # Article 74
    amend_error_in_article 74 constation constatation | \
    # Article 78
    amend_error_in_article 78 barêmes barèmes | \
    # Article 79
    amend_error_in_article 79 'du cent' 'de cent' | \
    # Article 80
    amend_error_in_article 80 1er premier | \
    amend_error_in_article 80 environnment environnement | \
    amend_error_in_article 80 'incriminé \(e\) est confisqué \(e\)' 'incriminé(e) est confisqué(e)' | \
    # Article 84
    amend_error_in_article 84 convernée concernée | \
    # Article 85
    amend_error_in_article 85 'ci-dessus ARTICLE 86:' 'ci-dessus.\n\n(86)' | \
    # Article 88
    amend_error_in_article 88 mêmes même | \
    # Article 89
    amend_error_in_article 89 '10, et 11' '10 et 11' | \
    # Article 95
    amend_error_in_article 95 '\[f\]' 'F)' | \
    # Article 97
    amend_error_in_article 97 'mille\) cinq' 'mille à cinq' | \
    # Article 99
    amend_error_in_article 99 0F 'O F' | \
    # Article 100
    amend_error_in_article 100 'A la' 'À la' | \
    # Article 102
    amend_error_in_article 102 'A la' 'À la' | \
    # Article 104
    amend_error_in_article 104 'loi no' 'loi numéro' | \
    amend_error_in_article 104 ' Ainsi.*$' ''
}

function amend_errors_in_headers {
  sed -E 's/- -/-/' | \
    sed -E 's/^(TITRE I -.*)GENERALES/\1GÉNÉRALES/' | \
    sed -E 's/^(TITRE II -.*)PRESERVATION(.*)AMELIORATION/\1PRÉSERVATION\2AMÉLIORATION/' | \
    sed -E 's/^(CHAPITRE I -.*)PRESERVATION(.*)ENVRIONNEMENT/\1PRÉSERVATION\2ENVIRONNEMENT/' | \
    sed -E 's/^(SECTION 1 - DU CADRE.*)EVALUATION/\1ÉVALUATION/' | \
    sed -E 's/^(SECTION 2 - DU )CONTROLE(.*)QUALITE/\1CONTRÔLE\2QUALITÉ/' | \
    sed -E 's/^(SECTION 3 -.*F\.I\.E\.)/\1)/' | \
    sed -E 's/^(SECTION 4 -.*)EDUCATION/\1ÉDUCATION/' | \
    sed -E 's/^(SECTION 5 -.*)ETUDES/\1ÉTUDES/' | \
    sed -E 's/^(CHAPITRE II -.*)PRESERVATION/\1PRÉSERVATION/' | \
    sed -E 's/^(SECTION 1 - DES MESURES.*)ETABLISSEMENTS/\1ÉTABLISSEMENTS/' | \
    sed -E 's/^(SECTION 2 - DES MESURES.*)DECHETS/\1DÉCHETS/' | \
    sed -E 's/^(SECTION 3 - DES MESURES.*)DECHETS(.*)ASSIMILES/\1DÉCHETS\2ASSIMILÉS/' | \
    sed -E 's/^(SECTION 4 - DES MESURES.*)DECHETS(.*)ETRANGER/\1DÉCHETS\2ÉTRANGER/' | \
    sed -E 's/^(SECTION 5 - )(MESURES.*)MATIERES/\1DES \2MATIÈRES/' | \
    sed -E 's/^(SECTION 6 - DES MESURES.*)ATMOSPHERIQUES/\1ATMOSPHÉRIQUES/' | \
    sed -E 's/^(SECTION 8 - DES MESURES.*PAYSAGES)/\1,/' | \
    sed -E 's/^(CHAPITRE III - DES MESURES.*)AMELIORATION/\1AMÉLIORATION/' | \
    sed -E 's/^(SECTION 3 - DES )AMENAGEMENTS/\1AMÉNAGEMENTS/' | \
    sed -E 's/^(TITRE III -.*)REPRESSION/\1RÉPRESSION/' | \
    sed -E 's/^(CHAPITRE I - DES )PROCEDURES/\1PROCÉDURES/' | \
    sed -E 's/^(SECTION 1 - DES INFRACTIONS.*)MATIERE(.*)PRESERVATION/\1MATIÈRE\2PRÉSERVATION/' | \
    sed -E 's/^(SECTION 2 - DES INFRACTIONS.*)MATIERE(.*)AMELIORATION/\1MATIÈRE\2AMÉLIORATION/' | \
    sed -E 's/^(TITRE V -.*)DISPPOSITIONS/\1DISPOSITIONS/'
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
