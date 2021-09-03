#!/bin/bash

function remove_degree_symbols {
  sed -E 's/n.º/número/g' | \
    sed -E 's/\.º//g'
}

function remove_all_text_before_first_chapter_header {
  sed -n '/CAPÍTULO I /,$p'
}

function move_article_titles_above_article_bodies {
  sed -E 's/^(\([0-9]+\)) \(([A-Za-z ]+)\)/\2\n\1/g'
}

function amend_errors_in_articles {
  # Article 1
  amend_error_in_article 1 '1, 2 e 3' '[1], [2] e [3]' | \
    amend_error_in_article 1 'número 2' 'número [2]' | \
    # Article 4
    sed -E ':start;s/^(\(4\).*:) \[•\]/\1/;t start' | \
    amend_error_in_article 4 'comuns\. \[g\]' 'comuns; [g]' | \
    # Article 5
    amend_error_in_article 5 '358 DIÁRIO DA REPÚBLICA ' '' | \
    amend_error_in_article 5 desiquilíbrios desequilíbrios | \
    # Article 12
    amend_error_in_article 12 ' I SÉRIE.*$' '' | \
    # Article 14
    amend_error_in_article 14 abrangir abranger | \
    # Article 19
    amend_error_in_article 19 '360 DIÁRIO DA REPÚBLICA ' '' | \
    # Article 20
    amend_error_in_article 20 'vertentes\. \[a\]' 'vertentes: [a]' | \
    # Article 27
    amend_error_in_article 27 'e nvolvam' envolvam | \
    # Article 32
    amend_error_in_article 32 'I SÉRIE \[•\] N 27 \[•\] DE 19 DE JUNHO DE 1998 361 ' '' | \
    # Article 37
    amend_error_in_article 37 ' Anexo' '\n\nAnexo' | \
    amend_error_in_article 37 ' Vista e aprovada.*$' ''
}

function format_annex {
  local stdin="$(</dev/stdin)"

  local line_prefix='Anexo à Lei de Bases do Ambiente'

  echo "$stdin" | \
    sed -E ":start;s/^(${line_prefix}.*:) \[•\]/\1/;t start" | \
    sed -E "s/^(${line_prefix}.*)362 DIÁRIO DA REPÚBLICA /\1/" | \
    sed -E "s/^(${line_prefix}.*) O Presidente da Assembleia Nacional.*$/\1/" | \
    sed -E "s/^(${line_prefix}) /\1\n\n/"
}

function preprocess_state_and_language_input_file {
  if [ "$#" -ne 2 ] ; then
    echo_usage_error "$*" '<input_file_path> <language>'
    return 1
  fi
  local input_file_path="$1"
  local language="$2"

  cat "$input_file_path" | \
    remove_degree_symbols | \
    apply_common_transformations_to_stdin "$language" | \
    remove_all_text_before_first_chapter_header | \
    move_article_titles_above_article_bodies | \
    amend_errors_in_articles | \
    format_annex
}
