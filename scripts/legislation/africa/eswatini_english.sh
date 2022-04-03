function remove_all_text_before_first_header {
  sed -n '/^Swaziland Environment Authority/,$p' | \
    sed -n '/^PART I - INTRODUCTORY PROVISIONS/,$p' 
}

function prefix_article_numbers_with_article_literal {
  sed -E 's/^([0-9]+\.)/Article \1/'
}

function replace_parentheses_around_article_delimiters_with_square_brackets {
  sed -E 's/\(([A-Za-z0-9]+)\)/[\1]/g'
}

function move_article_titles_after_article_numbers {
  sed -En '${p;q};N;/\nArticle/{s/^(.*)\n(Article [0-9]+\.) /\2 \1|/p;b};P;D'
}

function move_article_titles_above_articles {
  sed -E 's/^(\([0-9]+\) )([^|]+)\|/\2\n\1/'
}

function remove_all_text_after_last_article {
  sed -E '/^\(90\) /,${/^\(90\)/!d}' 
}

function amend_errors_in_headers {
  sed -E 's/(PART [A-Z]+ )\[•\]/\n\n\1-/g' 
}

function amend_errors_in_articles {
  sed -E 's/ \[•\]/:/g' | \
    sed -E 's/([a-z])- /\1: /g' | \
    sed -E 's/ section \[([0-9]+)\] / section \1. /' | \
    sed -E 's/\[([0-9]+,[0-9]+)\] Emalangeni/\1 Emalangeni/g' | \
    sed -E 's/\[([0-9]+)\] Emalangeni/\1 Emalangeni/g' | \
    sed -E 's/Emalangeni \[([0-9]+,[0-9]+)\]/Emalangeni \1/g' | \
    sed -E 's/Emalangeni \[([0-9]+)\]/Emalangeni \1/g' | \
    sed -E 's/sub-section/subsection/g' | \
    #Article 2
    amend_error_in_article 2 ', "' '; "' | \
    amend_error_in_article 2 'Ministry "' 'Ministry"' | \
    amend_error_in_article 2 '. "regulations,"' '; "regulations"' | \
    amend_error_in_article 2 '; \[2\]' '. [2]' | \
    amend_error_in_article 2 'definition; "genetic resources"' 'definition, "genetic resources"' | \
    #Article 11
    amend_error_in_article 11 'Schedule \[1\]' 'Schedule 1.' | \
    #Article 15
    amend_error_in_article 15 '\[b\] work' '[d] work' | \
    #Article 32
    amend_error_in_article 32 'aim\[s\]' 'aim(s)' | \
    amend_error_in_article 32 'interest. \[e\]' 'interest.' | \
    #Article 33
    amend_error_in_article 32 'Article \[33\] Regulations\|' '\n\nRegulations\n(33) ' | \
    amend_error_in_article 33 'an environmental audit reports' 'an environmental audit report' | \
    #Article 37
    amend_error_in_article 37 'standards guidelines' 'standards, guidelines' | \
    #Article 41
    amend_error_in_article 41 'shall,on' 'shall, on' | \
    amend_error_in_article 41 '\[100,000\]' '100,000 Emalangeni' | \
    #Article 42
    amend_error_in_article 42 'be liable toto' 'be liable to' | \
    amend_error_in_article 42 'accept the surrender' 'accepts the surrender' | \
    amend_error_in_article 42 'accepts the surrender of a licence' 'accept the surrender of a licence' | \
    #Article 50
    amend_error_in_article 50 'aggregate, edited or otherwise presented' 'aggregate, edit or otherwise present' | \
    #Article 51
    amend_error_in_article 51 'natural resources' 'natural resources.' | \
    #Article 52
    amend_error_in_article 52 ',:' ':' | \
    amend_error_in_article 52 '\[s\]' '(s)' | \
    #Article 44
    amend_error_in_article 44 ' and and' ' and' | \
    #Article 63
    amend_error_in_article 63 'subsection\[3\]' 'subsection [3]' | \
    #Article 64
    amend_error_in_article 64 'resulting is' 'resulting or is' | \
    #Article 69
    amend_error_in_article 69 'shall,on' 'shall, on' | \
    amend_error_in_article 69 'management of, a body corporate' 'management of a body corporate' | \
    amend_error_in_article 69 'Emalageni' 'Emalangeni' | \
    #Article 70
    amend_error_in_article 70 'all the circumstance' 'all the circumstances' | \
    #Article 71
    amend_error_in_article 71 '\[2 years\]' '2 years' | \
    amend_error_in_article 71 '5000' '5,000' | \
    #Article 73
    amend_error_in_article 73 '\[s\]' '(s)' | \
    #Article 76
    amend_error_in_article 76 '5000' '5,000' | \
    amend_error_in_article 76 'is legal person' 'is a legal person' | \
    amend_error_in_article 76 'Inspector .' 'Inspector.' | \
    #Article 83
    amend_error_in_article 83 'review ,' 'review,' | \
    #Article 88
    amend_error_in_article 88 'in those proceeding' 'in those proceedings' | \
    #Article 89
    amend_error_in_article 89 '\[10 000\]' '10,000' 
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
    remove_all_text_after_last_article | \
    amend_errors_in_headers | \
    amend_errors_in_articles
}
