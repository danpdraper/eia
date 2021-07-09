#!/bin/bash

function remove_all_text_before_first_title_header {
  sed -n '/TITRE I /,$p'
}

function remove_signatory_details {
  sed -E "s/ Fait à N'Djaména.*$//"
}

function remove_bullet_points {
  sed -E 's/\x06|\x04//g'
}

function remove_forward_slashes_colons_and_periods_from_headers {
  sed -E 's/^(titre|chapitre)([^\/:\.]+)[\/:\. ]+/\1\2 /i'
}

function remove_superfluous_newline_after_title_five_chapter_four_header {
  local stdin="$(</dev/stdin)"
  local regular_expression="^CHAPITRE 4 - La protection contre les substances "
  regular_expression+="chimiques, nocives ou dangereuses"
  echo "$stdin" | sed -E "/${regular_expression}/{N;s/\n.*//;}"
}

function format_definitions_article {
  sed -E ':start;s/^(\(2\).*)([a-z])[;. ]+([0-9]+)\.([^,.]+)[,.]/\1\2; (\3) \4:/;t start' | \
    sed -E 's/^(\(2\).*)1\.(Environment),/\1(1) \2:/'
}

function preprocess_state_and_language_input_file {
  if [ "#" -ne 2 ] ; then
    echo_error "USAGE: ${FUNCNAME[0]} <input_file_path> <language>"
    return 1
  fi
  local input_file_path="$1"
  local language="$2"

  apply_common_transformations "$input_file_path" "$language" | \
    remove_all_text_before_first_title_header | \
    remove_bullet_points | \
    remove_signatory_details | \
    remove_forward_slashes_colons_and_periods_from_headers | \
    replace_article_literals_with_numbers | \
    remove_superfluous_newline_after_title_five_chapter_four_header | \
    add_dash_to_unique_chapter_header | \
    format_definitions_article
}
