#!/usr/bin/env bash

set -o pipefail

GREEN='\033[1;32m'
NO_COLOUR='\033[0m'
RED='\033[1;31m'

function echo_error {
  >&2 echo -e "${RED}ERROR: $1${NO_COLOUR}"
}

function echo_usage_error {
  if [ "$#" -lt 1 ] || [ "$#" -gt 2 ] ; then
    echo_error "USAGE: ${FUNCNAME[0]} <provided_arguments> [expected_arguments]"
    echo_error "PROVIDED: ${FUNCNAME[0]} $*"
    return 1
  fi
  local provided_arguments="$1"
  local expected_arguments="$2"

  if [ "$#" -eq 1 ] ; then
    echo_error "USAGE: ${FUNCNAME[1]}"
  fi
  if [ "$#" -eq 2 ] ; then
    echo_error "USAGE: ${FUNCNAME[1]} $expected_arguments"
  fi
  echo_error "PROVIDED: ${FUNCNAME[1]} $provided_arguments"
}

function echo_info {
  echo -e "${GREEN}INFO: $1${NO_COLOUR}"
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
    echo_usage_error "$*" '<language>'
    return 1
  fi
  local language="$1"

  local header_regular_expression
  case "$language" in
    english)
      header_regular_expression="Title|TITLE|"
      header_regular_expression+="Chapter|CHAPTER|"
      header_regular_expression+="Section|SECTION|"
      header_regular_expression+="Annex|ANNEX"
      ;;
    french)
      header_regular_expression="Titre|TITRE|"
      header_regular_expression+="Chapitre|CHAPITRE|"
      header_regular_expression+="Section|SECTION|"
      header_regular_expression+="Annexe|ANNEXE"
      ;;
    portuguese)
      header_regular_expression="Título|TÍTULO|Titulo|TITULO|"
      header_regular_expression+="Capítulo|CAPÍTULO|Capitulo|CAPITULO|"
      header_regular_expression+="Seção|SEÇÃO|Secao|SECAO|"
      header_regular_expression+="Anexo|ANEXO"
      ;;
    spanish)
      header_regular_expression="Título|TÍTULO|Titulo|TITULO|"
      header_regular_expression+="Capítulo|CAPÍTULO|Capitulo|CAPITULO|"
      header_regular_expression+="Sección|SECCIÓN|Seccion|SECCION|"
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
    echo_usage_error "$*" '<language>'
    return 1
  fi
  local language="$1"

  local article_regular_expression
  case "$language" in
    english)
      article_regular_expression="Art\.|Article|ARTICLE"
      ;;
    french)
      article_regular_expression="Art\.|Article|ARTICLE"
      ;;
    portuguese)
      article_regular_expression="Art\.|Artigo|ARTIGO"
      ;;
    spanish)
      article_regular_expression="Art\.|Artículo|ARTÍCULO"
      ;;
    *)
      echo_error "Language $language is not supported by ${FUNCNAME[0]}."
      return 1
  esac

  echo "$article_regular_expression"
}

function get_header_and_article_regular_expression {
  if [ "$#" -ne 1 ] ; then
    echo_usage_error "$*" '<language>'
    return 1
  fi
  local language="$1"

  local header_regular_expression
  header_regular_expression="$(get_header_regular_expression $language)"
  local return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  local article_regular_expression
  article_regular_expression="$(get_article_regular_expression $language)"
  return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  local header_and_article_regular_expression="${header_regular_expression}|"
  header_and_article_regular_expression+="$article_regular_expression"

  echo "$header_and_article_regular_expression"
}

