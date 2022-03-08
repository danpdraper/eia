#!/bin/bash

function remove_all_text_before_first_header {
  sed -E 's/ (TITRE I )/\n\1- /' | \
    sed -n '/^TITRE I /,$p'
}

function remove_redundant_articles {
  sed -E '/^\(59\).*DES/,/^\(60\)/{/^\(59\).*DES/!{/^\(60\)/!d;};}'
}

function amend_errors_in_articles {
  local stdin="$(</dev/stdin)"

  local article_53_text="L'évaluation environnementale stratégique est requise "
  article_53_text+="dans deux conditions: la planification d'un secteur ou "
  article_53_text+="d'une filière et à chaque fois qu'un grand projet est "
  article_53_text+="susceptible d'influencer des facteurs importants, de "
  article_53_text+="l'équilibre environnemental notamment: [•] les ressources "
  article_53_text+="en eau, [•] la désertification, [•] les ressources "
  article_53_text+="naturelles, [•] la démographie, etc."


  echo "$stdin" | \
    # Article 1
    amend_error_in_article 1 Evaluation Évaluation | \
    amend_error_in_article 1 'Valeurs – limites' 'Valeurs-limites' | \
    amend_error_in_article 1 Etude Étude | \
    amend_error_in_article 1 Evaluation Évaluation | \
    # Article 3
    amend_error_in_article 3 'composantes \[' 'composantes. [' | \
    amend_error_in_article 3 'dégradés \[' 'dégradés. [' | \
    # Article 4
    amend_error_in_article 4 Elaborer Élaborer | \
    amend_error_in_article 4 'valeurs – limites' 'valeurs-limites' | \
    # Article 5
    sed -E ':start;s/^(\(5\).*)\* /\1/;t start' | \
    amend_error_in_article 5 'environnement ,' 'environnement,' | \
    amend_error_in_article 5 'immédiat, \[' 'immédiat. [' | \
    amend_error_in_article 5 'détruire, \[' 'détruire. [' | \
    amend_error_in_article 5 'développement\. Toute' 'développement. [•] Toute' | \
    # Article 6
    amend_error_in_article 6 "l'État aux" "l'État, aux" | \
    # Article 8
    amend_error_in_article 8 'oeuvre \.' 'oeuvre.' | \
    # Article 10 
    amend_error_in_article 10 créée créé | \
    # Article 11
    amend_error_in_article 11 CTE 'CTE).' | \
    # Article 14
    amend_error_in_article 14 'valeurs limites' 'valeurs-limites' | \
    # Article 15
    amend_error_in_article 15 'valeurs – limites' 'valeurs-limites' | \
    # Article 16
    amend_error_in_article 16 'valeurs – limites' 'valeurs-limites' | \
    # Article 19
    sed -E ':start;s/\] T/] t/;t start' | \
    amend_error_in_article 19 Djibouti 'Djibouti.' | \
    # Article 20
    amend_error_in_article 20 'vis à vis' 'vis-à-vis' | \
    # Article 22
    amend_error_in_article 22 'inflammables.*Il pourra' 'inflammables. Il pourra' | \
    # Article 24
    amend_error_in_article 24 inoccupés inoccupées | \
    # Article 27
    amend_error_in_article 27 'valeurs – limites' 'valeurs-limites' | \
    # Article 31
    amend_error_in_article 31 'sous – sol' 'sous-sol' | \
    amend_error_in_article 31 énumérées énumérés | \
    amend_error_in_article 31 'permanent Article 32:' 'permanent.\n\n(32)' | \
    # Article 33
    amend_error_in_article 33 'sous – sols' 'sous-sols' | \
    amend_error_in_article 33 environnementale environnemental | \
    # Article 34
    amend_error_in_article 34 interdit interdite | \
    # Article 35
    amend_error_in_article 35 'sous – sol' 'sous-sol' | \
    # Article 36
    amend_error_in_article 36 Etude Étude | \
    # Article 42
    amend_error_in_article 42 'valeurs \[•\] limites' 'valeurs-limites' | \
    amend_error_in_article 42 ' DES' '\n\nDES' | \
    # Article 44
    amend_error_in_article 44 ' DES' '\n\nDES' | \
    # Article 46
    amend_error_in_article 46 'valeurs \[•\] limites' 'valeurs-limites' | \
    # Article 47
    amend_error_in_article 47 agrées agréés | \
    # Article 48
    amend_error_in_article 48 '\] A' '] a' | \
    amend_error_in_article 48 '\] M' '] m' | \
    amend_error_in_article 48 '\] P' '] p' | \
    # Article 53
    amend_error_in_article 53 définie défini | \
    amend_error_in_article 53 ' Article 54:' '\n\n(54)' | \
    amend_error_in_article 53 '' " $article_53_text" | \
    # Article 54
    amend_error_in_article 54 'règlementaire \.' 'règlementaire.' | \
    # Article 57
    amend_error_in_article 57 '48, 52' '48 et 52' | \
    amend_error_in_article 57 'auto \[•\] saisine' 'auto-saisine' | \
    # Article 59
    amend_error_in_article 59 'X' 'X\n' | \
    amend_error_in_article 59 '\[58\] ' '58.\n\n' | \
    # Article 62
    amend_error_in_article 62 '48, 49' '48 et 49' | \
    # Article 68
    amend_error_in_article 68 ' Fait.*$' ''
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
    remove_redundant_articles | \
    amend_errors_in_articles
}
