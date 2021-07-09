#!/bin/bash

function remove_all_text_before_first_chapter_header {
  sed -n '/CAPÍTULO I /,$p'
}

function remove_page_headers_and_footers {
  sed -E 's/ [0-9]+ DIÁRIO DA REPÚBLICA//' | \
    sed -E 's/( )?I SÉRIE N.º 27 DE 19 DE JUNHO DE 1998 [0-9]+ ?/\1/'
}

function replace_number_abbreviations_with_complete_word {
  sed -E 's/n.º/número/g'
}

function remove_degree_symbols {
  sed -E 's/\.º//g'
}

function move_article_titles_above_article_bodies {
  sed -E 's/ARTIGO ([0-9]+) \(([A-Za-z ]+)\)/\2\n(\1)/g'
}

function remove_signatory_details {
  sed -E 's/ Vista e aprovada pela Assembleia Nacional.*$//' | \
    sed -E 's/ O Presidente da Assembleia Nacional.*$//'
}

function reformat_annex {
  sed -E 's/^(Anexo à Lei de Bases do Ambiente) (Para)/\1\n\n\2/' | \
    sed -E 's/(:|\.) (\([0-9]+\))/\1\n\2/g'
}

function preprocess_state_and_language_input_file {
  if [ "$#" -ne 2 ] ; then
    echo_error "USAGE: ${FUNCNAME[0]} <input_file_path> <language>"
    return 1
  fi
  local input_file_path="$1"
  local language="$2"

  apply_common_transformations "$input_file_path" "$language" | \
    remove_all_text_before_first_chapter_header | \
    remove_page_headers_and_footers | \
    replace_number_abbreviations_with_complete_word | \
    remove_degree_symbols | \
    move_article_titles_above_article_bodies | \
    rearrange_article_and_subarticle_numbers | \
    remove_signatory_details | \
    reformat_annex
}
