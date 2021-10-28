#!/bin/bash

function remove_all_text_before_first_header {
  sed -E 's/PART I - PRELIMINARY/\nPART I - PRELIMINARY/' | \
    sed -n '/PART I - PRELIMINARY/,$p'
}

function prefix_article_numbers_with_article_literal {
  sed -E 's/^([0-9]+\.)/Article \1/'
}

function replace_parentheses_around_article_delimiters_with_square_brackets {
  sed -E 's/^\(([A-Za-z0-9]+)\)/[\1]/' 
}

function remove_all_text_after_last_article {
  sed -E '/^\(109\)/q'
}

function amend_errors_in_headers {
  sed -E 's/PART/\n\nPART/g' | \
    sed -E 's/^(PART .*)\[•\]/\1-/' | \
    sed -n '/PART I /,$p'
}

function amend_errors_in_articles {
  sed -E 's/ \[•\]/:/g' | \
    sed -E 's/([a-z])- /\1: /g' | \
    sed -E 's/\(([a-z])\)/[\1]/g' | \
    sed -E 's/ \(([0-9])\)/ [\1]/g' | \
    sed -E 's/([0-9]+)\(([0-9]+)\)/\1[\2]/g' | \
    sed -E 's/Statute No. 4 National Environment Statute//g' | \
    sed -E 's/  1995 [0-9]+//g' | \
    #Article 2
    amend_error_in_article 2 'have become adopted;' 'have become adopted.' | \
    amend_error_in_article 2 '\[a\]crude' '[a] crude' | \
    amend_error_in_article 2 'andin' 'and in' | \
    #Article 7
    amend_error_in_article 7 'Policy Committee' '\n\nPolicy Committee' | \
    #Article 8
    amend_error_in_article 8 'meetings. THE BOARD' '\n\nTHE BOARD' | \
    amend_error_in_article 8 'Policy Committee on the environment, membership, functions and ' '' | \
    #Article 11
    amend_error_in_article 11 'STAFF OF THE AUTHORITY' '\n\nSTAFF OF THE AUTHORITY' | \
    #Article 12
    amend_error_in_article 12 'Executive Director, Deputy Executive Director.' '' | \
    #Article 13
    amend_error_in_article 13 'Functions of the Executive Director, or the Deputy Executive Director, or the Deputy Executive Director.' '' | \
    #Article 15
    amend_error_in_article 15 ':-' ':' | \
    #Article 18
    amend_error_in_article 18 'level.' '' | \
    #Article 21
    amend_error_in_article 21 'paragraph \[7\]' 'paragraph 7' | \
    #Article 34
    amend_error_in_article 34 '\[94\]' '94.' | \
    #Article 35
    amend_error_in_article 35 'Limits on the use of lakes and rivers. ' '' | \
    amend_error_in_article 35 '36-' '36:' | \
    #Article 37
    amend_error_in_article 37 'oris' 'or is' | \
    #Article 39
    amend_error_in_article 39 'if\[a\]' 'if: [a]' | \
    #Article 42
    amend_error_in_article 42 '\]-' ']:' | \
    #Article 43
    amend_error_in_article 43 '\]i' '\] i' | \
    #Article 46
    amend_error_in_article 46 'thelead' 'the lead' | \
    amend_error_in_article 46 'section \[3\]' 'section 3.' | \
    #Article 47
    amend_error_in_article 47 'section \[3\]' 'section 3.' | \
    #Article 55
    amend_error_in_article 55 'fallingunder' 'falling under' | \
    amend_error_in_article 55 '\[54\]' '54.' | \
    amend_error_in_article 55 'an offence ' 'an offence. ' | \
    #Article 56
    amend_error_in_article 56 'on\[a\]' 'on: [a]' | \
    #Article 57
    amend_error_in_article 57 'by\[a\]' 'by: [a]' | \
    #Article 61
    amend_error_in_article 61 '\]-' ']:' | \
    #Article 64
    amend_error_in_article 64 '\[4\]' '. [4]' | \
    #Article 65
    amend_error_in_article 65 'orin' 'or in' | \
    #Article 68
    amend_error_in_article 68 '\]levying' '] levying' | \
    #Article 73
    amend_error_in_article 73 '\[77\]' '77.' | \
    #Article 75
    amend_error_in_article 75 '. easement.' '.' | \
    #Article 76
    amend_error_in_article 76 ' Cap.' '' | \
    #Article 79
    amend_error_in_article 79 '\[87\]' '87.' | \
    #Article 81
    amend_error_in_article 81 'warrant\[' 'warrant: [' | \
    #Article 88
    amend_error_in_article 88 'Integration of environmental education i the school curriculum.' '' | \
    #Article 90
    amend_error_in_article 90 '91' '\n\n(91)' | \
    #Article 106
    amend_error_in_article 106 'Porfeiture, cancellation, community service and other orders. ' '' | \
    #Article 109
    amend_error_in_article 109 'Existing law.*' ''
}

