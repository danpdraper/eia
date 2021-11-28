#!/bin/bash

function remove_all_text_before_first_header {
  sed -E 's/(TITRE) (DISPOSITIONS GENERALES)/\n\1 I - \2/' | \
    sed -n '/^TITRE I /,$p'
}

function add_newlines_between_headers_and_articles {
  sed -E 's/^(Chapitre.*) Article ([0-9]+):/\1\n\n(\2)/'
}

function amend_errors_in_articles {
  sed -E 's/Etat/État/g' | \
    # Article 6
    amend_error_in_article 6 déterminée déterminées | \
    # Article 14
    amend_error_in_article 14 'biologiques\.' 'biologiques,' | \
    # Article 16
    amend_error_in_article 16 créés créées | \
    # Article 27
    amend_error_in_article 27 2000 '2.000' | \
    # Article 30
    amend_error_in_article 30 'n\(' numéro | \
    # Article 31
    amend_error_in_article 31 charge chargé | \
    # Article 35
    sed -E ':start;s/^(\(35\).*)([0-9])\(/\1[\2]/;t start' | \
    amend_error_in_article 35 '-actifs\.' 'actifs;' | \
    # Article 37
    sed -E ':start;s/^(\(37\).*)\[•\] /\1/;t start' | \
    # Article 38
    sed -E ':start;s/^(\(38\).*)\. \[/\1; [/;t start' | \
    # Article 41
    amend_error_in_article 41 '1\( alinéa' 'alinéa [1]' | \
    sed -E ':start;s/^(\(41\).*)([0-9])\(/\1[\2]/;t start' | \
    # Article 43
    amend_error_in_article 43 éloigne éloigné | \
    # Article 48
    sed -E ':start;s/^(\(48\).*)-/\1[•]/;t start' | \
    # Article 56
    amend_error_in_article 56 préscrits prescrits | \
    # Article 64
    amend_error_in_article 64 '\. \[' '; [' | \
    # Article 71
    amend_error_in_article 71 0D '0 D' | \
    amend_error_in_article 71 'présent loi' 'présente loi' | \
    amend_error_in_article 71 'par punissable' 'pas punissable' | \
    # Article 78
    amend_error_in_article 78 régles règles | \
    # Article 82
    sed -E ':start;s/^(\(82\).*)n\(/\1numéro/;t start' | \
    # Article 87
    amend_error_in_article 87 'an demeure' 'en demeure' | \
    amend_error_in_article 87 'à exécution' "à l'exécution" | \
    # Article 93
    amend_error_in_article 93 'loi appliquent' "loi s'appliquent" | \
    amend_error_in_article 93 'radio-actifs' radioactifs | \
    amend_error_in_article 93 'eaux usée' 'eaux usées' | \
    # Article 98
    amend_error_in_article 98 'fixe ,' 'fixe,' | \
    # Article 105
    amend_error_in_article 105 suspensions suspension | \
    amend_error_in_article 105 suppressions suppression | \
    # Article 108
    amend_error_in_article 108 'radio protection' 'radio-protection' | \
    # Article 110
    amend_error_in_article 110 'radio-actives' radioactives | \
    sed -E ':start;s/^(\(110\).*)([0-9])\(/\1[\2]/;t start' | \
    # Article 111
    amend_error_in_article 111 'que peut présenter' 'que peuvent présenter' | \
    amend_error_in_article 111 'fixes les' 'fixe les' | \
    # Article 112
    amend_error_in_article 112 prévues prévue | \
    # Article 119
    amend_error_in_article 119 gène gêne | \
    # Article 120
    amend_error_in_article 120 bruits bruit | \
    amend_error_in_article 120 gène gêne | \
    # Article 122
    amend_error_in_article 122 Quinconque Quiconque | \
    # Article 126
    amend_error_in_article 126 'sanction entraîne' 'sanction, entraîne' | \
    # Article 128
    amend_error_in_article 128 '\[114\]' '114.' | \
    # Article 131
    amend_error_in_article 131 'environnement\. Les' 'environnement; [•] les' | \
    amend_error_in_article 131 '; La' '; [•] la' | \
    amend_error_in_article 131 'impact; Il' 'impact. Il' | \
    # Article 134
    amend_error_in_article 134 'de environnement' "de l'environnement" | \
    amend_error_in_article 134 '\. \[' ', [' | \
    # Article 135
    sed -E ':start;s/^(\(135\).*)\. \[/\1, [/;t start' | \
    # Article 140
    amend_error_in_article 140 ' Faite.*$' ''
}

function amend_errors_in_headers {
  sed -E 's/GENERAL/GÉNÉRAL/g' | \
    sed -E 's/RECEPT/RÉCEPT/g' | \
    sed -E 's/ETUDE/ÉTUDE/g' | \
    sed -E 's/^(Chapitre II - .*)partes( nationaux)/\1parcs\2/' | \
    sed -E 's/^(Chapitre )VI( - Délits et peines)/\1IV\2/' | \
    sed -E 's/^(Chapitre III - .*)radio-activité/\1radioactivité/'
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
    add_newlines_between_headers_and_articles | \
    amend_errors_in_articles | \
    amend_errors_in_headers
}
