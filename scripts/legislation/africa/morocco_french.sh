#!/bin/bash

function remove_all_text_before_first_chapter_header {
  sed -E 's/ (Chapitre Premier): (Dispositions générales)/\n\1 - \2/' | \
  sed -n '/^Chapitre Premier /,$p'
}

function remove_all_text_after_last_article {
  sed -E '/^\(79\)/q'
}

function amend_errors_in_headers {
  sed -E 's/^(Section [0-9]+ - [A-Za-z,’ ]+)[^a-z]+Article ([0-9]+)(er)?/\1\n\n(\2)/' | \
    sed -E 's/Section Première:/\n\nSection Première -/' | \
    sed -E 's/Article Premier:/\n\n(1)/' | \
    sed -E 's/^(Chapitre )I -l:/\1II -/' | \
    sed -E 's/^(Section )I -l:/\1II -/' | \

    #identify articles preceded by sections
    sed -E 's/^(Section 2 - Définitions.*) Article 3:/\1\n\n(3) /' | \
    sed -E 's/^(Section Première - Les établissements.*) Article 4:/\1\n\n(4) /' | \
    sed -E 's/^(Section II - Le patrimoine.*) Article 8:/\1\n\n(8) /' | \
    sed -E 's/^(Section III - Les installations.*) Article 9:/\1\n\n(9) /' | \
    sed -E 's/^(Section Première - Le sol.*) Article 17:/\1\n\n(17) /' | \
    sed -E 's/^(Section II - La faune.*) Article 20:/\1\n\n(20) /' | \
    sed -E 's/^(Section III - Les eaux.*) Article 27:/\1\n\n(27) /' | \
    sed -E 's/^(Section IV.*) Article 30:/\1\n\n(30) /' | \
    sed -E 's/^(Section V - Les espaces.*) Article 33:/\1\n\n(33) /' | \
    sed -E 's/^(Section VI - Les campagnes.*) Article 37:/\1\n\n(37) /' | \
    sed -E 's/^(Section VI - Les aires.*) Article 38:/\1\n\n(38) /' | \
    sed -E 's/^(Section Première - Les déchets.*) Article 41:/\1\n\n(41) /' | \
    sed -E 's/^(Section II - Rejets liquides.*) Article 43:/\1\n\n(43) /' | \
    sed -E 's/^(Section III - Les substances.*) Article 45:/\1\n\n(45) /' | \
    sed -E 's/^(Section IV - Les nuisances.*) Article 47:/\1\n\n(47) /' | \
    sed -E 's/^(Section Première - Les études.*) Article 49:/\1\n\n(49) /' | \
    sed -E 's/^(Section II - Les plans.*) Article 51:/\1\n\n(51) /' | \
    sed -E 's/^(Section III - Les normes.*) Article 54:/\1\n\n(54) /' | \
    sed -E 's/^(Section IV - Les incitations.*) Article 58:/\1\n\n(58) /' | \
    sed -E 's/^(Section V - Fonds national.*) Article 60:/\1\n\n(60) /' | \
    sed -E 's/^(Section Première - Le régime.*) Article 63:/\1\n\n(63) /' | \
    sed -E 's/^(Section II - La remise.*) Article 69:/\1\n\n(69) /' | \
    sed -E 's/^(Section III - La procédure.*) Article 73:/\1\n\n(73) /' | \
    sed -E 's/^(Section IV - La procédure.*) Article 76:/\1\n\n(76) /' 

}

function amend_errors_in_articles {
  amend_error_in_article 3 '\* - Dahir.*Etablissements humains' 'Établissements humains' | \
  amend_error_in_article 3 '4 - Equilibre' '4 - Équilibre' | \
  amend_error_in_article 34 'les critères nécessaires' '[•] les critères nécessaires' | \

  #remove page numbers
  amend_error_in_article 3 'mer. 3' 'mer. ' | \
  amend_error_in_article 7 ' 4' '' | \
  amend_error_in_article 37 ' 7' '' | \
  amend_error_in_article 79 ' 12' '' | \

  #fix spacing
  amend_error_in_article 2 " l'usager payeur " "l'usager payeur" | \
  amend_error_in_article 2 " du pollueur payeur " "du pollueur payeur" | \

  #change dashes to bullet points
  sed -E ':start;s/^(\(1\).*)- /\1[•] /;t start' | \
  sed -E ':start;s/^(\(36\).*)- /\1 [•] /;t start' | \
  sed -E ':start;s/^(\(37\).*) - /\1 [•] /;t start' | \

  #article 3 numbering removal
  sed -E ':start;s/^(\(3\).*)[0-9] - /\1/;t start' | \
  sed -E ':start;s/^(\(3\).*)[0-9]/\1/;t start'
}

function preprocess_state_and_language_input_file {
  if [ "$#" -ne 2 ] ; then
    echo_usage_error "$*" '<input_file_path> <language>'
    return 1
  fi
  local input_file_path="$1"
  local language="$2"

  cat "$input_file_path" | \
    apply_common_transformations_to_stdin "$language" | \
    remove_all_text_before_first_chapter_header | \
    remove_all_text_after_last_article | \
    amend_errors_in_headers | \
    amend_errors_in_articles 
}




 
#/Users/matthkli/projects/eia/scripts/legislation/preprocess_legislation.sh morocco french && cat /Users/matthkli/projects/eia/raw_data/preprocessed/africa/morocco_french.txt