function remove_and_reinsert_article_titles {
  remove_and_reinsert_article_title 1 'Short title and commencement.' | \
    remove_and_reinsert_article_title 2 'Interpretation. ' | \
    remove_and_reinsert_article_title 3 'Principles of environmental Management. ' | \
    remove_and_reinsert_article_title 4 'Rights to a decent environment. ' | \
    remove_and_reinsert_article_title 5 'Establishment of the National Environment Management Authority. ' | \
    remove_and_reinsert_article_title 6 'Powers of the Authority.' | \
    remove_and_reinsert_article_title 7 'Functions of the Authority and relationship with lead agencies and delegation. ' | \
    remove_and_reinsert_article_title 8 'Policy Committee on the environment, membership, functions and meetings. ' | \
    remove_and_reinsert_article_title 9 'Establishment of Board membership. ' | \
    remove_and_reinsert_article_title 10 'Functions and meetings of the Board. ' | \
    remove_and_reinsert_article_title 11 'Technical Committees. ' | \
    remove_and_reinsert_article_title 12 'Executive Director and Deputy Executive Director\. ' | \
    remove_and_reinsert_article_title 13 'Functions of the Executive Director and Deputy Executive Director ' | \
    remove_and_reinsert_article_title 14 'Other staff of the Authority.' | \
    remove_and_reinsert_article_title 15 'District Environment Committee\. ' | \
    remove_and_reinsert_article_title 16 'District Environment Officer. ' | \
    remove_and_reinsert_article_title 17 'Local Environment Committee\. ' | \
    remove_and_reinsert_article_title 18 'Environmental planning at national level. ' | \
    remove_and_reinsert_article_title 19 'Environmental planning at district level. ' | \
    remove_and_reinsert_article_title 20 'Environmental impact assessment\. ' | \
    remove_and_reinsert_article_title 21 'Environmental impact statement\.' | \
    remove_and_reinsert_article_title 22 'Consideration of statement by lead agency and obligation of developer.' | \
    remove_and_reinsert_article_title 23 'Environmental audit\. ' | \
    remove_and_reinsert_article_title 24 'Environmental monitoring\. ' | \
    remove_and_reinsert_article_title 25 'Air quality standards.' | \
    remove_and_reinsert_article_title 26 'Water quality standards. ' | \
    remove_and_reinsert_article_title 27 'Standards for discharge of effluent into water.' | \
    remove_and_reinsert_article_title 28 'Standards for the control of noxious smells.' | \
    remove_and_reinsert_article_title 29 'Standards for the control of noise and vibration pollution. ' | \
    remove_and_reinsert_article_title 30 'Standards for subsonic vibrations.' | \
    remove_and_reinsert_article_title 31 'Soil quality standards.' | \
    remove_and_reinsert_article_title 32 'Standards for minimization of radiation. ' | \
    remove_and_reinsert_article_title 33 'Other standards.' | \
    remove_and_reinsert_article_title 34 'Scope of Part VII.' | \
    remove_and_reinsert_article_title 35 'Limits on the uses of lakes and rivers. ' | \
    remove_and_reinsert_article_title 36 'Management of river banks and lake shores.' | \
    remove_and_reinsert_article_title 37 'Restrictions on the use of wetlands. ' | \
    remove_and_reinsert_article_title 38 'Management of wetlands.' | \
    remove_and_reinsert_article_title 39 'Identification of hilly and mountainous areas. ' | \
    remove_and_reinsert_article_title 40 'Re-forestation and afforestation of hill tops, hill sides and mountainous areas.' | \
    remove_and_reinsert_article_title 41 'Other measures for the management of hill sides, hill topes and mountainous areas. ' | \
    remove_and_reinsert_article_title 42 'Guidelines for conservation of biological diversity.' | \
    remove_and_reinsert_article_title 43 'Conservation of biological resources in-situ. ' | \
    remove_and_reinsert_article_title 44 'Conservation of biological resources ex-situ. ' | \
    remove_and_reinsert_article_title 45 'Access to genetic resources of Uganda. ' | \
    remove_and_reinsert_article_title 46 'Management of forests.' | \
    remove_and_reinsert_article_title 47 'Conservation of energy and planting of trees or woodlots. ' | \
    remove_and_reinsert_article_title 48 'Management of rangelands.' | \
    remove_and_reinsert_article_title 49 'Land use planning.' | \
    remove_and_reinsert_article_title 50 'Protection of natural heritage sites. ' | \
    remove_and_reinsert_article_title 51 'Protection of the ozone layer. ' | \
    remove_and_reinsert_article_title 52 'Management of dangerous materials and processes.' | \
    remove_and_reinsert_article_title 53 'Duty to manage and minimize waste.' | \
    remove_and_reinsert_article_title 54 'Management of hazardous waste. ' | \
    remove_and_reinsert_article_title 55 'Illegal traffic in wastes.' | \
    remove_and_reinsert_article_title 56 'Guidelines for management of toxic and hazardous chemicals and materials. ' | \
    remove_and_reinsert_article_title 57 'Prohibition of discharge of hazardous substances, chemicals and materials or oil into the environment and spillers liability. ' | \
    remove_and_reinsert_article_title 58 'Prohibition of pollution contrary to established standards.' | \
    remove_and_reinsert_article_title 59 'Pollution licenses. ' | \
    remove_and_reinsert_article_title 60 'Application for a pollution licence.' | \
    remove_and_reinsert_article_title 61 'Consideration of the application by the Committee.' | \
    remove_and_reinsert_article_title 62 'Conditions in pollution licence.' | \
    remove_and_reinsert_article_title 63 'Fees for licence.' | \
    remove_and_reinsert_article_title 64 'Renewal of pollution licence.' | \
    remove_and_reinsert_article_title 65 'Cancellation of pollution licence.' | \
    remove_and_reinsert_article_title 66 'Register of pollution licence.' | \
    remove_and_reinsert_article_title 67 'Disaster preparedness. ' | \
    remove_and_reinsert_article_title 68 'Environmental restoration orders. ' | \
    remove_and_reinsert_article_title 69 'Service of environmental restoration order. ' | \
    remove_and_reinsert_article_title 70 'Reconsideration of restoration order. ' | \
    remove_and_reinsert_article_title 71 'Action by the Authority on environmental restoration orders and environmental easements. ' | \
    remove_and_reinsert_article_title 72 'Issue of environmental restoration order by a court.' | \
    remove_and_reinsert_article_title 73 'Environmental easements. ' | \
    remove_and_reinsert_article_title 74 'Application for environmental easement.' | \
    remove_and_reinsert_article_title 75 'Enforcement of environmental easement. ' | \
    remove_and_reinsert_article_title 76 'Registration of environmental easement.' | \
    remove_and_reinsert_article_title 77 'Compensation for environmental easement. ' | \
    remove_and_reinsert_article_title 78 'Record-keeping.' | \
    remove_and_reinsert_article_title 79 'Transmission of records to the Authority.' | \
    remove_and_reinsert_article_title 80 'Designation of environmental inspectors.' | \
    remove_and_reinsert_article_title 81 'Powers and duties of environmental inspectors. ' | \
    remove_and_reinsert_article_title 82 'Procedure for taking samples for analysis.' | \
    remove_and_reinsert_article_title 83 'Designation of analytical laboratories.' | \
    remove_and_reinsert_article_title 84 'Designation of analysts and reference analysts.' | \
    remove_and_reinsert_article_title 85 'Certificate of analysis and its effect.' | \
    remove_and_reinsert_article_title 86 'Freedom to environmental information.' | \
    remove_and_reinsert_article_title 87 'Gathering, analysis and management of environmental information. ' | \
    remove_and_reinsert_article_title 88 'Integration of environmental education in the school curriculum. ' | \
    remove_and_reinsert_article_title 89 'Funds of the Authority ' | \
    remove_and_reinsert_article_title 90 'Administration of the funds. ' | \
    remove_and_reinsert_article_title 91 'Duty to operate on sound financial principles.' | \
    remove_and_reinsert_article_title 92 'Estimates.' | \
    remove_and_reinsert_article_title 93 'Accounts, audits and annual report. ' | \
    remove_and_reinsert_article_title 94 "Minister's powers in relation to taxation, Decree No.1 of Article" | \
    remove_and_reinsert_article_title 95 'Refundable performance deposit bonds. ' | \
    remove_and_reinsert_article_title 96 'Penalties relating to environmental inspectors. ' | \
    remove_and_reinsert_article_title 97 'Offences relating to impact assessment.' | \
    remove_and_reinsert_article_title 98 'Offences relating to records.' | \
    remove_and_reinsert_article_title 99 'Offences relating to environmental standards and guidelines.' | \
    remove_and_reinsert_article_title 100 'Offences relating to hazardous waste, materials, chemicals and radioactive substances.' | \
    remove_and_reinsert_article_title 101 'Offences relating to pollution.' | \
    remove_and_reinsert_article_title 102 'Offenses relating to restoration orders and easements. ' | \
    remove_and_reinsert_article_title 103 'General penalty.' | \
    remove_and_reinsert_article_title 104 'Immunity of officials.' | \
    remove_and_reinsert_article_title 105 'Appeals from decision of Authority.' | \
    remove_and_reinsert_article_title 106 'Forfeiture, cancellation, community service and other orders. ' | \
    remove_and_reinsert_article_title 107 'Conventions and treaties on environment.' | \
    remove_and_reinsert_article_title 108 'Power to make regulations.' | \
    remove_and_reinsert_article_title 109 'Existing laws. ' 
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
    apply_common_transformations_to_stdin "$language" | \
    remove_all_text_after_last_article | \
    amend_errors_in_headers | \
    amend_errors_in_articles | \
    remove_and_reinsert_article_titles
}