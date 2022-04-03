function remove_all_text_before_first_header {
  sed -E 's/^REPUBLIQUE.*\[1\] (DES DEFINITIONS)/1. \1/'
}

function amend_errors_in_articles {
  sed -E 's/Etat/État/g' | \
    # Article 4
    amend_error_in_article 4 'devoir, de' 'devoir de' | \
    # Article 5
    amend_error_in_article 5 'toues activités' 'toutes activités' | \
    amend_error_in_article 5 ' Article 6:' '\n\n(6)' | \
    amend_error_in_article 5 ' \[2\]' '\n\n2.' | \
    # Article 7
    amend_error_in_article 7 Ministre 'Le Ministre' | \
    amend_error_in_article 7 loicadre 'loi-cadre' | \
    # Article 8
    amend_error_in_article 8 'dune catastrophe' "d'une catastrophe" | \
    amend_error_in_article 8 'délai, approbation' "délai d'approbation" | \
    amend_error_in_article 8 'divergences, entre' 'divergences entre' | \
    amend_error_in_article 8 'Ministre\.' 'Ministres.' | \
    # Article 9
    amend_error_in_article 9 '\(9\) Environnement' "(9) Le principal organe administratif de gestion de l'Environnement" | \
    amend_error_in_article 9 'des 4 Comores' 'des Comores' | \
    # Article 10
    amend_error_in_article 10 'N°' numéro | \
    amend_error_in_article 10 dune "d'une" | \
    amend_error_in_article 10 agréer agréées | \
    amend_error_in_article 10 ' \[3\]' '\n\n3.' | \
    # Article 11
    amend_error_in_article 11 projet projets | \
    # Article 12
    amend_error_in_article 12 '\[c\] Une' '[c] une' | \
    # Article 14
    amend_error_in_article 14 ' \[4\]' '.\n\n4.' | \
    # Article 15
    amend_error_in_article 15 'Il est crée' 'Il est créé' | \
    amend_error_in_article 15 'par \[•\]' 'par: [•]' | \
    amend_error_in_article 15 '; 5' ';' | \
    # Article 16
    amend_error_in_article 16 '\(16\) Environnement' "(16) Le fonds pour la gestion de l'Environnement" | \
    # Article 17
    amend_error_in_article 17 'des Ministre' 'des Ministres' | \
    amend_error_in_article 17 ' \[5\]' '\n\n5.' | \
    # Article 18
    amend_error_in_article 18 faune 'faune.' | \
    # Article 19
    amend_error_in_article 19 'es mis' 'est mis' | \
    amend_error_in_article 19 'sans effet le Ministre' 'sans effet, le Ministre' | \
    amend_error_in_article 19 'défaillant les' 'défaillant, les' | \
    amend_error_in_article 19 ' 5\.1\.' '\n\n5.1.' | \
    # Article 21
    amend_error_in_article 21 luttes lutte | \
    amend_error_in_article 21 luttes lutte | \
    # Article 23
    amend_error_in_article 23 '22, est' '22 est' | \
    amend_error_in_article 23 ' 5\.2\.1\.' '\n\n5.2.1.' | \
    amend_error_in_article 23 ' 5\.2\.' '\n\n5.2' | \
    # Article 24
    amend_error_in_article 24 ' Articles 25:' '\n\n(25)' | \
    # Article 27
    amend_error_in_article 27 chimique chimiques | \
    # Article 28
    amend_error_in_article 28 'Toute activités' 'Toutes activités' | \
    # Article 30
    amend_error_in_article 30 ': 7' ':' | \
    amend_error_in_article 30 'eaux usée' 'eaux usées' | \
    amend_error_in_article 30 ' 5\.2\.2\.' '\n\n5.2.2.' | \
    # Article 31
    amend_error_in_article 31 'telles que définit' 'telles que définies' | \
    # Article 32
    amend_error_in_article 32 peuventt peuvent | \
    # Article 33
    amend_error_in_article 33 'marin,' 'marin;' | \
    # Article 34
    amend_error_in_article 34 article33 'article 33' | \
    # Article 36
    amend_error_in_article 36 marines marine | \
    amend_error_in_article 36 ' 5\.3\.' '\n\n5.3.' | \
    # Article 38
    sed -E 's/^\(36\)(.*\[a\])/(38)\1/' | \
    amend_error_in_article 38 'nocives;' 'nocives,' | \
    amend_error_in_article 38 '\. \[b\] P' '; [b] p' | \
    amend_error_in_article 38 ' 5\.4\.' '\n\n5.4.' | \
    # Article 39
    amend_error_in_article 39 't animales' 'et animales' | \
    # Article 40
    amend_error_in_article 40 'd flore' 'de flore' | \
    amend_error_in_article 40 '\[•\] La capture' '[•] la capture' | \
    amend_error_in_article 40 '\[•\] Le transport' '[•] le transport' | \
    amend_error_in_article 40 '\[•\] Toute gêne' '[•] toute gêne' | \
    amend_error_in_article 40 '\[•\] La destruction' '[•] la destruction' | \
    amend_error_in_article 40 '\. \[b\] P' '; [b] p' | \
    amend_error_in_article 40 '\[•\] La cueillette' '[•] la cueillette' | \
    amend_error_in_article 40 '\[•\] Le transport' '[•] le transport' | \
    amend_error_in_article 40 "vente l'exportation" "vente ou l'exportation" | \
    # Article 42
    amend_error_in_article 42 "41n'est" "41 n'est" | \
    amend_error_in_article 42 agrée agréée | \
    amend_error_in_article 42 '9 La' La | \
    # Article 43
    amend_error_in_article 43 agrée agréée | \
    amend_error_in_article 43 '\[•\] La capture' '[•] la capture' | \
    amend_error_in_article 43 '\[•\] Le transport' '[•] le transport' | \
    amend_error_in_article 43 '; \[•\] T' '; [•] t' | \
    amend_error_in_article 43 'opérations menée ' 'opérations menées ' | \
    amend_error_in_article 43 '\. \[b\] P' '; [b] p' | \
    amend_error_in_article 43 '\[•\] La cueillette' '[•] la cueillette' | \
    amend_error_in_article 43 '\[•\] Le transport' '[•] le transport' | \
    amend_error_in_article 43 "vente l'exportation" "vente ou l'exportation" | \
    amend_error_in_article 43 '\. \[•\] T' '. [•] t' | \
    # Article 45
    amend_error_in_article 45 'un espèce' 'une espèce' | \
    amend_error_in_article 45 ' 5\.5\.' '\n\n5.5.' | \
    # Article 46
    amend_error_in_article 46 'elle ou présente' 'elle présente' | \
    # Article 48
    amend_error_in_article 48 '10 \[d\]' '[d]' | \
    # Article 49
    amend_error_in_article 49 ' 5\.6\.' '\n\n5.6.' | \
    # Article 50
    amend_error_in_article 50 'Elles inaliénables' 'Elles sont inaliénables' | \
    # Article 51
    amend_error_in_article 51 'ne culture' 'en culture' | \
    # Article 53
    amend_error_in_article 53 ' 6\.1\.' '\n\n6.1.' | \
    amend_error_in_article 53 ' \[6\]' '\n\n6.' | \
    # Article 58
    amend_error_in_article 58 ' 6\.2\.1\.' '\n\n6.2.1.' | \
    amend_error_in_article 58 ' 6\.2\.' '\n\n6.2.' | \
    # Article 59
    amend_error_in_article 59 resultant resultants | \
    amend_error_in_article 59 inutilisable inutilisables | \
    amend_error_in_article 59 abandonné abandonnés | \
    amend_error_in_article 59 destiné destinés | \
    # Article 60
    amend_error_in_article 60 personne personnes | \
    # Article 61
    amend_error_in_article 61 publique public | \
    # Article 63
    amend_error_in_article 63 'ces exploitation' 'ces exploitations' | \
    amend_error_in_article 63 '12 En' En | \
    amend_error_in_article 63 'doit tenue' 'doit tenir' | \
    # Article 65
    amend_error_in_article 65 'a\] L' 'a] l' | \
    amend_error_in_article 65 'b\] L' 'b] l' | \
    amend_error_in_article 65 'c\] L' 'c] l' | \
    amend_error_in_article 65 '\[1989\]' '1989.' | \
    amend_error_in_article 65 ' 6\.2\.2\.' '\n\n6.2.2.' | \
    # Article 67
    amend_error_in_article 67 ' 6\.2\.3\.' '\n\n6.2.3.' | \
    # Article 69
    amend_error_in_article 69 '\. 13 \[a\] L' ': [a] l' | \
    amend_error_in_article 69 '\[b\] L' '[b] l' | \
    amend_error_in_article 69 '\[c\] L' '[c] l' | \
    amend_error_in_article 69 '\. \[d\] L' '; [d] l' | \
    amend_error_in_article 69 '\[e\] L' '[e] l' | \
    amend_error_in_article 69 ' 6\.2\.4\.' '\n\n6.2.4.' | \
    # Article 72
    amend_error_in_article 72 ' 14 \[7\]' '\n\n7.' | \
    # Article 75
    amend_error_in_article 75 produit produits | \
    # Article 76
    amend_error_in_article 76 amande amende | \
    amend_error_in_article 76 '\(cinq\)millions' '(cinq) millions' | \
    amend_error_in_article 76 'projets aménagement' "projets d'aménagement" | \
    # Article 77
    amend_error_in_article 77 puni punie | \
    amend_error_in_article 77 '0\(c' '0 (c' | \
    # Article 81
    amend_error_in_article 81 puni punie | \
    # Article 82
    amend_error_in_article 82 ', 44,' ' et 44' | \
    amend_error_in_article 82 puni punie | \
    # Article 84
    amend_error_in_article 84 puni punie | \
    # Article 85
    amend_error_in_article 85 puni punie | \
    amend_error_in_article 85 'de ou de' 'ou de' | \
    # Article 86
    amend_error_in_article 86 puni punie | \
    amend_error_in_article 86 '1million' '1 million' | \
    # Article 87
    amend_error_in_article 87 puni punie | \
    amend_error_in_article 87 '1million' '1 million' | \
    # Article 88
    amend_error_in_article 88 puni punie | \
    amend_error_in_article 88 "des l'articles" 'des articles' | \
    amend_error_in_article 88 ' \[8\]' '\n\n8.' | \
    # Article 89
    amend_error_in_article 89 présenta présente | \
    # Article 90
    amend_error_in_article 90 'Adoptée.*$' ''
}

function amend_errors_in_headers {
  sed -E 's/^(1\. DES )DEFINITIONS/\1DÉFINITIONS/' | \
    sed -E 's/^2\. .*$/\U&/' | \
    sed -E 's/^(3\. DES )ETUDES/\1ÉTUDES/' | \
    sed -E 's/^(5\.5\. DES AIRES )PROTEGEES/\1PROTÉGÉES/' | \
    sed -E 's/^(5\.6\. DES )FORETS/\1FORÊTS/' | \
    sed -E 's/^(6\.1\. DES )ETABLISSEMENTS/\1ÉTABLISSEMENTS/' | \
    sed -E 's/^(6\.2\. DES POLLUTIONS )EN/\1ET/' | \
    sed -E 's/^(6\.2\.1\. DES )DECHETS/\1DÉCHETS/' | \
    sed -E 's/^(6\.2\.3\. DES )ETABLISSEMENTS CLASSES/\1ÉTABLISSEMENTS CLASSÉS/' | \
    sed -E 's/^(7\. DES DISPOSITIONS )PENALES/\1PÉNALES/'
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
