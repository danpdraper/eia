#!/bin/bash

set -o pipefail

function echo_error {
  >&2 echo "ERROR: $1"
}

function echo_info {
  echo "INFO: $1"
}

function replace_newlines_with_spaces {
  tr '\n' ' '
}

function add_newlines_before_headers {
  local stdin=$(</dev/stdin)

  if [ "$#" -ne 1 ] ; then
    echo_error "USAGE: ${FUNCNAME[0]} <language>"
    return 1
  fi
  local language="$1"

  local header_regular_expression
  case "$language" in
    french)
      header_regular_expression="Titre|TITRE|Chapitre|CHAPITRE|Section|SECTION|Article|ARTICLE|Annexe|ANNEXE"
      ;;
    portugese)
      header_regular_expression="Título|TÍTULO|Capítulo|CAPÍTULO|Seção|SEÇÃO|Artigo|ARTIGO|Anexo|ANEXO"
      ;;
    *)
      echo_error "Language $language is not supported by ${FUNCNAME[0]}."
      return 1
  esac

  echo "$stdin" | sed -E "s/.(${header_regular_expression})/\n\n\1/g"
}

function remove_dashes {
  sed -E 's/(-|—) //g'
}

function add_dash_to_headers_with_arabic_or_roman_numerals {
  local stdin=$(</dev/stdin)

  if [ "$#" -ne 1 ] ; then
    echo_error "USAGE: ${FUNCNAME[0]} <language>"
    return 1
  fi
  local language="$1"

  local header_regular_expression
  case "$language" in
    french)
      header_regular_expression="Titre|TITRE|Chapitre|CHAPITRE|Section|SECTION|Annexe|ANNEXE"
      ;;
    portugese)
      header_regular_expression="Título|TÍTULO|Capítulo|CAPÍTULO|Seção|SEÇÃO|Anexo|ANEXO"
      ;;
    *)
      echo_error "Language $language is not supported by ${FUNCNAME[0]}."
      return 1
  esac

  echo "$stdin" | sed -E "s/((${header_regular_expression}) ([0-9]+|[I,V,X]+))/\1 -/g"
}

function remove_article_literal {
  local stdin=$(</dev/stdin)

  if [ "$#" -ne 1 ] ; then
    echo_error "USAGE: ${FUNCNAME[0]} <language>"
    return 1
  fi
  local language="$1"

  local article_regular_expression
  case "$language" in
    french)
      article_regular_expression="Article|ARTICLE"
      ;;
    portugese)
      article_regular_expression="Artigo|ARTIGO"
      ;;
    *)
      echo_error "Language $language is not supported by ${FUNCNAME[0]}."
      return 1
  esac

  echo "$stdin" | sed -E "s/${article_regular_expression} ([0-9]+)/(\1)/gi"
}

function remove_space_before_colons_and_semicolons {
  sed -E 's/ (;|:)/\1/g'
}

function replace_double_angle_quotation_marks_with_quotation_marks {
  sed -E 's/(« ?| ?»)/"/g'
}

function apply_common_transformations {
  if [ "$#" -ne 2 ] ; then
    echo_error "USAGE: ${FUNCNAME[0]} <input_file_path> <language>"
    return 1
  fi
  local input_file_path="$input_file_path"
  local language="$language"

  cat "$input_file_path" | \
    replace_newlines_with_spaces | \
    add_newlines_before_headers "$language" | \
    remove_dashes | \
    add_dash_to_headers_with_arabic_or_roman_numerals "$language" | \
    remove_space_before_colons_and_semicolons | \
    replace_double_angle_quotation_marks_with_quotation_marks
}

function rearrange_article_and_subarticle_numbers {
  sed -E 's/(\([0-9]+\)|\.|:) ([0-9]+)\./\1 (\2)/g' | \
    sed -E 's/^(\([0-9]+\)) \(/\1(/' | \
    sed -E ':start;s/^(\([0-9]+\))(.*\.) (\([0-9]+\))/\1\2\n\1\3/;t start'
}

function preprocess_file {
  if [ "$#" -ne 2 ] ; then
    echo_error "USAGE: ${FUNCNAME[0]} <input_file_path> <output_file_path>"
    return 1
  fi
  local input_file_path="$1"
  local output_file_path="$2"

  local preprocessing_output="$(preprocess_state_and_language_input_file "$input_file_path" "$language")"
  local return_code="$?"

  if [ "$return_code" -ne 0 ] ; then
    return "$return_code"
  fi
  echo "$preprocessing_output" > "$output_file_path"
}
