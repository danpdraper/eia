function append_pipe_to_article_title {
  sed -E '/^ARTIGO/{$!{N;s/(ARTIGO.*)\n(.*)/\1 \2|/;t;P;D}}'
}

function move_article_titles_above_articles {
  sed -E 's/^(\([0-9]+\)) ([^|]+)\|/\2\n\1/'
}

function remove_all_text_before_first_header {
  sed -n '/CAPÍTULO I /,$p'
}

function amend_errors_in_articles {
  sed -E ':start;s/^\(([^5]|[0-9]{2})\)(.*\[[[:lower:]]\] )([[:upper:]])/(\1)\2\L\3/;t start' | \
    # Article 3
    amend_error_in_article 3 'comparáveis\.' 'comparáveis;' | \
    amend_error_in_article 3 'eficazes\.' 'eficazes;' | \
    amend_error_in_article 3 '2 DE MARÇO DE 2011 3 ' '' | \
    amend_error_in_article 3 inicidência incidência | \
    amend_error_in_article 3 '4 \[2\]º.*N\.º 9 ' '' | \
    amend_error_in_article 3 distruição destruição | \
    amend_error_in_article 3 '. Essa' '; essa' | \
    # Article 4
    amend_error_in_article 4 equilibradoe 'equilibrado e' | \
    # Article 5
    amend_error_in_article 5 '. Incumbe' '; incumbe' | \
    amend_error_in_article 5 incluseve inclusive | \
    amend_error_in_article 5 '2 DE MARÇO DE 2011 5 ' '' | \
    amend_error_in_article 5 '. Incumbe' '; incumbe' | \
    # Article 6
    amend_error_in_article 6 atráves através | \
    amend_error_in_article 6 'a Promoção' 'a promoção' | \
    amend_error_in_article 6 construido construído | \
    amend_error_in_article 6 'dos" impactes' 'dos "impactes' | \
    amend_error_in_article 6 "''" '"' | \
    amend_error_in_article 6 "''" '"' | \
    # Article 7
    sed -E 's/^(\(7\).*) 6.*\[8\]º ([^|]+)\|( Ambientais Naturais)/\1\n\n\2\3\n(8)/' | \
    # Article 9
    amend_error_in_article 9 'activi-dades' actividades | \
    # Article 10
    amend_error_in_article 10 àguas águas | \
    # Article 11
    amend_error_in_article 11 ameaçada ameaçadas | \
    amend_error_in_article 11 portecção protecção | \
    # Article 12
    amend_error_in_article 12 áerea aérea | \
    amend_error_in_article 12 'o Regulamentação' 'o regulamentação' | \
    # Article 13
    amend_error_in_article 13 '2 DE MARÇO DE 2011 7 ' '' | \
    # Article 15
    amend_error_in_article 15 ' SECÇÃO' '\n\nSECÇÃO' | \
    # Article 18
    amend_error_in_article 18 prespectiva perspectiva | \
    amend_error_in_article 18 ' SECÇÃO' '\n\nSECÇÃO' | \
    # Article 19
    amend_error_in_article 19 'assim com' 'assim como' | \
    amend_error_in_article 19 ' SUBSECÇÃO' '\n\nSUBSECÇÃO' | \
    # Article 20
    amend_error_in_article 20 '8.*9 ' '' | \
    # Article 21
    amend_error_in_article 21 trasportados transportados | \
    # Article 22
    amend_error_in_article 22 admissíveís admissíveis | \
    # Article 23
    amend_error_in_article 23 amazenamento armazenamento | \
    # Article 24
    amend_error_in_article 24 'pron- 2 DE MARÇO DE 2011 9 tos' prontos | \
    amend_error_in_article 24 ' SUBSECÇÃO' '\n\nSUBSECÇÃO' | \
    # Article 25
    amend_error_in_article 25 ' SECÇÃO' '\n\nSECÇÃO' | \
    # Article 26
    amend_error_in_article 26 poluicão poluição | \
    # Article 27
    sed -E 's/^(Proibição de.*$)/\1 ou lixos perigosos/' | \
    amend_error_in_article 27 'ou lixos perigosos ' '' | \
    amend_error_in_article 27 perigos perigosos | \
    # Article 28
    sed -E ':start;s/^(\(28\).*\[[a-z]\] )([a-z])/\1\U\2/;t start' | \
    # Article 29
    amend_error_in_article 29 'gestão, será' 'gestão será' | \
    # Article 31
    sed -E 's/^(Áreas Protegidas.*)/\1 e Objectos Classificados/' | \
    amend_error_in_article 31 'e Objectos Classificados ' '' | \
    sed -E 's/^(\(31\).*) 10.*\[32\]º ([^|]+)\|/\1\n\n\2\n(32)/' | \
    # Article 32
    amend_error_in_article 32 "''" '"' | \
    amend_error_in_article 32 "''" '"' | \
    # Article 33
    amend_error_in_article 33 Ambiental ambiental | \
    amend_error_in_article 33 "''" '"' | \
    amend_error_in_article 33 "''" '"' | \
    # Article 34
    amend_error_in_article 34 '\[l\] estão' '[1] Estão' | \
    amend_error_in_article 34 connhecimento conhecimento | \
    # Article 42
    amend_error_in_article 42 pesssoa pessoa | \
    amend_error_in_article 42 ' 2 DE.*$' '' | \
    # Article 44
    amend_error_in_article 44 empreendidor empreendedor | \
    # Article 45
    amend_error_in_article 45 ternos termos | \
    amend_error_in_article 45 '\[238\]º e \[239\]º' '238 e 239' | \
    # Article 46
    amend_error_in_article 46 malhoria melhoria | \
    # Article 49
    amend_error_in_article 49 '\[43\]º e \[44\]º' '43 e 44' | \
    amend_error_in_article 49 '\[43\]º' 43 | \
    # Article 51
    amend_error_in_article 51 'criminal bem' 'criminal, bem' | \
    # Article 52
    sed -E 's/^(Obrigatoriedade.*)/\1 da Infracção e da Reconstituição da Situação Anterior/' | \
    amend_error_in_article 52 'da Infracção.*\[1\]' '[1]' | \
    amend_error_in_article 52 situção situação | \
    amend_error_in_article 52 '\[n\]º 3' 'número [3]' | \
    amend_error_in_article 52 '12.*9 ' '' | \
    # Article 53
    sed -E ':start;s/^(\(53\).*\[[a-z]\] )([a-z])/\1\U\2/;t start' | \
    amend_error_in_article 53 Biosegurança Biossegurança | \
    amend_error_in_article 53 Flora 'Flora).' | \
    # Article 58
    amend_error_in_article 58 ' Aprovada em 14.*$' ''
}

function amend_errors_in_headers {
  sed -E 's/^(CAPÍTULO I) -l(.*) (SECÇÃO I )/\1I -\2\n\n\3- /' | \
    sed -E 's/^(SECÇÃO II )(COMPONENTES)/\1- \2/' | \
    sed -E 's/^(SECÇÃO III )(POLUIÇÃO)/\1- \2/' | \
    sed -E 's/^(SUBSECÇÃO I )(POLUIÇÃO)/\1- \2/' | \
    sed -E 's/^(SUBSECÇÃO II )(PROIBIÇÃO)/\1- \2/' | \
    sed -E 's/^(SECÇÃO IV )(OFENSAS)/\1- \2/' | \
    sed -E 's/^(CAPÍTULO III.*)POLíTICA/\1POLÍTICA/'
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
    move_article_titles_above_articles | \
    remove_all_text_before_first_header | \
    amend_errors_in_articles | \
    amend_errors_in_headers
}
