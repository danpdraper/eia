#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^ ENACTED by the Parliament of Malawi as follows/,$p' | \
    sed -n '/^ PART I -/,$p'
}

function prefix_article_numbers_with_article_literal {
  sed -E 's/^([0-9]+\.)/Article \1/'
}

function replace_parentheses_around_article_delimiters_with_square_brackets {
  sed -E 's/\(([A-Za-z0-9]+)\)/[\1]/g' 
}

function amend_errors_in_headers {
  sed -E 's/([^^])PART/\1\n\nPART/g' | \
    sed -E 's/^(PART .*)\[•\]/\1-/' | \
    sed -n '/PART I /,$p' | \
    sed -E 's/III \[•\]/III -/' | \
    sed -E 's/Projects for which an environmen tal impact assessment is required //' 
}

function format_article_literals {
  sed -E 's/Article \[([0-9]+)\] \[•\]/\n\n(\1)/g' | \
    sed -E 's/\[([0-9]+)\] \[•\]/\n\n(\1)/g' 
}

function amend_article_numbering {
  sed -E 's/\(16\)/(17)/' | \
    sed -E 's/\(15\)/(16)/' | \
    sed -E 's/\(14\)/(15)/' | \
    sed -E 's/\(13\)/(14)/' | \
    sed -E 's/\(12\)/(13)/' | \
    sed -E 's/\(11\)/(12)/' | \
    sed -E 's/\(10\)/(11)/' | \
    sed -E 's/\(9\)/(10)/' | \
    sed -E 's/\(8\)/(9)/' | \
    sed -E 's/\(7\)/(8)/' 
}

