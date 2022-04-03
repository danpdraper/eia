function remove_all_text_before_first_header {
  sed -n '/^CAPÍTULO I /,$p'
}

function amend_errors_in_headers {
  sed -E 's/^(CAPÍTULO I .*) Artigo 111 \{/\1\n\n(1) (/' | \
    sed -E 's/^(CAPÍTULO II .*) Artigo G2/\1\n\n(6)/' | \
    sed -E 's/^(CAPÍTULO IV .*) Artigo 272/\1\n\n(27)/' | \
    sed -E 's/^(CAPÍTULO V .*) Artigo 33º/\1\n\n(33)/' | \
    sed -E "s/^(CAPÍTULO VI .*) Artigo 3'79/\1\n\n(37)/" | \
    sed -E 's/^(CAPÍTULO VII - )\((.*)\) Artigo 4111/\1\2\n\n(41)/' | \
    sed -E 's/^(CAPÍTULO VIII -) \./\1/' | \
    sed -E 's/^(CAPÍTULO IX .*) Artigo 50º/\1\n\n(50)/'
}

function amend_errors_in_articles {
  sed -E 's/(\[[a-z]\] )([[:upper:]])/\1\L\2/g' | \
    # Article 1
    amend_error_in_article 1 "70'1" 70 | \
    # Article 2
    sed -E 's/^\(211\)/(2)/' | \
    # Article 3
    sed -E 's/^\(32\) /(3) (/' | \
    amend_error_in_article 3 '\. \[e\] do' '; [c] do' | \
    amend_error_in_article 3 'agentes·' agentes | \
    # Article 4
    sed -E 's/^\(411\)/(4)/' | \
    amend_error_in_article 4 ' Artigo S2' '\n\n(5)' | \
    amend_error_in_article 4 'auto- -sustentado' 'auto-sustentado' | \
    amend_error_in_article 4 'I SÉRIE.*\[h\]' '[h]' | \
    amend_error_in_article 4 '\{livros' '(livros' | \
    amend_error_in_article 4 '\[e\] g' '[c] g' | \
    # Article 5
    amend_error_in_article 5 'educaç_ão' educação | \
    amend_error_in_article 5 hvres livres | \
    amend_error_in_article 5 '\[e\] u' '[c] u' | \
    amend_error_in_article 5 '\[e\] p' '[c] p' | \
    amend_error_in_article 5 '\/\)' '[f]' | \
    # Article 6
    amend_error_in_article 6 '\[e\] aágua' '[c] a água' | \
    amend_error_in_article 6 '\/\) A' '[f] a' | \
    # Article 7
    amend_error_in_article 7 '1 \(' '(' | \
    amend_error_in_article 7 ' Artigo S2' '\n\n(8)' | \
    # Article 8
    amend_error_in_article 8 afectarern afectarem | \
    amend_error_in_article 8 '334 I.*\[2\]' '[2]' | \
    # Article 9
    sed -E 's/^\(92\)/(9)/' | \
    sed -E 's/Luz e JÚveis/Luz e níveis/' | \
    amend_error_in_article 9 cidadaõs cidadãos | \
    amend_error_in_article 9 cidadaõs cidadãos | \
    amend_error_in_article 9 '\[e\]' '[c]' | \
    # Article 10
    sed -E 's/^Artigo 1\(\)11/(10)/' | \
    amend_error_in_article 10 '\[e\] mar i' '[c] mar i' | \
    amend_error_in_article 10 '\/\)' '[f]' | \
    amend_error_in_article 10 '\[e\] o' '[c] o' | \
    # Article 11
    sed -E 's/^\(1111\)/(11)/' | \
    amend_error_in_article 11 ' I SÉRIE.*$' '' | \
    # Article 12
    sed -E 's/^\(121\)/(12)/' | \
    # Article 13
    amend_error_in_article 13 'nº 1' 'número [1]' | \
    # Article 14
    amend_error_in_article 14 '\[e\] o' '[c] o' | \
    amend_error_in_article 14 'nº 1' 'número [1]' | \
    amend_error_in_article 14 'matérias- -primas' 'matérias-primas' | \
    amend_error_in_article 14 '\[e\] e' '[c] e' | \
    # Article 15
    sed -E 's/^\(152\)/(15)/' | \
    amend_error_in_article 15 isolàdos isolados | \
    amend_error_in_article 15 'regulamen- -tar' regulamentar | \
    # Article 16
    amend_error_in_article 16 '336 I.*\[3\]' '[3]' | \
    amend_error_in_article 16 autóctene autóctone | \
    amend_error_in_article 16 'ef ectivo' efectivo | \
    amend_error_in_article 16 '\[e\] c' '[c] c' | \
    amend_error_in_article 16 selvagêm selvagem | \
    amend_error_in_article 16 'óu ameaçadas' 'ou ameaçadas' | \
    # Article 17
    sed -E 's/^\(1\) 79/(17)/' | \
    amend_error_in_article 17 '\[e\] a' '[c] a' | \
    # Article 18
    sed -E 's/^\(182\)/(18)/' | \
    amend_error_in_article 18 'localização,.' 'localização,' | \
    # Article 19
    sed -E 's/^\(192\)/(19)/' | \
    amend_error_in_article 19 '\[e\] u' '[c] u' | \
    # Article 20
    amend_error_in_article 20 ' I SÉRIE.*$' '' | \
    # Article 21
    sed -E 's/^\(2111\)/(21)/' | \
    # Article 22
    sed -E 's/^\(2\) 22/(22)/' | \
    sed -E ':start;s/^(\(22\).* )ruido/\1ruído/;t start' | \
    amend_error_in_article 22 '\[e\] da r' '[c] da r' | \
    amend_error_in_article 22 'den- \. tro' dentro | \
    amend_error_in_article 22 hdmologadas homologadas | \
    amend_error_in_article 22 adaptar adoptar | \
    # Article 23
    sed -E 's/^\(2311\)/(23)/' | \
    amend_error_in_article 23 '\[e\] do' '[c] do' | \
    amend_error_in_article 23 '\[e\] normas' '[c] normas' | \
    amend_error_in_article 23 '\. \[h\]' '; [h]' | \
    # Article 24
    sed -E 's/^\(2411\)/(24)/' | \
    amend_error_in_article 24 'aplicação·' aplicação | \
    amend_error_in_article 24 '338.*1993 \[e\]' '[c]' | \
    # Article 25
    amend_error_in_article 25 'faz-se;' 'faz-se,' | \
    amend_error_in_article 25 'radio- -activo' radioactivo | \
    amend_error_in_article 25 '\[e\] do' '[c] do' | \
    # Article 26
    amend_error_in_article 26 caboverdiana 'cabo-verdiana' | \
    amend_error_in_article 26 rnicroorganismos microorganismos | \
    amend_error_in_article 26 'tornar\.' tornar | \
    amend_error_in_article 26 'n9 1' 'número [1]' | \
    # Article 27
    amend_error_in_article 27 '\[e\] o' '[c] o' | \
    amend_error_in_article 27 ' \[d\]' '; [d]' | \
    amend_error_in_article 27 efectivarnente efectivamente | \
    amend_error_in_article 27 afectarern afectarem | \
    amend_error_in_article 27 'I SÉRIE.*339 ' '' | \
    amend_error_in_article 27 '\[l\]' '[k]' | \
    amend_error_in_article 27 '\[m\]' '[l]' | \
    amend_error_in_article 27 '\[n\]' '[m]' | \
    amend_error_in_article 27 '\[o\]' '[n]' | \
    amend_error_in_article 27 '\[p\]' '[o]' | \
    amend_error_in_article 27 '\[q\]' '[p]' | \
    amend_error_in_article 27 '\[r\]' '[q]' | \
    amend_error_in_article 27 '\[s\]' '[r]' | \
    amend_error_in_article 27 '\[t\]' '[s]' | \
    # Article 28
    amend_error_in_article 28 'globai_s' globais | \
    # Article 29
    amend_error_in_article 29 'salvaguardar \.' 'salvaguardar\.' | \
    # Article 30
    sed -E 's/^\(302\)/(30)/' | \
    # Article 31
    amend_error_in_article 31 '\[e\]' '[c]' | \
    # Article 32
    sed -E 's/^\(3\) \(\(/(32) ((/' | \
    amend_error_in_article 32 "\(Equih'brio" Equilíbrio | \
    # Article 33
    amend_error_in_article 33 semprejuízo 'sem prejuízo' | \
    amend_error_in_article 33 '30º' 30 | \
    amend_error_in_article 33 '14º, nº 2' '14, número [2]' | \
    amend_error_in_article 33 'nº 1' 'número [1]' | \
    amend_error_in_article 33 ' 340.*$' '' | \
    # Article 36
    sed -E 's/^\(362\)/(36)/' | \
    # Article 38
    amend_error_in_article 38 ' Organismos' Organismos | \
    amend_error_in_article 38 'aplicação_' aplicação | \
    amend_error_in_article 38 'região \.' 'região.' | \
    # Article 39
    sed -E 's/^\(392\)/(39)/' | \
    # Article 40
    amend_error_in_article 40 '402 nº 4, -' '40 número [4], ' | \
    amend_error_in_article 40 392 39 | \
    amend_error_in_article 40 'nº 1' 'número [1]' | \
    amend_error_in_article 40 'n2 1' 'número [1]' | \
    amend_error_in_article 40 'nº \[2\] 6\.' 'número [2]. [6]' | \
    amend_error_in_article 40 'I SÉRIE.*341 ' '' | \
    amend_error_in_article 40 '\[e\] i' '[c] i' | \
    amend_error_in_article 40 '\[e\] p' '[c] p' | \
    # Article 41
    amend_error_in_article 41 ' Artigo42º' '.\n\n(42)' | \
    # Article 43
    sed -E 's/^\(4311\)/(43)/' | \
    amend_error_in_article 43 écologicamente ecologicamente | \
    # Article 44
    sed -E 's/^\(4411\)/(44)/' | \
    # Article 45
    sed -E 's/^\(4511\)/(45)/' | \
    amend_error_in_article 45 preparas preparos | \
    # Article 46
    sed -E 's/^\(4611\)/(46)/' | \
    amend_error_in_article 46 '422 e 432' '42 e 43' | \
    amend_error_in_article 46 702 70 | \
    amend_error_in_article 46 412 41 | \
    # Article 47
    sed -E 's/^\(4711\)/(47)/' | \
    amend_error_in_article 47 ' 342.*$' '' | \
    # Article 48
    amend_error_in_article 48 '\[e\] c' '[c] c' | \
    # Article 49
    sed -E 's/^\(4\) 11/(49)/' | \
    amend_error_in_article 49 'nº \[3\] 2\.' 'número [3]. [2]' | \
    # Article 51
    sed -E 's/^\(512\)/(51)/' | \
    # Article 52
    amend_error_in_article 52 ' Aprovada em 31.*$' ''
}

function move_article_titles_above_articles {
  sed -E 's/^(\([0-9]+\)) \(([^)]+)\)/\2\n\1/'
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
    amend_errors_in_headers | \
    amend_errors_in_articles | \
    move_article_titles_above_articles
}
