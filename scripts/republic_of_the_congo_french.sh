#!/bin/bash

function replace_leading_dashes_with_stars {
  sed -E 's/^([\t ]+)-/\1**/'
}

function remove_all_text_before_first_article_header {
  sed -En '/^\(1\)/,$p'
}

function remove_signatory_details {
  sed -E 's/ Fait à Brazzaville.*$//'
}

function replace_ordinal_abbreviations {
  sed -E 's/(article 1)er/\1/' | \
    sed -E 's/1ère/première/' | \
    sed -E 's/2ème/deuxième/'
}

function reformat_annexes {
  sed -E ':start;s/^(ANNEX.* )([0-9]+)\./\1(\2)/;t start' | \
    sed -E ':start;s/^(ANNEX.*) (\([0-9]+\))/\1\n\2/;t start' | \
    sed -E ':start;s/^(\([0-9]+\).*) \*\* /\1\n  /;t start' | \
    sed -E ':start;s/^(  .*) \* /\1\n    /;t start' | \
    sed -E 's/(Défrichement des bois et forêts) • /\1: /' | \
    sed -E 's/ •/,/g' | \
    sed -E 's/^( +.*[^\.])[\.,;] ?$/\1/' | \
    sed -E 's/ (\.\.\.)$/\1/' | \
    sed -E 's/(etc) ?\.+/\1./g' | \
    sed -E 's/^(ANNEX) 1 - (.*) _+ (Liste des Travaux.*$)/\1 I \2 - \3\n/' | \
    sed -E 's/^(ANNEXE II) - (.*) (Liste Indicative.*$)/\1 \2 - \3\n/'
}

function preprocess_state_and_language_input_file {
  if [ "$#" -ne 2 ] ; then
    echo_error "USAGE: ${FUNCNAME[0]} <input_file_path> <language>"
    return 1
  fi
  local input_file_path="$1"
  local language="$2"

  cat "$input_file_path" | \
    replace_leading_dashes_with_stars | \
    apply_common_transformations_to_stdin "$language" | \
    remove_all_text_before_first_article_header | \
    remove_signatory_details | \
    replace_ordinal_abbreviations | \
    reformat_annexes
}
