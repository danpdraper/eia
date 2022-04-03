function remove_all_text_before_first_header {
  sed -E 's/ (TITRE I )/\n\1- /' | \
    sed -n '/^TITRE I /,$p'
}

function amend_errors_in_articles {
  sed -E 's/Etat/État/g' | \
    # Article 1
    amend_error_in_article 1 "vie L'environnement" "vie. L'environnement" | \
    amend_error_in_article 1 'général\. 2' 'général.' | \
    amend_error_in_article 1 'use seule' 'une seule' | \
    amend_error_in_article 1 'équilibrée\. 3' 'équilibrée.' | \
    amend_error_in_article 1 'odeurs etc\.\.\.' 'odeurs, etc.' | \
    amend_error_in_article 1 'emploi, contribue' 'emploi contribue' | \
    amend_error_in_article 1 'lesquels variations' 'lesquels les variations' | \
    amend_error_in_article 1 'et vigueur' 'en vigueur' | \
    amend_error_in_article 1 "d'impact l'environnemental" "d'impact environnemental" | \
    amend_error_in_article 1 Etudes Études | \
    amend_error_in_article 1 'impact\. 4' 'impact.' | \
    amend_error_in_article 1 'peut-être' 'peut être' | \
    # Article 5
    amend_error_in_article 5 1er premier | \
    # Article 6
    amend_error_in_article 6 'loi; \[' 'loi: [' | \
    amend_error_in_article 6 'nomenclature: 5' 'nomenclature;' | \
    amend_error_in_article 6 'publique\. \[' 'publique; [' | \
    # Article 20
    amend_error_in_article 20 'plastiques etc\.\.\.' 'plastiques, etc.' | \
    # Article 31
    amend_error_in_article 31 'service\. 8' 'service.' | \
    # Article 36
    amend_error_in_article 36 'précaution Lors' 'précaution: Lors' | \
    amend_error_in_article 36 'environnement\. 9' 'environnement.' | \
    amend_error_in_article 36 'Substitution Si' 'Substitution: Si' | \
    amend_error_in_article 36 'biologique Toute' 'biologique: Toute' | \
    amend_error_in_article 36 'naturelles Pour' 'naturelles: Pour' | \
    amend_error_in_article 36 'doivent êtres évités' 'doivent être évités' | \
    amend_error_in_article 36 "-Payeur'' Toute" '-Payeur": Toute' | \
    amend_error_in_article 36 'participation Toute' 'participation: Toute' | \
    amend_error_in_article 36 'Coopération Les' 'Coopération: Les' | \
    # Article 38
    amend_error_in_article 38 'naturels les' 'naturels, les' | \
    # Article 41
    amend_error_in_article 41 'proposée; 10' 'proposée;' | \
    amend_error_in_article 41 '\] Une' '] une' | \
    amend_error_in_article 41 'modalités de contrôlé' 'modalités de contrôle' | \
    amend_error_in_article 41 '\)\. \[' '); [' | \
    # Article 42
    amend_error_in_article 42 Etude Étude | \
    # Article 44
    amend_error_in_article 44 'article \[6\]' 'article 6.' | \
    amend_error_in_article 44 'etc\.\.\.' 'etc.' | \
    # Article 47
    amend_error_in_article 47 contrôlé contrôle | \
    # Article 48
    amend_error_in_article 48 'nationale, sont' 'nationale sont' | \
    # Article 52
    amend_error_in_article 52 'écosystèmes,' 'écosystèmes;' | \
    amend_error_in_article 52 'protégés,' 'protégés;' | \
    amend_error_in_article 52 'paysages,' 'paysages;' | \
    amend_error_in_article 52 'eaux\.' 'eaux;' | \
    # Article 56
    amend_error_in_article 56 'avec les collectivités avec' avec | \
    # Article 60
    amend_error_in_article 60 'liste: 13' 'liste:' | \
    amend_error_in_article 60 'les quels' lesquels | \
    # Article 76
    amend_error_in_article 76 'créé: 15' 'créé:' | \
    amend_error_in_article 76 '\): une' '); une' | \
    # Article 77
    amend_error_in_article 77 "d'eaux" "d'eau" | \
    amend_error_in_article 77 'abords\.' 'abords;' | \
    # Article 81
    amend_error_in_article 81 'territoriales; 16' 'territoriales;' | \
    amend_error_in_article 81 conformes conforme | \
    # Article 82
    amend_error_in_article 82 'biologiques \[' 'biologiques; [' | \
    # Article 91
    amend_error_in_article 91 'mois a deux' 'mois à deux' | \
    # Article 93
    amend_error_in_article 93 'classées; En' 'classées. En' | \
    # Article 94
    amend_error_in_article 94 '5 000 000' '5.000.000' | \
    amend_error_in_article 94 '50 000 000' '50.000.000' | \
    amend_error_in_article 94 ' 18' '' | \
    # Article 98
    amend_error_in_article 98 '500.000 000' '500.000.000' | \
    # Article 99
    amend_error_in_article 99 '2 000.000' '2.000.000' | \
    # Article 100
    amend_error_in_article 100 '1 000' '1.000' | \
    amend_error_in_article 100 'la \[' 'la pêche; [' | \
    # Article 101
    amend_error_in_article 101 'quiconque: 19' 'quiconque:' | \
    # Article 104
    amend_error_in_article 104 1000 '1.000' | \
    amend_error_in_article 104 5000 '5.000' | \
    amend_error_in_article 104 1000 '1.000' | \
    amend_error_in_article 104 '10 000' '10.000' | \
    # Article 106
    amend_error_in_article 106 'plastiques; 20' 'plastiques;' | \
    # Article 107
    amend_error_in_article 107 5000 '5.000' | \
    # Article 115
    amend_error_in_article 115 ' Fait.*$' ''
}

function amend_errors_in_headers {
  sed -E 's/^(TITRE I - )DEFINITIONS/\1DÉFINITIONS/' | \
    sed -E 's/^(CHAPITRE I - )DEFINITIONS/\1DÉFINITIONS/' | \
    sed -E 's/^(SECTION III - LA )DIVERSITE/\1DIVERSITÉ/' | \
    sed -E 's/^(SECTION IV - POLLUTION )ATMOSPHERIQUE/\1ATMOSPHÉRIQUE/' | \
    sed -E 's/^(TITRE III -.*)GENERALES(.*)ETAT(.*)COLLECTIVITES/\1GÉNÉRALES\2ÉTAT\3COLLECTIVITÉS/' | \
    sed -E 's/^(CHAPITRE I - DISPOSITIONS )GENERALES/\1GÉNÉRALES/' | \
    sed -E 's/^(CHAPITRE II -.*)ETAT(.*)COLLECTIVITES/\1ÉTAT\2COLLECTIVITÉS/' | \
    sed -E 's/^(SECTION I - LES OBLIGATIONS )GENERALES/\1GÉNÉRALES/' | \
    sed -E 's/^(TITRE IV -.*)PREVENTIVES(.*)PENALES/\1PRÉVENTIVES\2PÉNALES/' | \
    sed -E 's/^(CHAPITRE I - DISPOSITIONS )PREVENTIVES/\1PRÉVENTIVES/' | \
    sed -E 's/^(CHAPITRE II - DISPOSITIONS )PENALES/\1PÉNALES/'
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
