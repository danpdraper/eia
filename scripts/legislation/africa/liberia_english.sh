#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^Section 1 Title/,$p' 
}

function format_article_numbers_and_titles {
  sed -E 's/Section ([0-9]+)/Article \1/g' | \
    sed -E '/^Article [0-9]+/N;s/\n/ /' | \
    sed -E 's/(Article [0-9]+) ([A-Za-z].*)/\n\2\n\1/g' 
}

function remove_all_text_after_last_article {
  sed -E '/^\(115\)/q'
}

function move_article_titles_above_article_bodies {
  sed -E "s/^(\([0-9]+\).*)\. /\1.\n\n/" | \
    sed -z 's/\n(/(/g' 
}

function amend_errors_in_articles {
  sed -E 's/subsection \(([0-9]+)\)/subsection [\1]/g' | \
    sed -E 's/sub-section \(([0-9]+)\)/sub-section [\1]/g' | \
    sed -E 's/section ([0-9]{2})/section (\1)/g' | \
    sed -E 's/([0-9]{2}) (years)/\1\2/g' | \
    sed -E 's/ ([0-9]{2}) / /g' | \
    sed -E 's/([0-9]{2})(years)/\1 \2/g' | \
    sed -E 's/ section \(([0-9]+)\)/ section \1/g' | \
    #fix common OCR/spelling errors
    sed -E 's/enviromnent/environment/g' | \
    sed -E 's/Enviromnent/Environment/g' | \
    sed -E 's/and he /and the /g' | \
    sed -E 's/Ifthe/If the/g' | \
    sed -E 's/ifthe/if the/g' | \
    sed -E 's/of he /of the /g' | \
    sed -E 's/on he /on the /g' | \
    sed -E 's/ofLiberia/of Liberia/g' | \
    sed -E 's/of([a-z])/of \1/g' | \
    sed -E 's/of fence/offence/g' | \
    sed -E 's/of fice/office/g' | \
    sed -E 's/prof essional/professional/g' | \
    sed -E 's/\[I\]/[i]/g' | \
    sed -E 's/\[11\]/[ii]/g' | \
    sed -E 's/\[II\]/[ii]/g' | \
    sed -E 's/\[111\]/[iii]/g' | \
    sed -E 's/\[IV\]/[iv]/g' | \
    sed -E 's/\[VI\]/[vi]/g' | \
    sed -E 's/\[VIII\]/[viii]/g' | \
    #Article 1
    sed -E 's/ Title/Title -/' | \
    sed -E 's/Assembled: A/Assembled:/' | \
    sed -E 's/LIse/use/' | \
    sed -E 's/111 main/in main/' | \
    amend_error_in_article 1 'LIse' 'use' | \
    #Article 2
    sed -E 's/ShortTitle -/\n\nShort Title/' | \
    #Article 3
    sed -E 's/8 Definition/Definition/' | \
    amend_error_in_article 3 'as \[•\]' 'as:' | \
    amend_error_in_article 3 'stakeholders \[•\]' 'stakeholders -' | \
    amend_error_in_article 3 'sustainabiiity' 'sustainability' | \
    amend_error_in_article 3 'f nding ' 'finding' | \
    amend_error_in_article 3 'whichescape' 'which escape' | \
    amend_error_in_article 3 'll1 the Health Act ll1' 'in the Health Act in' | \
    amend_error_in_article 3 'poIlution' 'pollution' | \
    amend_error_in_article 3 'howell' 'how well' | \
    amend_error_in_article 3 'findingof' 'finding of' | \
    amend_error_in_article 3 'Chlorof ' 'Chlorof' | \
    amend_error_in_article 3 'mater,' 'matter,' | \
    amend_error_in_article 3 '. 9 ' '; ' | \
    sed -E ':start;s/^(\(3\).*)\./\1;/;t start' | \
    amend_error_in_article 3 'resources;' 'resources.' | \
    amend_error_in_article 3 'in-eversible' 'irreversible' | \
    amend_error_in_article 3 'soi1and' 'soil and' | \
    amend_error_in_article 3 'well dam' 'well, dam' | \
    #Article 4
    amend_error_in_article 4 'poll uter \[•\] ' 'polluter-' | \
    amend_error_in_article 4 'teclmology' 'technology' | \
    amend_error_in_article 4 'on III' 'on in' | \
    amend_error_in_article 4 '\[1\] Ensure' '[l] Ensure' | \
    #Article 5
    amend_error_in_article 5 'COUli' 'Court' | \
    amend_error_in_article 5 'with he' 'with the' | \
    amend_error_in_article 5 'assert' 'may assert' | \
    amend_error_in_article 5 'appeals to' 'appeal to' | \
    amend_error_in_article 5 '\(2\) and \(3\)' '[2] and [3]' | \
    #Article 6
    sed -E 's/: Application/: \n\nApplication/' | \
    amend_error_in_article 6 'conformity with' 'conformity with section 36' | \
    #Article 7
    sed -E 's/\(36\) Notice of lntent Article 7/\nNotice of Intent\n(7)/' | \
    amend_error_in_article 7 'including.' 'including;' | \
    #Article 8
    amend_error_in_article 8 'proj ected' 'projected' | \
    amend_error_in_article 8 '0 f' 'of' | \
    #Article 9
    sed -E 's/19 Duties/Duties/' | \
    #Article 10
    amend_error_in_article 9 '. Duties' '. \n\nDuties' | \
    sed -E 's/Article \[l\]/\n(10)/' | \
    amend_error_in_article 10 'as may' 'as may be' | \
    #Article 11
    amend_error_in_article 10 '. The Scoping process Article' '. \n\nThe Scoping process \n(11)' | \
    amend_error_in_article 11 '111' 'in' | \
    amend_error_in_article 11 'nan-ow' 'narrow' | \
    amend_error_in_article 11 'addressed n' 'addressed in' | \
    #Article 13
    amend_error_in_article 13 'reversibilitylirreversibility' 'reversibility\/irreversibility' | \
    amend_error_in_article 13 'submit and' 'submit an' | \
    #Article 14
    amend_error_in_article 14 'fullscale' 'full scale' | \
    amend_error_in_article 14 '\[1\] the' '[l] the' | \
    #Article 15
    amend_error_in_article 15 'Objectives' 'Objectives;' | \
    #Article 16
    amend_error_in_article 16 'ifit' 'if it' | \
    amend_error_in_article 16 'ifhe' 'if he' | \
    amend_error_in_article 16 'made: ' 'made:\n\n' | \
    #Article 17
    amend_error_in_article 17 '\(16\) \(3\) \(b\)' '16[3][b]' | \
    amend_error_in_article 17 '\(a\)' '[a]' | \
    #Article 18
    amend_error_in_article 18 'iffive' 'if five' | \
    amend_error_in_article 18 'quali fled' 'qualified' | \
    #Article 19
    sed -E 's/24 Line Ministrie/Line Ministrie/' | \
    #Article 20
    amend_error_in_article 20 'members 0' 'members of' | \
    amend_error_in_article 20 'sections \(16\), \(17\), \(18\), and \(19\)' 'sections 16, 17, 18, and 19' | \
    #Article 21
    amend_error_in_article 21 '.-' ':' | \
    #Article 23
    amend_error_in_article 22 '; Environmental' '; \n\nEnvironmental' | \
    amend_error_in_article 23 'ifissued' 'if issued' | \
    #Article 24
    amend_error_in_article 24 'ofJustice' 'of Justice' | \
    #Article 26
    amend_error_in_article 25 '. Submission of' '. \n\nSubmission of' | \
    sed -E 's/Article Environmental Impact Assessment License/Environmental Impact Assessment License\n(26)/' | \
    #Article 27
    amend_error_in_article 27 '\(15' '15' | \
    amend_error_in_article 27 '\(25\) and \(26\)' '25 and 26' | \
    #Article 28
    amend_error_in_article 28 'He Agency' 'The Agency' | \
    #Article 29
    sed -E 's/28 Fees/Fees/' | \
    #Article 31
    amend_error_in_article 31 'behal f' 'behalf' | \
    amend_error_in_article 31 'of ficial' 'official' | \
    amend_error_in_article 31 '\(2\)' '[2]' | \
    #Article 32
    sed -E 's/29 Trans/Trans/' | \
    #Article 33
    amend_error_in_article 33 'Submi tted' 'submitted' | \
    #Article 35
    amend_error_in_article 35 '; vn.' '; [vii]' | \
    amend_error_in_article 35 '0 effluent' 'of effluent' | \
    #Article 36
    amend_error_in_article 36 'ermssion' 'emission' | \
    amend_error_in_article 36 'Determi ne' 'Determine' | \
    amend_error_in_article 36 'lor c' 'or c' | \
    #Article 37
    amend_error_in_article 37 '\(a\)' 'a' | \
    #Article 40
    amend_error_in_article 40 '1,' '[1],' | \
    amend_error_in_article 40 '.;' '.' | \
    #Article 41
    sed -E 's/Criteria an/Criteria and/g' | \
    #Article 42
    amend_error_in_article 42 'of to' 'or to' | \
    #Article 44
    amend_error_in_article 44 'shall, ' 'shall, in ' | \
    amend_error_in_article 44 '0' 'of' | \
    #Article 45
    amend_error_in_article 45 'se out' 'set out' | \
    #Article 46
    sed -E 's/Environ mental/Environmental/' | \
    amend_error_in_article 46 '\(a\)' 'a' | \
    #Article 47
    amend_error_in_article 47 'for he' 'for the' | \
    #Article 49
    amend_error_in_article 49 'prod ucts' 'products' | \
    #Article 50
    amend_error_in_article 50 'for he' 'for the' | \
    #Article 51
    amend_error_in_article 51 'these pollutants ' 'these pollutants.\n\n' | \
    amend_error_in_article 51 '\[2\]' '[2].' | \
    #Article 54
    amend_error_in_article 54 'establ ished' 'established' | \
    amend_error_in_article 54 'overt' 'over' | \
    #Article 55
    sed -E 's/\(55\) Importation and Exportation of Hazardous Waste Prohibited/\nImportation and Exportation of Hazardous Waste Prohibited\n(55)/' | \
    #Article 56
    sed -E 's/Prohibition of Discharge/\n\nProhibition of Discharge/' | \
    sed -E 's/Article Environment and Spillers Liability/Environment and Spillers Liability \n(56)/' | \
    #Article 57
    amend_error_in_article 57 '\(2\)' '[2]' | \
    #Article 58
    amend_error_in_article 58 '\(1\) and \(5\)' '[1] and [5]' | \
    amend_error_in_article 58 '011' 'on' | \
    #Article 59
    sed -z 's/\n\n\[2\] Where/[2] Where/' | \
    amend_error_in_article 59 'Register of' '\n\nRegister of' | \
    amend_error_in_article 59 '.\[2\]' '. [2]' | \
    amend_error_in_article 59 'application;' 'application.' | \
    #Article 61
    amend_error_in_article 61 'coast' 'cost' | \
    #Article 62
    amend_error_in_article 61 'Prohibition of Solid' '\n\nProhibition of Solid' | \
    sed -E 's/Pollution: Article/Pollution \n(62)/' | \
    #Article 64
    amend_error_in_article 64 '\(1\) and \(5\)' '[1] and [5]' | \
    #Article 69
    amend_error_in_article 69 '\(3\) ,' '[3],' | \
    #Article 74
    amend_error_in_article 74 'nver' 'river' | \
    #Article 75
    amend_error_in_article 75 'drilJ' 'drill' | \
    #Article 76
    amend_error_in_article 76 'lanel' 'land' | \
    #Article 77
    amend_error_in_article 77 'inn' 'in' | \
    amend_error_in_article 77 'section \[4\]' 'section. [4]' | \
    amend_error_in_article 77 '\(3\) and \(4\)' '[3] and [4]' | \
    amend_error_in_article 77 'con ' 'on ' | \
    #Article 78
    amend_error_in_article 78 'actin ' 'action ' | \
    #Article 79
    amend_error_in_article 79 'Environemt' 'Environment' | \
    #Article 81
    amend_error_in_article 81 'Promoti ng' 'Promoting' | \
    #Article 82
    amend_error_in_article 82 'declare an' 'declare and' | \
    amend_error_in_article 82 'offence an' 'offence and' | \
    #Article 83
    amend_error_in_article 83 'disagregated' 'disaggregated' | \
    #Article 84
    amend_error_in_article 83 'Conservation of Biological Resources In-situ Article' '\n\nConservation of Biological Resources In-situ \n(84)' | \
    #Article 85
    amend_error_in_article 84 'Conservation of Biological Resources Ex-situ' '\n\nConservation of Biological Resources Ex-situ \n(85)' | \
    amend_error_in_article 85 'Article 54 ' '' | \
    amend_error_in_article 85 'aquana' 'aquaria' | \
    amend_error_in_article 85 'orgamsms' 'organisms' | \
    amend_error_in_article 85 '1V.' '[iv]' | \
    amend_error_in_article 85 '\[1\] germplasm' '[i] germplasm' | \
    amend_error_in_article 85 '\[1\] the' '[i] the' | \
    #Article 86
    sed -E 's/Resou rces/Resources/' | \
    amend_error_in_article 86 'nonresidents' 'non residents' | \
    amend_error_in_article 86 'ofDistrict' 'of District' | \
    #Article 87
    sed -E 's/55 Land/Land/' | \
    amend_error_in_article 87 'with he' 'with the' | \
    #Article 89
    amend_error_in_article 89 '\[i\] The' '[1] The' | \
    #Article 90
    amend_error_in_article 90 '\(6\)' '[6]' | \
    #Article 91
    amend_error_in_article 91 'COUli' 'Court' | \
    amend_error_in_article 91 ' hall ' ' shall ' | \
    #Article 92
    amend_error_in_article 92 '\(l\)' '[1]' | \
    #Article 93
    amend_error_in_article 92 'Action by' '\n\nAction by' | \
    sed -E 's/Article Environmental Restoration Order/Environmental Restoration Order\n(93)/' | \
    amend_error_in_article 93 'to he' 'to the' | \
    #Article 94
    amend_error_in_article 94 '\(93\) and \(94\)' '93 and 94' | \
    #Article 95
    amend_error_in_article 95 '21 \(2\)' '21[2]' | \
    amend_error_in_article 95 'with he' 'with the' | \
    amend_error_in_article 95 'machi nery' 'machinery' | \
    amend_error_in_article 95 'uncler' 'under' | \
    amend_error_in_article 95 'an the' 'and the' | \
    amend_error_in_article 95 'or \[1\]' 'or [l]' | \
    #Article 99
    sed -E ':start;s/^(\(99\).*)intemational/\1international/;t start' | \
    amend_error_in_article 99 'conceming' 'concerning' | \
    amend_error_in_article 99 'than he ' 'than the ' | \
    amend_error_in_article 99 'and Whether' 'and whether' | \
    #Article 105
    amend_error_in_article 105 'briefin' 'brief in' | \
    amend_error_in_article 105 'an is' 'and is' | \
    #ARticle 108
    amend_error_in_article 108 'the act a' 'the act is' 
}

function amend_errors_in_headers {
  sed -E 's/PART I /\n\nPART I /' | \
    sed -E 's/^(PART .*)\[•\]/\1-/g' | \
    sed -E 's/15 PART II \[•\]/PART II -/' | \
    sed -E 's/PART V \[•\]/\n\nPART V -/' | \
    sed -E 's/PART IX-/PART IX - /' | \
    sed -E 's/([A-Z]{2} )([A-Z][a-z])/\1\n\n\2/g' | \
    sed -z "s/\n\nLiberia's natural/Liberia's natural/" | \
    sed -E 's/THE MANAGEMEN /THE MANAGEMENT /' 
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
    format_article_numbers_and_titles | \
    apply_common_transformations_to_stdin "$language" | \
    move_article_titles_above_article_bodies | \
    remove_all_text_after_last_article | \
    amend_errors_in_articles | \
    amend_errors_in_headers
}