#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^Section 1 Title/,$p' 
}

function format_article_numbers_and_titles {
  sed -E 's/Section ([0-9]+)/Article \1/g' | \
    sed -E '/^Article [0-9]+/N;s/\n/ /' | \
    sed -E 's/(Article [0-9]+) ([A-Za-z].*)/\n\2\n\1/g' 
}

function move_article_titles_above_article_bodies {
  sed -E "s/^(\([0-9]+\).*)\. /\1.\n\n/" | \
    sed -z 's/\n(/(/g' 
}

function remove_all_text_after_last_article {
  sed -E '/^\(115\)/,${/^\(115\)/!d}'
}

function amend_errors_in_articles {
  sed -E 's/subsection \(([0-9]+)\)/subsection [\1]/g' | \
    sed -E 's/sub-section \(([0-9]+)\)/sub-section [\1]/g' | \
    sed -E 's/section ([0-9]{2})/section (\1)/g' | \
    sed -E 's/([0-9]{2}) (years)/\1\2/g' | \
    sed -E 's/ ([0-9]{2}) / /g' | \
    sed -E 's/([0-9]{2})(years)/\1 \2/g' | \
    sed -E 's/ section \(([0-9]+)\)/ section \1/g' | \
    sed -E 's/;( \[[0-9+]\] [A-Z])/.\1/g' | \
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
    sed -z 's/\n\nWHEREAS of.*Legislature Assembled://' | \
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
    amend_error_in_article 3 'resources;' 'resources.' | \
    amend_error_in_article 3 'in-eversible' 'irreversible' | \
    amend_error_in_article 3 'soi1and' 'soil and' | \
    amend_error_in_article 3 'well dam' 'well, dam' | \
    amend_error_in_article 3 'into alia' 'inter alia' | \
    amend_error_in_article 3 'biotic component or ecosystems' 'biotic component of ecosystems' | \
    amend_error_in_article 3 'section 83 or the Law' 'section 83 of the Law' | \
    amend_error_in_article 3 'atmosphere, soil vegetation, climate' 'atmosphere, soil, vegetation, climate' | \
    amend_error_in_article 3 'objectives evaluation' 'objective evaluation' | \
    amend_error_in_article 3 'established on under section 33' 'established under section 33' | \
    amend_error_in_article 3 'both the renewable or non-renewable' 'both the renewable and non-renewable' | \
    amend_error_in_article 3 'section 16 of this Agency Act:' 'section 16 of the Agency Act;' | \
    amend_error_in_article 3 'corrosive, irritating radioactive' 'corrosive, irritating, radioactive' | \
    amend_error_in_article 3 'section 29 of this Agency Act' 'section 29 of the Agency Act' | \
    amend_error_in_article 3 'air, land water' 'air, land, water' | \
    amend_error_in_article 3 'atmosphere with a structure' 'atmosphere within a structure' | \
    amend_error_in_article 3 "Brief'" 'Brief"' | \
    amend_error_in_article 3 "territorial waters of Liberia's coastline" "territorial waters off Liberia's coastline" | \
    amend_error_in_article 3 '; "Territorial' '. "Territorial' | \
    amend_error_in_article 3 'Liberia; "' 'Liberia. "' | \
    amend_error_in_article 3 'Law; "Coastal' 'Law. "Coastal' | \
    amend_error_in_article 3 'environment; "Environmental' 'environment. "Environmental' | \
    amend_error_in_article 3 'surroundings; "Environmental' 'surroundings. "Environmental' | \
    amend_error_in_article 3 'environment; "Environmental' 'environment. "Environmental' | \
    amend_error_in_article 3 'sustainability; "Environmental' 'sustainability. "Environmental' | \
    amend_error_in_article 3 'term; "Environmental' 'term. "Environmental' | \
    amend_error_in_article 3 'issues; "Environmental' 'issues. "Environmental' | \
    amend_error_in_article 3 'qualities; "Environmental' 'qualities. "Environmental' | \
    amend_error_in_article 3 ' Law; "Environmental' ' Law. "Environmental' | \
    amend_error_in_article 3 ' Act; "Ex-situ' ' Act. "Ex-situ' | \
    amend_error_in_article 3 'Liberia; "Genetic' 'Liberia. "Genetic' | \
    amend_error_in_article 3 'value; "Good' 'value. "Good' | \
    amend_error_in_article 3 'Law; "Mangrove' 'Law. "Mangrove' | \
    amend_error_in_article 3 'qualities; "Noise' 'qualities. "Noise' | \
    amend_error_in_article 3 'environment; "Occupational' 'environment. "Occupational' | \
    amend_error_in_article 3 'operation; "Precautionary' 'operation. "Precautionary' | \
    amend_error_in_article 3 'degradation; "Premises' 'degradation. "Premises' | \
    amend_error_in_article 3 'premises; "The' 'premises. "The' | \
    amend_error_in_article 3 'Liberia; "Project' 'Liberia. "Project' | \
    amend_error_in_article 3 'environment; "Project' 'environment. "Project' | \
    amend_error_in_article 3 'business; "Published' 'business. "Published' | \
    amend_error_in_article 3 'law; "Sustainable' 'law. "Sustainable' | \
    amend_error_in_article 3 'ecosystems; "Sustainable' 'ecosystems. "Sustainable' | \
    amend_error_in_article 3 'environment; "Water' 'environment. "Water' | \
    amend_error_in_article 3 '; and;' '.' | \
    amend_error_in_article 3 'Liberia; "' 'Liberia. "' | \
    amend_error_in_article 3 'Agency"' '"Agency"' | \
    amend_error_in_article 3 'coastline. Trade"' 'coastline. "Trade"' | \
    #Article 4
    amend_error_in_article 4 'poll uter \[•\] ' 'polluter-' | \
    amend_error_in_article 4 'teclmology' 'technology' | \
    amend_error_in_article 4 'on III' 'on in' | \
    amend_error_in_article 4 '\[1\] Ensure' '[l] Ensure' | \
    amend_error_in_article 4 'principle \[c\]' 'principle; [c]' | \
    amend_error_in_article 4 'principle \[d\]' 'principle; [d]' | \
    amend_error_in_article 4 'equity \[e\]' 'equity; [e]' | \
    amend_error_in_article 4 'participation \[f\]' 'participation; [f]' | \
    amend_error_in_article 4 'development within undermining' 'development without undermining' | \
    amend_error_in_article 4 'bequeath of future' 'bequeath on future' | \
    amend_error_in_article 4 'feasible. \[c\]' 'feasible; [c]' | \
    amend_error_in_article 4 'standards and to monitor' 'standards and monitor' | \
    #Article 5
    amend_error_in_article 5 'COUli' 'Court' | \
    amend_error_in_article 5 'with he' 'with the' | \
    amend_error_in_article 5 'assert' 'may assert' | \
    amend_error_in_article 5 'appeals to' 'appeal to' | \
    amend_error_in_article 5 '\(2\) and \(3\)' '[2] and [3]' | \
    amend_error_in_article 5 'Act; \[4\]' 'Act. [4]' | \
    amend_error_in_article 5 'any person may, commence' 'any person may commence' | \
    amend_error_in_article 5 'Act; \[5\]' 'Act. [5]' | \
    amend_error_in_article 5 '\[4\]; \[a\]' '[4]: [a]' | \
    amend_error_in_article 5 'Law; \[7\]' 'Law. [7]' | \
    amend_error_in_article 5 'appropriate; \[8\]' 'appropriate. [8]' | \
    amend_error_in_article 5 'agency\); \[9\]' 'agency). [9]' | \
    #Article 6
    sed -E 's/and provides/and provide/' | \
    sed -E 's/concerns:/concerns./' | \
    sed -E 's/. Application for an/. \n\nApplication for an/' | \
    amend_error_in_article 6 'conformity with' 'conformity with section 36' | \
    amend_error_in_article 6 'Law; \[2\]' 'Law. [2]' | \
    amend_error_in_article 6 'license, on' 'license on' | \
    #Article 7
    sed -E 's/\(36\) Notice of lntent Article 7/\nNotice of Intent\n(7)/' | \
    amend_error_in_article 7 'including.' 'including:' | \
    #Article 8
    amend_error_in_article 8 'proj ected' 'projected' | \
    amend_error_in_article 8 '0 f' 'of' | \
    amend_error_in_article 8 'scooping activities' 'scoping activities' | \
    amend_error_in_article 8 'Registry; \[3\]' 'Registry. [3]' | \
    amend_error_in_article 8 'brief; \[4\]' 'brief. [4]' | \
    amend_error_in_article 8 'proponent of applicant' 'proponent or applicant' | \
    amend_error_in_article 8 'proponent or application' 'proponent or applicant' | \
    amend_error_in_article 8 'sensitivity or the project' 'sensitivity of the project' | \
    #Article 9
    sed -E 's/19 Duties/Duties/' | \
    amend_error_in_article 9 'insured' 'incurred' | \
    #Article 10
    amend_error_in_article 9 '. Duties' '. \n\nDuties' | \
    sed -E 's/Article \[l\]/\n(10)/' | \
    amend_error_in_article 10 'as may' 'as may be' | \
    amend_error_in_article 10 'study; \[3\]' 'study. [3]' | \
    #Article 11
    amend_error_in_article 10 '. The Scoping process Article' '. \n\nThe Scoping process \n(11)' | \
    amend_error_in_article 11 '111' 'in' | \
    amend_error_in_article 11 'nan-ow' 'narrow' | \
    amend_error_in_article 11 'addressed n' 'addressed in' | \
    amend_error_in_article 11 'effected stakeholders' 'affected stakeholders' | \
    #Article 12 
    amend_error_in_article 12 'project; \[2\]' 'project. [2]' | \
    amend_error_in_article 12 'to be following' 'to be followed' | \
    #Article 13
    amend_error_in_article 13 'reversibilitylirreversibility' 'reversibility\/irreversibility' | \
    amend_error_in_article 13 'submit and' 'submit an' | \
    amend_error_in_article 13 'Ministry; \[2\]' 'Ministry. [2]' | \
    #Article 14
    amend_error_in_article 14 'fullscale' 'full scale' | \
    amend_error_in_article 14 '\[1\] the' '[l] the' | \
    amend_error_in_article 14 'proponent, shall' 'proponent shall' | \
    #Article 15
    amend_error_in_article 15 'Objectives' 'Objectives;' | \
    amend_error_in_article 15 'proponent, shall' 'proponent shall' | \
    #Article 16
    amend_error_in_article 16 'ifit' 'if it' | \
    amend_error_in_article 16 'ifhe' 'if he' | \
    amend_error_in_article 16 'made: ' 'made.\n\n' | \
    #Article 17
    amend_error_in_article 17 '\(16\) \(3\) \(b\)' '16[3][b]' | \
    amend_error_in_article 17 '\(a\)' '[a]' | \
    #Article 18
    amend_error_in_article 18 'iffive' 'if five' | \
    amend_error_in_article 18 'quali fled' 'qualified' | \
    amend_error_in_article 18 'a suitably qualified persons' 'a suitably qualified person' | \
    amend_error_in_article 18 'made; \[3\]' 'made. [3]' | \
    amend_error_in_article 18 'public hearing an as may' 'public hearing as may' | \
    amend_error_in_article 18 'Agency; \[4\]' 'Agency. [4]' | \
    #Article 19
    sed -E 's/24 Line Ministrie/Line Ministrie/' | \
    amend_error_in_article 19 'transmit than' 'transmit them' | \
    amend_error_in_article 19 'Agency; \[2\]' 'Agency. [2]' | \
    amend_error_in_article 19 'Agency; \[3\]' 'Agency. [3]' | \
    #Article 20
    amend_error_in_article 20 'members 0' 'members of' | \
    amend_error_in_article 20 'sections \(16\), \(17\), \(18\), and \(19\)' 'sections 16, 17, 18, and 19' | \
    amend_error_in_article 20 'statement; \[2\]' 'statement. [2]' | \
    amend_error_in_article 20 'activity; \[3\]' 'activity. [3]' | \
    #Article 21
    amend_error_in_article 21 '.-' ':' | \
    #Article 22
    amend_error_in_article 22 'public, an line' 'public and line' | \
    #Article 23
    amend_error_in_article 22 '. Environmental' '. \n\nEnvironmental' | \
    amend_error_in_article 23 'ifissued' 'if issued' | \
    amend_error_in_article 23 'management; \[2\]' 'management. [2]' | \
    amend_error_in_article 23 'plan an implementation' 'plan and implementation' | \
    #Article 24
    amend_error_in_article 24 'ofJustice' 'of Justice' | \
    amend_error_in_article 24 'plan; \[3\]' 'plan. [3]' | \
    amend_error_in_article 24 'as Agency may determine' 'as the Agency may determine' | \
    amend_error_in_article 24 'compliance; \[4\]' 'compliance. [4]' | \
    amend_error_in_article 24 'premises, at appropriate' 'premises at appropriate' | \
    amend_error_in_article 24 'act; \[5\]' 'act. [5]' | \
    #Article 25
    amend_error_in_article 25 'environment; \[2\]' 'environment. [2]' | \
    amend_error_in_article 25 'impact statements has been made' 'impact statement has been made' | \
    amend_error_in_article 25 'with; \[3\]' 'with. [3]' | \
    amend_error_in_article 25 'premises, at appropriate hours' 'premises at appropriate hours' | \
    amend_error_in_article 25 'Act; \[4\]' 'Act. [4]' | \
    amend_error_in_article 25 'randomly; \[5\]' 'randomly. [5]' | \
    #Article 26
    amend_error_in_article 25 '. Submission of' '. \n\nSubmission of' | \
    sed -E 's/Article Environmental Impact Assessment License/Environmental Impact Assessment License\n(26)/' | \
    amend_error_in_article 26 'addressed; \[3\]' 'addressed. [3]' | \
    amend_error_in_article 26 '\[1\] \[a\]' '[1]: [a]' | \
    #Article 27
    amend_error_in_article 27 '\(15' '15' | \
    amend_error_in_article 27 '\(25\) and \(26\)' '25 and 26' | \
    #Article 28
    amend_error_in_article 28 'He Agency' 'The Agency' | \
    amend_error_in_article 28 'The holder of may' 'The holder may' | \
    amend_error_in_article 28 'issued; \[2\]' 'issued. [2]' | \
    amend_error_in_article 28 'both the license and the person' 'both the licensee and the person' | \
    amend_error_in_article 28 'transfer; \[3\]' 'transfer. [3]' | \
    amend_error_in_article 28 'project; \[4\]' 'project. [4]' | \
    amend_error_in_article 28 'transfer; \[5\]' 'transfer. [5]' | \
    amend_error_in_article 28 'license; \[6\]' 'license. [6]' | \
    #Article 29
    sed -E 's/28 Fees/Fees/' | \
    amend_error_in_article 29 'Council; \[2\]' 'Council. [2]' | \
    amend_error_in_article 29 'process; \[3\]' 'process. [3]' | \
    amend_error_in_article 29 'does; \[4\]' 'does. [4]' | \
    #Article 30
    amend_error_in_article 30 'request that, the agency' 'request that the agency' | \
    amend_error_in_article 30 'decision; \[2\]' 'decision. [2]' | \
    amend_error_in_article 30 'decision; \[3\]' 'decision. [3]' | \
    amend_error_in_article 30 'decision; \[4\]' 'decision. [4]' | \
    #Article 31
    amend_error_in_article 31 'behal f' 'behalf' | \
    amend_error_in_article 31 'of ficial' 'official' | \
    amend_error_in_article 31 '\(2\)' '[2]' | \
    amend_error_in_article 31 'approval; \[2\]' 'approval. [2]' | \
    amend_error_in_article 31 'enactment; \[3\]' 'enactment. [3]' | \
    #Article 32
    sed -E 's/29 Trans/Trans/' | \
    amend_error_in_article 32 'the opinion that he project' 'the opinion that the project' | \
    #Article 33
    amend_error_in_article 33 'Submi tted' 'submitted' | \
    #Article 34
    amend_error_in_article 34 'Liberia; \[2\]' 'Liberia. [2]' | \
    #Article 35
    amend_error_in_article 35 '; vn.' '; [vii]' | \
    amend_error_in_article 35 '0 effluent' 'of effluent' | \
    amend_error_in_article 35 'uses. \[b\]' 'uses; [b]' | \
    amend_error_in_article 35 'perform any at necessary' 'perform any act necessary' | \
    #Article 36
    amend_error_in_article 36 'ermssion' 'emission' | \
    amend_error_in_article 36 'Determi ne' 'Determine' | \
    amend_error_in_article 36 'lor c' 'or c' | \
    amend_error_in_article 36 'plants of the installation' 'plants or the installation' | \
    amend_error_in_article 36 'section: \[c\]' 'section; [c]' | \
    amend_error_in_article 36 'both, such fine' 'both such fine' | \
    #Article 37
    sed -E 's/Classification an Identification/Classification and Identification/' | \
    amend_error_in_article 37 '\(a\)' '[a]' | \
    #Article 38
    amend_error_in_article 38 'section 38 above' 'section 37 above' | \
    #Article 39
    amend_error_in_article 39 'develop and publish' 'shall develop and publish' | \
    amend_error_in_article 39 'management; \[2\]' 'management. [2]' | \
    #Article 40
    sed -z 's/(40) The Agency/(40) [1] The Agency/' | \
    amend_error_in_article 40 '1,' '[1],' | \
    amend_error_in_article 40 '.;' '.' | \
    amend_error_in_article 40 'soil; \[2\]' 'soil. [2]' | \
    amend_error_in_article 40 'sub section' 'sub-section' | \
    amend_error_in_article 40 'various soil' 'various soils' | \
    amend_error_in_article 40 'soil \[e\]' 'soil; [e]' | \
    amend_error_in_article 40 'degrade the soi.' 'degrade the soil;' | \
    amend_error_in_article 40 'section.. \[4\]' 'section. [4]' | \
    #Article 41
    sed -E 's/Criteria an /Criteria and /g' | \
    amend_error_in_article 41 'form existing and future sources' 'from existing and future sources' | \
    #Article 42
    amend_error_in_article 42 'of to' 'or to' | \
    amend_error_in_article 42 'Law; \[2\]' 'Law. [2]' | \
    #Article 43
    amend_error_in_article 43 'the provision of section 42' 'the provisions of section 42' | \
    amend_error_in_article 43 'determine; \[2\]' 'determine. [2]' | \
    amend_error_in_article 43 'noise; \[3\]' 'noise. [3]' | \
    #Article 44
    amend_error_in_article 44 'shall, ' 'shall, in ' | \
    amend_error_in_article 44 '0' 'of' | \
    amend_error_in_article 44 'Conduct an ionizing' 'Conduct ionizing' | \
    amend_error_in_article 44 'Maintain register' 'Maintain a register' | \
    #Article 45
    amend_error_in_article 45 'se out' 'set out' | \
    amend_error_in_article 45 'Law; \[2\]' 'Law. [2]' | \
    amend_error_in_article 45 'year; \[3\]' 'year. [3]' | \
    amend_error_in_article 45 'for a ionizing' 'for an ionizing' | \
    amend_error_in_article 45 'fee; \[4\]' 'fee. [4]' | \
    amend_error_in_article 45 'both; \[5\]' 'both. [5]' | \
    #Article 46
    sed -E 's/Environ mental/Environmental/' | \
    amend_error_in_article 46 '\(a\)' 'a' | \
    amend_error_in_article 46 'radiation. \[c\]' 'radiation; [c]' | \
    amend_error_in_article 46 'paragraph a' 'paragraph [a]' | \
    #Article 47
    amend_error_in_article 47 'for he' 'for the' | \
    #Article 48
    amend_error_in_article 48 ' liable on conviction liable' ' liable on conviction' | \
    #Article 49
    amend_error_in_article 49 'prod ucts' 'products' | \
    #Article 50
    amend_error_in_article 50 'for he' 'for the' | \
    amend_error_in_article 50 'jurisdiction; \[3\]' 'jurisdiction. [3]' | \
    #Article 51
    amend_error_in_article 51 'these pollutants ' 'these pollutants.\n\n' | \
    amend_error_in_article 51 ' \[2\]' '. [2]' | \
    #Article 52
    amend_error_in_article 52 'Agency; \[2\]' 'Agency. [2]' | \
    amend_error_in_article 52 'practicable; \[3\]' 'practicable. [3]' | \
    amend_error_in_article 52 'Agency; \[4\]' 'Agency. [4]' | \
    amend_error_in_article 52 'Law; \[5\]' 'Law. [5]' | \
    #Article 54
    amend_error_in_article 54 'establ ished' 'established' | \
    amend_error_in_article 54 'overt' 'over' | \
    #Article 55
    sed -E 's/\(55\) Importation and Exportation of Hazardous Waste Prohibited/\nImportation and Exportation of Hazardous Waste Prohibited\n(55)/' | \
    amend_error_in_article 55 'Liberia to any county' 'Liberia to any country' | \
    #Article 56
    sed -E 's/Prohibition of Discharge/\n\nProhibition of Discharge/' | \
    sed -E 's/Article Environment and Spillers Liability/Environment and Spillers Liability \n(56)/' | \
    amend_error_in_article 56 'Ministry; \[2\]' 'Ministry. [2]' | \
    amend_error_in_article 56 'both; \[3\]' 'both. [3]' | \
    amend_error_in_article 56 'a discharging, production' 'a discharging production' | \
    amend_error_in_article 56 'means; \[6\]' 'means. [6]' | \
    amend_error_in_article 56 'both; \[7\]' 'both. [7]' | \
    amend_error_in_article 56 'discharge; \[8\]' 'discharge. [8]' | \
    #Article 57
    amend_error_in_article 57 '\(2\)' '[2]' | \
    #Article 58
    amend_error_in_article 58 '\(1\) and \(5\)' '[1] and [5]' | \
    amend_error_in_article 58 '011' 'on' | \
    amend_error_in_article 58 'industrial; and' 'industrial undertaking; and' | \
    amend_error_in_article 58 'conviction liable to a liable' 'conviction liable' | \
    #Article 59
    sed -z 's/\n\n\[2\] Where/[2] Where/' | \
    amend_error_in_article 59 'Register of' '\n\nRegister of' | \
    amend_error_in_article 59 '.\[2\]' '. [2]' | \
    amend_error_in_article 59 'application;' 'application.' | \
    #Article 60
    amend_error_in_article 60 'Law; \[2\]' 'Law. [2]' | \
    #Article 61
    amend_error_in_article 61 'coast' 'cost' | \
    amend_error_in_article 61 'DOLLARS to imprisonment' 'DOLLARS or to imprisonment' | \
    amend_error_in_article 61 'both; \[2\]' 'both. [2]' | \
    #Article 62
    amend_error_in_article 61 'Prohibition of Solid' '\n\nProhibition of Solid' | \
    sed -E 's/Pollution: Article/Pollution \n(62)/' | \
    amend_error_in_article 62 'discharges discard, dump or leave' 'discharges, dumps, discards or leaves' | \
    #Article 63
    amend_error_in_article 63 'pollutants; \[2\]' 'pollutants. [2]' | \
    amend_error_in_article 63 'imprisonment to a period' 'imprisonment for a period' | \
    #Article 64
    amend_error_in_article 64 '\(1\) and \(5\)' '[1] and [5]' | \
    amend_error_in_article 64 'Handle or transport hazardous waste' 'Handles or transports hazardous waste' | \
    amend_error_in_article 64 'waste; Shall' 'waste; shall' | \
    #Article 68
    amend_error_in_article 68 'Law; \[2\]' 'Law. [2]' | \
    #Article 69
    amend_error_in_article 69 '\(3\) ,' '[3],' | \
    amend_error_in_article 69 'Law: \[3\]' 'Law. [3]' | \
    #Article 74
    amend_error_in_article 74 'nver' 'river' | \
    amend_error_in_article 74 'degradation an take' 'degradation and take' | \
    #Article 75
    amend_error_in_article 75 'drilJ' 'drill' | \
    amend_error_in_article 75 'may by notice publish' 'may by published notice' | \
    amend_error_in_article 75 'riverbanks lakeshores or wetlands' 'riverbanks, lakeshores or wetlands' | \
    #Article 76
    amend_error_in_article 76 'lanel' 'land' | \
    #Article 77
    amend_error_in_article 77 'inn' 'in' | \
    amend_error_in_article 77 'of this section \[4\]' 'of this section. [4]' | \
    amend_error_in_article 77 '\(3\) and \(4\)' '[3] and [4]' | \
    amend_error_in_article 77 'con ' 'on ' | \
    amend_error_in_article 77 'with Line Ministry' 'with the Line Ministry' | \
    amend_error_in_article 77 'a forest areas a specially protected forest areas' 'a forest area a specially protected forest area' | \
    #Article 78
    amend_error_in_article 78 'actin ' 'action ' | \
    #Article 79
    amend_error_in_article 79 'Environemt' 'Environment' | \
    #Article 80
    amend_error_in_article 80 'reserve \[d\]' 'reserve; [d]' | \
    sed -E 's/51 Conservation to Energy/Conservation of Energy/' | \
    #Article 81
    amend_error_in_article 81 'Promoti ng' 'Promoting' | \
    #Article 82
    amend_error_in_article 82 'declare an' 'declare and' | \
    amend_error_in_article 82 'offence an' 'offence and' | \
    amend_error_in_article 82 'may by notice published' 'may by published notice' | \
    amend_error_in_article 82 'The first Report be produced' 'The first Report shall be produced' | \
    amend_error_in_article 82 'Act: \[6\]' 'Act. [6]' | \
    amend_error_in_article 82 "aircraft's and other engines" "aircrafts and other engines" | \
    amend_error_in_article 82 'installations and another structures' 'installations and other structures' | \
    amend_error_in_article 82 'any structure in on, under' 'any structure in, on, under' | \
    #Article 83
    amend_error_in_article 83 'disagregated' 'disaggregated' | \
    amend_error_in_article 83 'protection an influences' 'protection and influences' | \
    amend_error_in_article 83 'the allocation resources' 'the allocation of resources' | \
    #Article 84
    amend_error_in_article 83 'Conservation of Biological Resources In-situ Article' '\n\nConservation of Biological Resources In-situ \n(84)' | \
    amend_error_in_article 84 'habitats are threatened' 'habitats that are threatened' | \
    #Article 85
    amend_error_in_article 84 'Conservation of Biological Resources Ex-situ' '\n\nConservation of Biological Resources Ex-situ \n(85)' | \
    amend_error_in_article 85 'Article 54 ' '' | \
    amend_error_in_article 85 'aquana' 'aquaria' | \
    amend_error_in_article 85 'orgamsms' 'organisms' | \
    amend_error_in_article 85 '1V.' '[iv]' | \
    amend_error_in_article 85 '\[1\] germplasm' '[i] germplasm' | \
    amend_error_in_article 85 '\[1\] the' '[i] the' | \
    amend_error_in_article 85 'parks, and \[vi\]' 'parks; and [vi]' | \
    #Article 86
    sed -E 's/Resou rces/Resources/' | \
    amend_error_in_article 86 'nonresidents' 'non residents' | \
    amend_error_in_article 86 'ofDistrict' 'of District' | \
    amend_error_in_article 86 'collection characterization, evaluation' 'collection, characterization, evaluation' | \
    #Article 87
    sed -E 's/55 Land/Land/' | \
    amend_error_in_article 87 'with he' 'with the' | \
    amend_error_in_article 87 'strengthening or management systems' 'strengthening of management systems' | \
    #Article 88
    amend_error_in_article 88 'environmentally; , \[b\]' 'environmentally; [b]' | \
    amend_error_in_article 88 'objects an sites' 'objects and sites' | \
    amend_error_in_article 88 'paragraph \(a\)' 'paragraph [a]' | \
    #Article 89
    amend_error_in_article 89 '\[i\] The' '[1] The' | \
    #Article 90
    amend_error_in_article 90 '\(6\)' '[6]' | \
    amend_error_in_article 90 'order shall have contain' 'order shall contain' | \
    amend_error_in_article 90 'environment of the conservation' 'environment or the conservation' | \
    amend_error_in_article 90 'An Environmental Inspect of the Agency' 'An Environmental Inspector of the Agency' | \
    #Article 91
    amend_error_in_article 91 'COUli' 'Court' | \
    amend_error_in_article 91 ' hall ' ' shall ' | \
    amend_error_in_article 91 'order: \[4\]' 'order. [4]' | \
    amend_error_in_article 91 '\[7\] I shall' '[7] It shall' | \
    #Article 92
    amend_error_in_article 92 '\(l\)' '[1]' | \
    #Article 93
    amend_error_in_article 92 'Action by' '\n\nAction by' | \
    sed -E 's/Article Environmental Restoration Order/Environmental Restoration Order\n(93)/' | \
    amend_error_in_article 93 'to he' 'to the' | \
    amend_error_in_article 93 'served fails, the owner' 'served fails the owner' | \
    amend_error_in_article 93 'order an may be deemed' 'order as may be deemed' | \
    #Article 94
    amend_error_in_article 94 '\(93\) and \(94\)' '93 and 94' | \
    #Article 95
    amend_error_in_article 95 '21 \(2\)' '21[2]' | \
    amend_error_in_article 95 'with he' 'with the' | \
    amend_error_in_article 95 'machi nery' 'machinery' | \
    amend_error_in_article 95 'uncler' 'under' | \
    amend_error_in_article 95 'an the' 'and the' | \
    amend_error_in_article 95 'or \[1\]' 'or [l]' | \
    amend_error_in_article 95 'paragraph \(h\)' 'paragraph [h]' | \
    amend_error_in_article 95 'manufacturing plant undertaking or establishment' 'manufacturing plant, undertaking or establishment' | \
    amend_error_in_article 95 'liable on conviction of a fine' 'liable on conviction to a fine' | \
    #Article 99
    sed -E ':start;s/^(\(99\).*)intemational/\1international/;t start' | \
    amend_error_in_article 99 'conceming' 'concerning' | \
    amend_error_in_article 99 'than he ' 'than the ' | \
    amend_error_in_article 99 'and Whether' 'and whether' | \
    amend_error_in_article 99 'identify appropriate measure' 'identify appropriate measures' | \
    amend_error_in_article 99 'treatise and protocols' 'treaties and protocols' | \
    amend_error_in_article 99 'all-international conventions' 'all international conventions' | \
    #Article 100
    amend_error_in_article 100 'guidelines and principle' 'guidelines and principles' | \
    #Article 101
    amend_error_in_article 101 'A personae' 'A person' | \
    amend_error_in_article 101 'prescribed form indication' 'prescribed form indicating' | \
    amend_error_in_article 101 'access to information; \[a\]' 'access to information: [a]' | \
    amend_error_in_article 101 'within its offices; the Agency' 'within its offices, the Agency' | \
    amend_error_in_article 101 '. \[2' '; [2' | \
    amend_error_in_article 101 '. \[3' '; [3' | \
    amend_error_in_article 101 '. \[4' '; [4' | \
    amend_error_in_article 101 '. \[5' '; [5' | \
    amend_error_in_article 101 '. \[6' '; [6' | \
    amend_error_in_article 101 '. \[7' '; [7' | \
    amend_error_in_article 101 '. \[8' '; [8' | \
    #Article 103
    amend_error_in_article 103 'The Agency may, publish' 'The Agency may publish' | \
    #Article 104
    amend_error_in_article 104 'may on the application to the Agency' 'may on application to the Agency' | \
    amend_error_in_article 104 'to the Agency may be determined' 'to the Agency as may be determined' | \
    #Article 105
    amend_error_in_article 105 'briefin' 'brief in' | \
    amend_error_in_article 105 'an is' 'and is' | \
    amend_error_in_article 105 'intent; in accordance' 'intent in accordance' | \
    amend_error_in_article 105 'liable on conviction, to imprisonment' 'liable on conviction to imprisonment' | \
    #Article 108
    amend_error_in_article 108 'shall also be deemed to be shall be guilty' 'shall also be deemed to be guilty' | \
    amend_error_in_article 108 '\[2\] a person' '[2] A person' | \
    amend_error_in_article 108 'partnership; \[3\] an' 'partnership. [3] An' | \
    amend_error_in_article 108 'directions \[4\] it' 'directions. [4] It' | \
    amend_error_in_article 108 'diligence or prevent' 'diligence to prevent' | \
    amend_error_in_article 108 'the act a' 'the act is' | \
    #Article 111
    amend_error_in_article 111 'gender or neuter' 'gender or neutral' | \
    amend_error_in_article 111 'genders and the neuter; and \[4\]' 'genders and the neutral. [4]' | \
    #Article 112
    amend_error_in_article 112 ' for a tern' ' for a term' 
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