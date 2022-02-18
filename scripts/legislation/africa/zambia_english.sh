#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^13 of 1994/,$p' | \
    sed -n '/PART I/,$p'
}

function prefix_article_numbers_with_article_literal {
  sed -E 's/^([0-9]+\.)/Article \1/'
}

function replace_parentheses_around_article_delimiters_with_square_brackets {
  sed -E 's/\(([A-Za-z0-9]+)\)/[\1]/g' 
}

function remove_all_text_after_last_article {
  sed -z 's/Regulations SUBSIDIARY LEGISLATION.*$//' 
}

function format_article_numbers {
  sed -E 's/Article \[([0-9]+)\]/\n\n(\1)/g' 
}

function remove_and_reinsert_article_titles {
  remove_and_reinsert_article_title 1 'Short title' | \
    remove_and_reinsert_article_title 2 'Interpretation ' | \
    remove_and_reinsert_article_title 3 'Establishment of Environmental Council' | \
    remove_and_reinsert_article_title 4 'Composition of Council ' | \
    remove_and_reinsert_article_title 5 'Tenure of office and vacancies ' | \
    remove_and_reinsert_article_title 6 'Functions of Council ' | \
    remove_and_reinsert_article_title 7 'Proceedings of Council ' | \
    remove_and_reinsert_article_title 8 'Seal of Council ' | \
    remove_and_reinsert_article_title 9 'Committee of Council ' | \
    remove_and_reinsert_article_title 10 'Disclosure of interest ' | \
    remove_and_reinsert_article_title 11 'Immunity of members' | \
    remove_and_reinsert_article_title 12 'Prohibition of publication or disclosure of information to unauthorised persons ' | \
    remove_and_reinsert_article_title 13 'Remuneration of member of Council' | \
    remove_and_reinsert_article_title 14 'Funds of Council ' | \
    remove_and_reinsert_article_title 15 'Investment of funds' | \
    remove_and_reinsert_article_title 16 'Financial year' | \
    remove_and_reinsert_article_title 17 'Accounts' | \
    remove_and_reinsert_article_title 18 'Annual report ' | \
    remove_and_reinsert_article_title 19 'Director and Deputy Director ' | \
    remove_and_reinsert_article_title 20 'Secretary and other staff ' | \
    remove_and_reinsert_article_title 23 'Responsibilities of Council' | \
    remove_and_reinsert_article_title 24 'Prohibition of water pollution' | \
    remove_and_reinsert_article_title 25 'Duty to supply information to Inspectorate ' | \
    remove_and_reinsert_article_title 26 'Permission to discharge effluent into sewage system' | \
    remove_and_reinsert_article_title 27 'Conditions for acceptance of effluent ' | \
    remove_and_reinsert_article_title 28 'Offence relating to effluent' | \
    remove_and_reinsert_article_title 29 'Treatment of effluent ' | \
    remove_and_reinsert_article_title 30 'Licence to discharge effluent ' | \
    remove_and_reinsert_article_title 31 'Application for licence for new undertaking etc., likely to discharge effluent ' | \
    remove_and_reinsert_article_title 32 'Circumstances under which extension deemed new' | \
    remove_and_reinsert_article_title 33 'Grant or refusal of licences ' | \
    remove_and_reinsert_article_title 34 'Contents of application and conditions of licence' | \
    remove_and_reinsert_article_title 37 'Controlled areas ' | \
    remove_and_reinsert_article_title 38 'Emission standards' | \
    remove_and_reinsert_article_title 39 'Air pollution prohibited' | \
    remove_and_reinsert_article_title 40 'Emergency situations ' | \
    remove_and_reinsert_article_title 41 'Information regarding emissions into ambient air' | \
    remove_and_reinsert_article_title 42 'Licensing of emissions' | \
    remove_and_reinsert_article_title 43 'Application for licence for new sources of emission ' | \
    remove_and_reinsert_article_title 46 'Contents of application and conditions for licence' | \
    remove_and_reinsert_article_title 48 "Control of local authorities' Cap. 281" | \
    remove_and_reinsert_article_title 50 'Prohibition against disposal of waste ' | \
    remove_and_reinsert_article_title 51 'Licences ' | \
    remove_and_reinsert_article_title 53 'Application for licence for existing disposal site or plant' | \
    remove_and_reinsert_article_title 55 'Cessation of activity relating to hazardous waste' | \
    remove_and_reinsert_article_title 56 'Import, export and transportation of hazardous waste' | \
    remove_and_reinsert_article_title 59 'Application for registration of new or reprocessed pesticide or toxic substance ' | \
    remove_and_reinsert_article_title 60 'Application for registration of pesticide or toxic substance in use before commencement of Act ' | \
    remove_and_reinsert_article_title 61 'Information required for, and period of registration ' | \
    remove_and_reinsert_article_title 62 'Registration ' | \
    remove_and_reinsert_article_title 63 'Contents of application and conditions for registration' | \
    remove_and_reinsert_article_title 64 'Offences relating to pesticides and toxic substances ' | \
    remove_and_reinsert_article_title 65 'Seizure of pesticides and toxic substances ' | \
    remove_and_reinsert_article_title 68 'Noise emission in excess of established standards prohibited' | \
    remove_and_reinsert_article_title 69 'Exemption ' | \
    remove_and_reinsert_article_title 70 'Publication of noise pollution control standards and guidelines' | \
    remove_and_reinsert_article_title 73 'Powers of inspectors relating to ionising radiation ' | \
    remove_and_reinsert_article_title 74 'Offences relating to ionising radiation ' | \
    remove_and_reinsert_article_title 77 'Rehabilitation works ' | \
    remove_and_reinsert_article_title 78 'Powers of inspectors relating to natural resources' | \
    remove_and_reinsert_article_title 79 'Repeal of certain Parts of Cap. 156 of old edition' | \
    remove_and_reinsert_article_title 80 'Savings' | \
    remove_and_reinsert_article_title 81 'Establishment of Inspectorate' | \
    remove_and_reinsert_article_title 82 'Delegation of duties to Inspectorate' | \
    remove_and_reinsert_article_title 83 'Appointment of inspectors ' | \
    remove_and_reinsert_article_title 85 'Obstruction of Inspector ' | \
    remove_and_reinsert_article_title 86 'Duty to report pollution ' | \
    remove_and_reinsert_article_title 87 'Secrecy' | \
    remove_and_reinsert_article_title 88 'Renewal of licence ' | \
    remove_and_reinsert_article_title 89 'Inspector may request application for licence' | \
    remove_and_reinsert_article_title 90 'Pollutor obligations ' | \
    remove_and_reinsert_article_title 91 'Offences and penalties ' | \
    remove_and_reinsert_article_title 92 'Applications for licences to be made to Inspectorate or local authority ' | \
    remove_and_reinsert_article_title 93 'Grant of licence permit subject to public representation ' | \
    remove_and_reinsert_article_title 94 'Cessation of licences' | \
    remove_and_reinsert_article_title 95 'Appeals ' 
}

