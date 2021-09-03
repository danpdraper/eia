#!/bin/bash

function append_pipe_to_article_title {
  tr '\n' '\r' | sed -E 's/(Artigo[^\r]+\r)([^\r]+)/\1\2|/g' | tr '\r' '\n'
}

function remove_all_text_before_first_header {
  sed -E 's/ (DISPOSIÇÕES GERAIS)/\n\1/' | \
    sed -n '/^DISPOSIÇÕES GERAIS/,$p'
}

function move_article_titles_above_article_bodies {
  sed -E 's/^(\([0-9]+\)) ([^|]+)\|/\2\n\1/'
}

function amend_errors_in_headers {
  sed -E 's/^Cap[ií]tulo(.*) Artigo \[([0-9]+)\]º ([^|]+)\|/Capítulo\1\n\n\3\n(\2)/' | \
    sed -E 's/^Capitulo/Capítulo/' | \
    sed -E 's/^(Capítulo )VI( - Disposições Finais)/\1XI\2/'
}

function amend_errors_in_articles {
  local stdin="$(</dev/stdin)"

  local missing_article_50_text="$(echo "$stdin" | grep '^A CNA')"

  echo "$stdin" | \
    sed -E 's/^Principio/Princípio/' | \
    # Article 8
    amend_error_in_article 8 protegêlos 'protegê-los' | \
    # Article 9
    amend_error_in_article 9 'sustentável \[2\]' 'sustentável. [2]' | \
    # Article 10
    amend_error_in_article 10 bemestar 'bem-estar' | \
    # Article 11
    sed -E 's/^(Princípio do utilizador-) (pagador)/\1\2/' | \
    # Article 16
    sed -E ':start;s/^(\(16\).*\[[0-9]+\])([A-Z])/\1 \2/;t start' | \
    amend_error_in_article 16 '; Capitulo IV Conceitos' '.\n\nCapítulo IV - Conceitos' | \
    # Article 23
    amend_error_in_article 23 terrestre terrestres | \
    # Article 27
    amend_error_in_article 27 'fauna\.' 'fauna;' | \
    # Article 33
    amend_error_in_article 33 'designadamente\.' 'designadamente:' | \
    # Article 34
    amend_error_in_article 34 substancias substâncias | \
    # Article 41
    amend_error_in_article 41 armazenado armazenados | \
    # Article 43
    amend_error_in_article 43 'eles, \[q\]' 'eles; [q]' | \
    # Article 45
    amend_error_in_article 45 ', \[d\]' '. [d]' | \
    amend_error_in_article 45 'afectadas;' 'afectadas.' | \
    # Article 49
    amend_error_in_article 49 'ambiente\. \[d\]' 'ambiente; [d]' | \
    # Article 50
    sed '/^A CNA/d' | \
    sed -E "s/^(\(50\) )/\1${missing_article_50_text}/" | \
    amend_error_in_article 50 pelasseguintes 'pelas seguintes' | \
    amend_error_in_article 50 Industria Indústria | \
    amend_error_in_article 50 'sindicais;' 'sindicais; [e]' | \
    amend_error_in_article 50 'ambiente;' 'ambiente.' | \
    amend_error_in_article 50 representares representantes | \
    # Article 52
    amend_error_in_article 52 'Ministro \[3\]' 'Ministro. [3]' | \
    # Article 53
    amend_error_in_article 53 'próprio \[2\]' 'próprio. [2]' | \
    # Article 55
    amend_error_in_article 55 'da utilidade' 'de utilidade' | \
    # Article 58
    sed -E 's/^\((Seguro de responsabilidade civil)\)/\1/' | \
    # Article 59
    sed -E 's/^\((Acesso à justiça)\)/\1/' | \
    # Article 62
    amend_error_in_article 62 cientifico científico | \
    amend_error_in_article 62 'marinhos, \[f\]' 'marinhos; [f]' | \
    amend_error_in_article 62 pais país | \
    # Article 65
    amend_error_in_article 65 '49º a61º' '49 a 61' | \
    amend_error_in_article 65 'DecretoLei n' 'Decreto-Lei número' | \
    # Article 66
    sed -E 's/^(\(66\)) (.*) (Os diplomas)/\2\n\1 \3/' | \
    amend_error_in_article 66 obrigatóriamente obrigatoriamente | \
    # Article 67
    sed -E 's/\. Assembleia.*$/./'
}

function preprocess_state_and_language_input_file {
  if [ "$#" -ne 2 ] ; then
    echo_usage_error "$*" '<input_file_path> <language>'
    return 1
  fi
  local input_file_path="$1"
  local language="$2"

  cat "$input_file_path" | \
    append_pipe_to_article_title | \
    apply_common_transformations_to_stdin "$language" | \
    remove_all_text_before_first_header | \
    move_article_titles_above_article_bodies | \
    amend_errors_in_headers | \
    amend_errors_in_articles
}
