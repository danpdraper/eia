function remove_all_text_before_first_header {
  sed -n '/^TITRE I /,$p'
}

function amend_errors_in_articles {
  sed -E 's/Etat/État/g' | \
    # Article 5
    amend_error_in_article 5 '\[•\] notamment' notamment | \
    amend_error_in_article 5 '4 \[•\]' '[•]' | \
    # Article 10
    amend_error_in_article 10 Finances 'Finances.' | \
    # Article 13
    amend_error_in_article 13 '6 La protection' 'La protection' | \
    # Article 14
    amend_error_in_article 14 'ce 7 soit' 'ce soit' | \
    amend_error_in_article 14 semiarides 'semi-arides' | \
    amend_error_in_article 14 Ecosystème Écosystème | \
    amend_error_in_article 14 Equilibre Équilibre | \
    amend_error_in_article 14 Etablissements Établissements | \
    amend_error_in_article 14 'décente\. \[•\]' 'décente; [•]' | \
    amend_error_in_article 14 Etude Étude | \
    amend_error_in_article 14 'environnement\. \[•\]' 'environnement; [•]' | \
    amend_error_in_article 14 "à 8 l'exclusion" "à l'exclusion" | \
    amend_error_in_article 14 'Toute contamination' 'toute contamination' | \
    amend_error_in_article 14 '− "Pollution' '[•] "Pollution' | \
    amend_error_in_article 14 '− "Radioactivité' '[•] "Radioactivité' | \
    amend_error_in_article 14 ': Propriété' ': propriété' | \
    amend_error_in_article 14 'électromagnétiques\. −' 'électromagnétiques; [•]' | \
    amend_error_in_article 14 '− "Télédétection' '[•] "Télédétection' | \
    amend_error_in_article 14 ': Technique' ': technique' | \
    amend_error_in_article 14 'satellites \. −' 'satellites; [•]' | \
    # Article 17
    amend_error_in_article 17 'matière ,' 'matière,' | \
    amend_error_in_article 17 'place \.' 'place.' | \
    # Article 20
    amend_error_in_article 20 'services 10' services | \
    # Article 24
    amend_error_in_article 24 '11 Un' Un | \
    # Article 28
    amend_error_in_article 28 '12 Le' Le | \
    # Article 31
    amend_error_in_article 31 '\[•\] Régénérer' '[•] régénérer' | \
    amend_error_in_article 31 '\[•\] Mettre' '[•] mettre' | \
    amend_error_in_article 31 '\[•\] Diffuser' '[•] diffuser' | \
    amend_error_in_article 31 '\[•\] Promouvoir' '[•] promouvoir' | \
    # Article 36
    amend_error_in_article 36 '15 \[•\]' '[•]' | \
    # Article 38
    amend_error_in_article 38 'n°' numéro | \
    # Article 39
    amend_error_in_article 39 chimique chimiques | \
    # Article 41
    amend_error_in_article 41 'bio-logiques' biologiques | \
    # Article 44
    amend_error_in_article 44 'et 17' et | \
    # Article 48
    amend_error_in_article 48 '18 \[•\]' '[•]' | \
    amend_error_in_article 48 cidessus 'ci-dessus' | \
    # Article 55
    amend_error_in_article 55 '500 m' '500 mètres' | \
    # Article 62
    amend_error_in_article 62 '21 \[•\]' '[•]' | \
    # Article 69
    amend_error_in_article 69 '23 Le' Le | \
    amend_error_in_article 69 'n°1\/ 02' 'numéro 1\/02' | \
    # Article 72
    amend_error_in_article 72 'n° 1\/02' 'numéro 1\/02' | \
    # Article 73
    amend_error_in_article 73 '\[1985\] 24' '1985.' | \
    # Article 76
    amend_error_in_article 76 'altérer 25' altérer | \
    # Article 77
    amend_error_in_article 77 'les préservation' 'la préservation' | \
    # Article 78
    amend_error_in_article 78 '− les' '[•] les' | \
    amend_error_in_article 78 '− les' '[•] les' | \
    amend_error_in_article 78 '− les' '[•] les' | \
    amend_error_in_article 78 '− le' '[•] le' | \
    # Article 82
    amend_error_in_article 82 '75,76' '75, 76' | \
    # Article 83
    amend_error_in_article 83 '27 Cette' Cette | \
    # Article 92
    amend_error_in_article 92 Elevage Élevage | \
    # Article 95
    amend_error_in_article 95 'n° 1\/6 du 2 5' 'numéro 1\/6 du 25' | \
    # Article 96
    amend_error_in_article 96 'n°1\/6' 'numéro 1\/6' | \
    amend_error_in_article 96 '30 risques' risques | \
    # Article 99
    amend_error_in_article 99 'n°1\/6' 'numéro 1\/6' | \
    # Article 104
    amend_error_in_article 104 '32 Ces' Ces | \
    # Article 109
    amend_error_in_article 109 '\[106\]' '106.' | \
    amend_error_in_article 109 '\[107\]' '107.' | \
    # Article 117
    amend_error_in_article 117 '36 Ces' Ces | \
    # Article 118
    amend_error_in_article 118 '\[106\]' '106.' | \
    # Article 119
    amend_error_in_article 119 'installation classées' 'installations classées' | \
    # Article 121
    amend_error_in_article 121 'contravention 37' contravention | \
    # Article 135
    amend_error_in_article 135 '  pénétrer' ' pénétrer' | \
    amend_error_in_article 135 '  saisir' ' saisir' | \
    amend_error_in_article 135 '  cette' ' cette' | \
    amend_error_in_article 135 '  opérer' ' opérer' | \
    # Article 140
    amend_error_in_article 140 'dommagesintérêts-compensatoires' 'dommages-intérêts-compensatoires' | \
    # Article 163
    amend_error_in_article 163 ' Fait.*$' ''
}

function amend_errors_in_headers {
  sed -E 's/^(CHAPITRE 2 - CONCEPTS.*)DEFINITIONS/\1DÉFINITIONS/' | \
    sed -E 's/^(CHAPITRE 2 - COORDINATION.*)ACTIVITES/\1ACTIVITÉS/' | \
    sed -E "s/^(CHAPITRE 3 - LA )PROCEDURE D'ETUDE/\1PROCÉDURE D'ÉTUDE/" | \
    sed -E 's/^(CHAPITRE 4 - LES )FORETS/\1FORÊTS/' | \
    sed -E 's/^(CHAPITRE 5 - LES ESPACES.*)PROTEGES(.*)DIVERSITE/\1PROTÉGÉS\2DIVERSITÉ/' | \
    sed -E 's/^(CHAPITRE 2 - )AMENAGEMENT(.*)ETABLISSEMENTS/\1AMÉNAGEMENT\2ÉTABLISSEMENTS/' | \
    sed -E 's/^(CHAPITRE 1 - LES INSTALLATIONS )CLASSEES/\1CLASSÉES/' | \
    sed -E 's/^(CHAPITRE 2 - LES )DECHETS/\1DÉCHETS/' | \
    sed -E 's/^(CHAPITRE 4 - LES BRUITS.*)\./\1/' | \
    sed -E 's/^(TITRE VI - DISPOSITIONS )PENALES/\1PÉNALES/' | \
    sed -E 's/^(CHAPITRE 1 - LA )COMPETENCE(.*)PROCEDURE/\1COMPÉTENCE\2PROCÉDURE/' | \
    sed -E 's/^(CHAPITRE 2 - LES )PENALITES/\1PÉNALITÉS/' | \
    sed -E 's/^(TITRE VII - DISPOSITIONS FINALES)\./\1/'
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
