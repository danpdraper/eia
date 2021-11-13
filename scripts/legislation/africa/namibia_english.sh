#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^58. Short title and commencement/,$p' | \
    sed -n '/^PART I/,$p'
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

function add_newlines_before_headers {
  sed -E 's/([^^]) ?(PART [IVX]+)/\1\n\n\2 -/'
}

function remove_margin_headers {
  sed -E 's/No. 3966 Government Gazette 27 December 2007//g' | \
    sed -E 's/Act No. 7, 2007 ENVIRONMENTAL MANAGEMENT ACT, 2007//g' | \
    sed -E 's/Government Gazette 27 December 2007 No. 3966 //g' 
}

function amend_errors_in_articles {
  local stdin="$(</dev/stdin)"

  local article_35_text="Environmental Commissioner must follow the "
  article_35_text+="consultative process referred to in section 44."

  echo "$stdin" | \
    #remove incorrect bullet points
    sed -E 's/ \[•\]//g' | \
    #format subsection numbers
    sed -E 's/(subsection )\(([0-9]+)\)/\1[\2]/g' | \
    #format (a-z) to [a-z]
    sed -E 's/\(([a-z])\)/[\1]/g' | \
    #turn (1) to [1] in articles
    sed -E "s/^(\([0-9]+\).*) \(1\) /\1 [1] /" | \
    #remove page numbers
    sed -E 's/. [0-9]+  /. /g' | \
    sed -E 's/\.\././g' | \
    #remove space from dollar amounts
    sed -E 's/ 000/000/g' | \

    #Article 1
    amend_error_in_article 1 '\[1995]' '1995)' | \
    amend_error_in_article 1 '\[1977]' '1977)' | \
    amend_error_in_article 1 '\[2001]' '2001)' | \
    amend_error_in_article 1 'including\.' 'including' | \
    amend_error_in_article 1 'activity\.' 'activity;' | \
    amend_error_in_article 1 'section \[1\]' 'section 1' | \
    amend_error_in_article 1 'section 27[(]1[)]' 'section 27[1]' | \
    #Article 3
    amend_error_in_article 3 '\[2\] \[a\]' '\[2\]\[a\]' | \
    amend_error_in_article 3 ' 8' '' | \
    #Article 5
    amend_error_in_article 5 '  9' '' | \
    #Article 8
    amend_error_in_article 8 'subsections [(]4[)]' 'subsections [4]' | \
    #Article 10
    amend_error_in_article 10 'or\.' 'or' | \
    #Article 11
    sed -E 's/^(\(11\).*) Article \[12\] ([^|]+)\|\(1\)/\1\n\n\2\n(12) [1]/' | \
    #Article 15
    amend_error_in_article 15 '\[1991]' '1991)' | \
    amend_error_in_article 15 'before\.' 'before' | \
    #Article 17
    sed -E 's/^(\(17\).*) Article \[18\] ([^|]+)\|\(1\)/\1\n\n\2\n(18) [1]/' | \
    #Article 18
    amend_error_in_article 18 '\( \[2]' '[2]' | \
    amend_error_in_article 18 '\(2\)' '\[2\]' | \
    #Article 19
    amend_error_in_article 19 'To the extend that this' 'To the extent that this' | \
    amend_error_in_article 19 '\[1990]' '1990)' | \
    amend_error_in_article 19 'Sub-Article \(2\)' 'Sub-Article \[2\]' | \
    amend_error_in_article 19 '\[5\] \[a\]' '\[5\]\[a\]' | \
    amend_error_in_article 19 'and\.' 'and' | \
    amend_error_in_article 19 'and \(10\)' 'and \[10\]' | \
    #Article 20
    amend_error_in_article 20 'and\.' 'and' | \
    amend_error_in_article 20 '\[21\] \[6\]' '\[21\]\[6\]' | \
    #Article 22
    amend_error_in_article 22 'perso\.' 'person' | \
    #Article 25
    amend_error_in_article 25 'with-' 'with' | \
    #Article 26
    amend_error_in_article 26 'Enviromental Commissionr' 'Environmental Commissioner' | \
    amend_error_in_article 26 '24\(1\)' '24\[1\]' | \
    amend_error_in_article 26 'ma\.' 'may' | \
    #Article 29
    amend_error_in_article 29 'list; \[2\]' 'list\. \[2\]' | \
    amend_error_in_article 29 'in section 27\(1\)' 'in section 27\[1\]' | \
    sed -E ':start;s/^(\(29\).*)27[(]1[)] /\127[1] /;t start' | \
    #Article 30
    amend_error_in_article 30 '27\(1\)' '27\[1\]' | \
    #Article 31
    amend_error_in_article 31 ' 22' '' | \
    #Article 34
    amend_error_in_article 34 'or\.' 'or' | \
    #Article 35
    sed -E "s/^(\(35\).*)(\[4\])/\1${article_35_text} \2/" | \
    amend_error_in_article 35 '\[1\]\[b\]\(ii\)' '[1][b][ii]' | \
    #Article 36
    amend_error_in_article 36 '35\(7\)\[c\]' '35[7][c]' | \
    amend_error_in_article 36 'and\.' 'and' | \
    #Article 38
    amend_error_in_article 38 '\[37]' '37.' | \
    #Article 39
    amend_error_in_article 39 'in section \[44]' 'section 44.' | \
    amend_error_in_article 39 'initiave' 'initiative' | \
    #Article 40
    amend_error_in_article 40 'under section \[42]' 'under section 42.' | \
    #Article 42
    amend_error_in_article 42 'section \[44]' 'section 44.' | \
    amend_error_in_article 42 '\[1\] \[a\]' '\[1\]\[a\]' | \
    #Article 44
    sed -E 's/^(\(44\).*) Article \[45\] ([^|]+)\|/\1\n\n\2\n(45) /' | \
    #Article 48
    amend_error_in_article 48 'and\.' 'and' | \
    #Article 49
    amend_error_in_article 49 '\(1\)' '[1]' | \
    amend_error_in_article 49 '\[1\] \[a\]' '\[1\]\[a\]' | \
    #Article 50
    amend_error_in_article 50 'otherwise.Appeal' 'otherwise. Appeal' | \
    sed -E 's/^(\(50\).*) Article \[51\] ([^|]+)\|\(1\)/\1\n\n\2\n(51) [1]/' | \
    #Article 51
    amend_error_in_article 51 '50\(4\)' '50[4]' | \
    #Article 56
    amend_error_in_article 56 'Act\. \[l\]' 'Act; [l]' | \
    #Article 58
    amend_error_in_article 58 '________________' ''
}

function amend_errors_in_headers {
  sed -E 's/^(PART )I /\1I - /'
}

function remove_all_text_after_last_article {
  sed -E '/^\(58\)/,${/^\(58\)/!d}'
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
    add_newlines_before_headers | \
    remove_margin_headers | \
    amend_errors_in_articles | \
    amend_errors_in_headers | \
    remove_all_text_after_last_article
}
