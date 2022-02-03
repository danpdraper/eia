#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^I. In this Act/,$p'
}

function prefix_article_numbers_with_article_literal {
  sed -E 's/^([0-9]+\.)/Article \1/'
}

function replace_parentheses_around_article_delimiters_with_square_brackets {
  sed -E 's/^\(([A-Za-z0-9]+)\)/[\1]/'
}

function move_article_titles_after_article_numbers {
  sed -En '${p;q};N;/\nArticle/{s/^(.*)\n(Article [0-9]+\.) /\2 \1|/p;b};P;D'
}

function move_article_titles_above_articles {
  sed -E 's/^(\([0-9]+\) )([^|]+)\|/\2\n\1/'
}

function remove_line_numbers {
  sed -E 's/ 5 | 10 | 15 | 20 | 25 | 30 | 35 | 40 | 45 | 50 | 55 | 60/ /g' 
}

function amend_errors_in_articles {
  sed -E 's/-- /: /g' | \
    sed -E 's/- /: /g' | \
    sed -E 's/ \(([0-9]+)\)/ [\1]/g' | \
    sed -E 's/([0-9]+) (\[[0-9]+\])/\1\2/g' | \
    sed -E 's/ \(a\)/ \[a\]/g' | \
    sed -E 's/subsection \(([0-9]+)\)/subsection [\1]/g' | \
    sed -E 's/: \(/:/g' | \
    sed -E 's/I. In this Act/(1) In this Act/' | \
    sed -E 's/\( \[/[/g' | \
    sed -E 's/\[([0-9]{4})\]/\1)/g' | \
    sed -E 's/\{/(/g' | \
    sed -E 's/No.11927 GOVERNMENT GAZETTE, 9 JUNE 1989 Act No. 73, 1989 ENVIRONMENT CONSERVATION ACT, 1989//g' | \
    #Article 1
    amend_error_in_article 1 'Sections 1 2-3 4-15 16-18 19-20 21-23 24-28 29-30 31-46' ':' | \
    amend_error_in_article 1 'per~on' 'person' | \
    amend_error_in_article 1 '4 ' '' | \
    amend_error_in_article 1 '\(i\) ' '' | \
    amend_error_in_article 1 ' \(xi\)' '' | \
    amend_error_in_article 1 '\(xii\) ' '' | \
    amend_error_in_article 1 '\[xviii\] \[' '[' | \
    amend_error_in_article 1 '\(vi\) ' '' | \
    amend_error_in_article 1 '\(vii\) ' '' | \
    amend_error_in_article 1 '\(xxi\) ' '' | \
    amend_error_in_article 1 '\(viii\) ' '' | \
    amend_error_in_article 1 '\(ix\)  ' '' | \
    amend_error_in_article 1 '\(xiv\) ' '' | \
    amend_error_in_article 1 '\[xv\] \[' '[' | \
    amend_error_in_article 1 '\(xvi\) ' '' | \
    amend_error_in_article 1 '\(I\); \(iii\)' '[1];' | \
    amend_error_in_article 1 ' \(xix\)' '' | \
    amend_error_in_article 1 '\[1\] \[f\]' '[1][f]' | \
    amend_error_in_article 1 '\[2\] \[a\]' '2[a]' | \
    amend_error_in_article 1 '\(xvii\) ' '' | \
    amend_error_in_article 1 '\(v\) ' '' | \
    amend_error_in_article 1 '\(xiii\) ' '' | \
    amend_error_in_article 1 ' \(iv\)' '' | \
    amend_error_in_article 1 '\(xx\) ' '' | \
    amend_error_in_article 1 ' \(ii\)' '' | \
    amend_error_in_article 1 '23 \[1\]' '23[1]' | \
    amend_error_in_article 1 '\(x\) ' '' | \
    amend_error_in_article 1 '\(xxii\) ' '' | \
    #Article 2
    amend_error_in_article 2 ' \( 1 \)' ' [1]' | \
    amend_error_in_article 2 'll,nd' 'and' | \
    amend_error_in_article 2 '. 10 20 30 40 ' '' | \
    amend_error_in_article 2 ' 6 No.11927 GOVERNMENTGAZETIE, 9 JUNE 1989 Act No. 73, 1989 ENVIRONMENT CONSERVATION ACT, 1989' '' | \
    amend_error_in_article 2 '.the' 'the' | \
    amend_error_in_article 2 'amendthe' 'amend the' | \
    #Article 3
    amend_error_in_article 3 '\[2\]' '2.' | \
    #Article 5
    amend_error_in_article 5 '·after' 'after' | \
    #Article 6
    amend_error_in_article 6 'wh~' 'who:' | \
    amend_error_in_article 6 'or:for' 'or for' | \
    #Article 7
    amend_error_in_article 7 '1\] ' '1]' | \
    amend_error_in_article 7 '2\] ' '2]' | \
    amend_error_in_article 7 '8 No.ll927 GOVERNMENT GAZETTE, 9 JUNE 1989 Act No. 73, 1989 ENVIRONMENT CONSERVATION ACT, 1989 ' '' | \
    #Article 9
    sed -E 's/Minister 20/Minister/' | \
    #Article 10
    sed -E 's/work of council 30/work of council/' | \
    amend_error_in_article 10 'Reports by council ll.' '\n\nReports by council \n(11)' | \
    #Article 12
    amend_error_in_article 12 'No.U927 GOVERNMENT GAZETTE, 9 JUNE 1989 Act No. 73, 1989 ENVIRONMENT CONSERVATION ACT, 1989 ' '' | \
    sed -E 's/Management 45/Management/' | \
    amend_error_in_article 12 'Objects of committee l3. ' '\n\nObjects of committee \n(13) ' | \
    #Article 14
    sed -E 's/\(;onstitutio11/Constitution/' | \
    amend_error_in_article 14 'ancl' 'and' | \
    amend_error_in_article 14 'adminis: tration' 'administration' | \
    amend_error_in_article 14 'the . M' 'the M' | \
    amend_error_in_article 14 'section \(I\)' 'section 5[1]' | \
    #Article 15
    amend_error_in_article 15 "12 No.11927 GOVERNMENT GAZETI'E, 9 JUNE 1989 Act No. 73, 1989 ENVIRONMENT CONSERVATION ACT, 1989" "" | \
    amend_error_in_article 15 '53 ·' '53' | \
    amend_error_in_article 15 '\[4\] \[a\]' '[4][a]' | \
    #Article 16
    amend_error_in_article 16 ': SO' ':' | \
    amend_error_in_article 16 '14 No.l1927 GOVERNMENTGAZEITE, 9 JUNE 1989 Act No. 73, 1989 ENVIRONMENT CONSERVATION ACT, 1989 ' '' | \
    #Article 17
    amend_error_in_article 17 '16 No.11927 GOVERNMENT GAZETTE, 9 JUNE 1989 Act No. 73, 1989 ENVIRONMENT CONSERVATION ACT, 1989' '' | \
    amend_error_in_article 17 '\] \[' '][' | \
    amend_error_in_article 17 ' 16 ' ' ' | \
    amend_error_in_article 17 'manage: ment' 'management' | \
    amend_error_in_article 17 'managment' 'management' | \
    amend_error_in_article 17 'made ,with' 'made, with' | \
    amend_error_in_article 17 'within SO' 'within' | \
    #Article 18
    amend_error_in_article 18 '18 No.ll927 GOVERNMENTGAZETIE, 9 JUNE 1989 Act No. 73, 1989 ENVIRONMENT CONSERVATION ACI",l989' '' | \
    amend_error_in_article 18 'witlf' 'with' | \
    #Article 19
    amend_error_in_article 19 '~urface' 'surface' | \
    amend_error_in_article 19 'tQ' 'to' | \
    amend_error_in_article 19 '\[p\]ace&' 'places' | \
    #Article 20
    amend_error_in_article 20 'i~sued' 'issued' | \
    amend_error_in_article 20 'dispos~l' 'disposal' | \
    amend_error_in_article 20 'and .subject' 'and subject' | \
    #Article 22
    amend_error_in_article 22 '\(I\)' '[1]' | \
    amend_error_in_article 22 '\\n' 'in' | \
    amend_error_in_article 22 "days'" "30 days'" | \
    #Article 23
    sed -E 's/areas 25/areas/' | \
    amend_error_in_article 23 '\(I\)' '[1]' | \
    amend_error_in_article 23 'DirectorGeneral' 'Director General' | \
    #Article 24
    amend_error_in_article 24 '22 No.11927 GOVERNMENT GAZETTE, 9 JUNE 1989 Act No. 73, 1989 ENVIRONMENT CONSERV AT! ON ACT, 1989 ' '' | \
    amend_error_in_article 24 'section \[1\]' 'section 1' | \
    #Article 25
    amend_error_in_article 25 '·and' 'and' | \
    #Article 26
    amend_error_in_article 26 'to35' 'to:' | \
    amend_error_in_article 26 '24 ' '' | \
    amend_error_in_article 26 'affecte!l' 'affected' | \
    amend_error_in_article 26 'environ: ments' 'environments' | \
    amend_error_in_article 26 'substanti: ate' 'substantiate' | \
    amend_error_in_article 26 ';  \[b' '; [b' | \
    #Article 27
    amend_error_in_article 27 ' I 0' '' | \
    #Article 28
    amend_error_in_article 28 '; w' ';' | \
    amend_error_in_article 28 'authoricy' 'authority' | \
    amend_error_in_article 28 '\(\/\)' '[f]' | \
    amend_error_in_article 28 ' 26' '' | \
    amend_error_in_article 28 '\(i\)' '[i]' | \
    amend_error_in_article 28 'exceeding years' 'exceeding 10 years' | \
    amend_error_in_article 28 'exceeding days' 'exceeding 20 days' | \
    amend_error_in_article 28 'RlOO' 'R100' | \
    #Article 29
    sed -E 's/tine/fine/g' | \
    sed -E 's/penalities/penalties/' | \
    amend_error_in_article 29 '\(!\), \[6\]' '20[1], 20[6]' | \
    amend_error_in_article 29 'RlOO' 'R100' | \
    amend_error_in_article 29 'section \[5\]' 'section 5' | \
    amend_error_in_article 29 '\(I\) Any' '[1] Any' | \
    amend_error_in_article 29 'who.' 'who' | \
    amend_error_in_article 29 'Rl,000' 'R1,000' | \
    amend_error_in_article 29 'contravenes·' 'contravenes' | \
    amend_error_in_article 29 'exceeding years' 'exceeding 10 years' | \
    amend_error_in_article 29 'exceeding days' 'exceeding 20 days' | \
    amend_error_in_article 29 'whoafter' 'who after' | \
    #Article 30
    amend_error_in_article 30 '\(I\)' '[1]' | \
    amend_error_in_article 30 '\[2\] A declaration' ' \[2\] A declaration' | \
    amend_error_in_article 30 ' 28 No.11927 GOVERNMENTGAZETfE, 9 JUNE 1989 Act No. 73, 1989 ENVIRONMENT CONSERVATION ACT, 1989' '' | \
    amend_error_in_article 30 ' \[3\] and \[4\]' ' 35[3] and [4]' | \
    #Article 31
    sed -E 's/Powers of Minister and Administrator in case of default by local authority Article \[31\] 10\|/\n\nPowers of Minister and Administrator in case of default by local authority \n(31) /' | \
    amend_error_in_article 31 '\(1\) If' '[1] If' | \
    #Article 32
    amend_error_in_article 32 '16\[1\], 18 \[1\], 21\[1\] or23\(1\);' '16[1], 18[1], 21[1] or 23[1]; ' | \
    amend_error_in_article 32 'No.l1927 GOVERNMENT GAZETIE, 9 JUNE 1989 Act No. 73, 1989 ENVIRONMENT CONSERVATION ACT, 1989 ' '' | \
    amend_error_in_article 32 'Article \[33\] Delegation\|' '\n\nDelegation\n(33) ' | \
    #Article 33
    amend_error_in_article 33 '16\[2\], 18\[1\], 18 \[4\], 20\[5\],' '16[2], 18[1], 18[4], 20[5],' | \
    #Article 35
    amend_error_in_article 35 'var·y' 'vary' | \
    amend_error_in_article 35 'section in' 'section 20 in' | \
    #Article 36
    amend_error_in_article 36 '32 No.ll927 GOVERNMENT GAZETIE, 9 JUNE 1989 Act No. 73, 1989 ENVIRONMENT CONSERVATION ACf, 1989 ' '' | \
    amend_error_in_article 36 'Article \[37\] Restriction of liability\|' '\n\nRestriction of liability\n(37) ' | \
    #Article 38
    amend_error_in_article 38 '\(1\)' '[1]' | \
    #Article 42
    amend_error_in_article 42 'Article \[43\] ' '' | \
    amend_error_in_article 42 '\|' '\n\n(43) ' | \
    sed -E ':start;s/^(\(42\).*) section I/\1 section 1/;t start' | \
    amend_error_in_article 42 'Amendment of section 1 of Act 88' '\n\nAmendment of section 1 of Act 88' | \
    #Article 44
    amend_error_in_article 44 "34 No.11927 GOVERNMENT GAZETrE, 9 JUNE 1989 Act No. 73, 1989 ENViRONMENT CONSERVATION ACI', 1989" "" | \
    amend_error_in_article 44 '  \[' ' [' | \
    amend_error_in_article 44 'paragraph \(b\) ' 'paragraph [b] ' | \
    amend_error_in_article 44 '4\[1\] \(b\)' '4[1][b]' | \
    amend_error_in_article 44 'PlanningAct' 'Planning Act' | \
    #Article 45
    amend_error_in_article 45 '\(i\) of paragraph \(e\)' '[i] of paragraph [e]' | \
    amend_error_in_article 45 '\(i\) which' '[i] which' | \
    #Article 46
    amend_error_in_article 46 '1989\).*$' '1989.' | \
    #formatting 000s
    sed -E 's/ 000/,000/g' 
}