function get_ordinal_regular_expression {
  if [ "$#" -ne 1 ] ; then
    echo_usage_error "$*" '<language>'
    return 1
  fi
  local language="$1"

  local ordinal_regular_expression
  case "$language" in
    english)
      ordinal_regular_expression="First|FIRST|"
      ordinal_regular_expression+="Second|SECOND|"
      ordinal_regular_expression+="Third|THIRD|"
      ordinal_regular_expression+="Fourth|FOURTH|"
      ordinal_regular_expression+="Fifth|FIFTH|"
      ordinal_regular_expression+="Sixth|SIXTH|"
      ordinal_regular_expression+="Seventh|SEVENTH|"
      ordinal_regular_expression+="Eighth|EIGHTH|"
      ordinal_regular_expression+="Ninth|NINTH|"
      ordinal_regular_expression+="Tenth|TENTH|"
      ordinal_regular_expression+="Preliminary|PRELIMINARY"
      ;;
    french)
      ordinal_regular_expression="Premier|PREMIER|Première|PREMIÈRE|"
      ordinal_regular_expression+="Deuxième|DEUXIÈME|"
      ordinal_regular_expression+="Troisième|TROISIÈME|"
      ordinal_regular_expression+="Quatrième|QUATRIÈME|"
      ordinal_regular_expression+="Cinquième|CINQUIÈME|"
      ordinal_regular_expression+="Sixième|SIXIÈME|"
      ordinal_regular_expression+="Septième|SEPTIÈME|"
      ordinal_regular_expression+="Huitième|HUITIÈME|"
      ordinal_regular_expression+="Neuvième|NEUVIÈME|"
      ordinal_regular_expression+="Dixième|DIXIÈME|"
      ordinal_regular_expression+="Préliminaire|PRÉLIMINAIRE"
      ;;
    portuguese)
      ordinal_regular_expression="Primeir[oa]|PRIMEIR[OA]|"
      ordinal_regular_expression+="Segund[oa]|SEGUND[OA]|"
      ordinal_regular_expression+="Terceir[oa]|TERCEIR[OA]|"
      ordinal_regular_expression+="Quarto|QUARTO|"
      ordinal_regular_expression+="Quint[oa]|QUINT[OA]|"
      ordinal_regular_expression+="Sext[oa]|SEXT[OA]|"
      ordinal_regular_expression+="Sétim[oa]|SÉTIM[OA]|"
      ordinal_regular_expression+="Oitav[oa]|OITAV[OA]|"
      ordinal_regular_expression+="Non[oa]|NON[OA]|"
      ordinal_regular_expression+="Décim[oa]|DÉCIM[OA]|"
      ordinal_regular_expression+="Preliminares|PRELIMINARES"
      ;;
    spanish)
      ordinal_regular_expression="Primer[oa]|PRIMER[OA]|"
      ordinal_regular_expression+="Segund[oa]|SEGUND[OA]|"
      ordinal_regular_expression+="Tercer[oa]|TERCER[OA]|"
      ordinal_regular_expression+="Cuart[oa]|CUART[OA]|"
      ordinal_regular_expression+="Quint[oa]|QUINT[OA]|"
      ordinal_regular_expression+="Sext[oa]|SEXT[OA]|"
      ordinal_regular_expression+="Séptim[oa]|SÉPTIM[OA]|"
      ordinal_regular_expression+="Oitav[oa]|OITAV[OA]|"
      ordinal_regular_expression+="Non[oa]|NON[OA]|"
      ordinal_regular_expression+="Décim[oa]|DÉCIM[OA]|"
      ordinal_regular_expression+="Preliminar|PRELIMINAR"
      ;;
    *)
      echo_error "Language $language is not supported by ${FUNCNAME[0]}."
      return 1
  esac

  echo "$ordinal_regular_expression"
}

function get_unique_regular_expression {
  if [ "$#" -ne 1 ] ; then
    echo_usage_error "$*" '<language>'
    return 1
  fi
  local language="$1"

  local unique_regular_expression
  case "$language" in
    english)
      unique_regular_expression="Unique|UNIQUE"
      ;;
    french)
      unique_regular_expression="Unique|UNIQUE"
      ;;
    portuguese)
      unique_regular_expression="Únic[oa]|ÚNIC[OA]"
      ;;
    spanish)
      unique_regular_expression="Únic[oa]|ÚNIC[OA]"
      ;;
    *)
      echo_error "Language $language is not supported by ${FUNCNAME[0]}."
      return 1
  esac

  echo "$unique_regular_expression"
}

function get_line_prefix_regular_expression {
  if [ "$#" -ne 1 ] ; then
    echo_usage_error "$*" '<language>'
    return 1
  fi
  local language="$1"

  local header_and_article_regular_expression
  header_and_article_regular_expression="$(get_header_and_article_regular_expression $language)"
  local return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  local ordinal_regular_expression
  ordinal_regular_expression="$(get_ordinal_regular_expression $language)"
  return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  local unique_regular_expression
  unique_regular_expression="$(get_unique_regular_expression $language)"
  return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  local line_prefix_regular_expression="($header_and_article_regular_expression)"
  line_prefix_regular_expression+=" ?([0-9IVX]+|${ordinal_regular_expression}|"
  line_prefix_regular_expression+="${unique_regular_expression})"

  echo "$line_prefix_regular_expression"
}

