#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^PART ONE2/,$p'
}

function remove_footnotes {
  sed '/^I\. This Act is consolidated/d' | \
    sed '/^2\. Enacted as the/d'
}

function prefix_article_numbers_with_article_literal {
  sed -E 's/^([0-9]+\.)/Article \1/'
}

function append_pipe_to_article_title {
  sed -E 's/^(Article .*)$/\1|/'
}

function replace_parentheses_around_article_delimiters_with_square_brackets {
  sed -E 's/^\(([A-Za-z0-9]+)\)/[\1]/'
}

function move_article_titles_above_article_bodies {
  sed -E 's/^(\([0-9]+\)) ([^|]+)\|/\2\n\1/'
}

function amend_errors_in_articles {
  sed -E 's/(subsection )\(([0-9]+)\)/\1[\2]/g' | \
  sed -E 's/\(([a-z])\)/[\1]/g' | \
    # Article 2
    amend_error_in_article 2 'are, \[a' 'are: [a' | \
    amend_error_in_article 2 'environment; to co-ordinate' 'environment; [b] to coordinate' | \
    amend_error_in_article 2 'Ministry; to co-ordinate' 'Ministry; [c] to coordinate' | \
    amend_error_in_article 2 'waste; to secure' 'waste; [d] to secure' | \
    amend_error_in_article 2 '\[b\] \[c\].*\[e' '[e' | \
    amend_error_in_article 2 'Act; \[j' 'Act; [f' | \
    amend_error_in_article 2 'substances; \[I' 'substances; [i' | \
    amend_error_in_article 2 '; \(I\) \.' '; [l]' | \
    amend_error_in_article 2 '; \[0' '; [o' | \
    amend_error_in_article 2 'environ mental' environmental | \
    amend_error_in_article 2 '; \[P' '; [p' | \
    amend_error_in_article 2 're ports' reports | \
    # Article 3
    amend_error_in_article 3 ' \[Issue.*' '' | \
    # Article 4
    amend_error_in_article 4 '\(\/\)' '[f]' | \
    amend_error_in_article 4 'section have' 'section, have' | \
    # Article 7
    amend_error_in_article 7 ' \[Issue.*\[3' ' [3' | \
    amend_error_in_article 7 'an~' and | \
    amend_error_in_article 7 '" \(7\)' '[7]' | \
    # Article 8
    amend_error_in_article 8 '\[a\] \[b\]' '[a]' | \
    amend_error_in_article 8 'and \. shall' 'and [b] shall' | \
    amend_error_in_article 8 'subsection \[2\]' 'subsection [1]' | \
    # Article 9
    amend_error_in_article 9 'comprising of' comprising | \
    # Article 10
    amend_error_in_article 10 '\[Issue.*\[v\]' '[v]' | \
    # Article 11
    amend_error_in_article 11 'deter mined' determined | \
    amend_error_in_article 11 ' \. \(3\)' ' [3]' | \
    amend_error_in_article 11 ' Enforcement' '\n\nEnforcement' | \
    # Article 13
    amend_error_in_article 13 'IV-7.*\[2' '[2' | \
    # Article 14
    amend_error_in_article 14 'with, the' 'with the' | \
    # Article 15
    amend_error_in_article 15 ' National' '\n\nNational' | \
    amend_error_in_article 15 ' \[Issue.*' '' | \
    # Article 16
    amend_error_in_article 16 '\[b\] \[c\]' '[b]' | \
    amend_error_in_article 16 'and donations' 'and [c] donations' | \
    # Article 17
    amend_error_in_article 17 Moneys Monies | \
    # Article 18
    amend_error_in_article 18 moneys monies | \
    amend_error_in_article 18 'annual report' 'annual reports' | \
    # Article 19
    amend_error_in_article 19 '\[a\] \[b\] \[c\]' '[a]' | \
    amend_error_in_article 19 ', determine the allocations' ', [b] determine the allocations' | \
    amend_error_in_article 19 ', determine the annual' ', [c] determine the annual' | \
    amend_error_in_article 19 ' Administration' '\n\nAdministration' | \
    amend_error_in_article 19 ' IV-9.*' '' | \
    # Article 21
    amend_error_in_article 21 'wi constitution' 'with article 195 of the constitution' | \
    amend_error_in_article 21 '\. th article 195 of the' '.' | \
    # Article 23
    amend_error_in_article 23 '\(2\)' '[2]' | \
    # Article 24
    amend_error_in_article 24 'end " of' 'end of' | \
    # Article 25
    amend_error_in_article 25 'records of account' 'records of accounts' | \
    amend_error_in_article 25 '\[Issue.*\[3' '[3' | \
    amend_error_in_article 25 '\(6\)' '[6]' | \
    # Article 27
    amend_error_in_article 27 'Regulations, in' 'Regulations, [a]' | \
    amend_error_in_article 27 'offence; in' 'offence; [b]' | \
    amend_error_in_article 27 '\[a\] \[b\].*\[4' '[4' | \
    amend_error_in_article 27 ' Registration' '\n\nRegistration' | \
    amend_error_in_article 27 ' PART' '\n\nPART' | \
    # Article 28
    amend_error_in_article 28 "\[b\]'" '[b]' | \
    amend_error_in_article 28 'pro vided' provided | \
    amend_error_in_article 28 '\(4\)' '[4]' | \
    amend_error_in_article 28 'Article \[3\].*the relative' '[d] the relative' | \
    amend_error_in_article 28 'applications; the extent' 'applications; [e] the extent' | \
    amend_error_in_article 28 'use; the supporting' 'use; [f] the supporting' | \
    amend_error_in_article 28 'and any other matter' 'and [g] any other matter' | \
    amend_error_in_article 28 ' \[d\] \[e\] \[f\] \[g\] ' '' | \
    amend_error_in_article 28 'pre scribed' prescribed | \
    sed -E 's/Article \[29\] (Application.*)\|/\n\n\1\n(29)/' | \
    # Article 30
    amend_error_in_article 30 '28 \(3\)' '28 [3]' | \
    amend_error_in_article 30 '\.\. \. ' '' | \
    # Article 31
    amend_error_in_article 31 'and that the pesticide' 'and [b] that the pesticide' | \
    amend_error_in_article 31 '\[b\] Article' Article | \
    amend_error_in_article 31 'is satisfied that most' 'is satisfied [a] that most' | \
    amend_error_in_article 31 'and that the pesticide' 'and [b] that the pesticide' | \
    amend_error_in_article 31 '\[a\] \[b\].*it may' 'it may' | \
    sed -E 's/Article \[32\] (Provisional clearance)\|/\n\n\1\n(32)/' | \
    # Article 34
    amend_error_in_article 34 'deci sion' decision | \
    # Article 37
    amend_error_in_article 37 '\[Issue.*may by' 'may by' | \
    amend_error_in_article 37 ' The Agency shall publish.*' '' | \
    # Article 38
    amend_error_in_article 38 're cord' record | \
    # Article 39
    amend_error_in_article 39 '\[a\]' 'The Agency shall publish annually in the Gazette [a]' | \
    amend_error_in_article 39 ' Pesticides' '\n\nPesticides' | \
    # Article 44
    amend_error_in_article 44 'IV.*\[2' '[2' | \
    # Article 48
    amend_error_in_article 48 '\[Issue.*\[2' '[2' | \
    amend_error_in_article 48 '\(2\)' '[2]' | \
    # Article 50
    amend_error_in_article 50 'regis tered' registered | \
    # Article 51
    amend_error_in_article 51 '\[a\] \[b\]' '[a]' | \
    amend_error_in_article 51 'and made available' 'and [b] made available' | \
    # Article 52
    amend_error_in_article 52 'IV -17.*Article' Article | \
    amend_error_in_article 52 'Agriculture, \[j\]' 'Agriculture, [f]' | \
    amend_error_in_article 52 '\(3\)' '[3]' | \
    amend_error_in_article 52 ' Enforcement' '\n\nEnforcement' | \
    sed -E 's/Article \[53\] (The Pesticides.*)\|/\n\n\1\n(53)/' | \
    # Article 54
    amend_error_in_article 54 '\[Issue.*take samples' '[e] take samples' | \
    amend_error_in_article 54 '; monitor' '; [f] monitor' | \
    amend_error_in_article 54 '; examine' '; [g] examine' | \
    amend_error_in_article 54 '\[e\] \[j\] \[g\] ' '' | \
    # Article 56
    amend_error_in_article 56 ' IV-19.*' '' | \
    # Article 57
    amend_error_in_article 57 '28 \(2\)' '28 [2]' | \
    amend_error_in_article 57 '40 \(1\)' '40 [1]' | \
    amend_error_in_article 57 '48 \(1\)' '48 [1]' | \
    amend_error_in_article 57 '48 \(2\)' '48 [2]' | \
    amend_error_in_article 57 'or \[j\] contravenes' 'or [f] contravenes' | \
    amend_error_in_article 57 '50 \(2\)' '50 [2]' | \
    amend_error_in_article 57 ' \[Issue.*' '' | \
    # Article 60
    amend_error_in_article 60 ' Miscellaneous' '\n\nMiscellaneous' | \
    # Article 61
    amend_error_in_article 61 '\[Issue.*Article' Article | \
    sed -E 's/ Article \[62\] Regulations\|/\n\nRegulations\n(62)/' | \
    # Article 62
    amend_error_in_article 62 'generally; \[j\] the' 'generally; [f] the' | \
    amend_error_in_article 62 'No\. \[52\]' 'No. 52)' | \
    amend_error_in_article 62 'pesticides; \[j\]' 'pesticides; [f]' | \
    amend_error_in_article 62 '\[Issue.*\[j' '[j' | \
    amend_error_in_article 62 '\[0\]' '[o]' | \
    amend_error_in_article 62 '\[P\]' '[p]' | \
    # Article 63
    amend_error_in_article 63 '4 \(1\)' '4 [1]' | \
    amend_error_in_article 63 'IV .*"desiccant' '"desiccant' | \
    amend_error_in_article 63 'other wise' otherwise | \
    amend_error_in_article 63 'for \[Issue.*use as' 'for use as' | \
    amend_error_in_article 63 'premises" includes' 'premises" includes' | \
    # Article 64
    amend_error_in_article 64 'Act \[490\]' 'Act 490)' | \
    amend_error_in_article 64 'Act \[528\]' 'Act 528)' | \
    amend_error_in_article 64 '~2\)' '[2]' | \
    amend_error_in_article 64 'Act \[490\]' 'Act 490)' | \
    # Article 65
    amend_error_in_article 65 ' \[Issue.*' ''
}

function amend_errors_in_headers {
  sed -E 's/^(PART ONE)2 (Environmental Protection) (Establishment.*)/\1 - \2\n\n\3cy/' | \
    sed -E 's/^(PART TWO)/\1 -/'
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
    remove_footnotes | \
    prefix_article_numbers_with_article_literal | \
    append_pipe_to_article_title | \
    replace_parentheses_around_article_delimiters_with_square_brackets | \
    apply_common_transformations_to_stdin "$language" | \
    move_article_titles_above_article_bodies | \
    amend_errors_in_articles | \
    amend_errors_in_headers
}
