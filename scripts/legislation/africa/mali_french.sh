#!/bin/bash

function remove_all_text_before_first_article {
  sed -E -n '/^\(1\)/,$p'
}

function amend_errors_in_articles {
  sed -E 's/ ARTICLE\. 2/\n\n(2) /' | \
    sed -E 's/ ARTICLE 3/\n\n(3)/' | \
    sed -E 's/ ARTIC:/\n\n(4)/' | \
    sed -E 's/ ARTICLE. 6: ./\n\n(6)/' | \
    # Article 1
    amend_error_in_article 1 'Au \. sens' 'Au sens' | \
    amend_error_in_article 1 ',\.d9:;3présegt-;\.décret\.' 'du présent décret,' | \
    amend_error_in_article 1 ',;oppp::ente,nd -par\.' 'on entend par' | \
    amend_error_in_article 1 'toute\.-activite~:-\.huma,ine' 'toute activité humaine' | \
    amend_error_in_article 1 ':..ay~t:~~~o~u~~.effet' ' ayant pour effet' | \
    amend_error_in_article 1 '~\.~de-nuire \.,\.\., \. \.' ' de nuire ' | \
    amend_error_in_article 1 "dfapporterdes'--perturbati~n~s" "d’apporter des perturbations" | \
    amend_error_in_article 1 '-notab1~~~à11~fro~e~~t' " notables à l’environnement" | \
    amend_error_in_article 1 comprerinent comprennent | \
    amend_error_in_article 1 roytes routes | \
    amend_error_in_article 1 "toute'activité" 'toute activité' | \
    amend_error_in_article 1 zpporter apporter | \
    # Article 2
    amend_error_in_article 2 ';,: \.,&q~op@ent\.\.a-qz~r\.egI,eess' 'Conformément aux règles' | \
    amend_error_in_article 2 '\.rel\+tives' relatives | \
    amend_error_in_article 2 "\[1\]' " "l'" | \
    amend_error_in_article 2 "-:et \.- du \. ',c,we L'de',\." ' et du cadre de' | \
    amend_error_in_article 2 " , ' 1 es _ ac , t'ions \. \._:" ' , les actions ' | \
    amend_error_in_article 2 '\. 1-ors- c& \.1~,~cut~o' "lors de l'exécution " | \
    amend_error_in_article 2 "~es~'9f~d~:~~a~auX" 'des grands travaux ' | \
    amend_error_in_article 2 'r;do~Y~resee~~é~~' 'doivent préserver' | \
    amend_error_in_article 2 '--- \[•\] SSOILC~S' 'les ressources naturelles' | \
    amend_error_in_article 2 's2t-üyaTè-g-e ,,, \.-" 2a ---' 'et minimiser la' | \
    amend_error_in_article 2 "~egr~4~07'c'\. \[•\] ---" 'dégradation de' | \
    amend_error_in_article 2 '~ëT~~~~romement~2é~\.;-' "l’environnement et " | \
    amend_error_in_article 2 ', -, >- kadre >-\.de:cv~ e,' 'du cadre de vie.' | \
    # Article 3
    amend_error_in_article 3 '-: #-Tout proj et' 'Tout projet' | \
    amend_error_in_article 3 '>-cl,e:<qrands -travaux' ' de grands travaux' | \
    amend_error_in_article 3 "-réaliser par 1 ' Etat" "réaliser par l’État" | \
    amend_error_in_article 3 '\.oTectivités:' ' collectivités' | \
    amend_error_in_article 3 "accompap-é: 'dj\.\.\.~ e \.;" "accompagné d’une " | \
    amend_error_in_article 3 ' \[•\]' '' | \
    amend_error_in_article 3 "'&ablies" établies | \
    amend_error_in_article 3 'milieu-' milieu | \
    # Article 4
    amend_error_in_article 4 'sl;rr' sur | \
    amend_error_in_article 4 'de ique' 'de la République' | \
    amend_error_in_article 4 cornote compte | \
    amend_error_in_article 4 '_du' 'du' | \
    amend_error_in_article 4 'Agenda-21' 'Agenda 21' | \
    amend_error_in_article 4 "juin'i992" 'juin 1992' | \
    amend_error_in_article 4 '-Janeiro' Janeiro | \
    # Article 5
    amend_error_in_article 5 modaIités modalités | \
    # Article 6
    amend_error_in_article 6 "l'-Environnement" "l'Environnement" | \
    amend_error_in_article 6 "1'Energie" "l'Énergie" | \
    amend_error_in_article 6 "'Urbanisme" "l'Urbanisme" | \
    amend_error_in_article 6 'de et du' "de l'Artisanat et du" | \
    amend_error_in_article 6 ' P\/ Le.*$' ''
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
    amend_errors_in_articles
}