function remove_unwanted_characters_prior_to_line_prefixes {
  local stdin="$(</dev/stdin)"

  if [ "$#" -ne 1 ] ; then
    echo_usage_error "$*" '<language>'
    return 1
  fi
  local language="$1"

  local line_prefix_regular_expression
  line_prefix_regular_expression="$(get_line_prefix_regular_expression $language)"
  local return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  local first_regular_expression="([[:alpha:]]+\.)[^[:alpha:]]+"
  first_regular_expression+="${line_prefix_regular_expression}"

  local second_regular_expression="([[:upper:]][[:alpha:]]+)[^[:alpha:],:.][^[:alpha:]]+"
  second_regular_expression+="${line_prefix_regular_expression}"

  echo "$stdin" | \
    sed -E "s/${first_regular_expression}/\1 \2 \3/g" | \
    sed -E "s/${second_regular_expression}/\1 \2 \3/g"
}

function add_newlines_before_headers_and_articles {
  local stdin="$(</dev/stdin)"

  if [ "$#" -ne 1 ] ; then
    echo_usage_error "$*" '<language>'
    return 1
  fi
  local language="$1"

  local line_prefix_regular_expression
  line_prefix_regular_expression="$(get_line_prefix_regular_expression $language)"
  local return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  local regular_expression="([[:upper:]][[:alpha:]]+|\.) ${line_prefix_regular_expression}"

  echo "$stdin" | sed -E ":start;s/${regular_expression}/\1\n\n\2 \3/;t start"
}

function get_abbreviated_ordinal_regular_expression {
  if [ "$#" -ne 1 ] ; then
    echo_usage_error "$*" '<language>'
    return 1
  fi
  local language="$1"

  local abbreviated_ordinal_regular_expression
  case "$language" in
    french)
      abbreviated_ordinal_regular_expression="([0-9IVX]+) ?(er|ER|ère|ÈRE|ème|ÈME)"
      ;;
    *)
      abbreviated_ordinal_regular_expression="([0-9IVX]+)"
      ;;
  esac

  echo "$abbreviated_ordinal_regular_expression"
}

function remove_abbreviated_ordinals_from_headers_and_articles {
  local stdin="$(</dev/stdin)"

  if [ "$#" -ne 1 ] ; then
    echo_usage_error "$*" '<language>'
    return 1
  fi
  local language="$1"

  local header_and_article_regular_expression
  header_and_article_regular_expression="$(get_header_and_article_regular_expression $language)"
  local return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  local abbreviated_ordinal_regular_expression
  abbreviated_ordinal_regular_expression="$(get_abbreviated_ordinal_regular_expression $language)"
  return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  local regular_expression="^(${header_and_article_regular_expression}) +"
  regular_expression+="${abbreviated_ordinal_regular_expression}"

  echo "$stdin" | sed -E "s/${regular_expression}/\1 \2/"
}

function replace_dashes_with_bullet_points_in_articles {
  local stdin="$(</dev/stdin)"

  if [ "$#" -ne 1 ] ; then
    echo_usage_error "$*" '<language>'
    return 1
  fi
  local language="$1"

  local article_regular_expression
  article_regular_expression="$(get_article_regular_expression $language)"
  local return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  echo "$stdin" | \
    sed -E ":start;s/^(${article_regular_expression})(.* )(-|—) /\1\2• /;t start"
}

function get_header_line_prefix_regular_expression {
  if [ "$#" -ne 1 ] ; then
    echo_usage_error "$*" '<language>'
    return 1
  fi
  local language="$1"

  local header_regular_expression
  header_regular_expression="$(get_header_regular_expression $language)"
  local return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  local ordinal_regular_expression
  ordinal_regular_expression="$(get_ordinal_regular_expression $language)"
  return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  local unique_regular_expression
  unique_regular_expression="$(get_unique_regular_expression $language)"
  return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  local header_line_prefix_regular_expression="^($header_regular_expression)"
  header_line_prefix_regular_expression+=" ?([0-9IVX]+|${ordinal_regular_expression}|"
  header_line_prefix_regular_expression+="${unique_regular_expression})(.)"

  echo "$header_line_prefix_regular_expression"
}

function add_dash_to_headers {
  local stdin=$(</dev/stdin)

  local header_line_prefix_regular_expression
  header_line_prefix_regular_expression="$(get_header_line_prefix_regular_expression $language)"
  local return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  echo "$stdin" | sed -E "s/${header_line_prefix_regular_expression}/\1 \2 -\3/"
}

function remove_space_before_colons_and_semicolons {
  sed -E 's/ (;|:)/\1/g'
}