function amend_errors_in_articles {
  sed -E 's/ \[•\]/:/g' | \
    sed -E 's/ 1\]/ \[1\]/g' | \
    #Article 1
    amend_error_in_article 1 'Short title and commence ment Interpretation \[2\]' '\n\n(2)' | \
    #Article 2
    amend_error_in_article 2 'diversity"means' 'diversity" means' | \
    amend_error_in_article 2 'danger"shall' 'danger" shall' | \
    amend_error_in_article 2 'occupatio ' 'occupation ' | \
    amend_error_in_article 2 '25 \[1\]' '25[1]' | \
    amend_error_in_article 2 'means the person in occupation are occupied by different persons, ' '' | \
    #Article 3
    amend_error_in_article 3 'lawandementf o mlaang protection relatingthe to Cap.69.01 National environ mental policy ' '' | \
    #Article 5
    amend_error_in_article 5 '\[6\]' '\n\n(7)' | \
    amend_error_in_article 5 '\[5\]' '\n\n(6)' | \
    amend_error_in_article 5 'Provided that an action' 'provided that an action' | \
    amend_error_in_article 5 '. \[b\]' '; [b]' | \
    amend_error_in_article 5 '\[2\];' '[2],' | \
    #Article 8
    amend_error_in_article 8 'were appropriate' 'where appropriate' | \
    #Article 9
    amend_error_in_article 9 'natural resources;' 'natural resources.' | \
    #Article 11
    amend_error_in_article 11 'Council -' 'Council:' | \
    amend_error_in_article 11 'a fine.' 'a fine;' | \
    amend_error_in_article 11 'Council \[b\]' 'Council; [b]' | \
    #Article 13
    amend_error_in_article 13 'shall have not right to vote' 'shall not have the right to vote' | \
    amend_error_in_article 13 'Technical Committee on the Environment' '' | \
    #Article 14
    amend_error_in_article 14 'vote on ,' 'vote on,' | \
    #Article 17
    amend_error_in_article 17 'Functions of District Developmen t Committees ' '' | \
    #Article 19
    amend_error_in_article 19 'District Environmen tal Officer ' '' | \
    #Article 20
    sed -E 's/\(20\)/District Environmental Officer\n(20)/' | \
    amend_error_in_article 20 'Environ mental planning at national level' '' | \
    #Article 24
    amend_error_in_article 24 '\[1\] ' '[1]' | \
    amend_error_in_article 24 'Environment al impact assessment reports ' '' | \
    #Article 25
    amend_error_in_article 25 'Review of Environment al impact assessment reports ' '' | \
    #Article 26
    amend_error_in_article 26 'ac Environmen tal audits ' '' | \
    amend_error_in_article 26 'issues any licence' 'issue any licence' | \
    #Article 27
    amend_error_in_article 27 'meas ' '' | \
    #Article 29
    amend_error_in_article 29 'Power to prescribe environment al quality standards Environmen tal incentives ' '' | \
    #Article 31
    amend_error_in_article 31 'Environment al protection areas' '' | \
    #Article 32
    amend_error_in_article 32 'Environmen tal protection orders ' '' | \
    amend_error_in_article 32 '; \[3\]' '. [3]' | \
    #Article 33
    amend_error_in_article 33 'Enforcement of environmen tal protection Conservatio n of biological diversity ' '' | \
    #Article 35
    amend_error_in_article 35 'exsitu ' 'ex-situ ' | \
    #Article 38
    amend_error_in_article 38 'Importation exportation and hazardous waste Cap.18:08 Classifica tion of pesticides and hazardous substances ' '' | \
    #Article 40
    amend_error_in_article 40 'Cap.' '' | \
    amend_error_in_article 40 'environment and natural resources.' 'environment and natural resources;' | \
    #Article 41 
    amend_error_in_article 41 '\[e\]' '[d]' | \
    amend_error_in_article 41 '\[f\]' '[e]' | \
    #Article 42
    amend_error_in_article 42 'poll any orosing disp ' '' | \
    amend_error_in_article 42 'duty of person' 'duty of every person' | \
    #Article 43
    amend_error_in_article 43 'Part: Provided' 'Part, provided' | \
    #Article 45
    amend_error_in_article 45 'Environmen tal Inspectors ' '' | \
    #Article 46
    amend_error_in_article 46 'section 45 ' 'section 45' | \
    amend_error_in_article 46 'section \[48\] ' 'section 48' | \
    amend_error_in_article 46 'Establish ment or designation of laboratories Appointmen t of analysts ' '' | \
    amend_error_in_article 46 '48\[2\]' '48[2].' | \
    #Article 51
    amend_error_in_article 51 'Cap.49.01; Cap.49.02 ' '' | \
    #Article 52
    amend_error_in_article 52 'Establish ment of Environ mental Fund ' '' | \
    #Article 53
    amend_error_in_article 53 'Cap.37.*$' '' | \
    #Article 57
    amend_error_in_article 57 'Fund,may ' 'Fund, may ' | \
    amend_error_in_article 57 'Books and other records of account, audit and report of the Fund ' '' | \
    amend_error_in_article 57 'Cap.37:01 Cap.37.01 ' '' | \
    #Article 58
    amend_error_in_article 58 'Holdings of the Fund Financial year General' '' | \
    #Article 59
    amend_error_in_article 59 'hade purposes' 'the purposes' | \
    #Article 60
    amend_error_in_article 60 '; Provided' ', provided' | \
    #Article 61
    amend_error_in_article 61 'offences Hindering, obstructing, etc. of inspector ' '' | \
    amend_error_in_article 61 'no to her penalty' 'no penalty' | \
    #Article 62
    amend_error_in_article 62 'Offences relating to environment al impact assessments ' '' | \
    #Article 63
    amend_error_in_article 63 'section 24 ' 'section 24' | \
    #Article 64
    amend_error_in_article 64 'Offences relating to environment al standards and guidelines ' '' | \
    #Article 65
    amend_error_in_article 65 'thi ' '' | \
    #Article 69
    amend_error_in_article 69 'Establish ment of Environmen tal Appeals Tribunals Director ' '' | \
    #Article 70
    amend_error_in_article 70 'confirm,vary' 'confirm, vary' | \
    amend_error_in_article 70 'sust Failure to attend Representa tion of parties Enforcement of Orders Costs Liability of bodies corporate, etc. ' '' | \
    amend_error_in_article 70 '\[7\]' '[5]' | \
    #Article 76
    sed -E 's/Closure of premises 76/\n\nClosure of premises \n\(76\)/' | \
    amend_error_in_article 76 'been complied with' 'complied with' | \
    #Article 77
    amend_error_in_article 77 'Passed in Parliament.*$' ''
}