function amend_errors_in_headers {
  sed -E 's/([^^])PART/\1\n\nPART/g' | \
    sed -E 's/^(PART [A-Z]+)/\1 -/g' | \
    sed -E 's/AND lO BOARD/AND BOARD/' | \
    sed -E 's/CoNTROL OF ENVIRONMENTAL PoLLUTION/CONTROL OF ENVIRONMENTAL POLLUTION/' | \
    sed -E 's/FoRFEITURE/FORFEITURE/' 
}

function preprocess_state_and_language_input_file {
  if [ "$#" -ne 2 ] ; then
    echo_usage_error "$*" '<input_file_path> <language>'
    return 1
  fi
  local input_file_path="$1"
  local language="$2"

  cat "$input_file_path" | \
    remove_all_text_before_first_header | \
    prefix_article_numbers_with_article_literal | \
    replace_parentheses_around_article_delimiters_with_square_brackets | \
    move_article_titles_after_article_numbers | \
    apply_common_transformations_to_stdin "$language" | \
    move_article_titles_above_articles | \
    remove_line_numbers | \
    amend_errors_in_articles | \
    amend_errors_in_headers 
}

#/Users/matthkli/projects/eia/scripts/legislation/preprocess_legislation.sh south_africa english && cat /Users/matthkli/projects/eia/raw_data/preprocessed/africa/south_africa_english.txt