function remove_colon_from_headers {
  local stdin=$(</dev/stdin)

  if [ "$#" -ne 1 ] ; then
    echo_usage_error "$*" '<language>'
    return 1
  fi
  local language="$1"

  local header_regular_expression
  header_regular_expression="$(get_header_regular_expression $language)"
  local return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  echo "$stdin" | sed -E "s/^(${header_regular_expression})([^-]+)(-):/\1\2\3/"
}

function replace_article_literals_with_numbers {
  local stdin=$(</dev/stdin)

  if [ "$#" -ne 1 ] ; then
    echo_usage_error "$*" '<language>'
    return 1
  fi
  local language="$1"

  local article_regular_expression
  article_regular_expression="$(get_article_regular_expression $language)"
  local return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  echo "$stdin" | sed -E "s/^(${article_regular_expression}) ([0-9]+)[^[:upper:]0-9(]+/(\2) /"
}

function wrap_list_item_leading_characters {
  sed -E 's/ ([0-9]+)[\.)]([^0-9])/ [\1]\2/g' | \
    sed -E 's/ ([a-z])[\.)](.)/ [\1]\2/g' | \
    sed -E 's/ ([ivxIVX]+)[\.)](.)/ [\1]\2/g' | \
    sed -E 's/ • / [•] /g'
}

function replace_œ_with_oe {
  sed -E 's/œ/oe/g'
}

function replace_réglement_with_règlement {
  sed -E 's/réglement/règlement/g'
}

function harmonize_quotation_marks {
  sed -E 's/(« ?| ?»)/"/g' | \
    sed -E 's/“|”/"/g' | \
    sed -E "s/‘|’/'/g"
}

function apply_common_transformations_to_stdin {
  local stdin="$(</dev/stdin)"

  if [ "$#" -ne 1 ] ; then
    echo_usage_error "$*" '<language>'
    return 1
  fi
  local language="$1"

  echo "$stdin" | \
    replace_newlines_with_spaces | \
    replace_tabs_with_spaces | \
    remove_redundant_spaces | \
    remove_unwanted_characters_prior_to_line_prefixes "$language" | \
    add_newlines_before_headers_and_articles "$language" | \
    # The replacement in remove_unwanted_characters_prior_to_line_prefixes does
    # not capture the second match in successive matches that both match the
    # same text.
    remove_unwanted_characters_prior_to_line_prefixes "$language" | \
    add_newlines_before_headers_and_articles "$language" | \
    remove_abbreviated_ordinals_from_headers_and_articles "$language" | \
    replace_dashes_with_bullet_points_in_articles "$language" | \
    add_dash_to_headers "$language" | \
    remove_space_before_colons_and_semicolons | \
    remove_colon_from_headers "$language" | \
    replace_article_literals_with_numbers "$language" | \
    wrap_list_item_leading_characters | \
    replace_œ_with_oe | \
    replace_réglement_with_règlement | \
    harmonize_quotation_marks
}

function apply_common_transformations {
  if [ "$#" -ne 2 ] ; then
    echo_usage_error "$*" '<input_file_path> <language>'
    return 1
  fi
  local input_file_path="$input_file_path"
  local language="$language"

  cat "$input_file_path" | apply_common_transformations_to_stdin "$language"
}

function amend_error_in_article {
  local stdin="$(</dev/stdin)"

  if [ "$#" -ne 3 ] ; then
    echo_usage_error "$*" '<article_number> <regular_expression> <replacement>'
    return 1
  fi
  local article_number="$1"
  local regular_expression="$2"
  local replacement="$3"
  
  echo "$stdin" | sed -E "s/^(\(${article_number}\).*)${regular_expression}/\1${replacement}/"
}

function remove_and_reinsert_article_title {
  local stdin="$(</dev/stdin)"

  if [ "$#" -ne 2 ] ; then
    echo_usage_error "$*" '<article_number> <article_title> '
    return 1
  fi
  local article_number="$1"
  local article_title="$2"

  echo "$stdin" | sed -E "s/${article_title}//" | \
    sed -E "s/^\(${article_number}\)/${article_title}\n(${article_number})/"
}

function preprocess_file {
  if [ "$#" -ne 2 ] ; then
    echo_usage_error "$*" '<input_file_path> <output_file_path>'
    return 1
  fi
  local input_file_path="$1"
  local output_file_path="$2"

  local preprocessing_output
  preprocessing_output="$(preprocess_state_and_language_input_file "$input_file_path" "$language")"
  local return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  echo "$preprocessing_output" > "$output_file_path"
}