function remove_and_reinsert_article_titles {
  remove_and_reinsert_article_title 1 'Short title and commencement ' | \
    remove_and_reinsert_article_title 2 'Interpretation ' | \
    remove_and_reinsert_article_title 3 'National environmental policy ' | \
    remove_and_reinsert_article_title 4 'Natural and genetic resources ' | \
    remove_and_reinsert_article_title 5 'Right to a decent environment ' | \
    remove_and_reinsert_article_title 6 'Role of lead agencies ' | \
    remove_and_reinsert_article_title 7 'Inconsistent provisions in other written laws ' | \
    remove_and_reinsert_article_title 8 'Duties and powers of the Minister ' | \
    remove_and_reinsert_article_title 9 'Appointment of Director of Environmental Affairs ' | \
    remove_and_reinsert_article_title 10 'Establishment and composition of the National Council for the Environment ' | \
    remove_and_reinsert_article_title 11 'Tenure of office and vacancies ' | \
    remove_and_reinsert_article_title 12 'Functions of the Council ' | \
    remove_and_reinsert_article_title 13 'Proceedings of the Council' | \
    remove_and_reinsert_article_title 14 'Disclosure of interest ' | \
    remove_and_reinsert_article_title 15 'Allowances of members of the Council ' | \
    remove_and_reinsert_article_title 16 'Technical Committee on the Environment  ' | \
    remove_and_reinsert_article_title 17 'Functions of the Technical Committee ' | \
    remove_and_reinsert_article_title 18 'Proceedings of the Technical Committee ' | \
    remove_and_reinsert_article_title 19 'Functions of District Development Committees ' | \
    remove_and_reinsert_article_title 21 'Environmental planning at national level ' | \
    remove_and_reinsert_article_title 22 'Purposes and contents of action plan ' | \
    remove_and_reinsert_article_title 23 'Planning at district level ' | \
    remove_and_reinsert_article_title 24 'Projects for which an environmental impact assessment is required ' | \
    remove_and_reinsert_article_title 25 'Environmental impact assessment reports ' | \
    remove_and_reinsert_article_title 26 'Review of environmental impact assessment reports ' | \
    remove_and_reinsert_article_title 27 'Environmental audits ' | \
    remove_and_reinsert_article_title 28 'Monitoring existing projects ' | \
    remove_and_reinsert_article_title 29 'Fees ' | \
    remove_and_reinsert_article_title 30 'Power to prescribe environmental quality standards ' | \
    remove_and_reinsert_article_title 31 'Environmental incentives ' | \
    remove_and_reinsert_article_title 32 'Environmental protection areas ' | \
    remove_and_reinsert_article_title 33 'Environmental protection orders ' | \
    remove_and_reinsert_article_title 34 'Enforcement of environmental protection orders ' | \
    remove_and_reinsert_article_title 35 'Conservation of biological diversity ' | \
    remove_and_reinsert_article_title 36 'Access to genetic resources ' | \
    remove_and_reinsert_article_title 37 'Waste management ' | \
    remove_and_reinsert_article_title 38 'Licences for Waste ' | \
    remove_and_reinsert_article_title 39 'Importation, exportation and transportation of waste ' | \
    remove_and_reinsert_article_title 40 'Classification of pesticides and hazardous substances ' | \
    remove_and_reinsert_article_title 41 'Protection of the ozone layer ' | \
    remove_and_reinsert_article_title 42 'Discharge of pollutants ' | \
    remove_and_reinsert_article_title 43 'Licence to discharge effluent, etc. ' | \
    remove_and_reinsert_article_title 44 'Prohibition of pollution ' | \
    remove_and_reinsert_article_title 45 'Environmental inspectors ' | \
    remove_and_reinsert_article_title 46 'Powers of inspectors ' | \
    remove_and_reinsert_article_title 47 'Procedure for taking samples ' | \
    remove_and_reinsert_article_title 48 'Establishment or designation of analytical laboratories ' | \
    remove_and_reinsert_article_title 49 'Appointment of analysts ' | \
    remove_and_reinsert_article_title 50 'Certificate of analysis, etc. ' | \
    remove_and_reinsert_article_title 51 'Keeping of records ' | \
    remove_and_reinsert_article_title 52 'Public access to information and prohibition of disclosure ' | \
    remove_and_reinsert_article_title 53 'Establishment of Environmental Fund ' | \
    remove_and_reinsert_article_title 54 'Vesting of Fund in the Minister ' | \
    remove_and_reinsert_article_title 55 'Advances to the Fund ' | \
    remove_and_reinsert_article_title 56 'Objects of the Fund ' | \
    remove_and_reinsert_article_title 57 'Application of the Fund' | \
    remove_and_reinsert_article_title 58 'Books and other records of account, audit and reports of the Fund ' | \
    remove_and_reinsert_article_title 59 'Holdings of the Fund ' | \
    remove_and_reinsert_article_title 60 'Financial year ' | \
    remove_and_reinsert_article_title 61 'General offences ' | \
    remove_and_reinsert_article_title 62 'Hindering, obstructing, etc., of inspectors ' | \
    remove_and_reinsert_article_title 63 'Offences relating to environmental impact assessments ' | \
    remove_and_reinsert_article_title 64 'Offences relating to records ' | \
    remove_and_reinsert_article_title 65 'Offences relating to environmental standards and guidelines ' | \
    remove_and_reinsert_article_title 66 'Offences relating to hazardous materials, processes and wastes ' | \
    remove_and_reinsert_article_title 67 'Offences relating to pollution ' | \
    remove_and_reinsert_article_title 68 'Immunity of officials ' | \
    remove_and_reinsert_article_title 69 'Establishment of Environmental Appeals Tribunal ' | \
    remove_and_reinsert_article_title 70 'Composition of Tribunal ' | \
    remove_and_reinsert_article_title 71 'Failure to attend ' | \
    remove_and_reinsert_article_title 72 'Representation of parties ' | \
    remove_and_reinsert_article_title 73 'Enforcement orders ' | \
    remove_and_reinsert_article_title 74 'Costs ' | \
    remove_and_reinsert_article_title 75 'Liability of bodies corporate, etc. ' | \
    remove_and_reinsert_article_title 77 'Regulations ' 
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
    amend_errors_in_headers | \
    format_article_literals | \
    amend_article_numbering | \
    amend_errors_in_articles | \
    remove_and_reinsert_article_titles
}