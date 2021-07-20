#!/bin/bash

set -o pipefail

function echo_error {
  >&2 echo "ERROR: $1"
}

function echo_info {
  echo "INFO: $1"
}

function tee_to_stderr {
  tee /dev/fd/2
}

function replace_newlines_with_spaces {
  tr '\n' ' '
}

function replace_tabs_with_spaces {
  tr '\t' ' '
}

function remove_redundant_spaces {
  sed -E 's/  +/ /g'
}

function get_header_regular_expression {
  if [ "$#" -ne 1 ] ; then
    echo_error "USAGE: ${FUNCNAME[0]} <language>"
    return 1
  fi
  local language="$1"

  local header_regular_expression
  case "$language" in
    french)
      header_regular_expression="Titre|TITRE|"
      header_regular_expression+="Chapitre|CHAPITRE|"
      header_regular_expression+="Section|SECTION|"
      header_regular_expression+="Annexe?|ANNEXE?"
      ;;
    portugese)
      header_regular_expression="Título|TÍTULO|"
      header_regular_expression+="Capítulo|CAPÍTULO|"
      header_regular_expression+="Seção|SEÇÃO|"
      header_regular_expression+="Anexo|ANEXO"
      ;;
    *)
      echo_error "Language $language is not supported by ${FUNCNAME[0]}."
      return 1
  esac

  echo "$header_regular_expression"
}

function get_article_regular_expression {
  if [ "$#" -ne 1 ] ; then
    echo_error "USAGE: ${FUNCNAME[0]} <language>"
    return 1
  fi
  local language="$1"

  local article_regular_expression
  case "$language" in
    french)
      article_regular_expression="Art\.|Article|ARTICLE"
      ;;
    portugese)
      article_regular_expression="Art\.|Artigo|ARTIGO"
      ;;
    *)
      echo_error "Language $language is not supported by ${FUNCNAME[0]}."
      return 1
  esac

  echo "$article_regular_expression"
}

function get_header_and_article_regular_expression {
  if [ "$#" -ne 1 ] ; then
    echo_error "USAGE: ${FUNCNAME[0]} <language>"
    return 1
  fi
  local language="$1"

  local header_regular_expression="$(get_header_regular_expression $language)"
  local return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  local article_regular_expression="$(get_article_regular_expression $language)"
  return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  local header_and_article_regular_expression="${header_regular_expression}|"
  header_and_article_regular_expression+="$article_regular_expression"

  echo "$header_and_article_regular_expression"
}

function add_newlines_before_headers_and_articles {
  local stdin=$(</dev/stdin)

  if [ "$#" -ne 1 ] ; then
    echo_error "USAGE: ${FUNCNAME[0]} <language>"
    return 1
  fi
  local language="$1"

  local header_and_article_regular_expression="$(get_header_and_article_regular_expression $language)"
  local return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  echo "$stdin" | sed -E "s/ (${header_and_article_regular_expression})/\n\n\1/g"
}

function get_ordinal_regular_expression {
  if [ "$#" -ne 1 ] ; then
    echo_error "USAGE: ${FUNCNAME[0]} <language>"
    return 1
  fi
  local language="$1"

  local ordinal_regular_expression
  case "$language" in
    french)
      ordinal_regular_expression="([0-9IVX]+) ?(er|ER|ère|ÈRE|ème|ÈME)"
      ;;
    *)
      ordinal_regular_expression="([0-9IVX]+)"
      ;;
  esac

  echo "$ordinal_regular_expression"
}

function remove_ordinals_from_headers_and_articles {
  local stdin=$(</dev/stdin)

  if [ "$#" -ne 1 ] ; then
    echo_error "USAGE: ${FUNCNAME[0]} <language>"
    return 1
  fi
  local language="$1"

  local header_and_article_regular_expression="$(get_header_and_article_regular_expression $language)"
  local return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  local ordinal_regular_expression="$(get_ordinal_regular_expression $language)"
  return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  local regular_expression="^(${header_and_article_regular_expression}) +"
  regular_expression+="${ordinal_regular_expression}"

  echo "$stdin" | sed -E "s/${regular_expression}/\1 \2/"
}

function remove_dashes {
  sed -E 's/(-|—) //g'
}

function get_unique_regular_expression {
  if [ "$#" -ne 1 ] ; then
    echo_error "USAGE: ${FUNCNAME[0]} <language>"
    return 1
  fi
  local language="$1"

  local unique_in_language
  case "$language" in
    french)
      unique_in_language="Unique|UNIQUE"
      ;;
    portugese)
      unique_in_language="Únic[o,a]|ÚNIC[O,A]"
      ;;
    *)
      echo_error "Language $language is not supported by ${FUNCNAME[0]}."
      return 1
  esac

  echo "$unique_in_language"
}

function add_dash_to_headers {
  local stdin=$(</dev/stdin)

  if [ "$#" -ne 1 ] ; then
    echo_error "USAGE: ${FUNCNAME[0]} <language>"
    return 1
  fi
  local language="$1"

  local header_regular_expression="$(get_header_regular_expression $language)"
  local return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  local unique_regular_expression="$(get_unique_regular_expression $language)"
  return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  local regular_expression="^(${header_regular_expression}) "
  regular_expression+="([0-9IVX]+|${unique_regular_expression})"

  echo "$stdin" | sed -E "s/${regular_expression}/\1 \2 -/g"
}

function remove_space_before_colons_and_semicolons {
  sed -E 's/ (;|:)/\1/g'
}

function replace_double_angle_quotation_marks_with_quotation_marks {
  sed -E 's/(« ?| ?»)/"/g'
}

function remove_colon_from_headers {
  local stdin=$(</dev/stdin)

  if [ "$#" -ne 1 ] ; then
    echo_error "USAGE: ${FUNCNAME[0]} <language>"
    return 1
  fi
  local language="$1"

  local header_regular_expression="$(get_header_regular_expression $language)"
  local return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  echo "$stdin" | sed -E "s/^(${header_regular_expression})([^-]+)(-):/\1\2\3/"
}

function replace_article_literals_with_numbers {
  local stdin=$(</dev/stdin)

  if [ "$#" -ne 1 ] ; then
    echo_error "USAGE: ${FUNCNAME[0]} <language>"
    return 1
  fi
  local language="$1"

  local article_regular_expression="$(get_article_regular_expression $language)"
  local return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  echo "$stdin" | sed -E "s/^(${article_regular_expression}) ([0-9]+)[^A-Z0-9(]+/(\2) /"
}

function apply_common_transformations_to_stdin {
  local stdin=$(</dev/stdin)

  if [ "$#" -ne 1 ] ; then
    echo_error "USAGE: ${FUNCNAME[0]} <language>"
    return 1
  fi
  local language="$1"

  echo "$stdin" | \
    replace_newlines_with_spaces | \
    replace_tabs_with_spaces | \
    remove_redundant_spaces | \
    add_newlines_before_headers_and_articles "$language" | \
    remove_ordinals_from_headers_and_articles "$language" | \
    remove_dashes | \
    add_dash_to_headers "$language" | \
    remove_space_before_colons_and_semicolons | \
    replace_double_angle_quotation_marks_with_quotation_marks | \
    remove_colon_from_headers "$language" | \
    replace_article_literals_with_numbers "$language"
}

function apply_common_transformations {
  if [ "$#" -ne 2 ] ; then
    echo_error "USAGE: ${FUNCNAME[0]} <input_file_path> <language>"
    return 1
  fi
  local input_file_path="$input_file_path"
  local language="$language"

  cat "$input_file_path" | apply_common_transformations_to_stdin "$language"
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
