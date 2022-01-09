#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^\[Date of commencement/,$p' | \
    sed -n '/^PART I/,$p'
}

function prefix_article_numbers_with_article_literal {
  sed -E 's/^([0-9]+)/Article \1/' 
}

function append_pipe_to_article_title {
  sed -E 's/^(Article .*)$/\1|/' 
}

function replace_parentheses_around_article_delimiters_with_square_brackets {
  sed -E 's/\(([A-Za-z0-9]+)\)/[\1]/g' 
}

function move_article_titles_above_article_bodies {
  sed -E 's/^(\([0-9]+\)) ([^|]+)\|/\2\n\1/'
}

function remove_all_text_after_last_article {
  sed -E '/^\(146\)/q'
}

function fix_chapter_reference_formatting { 
  sed -z 's/\n\nChapter/ [Chapter/g' | \
    sed -E 's/(Chapter [0-9]+) -/\1:/g'
}

function amend_errors_in_headers {
  sed -E 's/([^^])(PART)/\1\n\n\2/g' | \
    sed -E 's/OFMINISTER/OF MINISTER/' | \
    sed -E 's/^(PART [A-Z]+)/\1 -/g' | \
    sed -E 's/ENVIRONMENTALIMPACT/ENVIRONMENTAL IMPACT/' 
}

function amend_errors_in_articles {
  sed -E 's/—/:/g' | \
    #Article 4
    amend_error_in_article 4 'sustainable. ' 'sustainable; ' | \
    #Article 5
    amend_error_in_article 5 'co -ordinate' 'co-ordinate' | \
    amend_error_in_article 5 'natu ral' 'natural' | \
    #Article 7
    amend_error_in_article 7 '\[s\]' 's.' | \
    amend_error_in_article 7 'co -opted' 'co-opted' | \
    #Article 10
    amend_error_in_article 10 'environmental where' 'environment where' | \
    #Article 14
    amend_error_in_article 14 're -appointment' 're-appointment' | \
    #Article 15
    amend_error_in_article 15 "days'" "days" | \
    #Article 28
    amend_error_in_article 28 '\[3\]' ' [3]' | \
    #Article 35
    amend_error_in_article 35 'DirectorGeneral' 'Director-General' | \
    #Article 46
    amend_error_in_article 46 'Auditor -General' 'Auditor-General' | \
    #Article 60
    amend_error_in_article 60 'twentyone' 'twenty one' | \
    #Article 63
    amend_error_in_article 63 'air quality standards. ' 'air quality standards; ' | \
    #Article 68
    sed -z 's/\n\nSection 356 -/ [5] Section 356/g' | \
    amend_error_in_article 68 'subsection\[4\]' 'subsection [4]' | \
    #Article 73
    amend_error_in_article 73 'te rms' 'terms' | \
    amend_error_in_article 73 'seventytwo' 'seventy two' | \
    amend_error_in_article 73 'may be determined court ' 'may be determined by court ' | \
    #Article 84-86
    sed -z 's/\n86 …..//' | \
    sed -E 's/\(84\)/84 - 86.../' | \
    #Article 88
    amend_error_in_article 88 'environme nt' 'environment' | \
    amend_error_in_article 88 're -use' 're-use' | \
    #Article 98 
    amend_error_in_article 98 'Director -General' 'Director-General' | \
    #Article 109
    sed -z 's/\n\n(20) 10] shall apply, mutatis mutandis, in relation to the acquisition.//' | \
    amend_error_in_article 109 '\[Chapter' '[Chapter 20:10] shall apply, mutatis mutandis, in relation to the acquisition.' | \
    #Article 114
    amend_error_in_article 114 'Part \[XIV\]' 'Part XIV.' | \
    #Article 119
    amend_error_in_article 119 'or or' 'or' | \
    sed -E ':start;s/^(\(119\).*)subsection\[/\1 subsection \[/;t start' | \
    #Article 136
    amend_error_in_article 136 'DirectorGeneral' 'Director-General' | \
    #Article 138
    amend_error_in_article 138 'a in vasive' 'an invasive' | \
    #Article 143
    sed -E 's/Article 143 Repeal of Cap 20:13 and savings\|/Repeal of Cap 20:13 and savings\n(143)/' | \
    amend_error_in_article 145 '\[Pensions\]' '(Pensions)' | \
    #Article 144
    amend_error_in_article 144 '\[Subsection inserted' '\n\n[Subsection inserted' | \
    #Article 145
    sed -E 's/Article 145 Transfer of certain assets, obligations, etc\., of State to Agency\|/\n\nTransfer of certain assets, obligations, etc., of State to Agency\n(145)/' | \
    #Article 146
    amend_error_in_article 146 'FIRST SCHEDULE' ''
}

function format_amendments {
  sed -E 's/\[Subsection amended by section 28 of At 6 of 2005\] /\n\n[Subsection amended by section 28 of Act 6 of 2005]\n\n/' | \
    sed -E 's/\[Subsection amended by section 28 of Act 6 of 2005\] /\n\n[Subsection amended by section 28 of Act 6 of 2005]\n\n/' | \
    sed -E 's/\[Paragraph amended by section 28 of At 6 of 2005\] /\n\n[Paragraph amended by section 28 of Act 6 of 2005]\n\n/' | \
    sed -E 's/\[Paragraph amended, Act 6 of 2005, s. 28\] /\n\n[Paragraph amended, Act 6 of 2005, s. 28]\n\n/' 
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
    append_pipe_to_article_title | \
    replace_parentheses_around_article_delimiters_with_square_brackets | \
    apply_common_transformations_to_stdin "$language" | \
    move_article_titles_above_article_bodies | \
    remove_all_text_after_last_article | \
    fix_chapter_reference_formatting | \
    amend_errors_in_headers | \
    amend_errors_in_articles | \
    format_amendments
}