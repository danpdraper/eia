#!/bin/bash

function remove_all_text_before_first_chapter_header {
  sed -n '/CHAPITRE PREMIER - DES DISPOSITIONS GENERALES /,$p'
}

function amend_errors_in_headers {
  sed -E "s/^(Section [0-9]+ - [A-Za-z,' ]+)[^a-z]+Article ([0-9]+)(er)?:/\1\n\n(\2)/" | \
    sed -E 's/CHAPITRE PREMIER - DES DISPOSITIONS GENERALES/CHAPITRE PREMIER - DES DISPOSITIONS GÉNÉRALES/' | \
    sed -E 's/Article premier:/\n\n(1)/' | \
    sed -E 's/^(CHAPITRE )I -l:/\1II -/' | \
    sed -E 's/CHAPITRE II - DES DEFINITIONS DE QUELQUES MOTS UTILISES DANS LA PRESENTE LOI ORGANIQUE/CHAPITRE II - DES DÉFINITIONS DE QUELQUES MOTS UTILISÉS DANS LA PRÉSENTE LOI ORGANIQUE/' | \
    sed -E 's/^(TITRE )I -l:/\1II -/' | \
    sed -E "s/(CHAPITRE PREMIER - DE L'ENVIRONNEMENT NATUREL )/\1\n\n/" | \
    sed -E 's/^(Section première: Le sol.*) Article 11:/\1\n\n(11)/' | \
    sed -E 's/^(CHAPITRE )I -ll:/\1III -/' | \
    sed -E 's/^(CHAPITRE IV - .*)LA PRESENTE LOI/\1LA PRÉSENTE LOI/' | \
    sed -E "s/^(TITRE III - .*)DE L'ETAT, DES COLLECTIVITES/\1DE L'ÉTAT, DES COLLECTIVITÉS/" | \
    sed -E "s/^CHAPITRE PREMIER - DES OBLIGATIONS GENERALES/CHAPITRE PREMIER - DES OBLIGATIONS GÉNÉRALES/" | \
    sed -E "s/^(CHAPITRE II - DES OBLIGATIONS.*)Section première:/\1\n\nSection première:/" | \
    sed -E "s/^(CHAPITRE IV - .*)DES ETUDES/\1DES ÉTUDES/" | \
    sed -E "s/^(TITRE VI - .*)PREVENTIVES/\1PRÉVENTIVES/" | \
    sed -E "s/^(CHAPITRE PREMIER - DES DISPOSITIONS.*)PREVENTIVES/\1PRÉVENTIVES/" 
}

function amend_errors_in_articles {   
  #Article 1
  amend_error_in_article 1 'bien être' 'bien-être' | \
    #Article 4
    amend_error_in_article 4 '; 5' ';' | \
    amend_error_in_article 4 ' 6' '' | \
    amend_error_in_article 4 ' 7' '' | \
    amend_error_in_article 4 "d'Etude" "d'Étude" | \
    amend_error_in_article 4 "A. L'environnement naturel: " "" | \
    amend_error_in_article 4 "B\. L'environnement humain" "" | \
    amend_error_in_article 4 "B\.1\. Les éléments nuisibles" "" | \
    amend_error_in_article 4 "13\.2\. Les éléments non nuisibles" "Les éléments non nuisibles sont" | \
    amend_error_in_article 4 'Les activités de nature' 'les activités de nature' | \
    amend_error_in_article 4 "C\. Autres mots utilisés" "" | \
    sed -E ':start;s/^(\(4\).*)\[[0-9]+\] /\1/;t start' | \
    sed -E ':start;s/^(\(4\).*)  /\1 /;t start' | \
    amend_error_in_article 4 'la même famille\.' 'la même famille;' | \
    amend_error_in_article 4 '\[a\] La pollution' 'La pollution' | \
    amend_error_in_article 4 '\[b\] La pollution' 'La pollution' | \
    amend_error_in_article 4 '\[c\] La pollution' 'La pollution' | \
    amend_error_in_article 4 '\[a\] Une' 'Une' | \
    amend_error_in_article 4 '; \[b\] Une' '. Une' | \
    amend_error_in_article 4 '; \[c\] Une' '. Une' | \
    amend_error_in_article 4 '; \[d\] Un' '. Un' | \
    amend_error_in_article 4 '; \[e\] Une' '. Une' | \
    #Article 5
    amend_error_in_article 5 'a la faune' 'à la faune' | \
    amend_error_in_article 5 'programme' 'programmes' | \
    #Article 7
    amend_error_in_article 7 ' 8' '' | \
    amend_error_in_article 7 'Principe de protection' 'Principe de protection:' | \
    amend_error_in_article 7 'entre les générations' 'entre les générations:' | \
    amend_error_in_article 7 'du pollueur payeur' 'du pollueur payeur:' | \
    amend_error_in_article 7 "et à la protection de l'environnement" "et à la protection de l'environnement:" | \
    amend_error_in_article 7 'coopération Les autorités' 'coopération: Les autorités' | \
    #Article 8
    amend_error_in_article 8 ' 9' '' | \
    amend_error_in_article 8 'surface,' 'surface;' | \
    #Article 10
    amend_error_in_article 10 'la-défense' 'la défense' | \
    #Article 15
    amend_error_in_article 15 ': ' ' ' | \
    #Article 17
    amend_error_in_article 17 "d'exploitation\.," "d'exploitation" | \
    #Article 49
    amend_error_in_article 49 'transfrontière , \.' 'transfrontière;' | \
    #Article 53
    amend_error_in_article 53 ' 18' '' | \
    amend_error_in_article 53 'zone ,' 'zone;' | \
    #Article 62
    amend_error_in_article 62 ' 20' '' | \
    #Article 69
    amend_error_in_article 69 'Office,' 'Office' | \
    #Article 72
    amend_error_in_article 72 'accorder\.' 'accorder' | \
    #Article 73 
    amend_error_in_article 73 ' 23' '' | \
    #Article 81 
    amend_error_in_article 81 ' 25' '' | \
    #Article 85 
    amend_error_in_article 85 ' 26' '' | \
    #Article 88
    amend_error_in_article 88 'réglementées' 'réglementées;' | \
    #Article 89
    amend_error_in_article 89 'autres' 'autres;' | \
    #Article 90
    amend_error_in_article 90 'textes en vaguer' 'textes en vigueur' | \
    #Article 99
    amend_error_in_article 99 'mille\.' 'mille' | \
    #Article 106 
    amend_error_in_article 106 ' 31' '' | \
    #Article 107
    amend_error_in_article 107 'compétente\.\.' 'compétente\.' | \
    #Article 110
    amend_error_in_article 110 'récidive;' 'récidive,' | \
    #Article 112
    amend_error_in_article 112 'même peines' 'mêmes peines' | \
    #Article 118
    amend_error_in_article 118 'Fait.*$' '' | \
    #All articles
    sed -E 's/Etat/État/g' | \
    sed -E 's/\[m\]/m)/g'
}

function reformat_numbering_within_articles {
  sed -E 's/([0-9])°/[\1]/g'
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
    amend_errors_in_headers | \
    reformat_numbering_within_articles | \
    amend_errors_in_articles 
}