function amend_errors_in_articles { 
  sed -E 's/ The Laws of Zambia Copyright Ministry of Legal Affairs, Government of the Republic of Zambia//g' | \
    sed -E 's/- /: /g' | \
    sed -E 's/ 1\]/ [1]/g' | \
    sed -E 's/\(As amended.*$//g' | \
    sed -E 's/instal /install /g' | \
    sed -E 's/inspectorate/Inspectorate/g' | \
    #Article 6
    amend_error_in_article 6 'consider and advise, on' 'consider and advise on' | \
    #Article 7
    amend_error_in_article 7 'writing: Provided' 'writing, provided' | \
    #Article 21
    amend_error_in_article 21 'Standing Technical Advisory Committee \[2' '[2' | \
    sed -E 's/\(21\)/Standing Technical Advisory Committee\n(21)/' | \
    #Article 22
    sed -E 's/\(22\)/Interpretation\n(22)/' | \
    #Article 32
    amend_error_in_article 32 'extention' 'extension' | \
    #Article 33
    amend_error_in_article 33 'of\[' 'of: [' | \
    amend_error_in_article 33 'Inspectorate, may' 'Inspectorate may' | \
    #Article 35
    sed -E 's/\(35\)/Interpretation\n(35)/' | \
    amend_error_in_article 35 'source "licence"' 'source; "licence"' | \
    #Article 36
    sed -E 's/\(36\)/Responsibilities of Council\n(36)/' | \
    #Article 38
    amend_error_in_article 38 'consider \[a\]' 'consider: [a]' | \
    #Article 44
    sed -E 's/\(44\)/Circumstances under which extension deemed new\n(44)/' | \
    amend_error_in_article 44 'change \[a\]' 'change: [a]' | \
    #Article 45
    sed -E 's/\(45\)/Grant or refusal of licences\n(45)/' | \
    amend_error_in_article 45 'of\[' 'of: [' | \
    #Article 47
    sed -E 's/\(47\)/Interpretation\n(46)/' | \
    #Article 49
    sed -E 's/\(49\)/Responsibilities of Council\n(49)/' | \
    #Article 52
    amend_error_in_article 52 'Application for licence' '' | \
    sed -E 's/\(52\)/Application for licence\n(52)/' | \
    #Article 54
    sed -E 's/\(54\)/Contents of application and conditions for licence\n(54)/' | \
    #Article 56
    amend_error_in_article 56 'Zambia.  ' 'Zambia. ' | \
    #Article 57
    sed -E 's/\(57\)/Interpretation\n(57)/' | \
    #Article 58
    sed -E 's/\(58\)/Responsibilities of Council\n(58)/' | \
    #Article 60
    amend_error_in_article 60 'Inspectorate assess' 'Inspectorate to assess' | \
    #Article 66
    sed -E 's/\(66\)/Interpretation\n(66)/' | \
    #Article 67
    sed -E 's/\(67\)/Responsibilities of Council\n(67/' | \
    #Article 71
    sed -E 's/\(71\)/Interpretation\n(71)/' | \
    amend_error_in_article 71 'functions.' 'functions;' | \
    #Article 72
    sed -E 's/\(72\)/Responsibilities of Council\n(72)/' | \
    amend_error_in_article 72 '. Cap. 311 Cap.' '' | \
    amend_error_in_article 72 'programme and advice on' 'programme and advise on' | \
    #Article 73
    amend_error_in_article 73 'Cap.' '' | \
    #Article 74
    amend_error_in_article 74 'Cap. 311 ' '' | \
    #Article 75
    sed -E 's/\(75\)/Interpretation\n(75)/' | \
    #Article 76
    sed -E 's/\(76\)/Responsibilities of Council\n(76)/' | \
    #Article 77
    amend_error_in_article 77 'contamin-ation' 'contamination' | \
    #Article 84
    amend_error_in_article 84 'Powers of inspectors ' '' | \
    sed -E 's/\(84\)/Powers of inspectors\n(84)/' | \
    amend_error_in_article 84 'enquiry collection of samples' 'enquiry, collection of samples' | \
    #Article 95
    amend_error_in_article 95 'after the receiving' 'after receiving' | \
    #Article 96 
    sed -E 's/\(96\)/Regulations\n(96)/'
}

function amend_errors_in_headers {
  sed -E 's/([^^])PART/\1\n\nPART/g' | \
    sed -E 's/^(PART [A-Z]+)/\1 -/g' | \
    sed -z 's/\n\nPART IX -,/PART IX,/' | \
    sed -z 's/Interpretation\n(75)/PART X - NATURAL RESOURCES CONSERVATION\n\nInterpretation\n(75)/' 
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
    format_article_numbers | \
    remove_and_reinsert_article_titles | \
    amend_errors_in_articles | \
    amend_errors_in_headers 
}