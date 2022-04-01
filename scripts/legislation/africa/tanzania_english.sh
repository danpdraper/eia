#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^ENACTED by Parliament of the United Republic of Tanzania./,$p' | \
    sed -n '/^PART I/,$p'
}

function prefix_article_numbers_with_article_literal {
  sed -E 's/^([0-9]+\. |[0-9]+\.\()/Article \1 /'
}

function replace_parentheses_around_article_delimiters_with_square_brackets {
  sed -E 's/\(([A-Za-z0-9]+)\)/[\1]/g'
}

function remove_all_text_after_last_article {
  sed -z 's/No. 20 Environmental Management 2004 123.*$//' 
}

function amend_errors_in_articles {
  sed -E 's/·//g' | \
    sed -E 's/  / /g' | \
    sed -E "s/''/|/g" | \
    sed -E 's/\|/"/g' | \
    sed -E 's/No.20 Environmental Management 2004 [0-9]{2} //g' | \
    sed -E 's/No. 20 Environmental Management 2004 |No. 20 Environmental Management 2004 [0-9]{2} //g' | \
    sed -E 's/- /: /g' | \
    sed -E 's/\[•\] //g' | \
    sed -E 's/; \./;/g' | \
    sed -E 's/ \.([A-z])/\1/g' | \
    sed -E 's/ \. / /g' | \
    sed -E 's/\[([0-9]+)\]-/\n\n(\1) /g' | \
    sed -E 's/\( 1 \)/[1]/g' | \
    sed -E 's/\( \[/[/g' | \
    sed -E 's/\. ([a-z])/ \1/g' | \
    sed -E 's/ ,/,/g' | \
    sed -E 's/::/:/g' | \
    sed -E 's/;\./;/g' | \
    sed -E 's/sub-section/subsection/g' | \
    sed -E 's/detennining/determining/g' | \
    sed -E 's/detennine/determine/g' | \
    sed -E 's/infonnation/information/g' | \
    sed -E 's/infonn/inform/g' | \
    sed -E 's/hann/harm/g' | \
    sed -E 's/confonn/conform/g' | \
    sed -E 's/perfornnance|perfonnance/performance/g' | \
    sed -E 's/perfonn/perform/g' | \
    sed -E 's/pennit/permit/g' | \
    #Article 1
    amend_error_in_article 1 '\[2004\] 2.-' '2004\.\n\n(2) ' | \
    #Article 2
    amend_error_in_article 2 ' \[1\],' ' [1] ' | \
    #Article 3
    amend_error_in_article 3 'meansa' 'means a' | \
    amend_error_in_article 3 'thj.s' 'this' | \
    amend_error_in_article 3 'micro-organism ....' 'micro-organism' | \
    amend_error_in_article 3 'organismcommunities' 'organism communities' | \
    amend_error_in_article 3 'micro organism' 'micro-organism' | \
    amend_error_in_article 3 'theitnott-tivin' 'their non-livin' | \
    amend_error_in_article 3 'interactihg' 'interacting' | \
    amend_error_in_article 3 'ofdpmestic' 'of domestic' | \
    amend_error_in_article 3 '~ or ind.u~al otjgin trea~ or untreated and discharged.' 'or industrial origin treated or untreated and discharged ' | \
    amend_error_in_article 3 '~sthetics' 'aesthetics' | \
    amend_error_in_article 3 'objectiye;evall18tjon of how wen ~nviro~ental org~ization' 'objective evaluation of how well environment organization' | \
    amend_error_in_article 3 'ex situ' 'ex-situ' | \
    amend_error_in_article 3 'me3:Ds' 'means' | \
    amend_error_in_article 3 'kirids' 'kinds' | \
    amend_error_in_article 3 'prpvisions' 'provisions' | \
    amend_error_in_article 3 'part IX' 'PART IX' | \
    amend_error_in_article 3 '16 Act No.3 of2003' '' | \
    amend_error_in_article 3 'o~ism' 'organism' | \
    amend_error_in_article 3 'booodary as defmed in the \\lienna' 'boundary as defined in the Vienna' | \
    amend_error_in_article 3 'Oiganic' 'Organic' | \
    amend_error_in_article 3 'thq' 'the' | \
    amend_error_in_article 3 '~anagement' 'Management' | \
    amend_error_in_article 3 'fSCribed' 'prescribed' | \
    amend_error_in_article 3 'the .' 'the' | \
    amend_error_in_article 3 'bome by the person convi~ted' 'borne by the person convicted' | \
    amend_error_in_article 3 'other.applicable' 'other applicable' | \
    amend_error_in_article 3 'thennal' 'thermal' | \
    amend_error_in_article 3 'dischaiging' 'discharging' | \
    amend_error_in_article 3 'organit.ations' 'organizations' | \
    amend_error_in_article 3 'marlcet' 'market' | \
    amend_error_in_article 3 'institutio~' 'institution' | \
    amend_error_in_article 3 'and.operations' 'and operations' | \
    amend_error_in_article 3 'solid waste _f:lisposal' 'solid waste disposal' | \
    amend_error_in_article 3 'final stage ~ solid ~ managem_e~t system' 'final stage in solid waste management system' | \
    amend_error_in_article 3 'ActNo. 7 of 2003 18' '' | \
    amend_error_in_article 3 "Right to -bring an action on environment by futlU'e" 'by future' | \
    amend_error_in_article 3 'focludes' 'includes' | \
    amend_error_in_article 3 '\[1\]U1derground' 'underground' | \
    amend_error_in_article 3 'meansa' 'means a' | \
    amend_error_in_article 3 'agricultural,or' 'agricultural, or' | \
    amend_error_in_article 3 ": 'health.and disease that are deteniiined by factors iri" " health and disease that are determined by factors in" | \
    amend_error_in_article 3 'PART I -X' 'PART IX' | \
    amend_error_in_article 3 '\[2003\]' '2003;' | \
    amend_error_in_article 3 'lnfonnation' 'Information' | \
    amend_error_in_article 3 'cmrying' 'carrying' | \
    amend_error_in_article 3 "'lrade" '"Trade' | \
    amend_error_in_article 3 "'lransfer" '"Transfer' | \
    amend_error_in_article 3 'or -' 'or ' | \
    amend_error_in_article 3 'thenvironment' 'the environment' | \
    amend_error_in_article 3 'charmel' 'channel' | \
    amend_error_in_article 3 '14 "' '"' | \
    amend_error_in_article 3 'DirectorGeneral" means the.' 'Director General" means the' | \
    amend_error_in_article 3 '" and' 'and' | \
    amend_error_in_article 3 '\[GMO\]' '(GMO)' | \
    amend_error_in_article 3 ",'" ',' | \
    amend_error_in_article 3 '; by means of cell or gene technology;' ', by means of cell or gene technology,' | \
    amend_error_in_article 3 '\[POPs\]' '(POPs)' | \
    amend_error_in_article 3 'any "' 'any' | \
    amend_error_in_article 3 'are~' 'areas' | \
    amend_error_in_article 3 'environmentand' 'environment and' | \
    amend_error_in_article 3 'measuages' 'messuages' | \
    amend_error_in_article 3 'other radiation "likely to have' 'other radiation likely to have' | \
    amend_error_in_article 3 'homesteads, institution' 'homesteads, institutions' | \
    amend_error_in_article 3 'abandoned cars scraps' 'abandoned car scraps' | \
    amend_error_in_article 3 'undertaking-for' 'undertaking for' | \
    #Article 4
    amend_error_in_article 4 '\[l' '[1' | \
    sed -E 's/to clean, safe/to a clean, safe/g' | \
    #Article 5
    amend_error_in_article 5 '\[l\]' '[1]' | \
    amend_error_in_article 5 'therinciple' 'the principle' | \
    amend_error_in_article 5 'omissionislikely' 'omission is likely' | \
    amend_error_in_article 5 'useslost' 'uses lost' | \
    amend_error_in_article 5 'in relation: to' 'in relation to' | \
    amend_error_in_article 5 'in the development policies' 'in the development of policies' | \
    #Article 6
    amend_error_in_article 6 'environment ment' 'environment' | \
    amend_error_in_article 6 'sys~m' 'system' | \
    #Article 7
    amend_error_in_article 6 ' 20 Principles of environmental manage7.-' '\n\n(7) ' | \
    amend_error_in_article 7 'integration and co-q>eratioo of effi>rts, winch coosider1he entire envilooment as' 'integration and cooperation of efforts, which consider the entire environment as' | \
    amend_error_in_article 7 '.. . . ... ' '' | \
    amend_error_in_article 7 'o~' 'or' | \
    amend_error_in_article 7 'environment \[2\]' 'environment. [2]' | \
    amend_error_in_article 7 "as'" 'as' | \
    amend_error_in_article 7 "'\[" '[' | \
    amend_error_in_article 7 "respe'ct" 'respect' | \
    #Article 9
    amend_error_in_article 9 'Environmental Policy..*$' 'Environment Policy.' | \
    amend_error_in_article 9 'Promotion of the National Environment Policy.' '' | \
    #Article 10
    amend_error_in_article 10 'to be known as' 'to be known as Environment Day' | \
    #Article 11
    amend_error_in_article 11 'members, specified' 'members specified' | \
    #Article 12
    amend_error_in_article 12 'it shall' 'it shall:' | \
    amend_error_in_article 12 '\[b\] Minister Responsible for Environment' '\n\n(b) Minister Responsible for Environment' | \
    amend_error_in_article 12 ',where' ', where' | \
    #Article 13
    amend_error_in_article 13 '\[c\] Director of Environment' '\n\n(c) Director of Environment' | \
    #Article 14
    amend_error_in_article 14 'Powers ofthe.*$' '' | \
    #Article 15
    amend_error_in_article 15 'coordinare issues relating to articulatioo' 'coordinate issues relating to the articulation' | \
    amend_error_in_article 15 'to articulation' 'to the articulation' | \
    amend_error_in_article 15 '\[d\] National' '\n\n(d) National' | \
    #Article 16
    amend_error_in_article 16 'naine' 'name' | \
    amend_error_in_article 16 'by acronym' 'by the acronym' | \
    #Article 18
    amend_error_in_article 18 'canying' 'carrying' | \
    amend_error_in_article 18 'persons,' 'persons.' | \
    amend_error_in_article 18 'Object for establishment ofthe Council Functions ofthe Council 26 ' '' | \
    amend_error_in_article 18 'undertake;' 'undertake,' | \
    amend_error_in_article 18 'G\)' '[j]' | \
    #Article 22
    amend_error_in_article 21 '28' '' | \
    amend_error_in_article 21 'Article \[22\]' '\n\n(22)' | \
    amend_error_in_article 22 "dischal'ge" 'discharge' | \
    amend_error_in_article 22 'tenns' 'terms' | \
    #Article 23
    amend_error_in_article 23 'wtder' 'under' | \
    amend_error_in_article 23 'powerto' 'power to' | \
    amend_error_in_article 23 'pwpose' 'purpose' | \
    amend_error_in_article 23 'Oiganisation' 'Organizations' | \
    amend_error_in_article 23 'Cowtcil' 'Council' | \
    #Article 24
    amend_error_in_article 23 '\[220\] 24.-' '220.\n\n(24) ' | \
    amend_error_in_article 24 'perfonned' 'performed' | \
    #Article 27
    amend_error_in_article 27 'Chainnan' 'Chairman' | \
    #Article 29
    amend_error_in_article 29 '\[e\]' '\n\n(e)' | \
    amend_error_in_article 29 'Powers ofthe.*$' '' | \
    #Article 30
    amend_error_in_article 30 'otherwritten' 'other written' | \
    amend_error_in_article 30 'liason' 'liaison' | \
    #Article 31
    amend_error_in_article 31 'coordinat\.e' 'coordinate' | \
    amend_error_in_article 31 'worlcing' 'working' | \
    #Article 32
    amend_error_in_article 32 'Sector.' 'Sector' | \
    amend_error_in_article 32 'environm~nt' 'environment' | \
    amend_error_in_article 32 'Submission of sector.* expert ' '' | \
    amend_error_in_article 32 '\[a\] bi-annual report' '[a] a bi-annual report' | \
    #Article 33
    amend_error_in_article 33 '-shall' 'shall' | \
    amend_error_in_article 33 'mlling' 'falling' | \
    amend_error_in_article 33 '\[I\] Regional Secretariat' '\n\n(f) Regional Secretariat' | \
    #Article 35
    amend_error_in_article 35 '\[g\] Local GovernmentAuthorities' '\n\n(g) Local Government Authorities' | \
    #Article 36
    amend_error_in_article 36 'shall \[a\]' 'shall: [a]' | \
    amend_error_in_article 36 'by~laws' 'bylaws' | \
    amend_error_in_article 36 'FW1Ctions.*$' '' | \
    amend_error_in_article 36 'the Management Officer who shall be known' 'the Management Officer shall be known' | \
    amend_error_in_article 36 'the Management Officer who shall be known as the District Environment Management Officer' 'the Management Officer shall be known as the District Environment Management Officer' | \
    #Article 37
    amend_error_in_article 37 'Commit: ' '' | \
    amend_error_in_article 37 'tees of ' '' | \
    amend_error_in_article 37 'Worlcs and Enviroilment govern: ' 'Works and Environment ' | \
    amend_error_in_article 37 'ment authori: ' '' | \
    amend_error_in_article 37 'tics ' '' | \
    amend_error_in_article 37 'Act Nos ' '' | \
    amend_error_in_article 37 '7 and 8 Committee' 'Committee' | \
    amend_error_in_article 37 'of 1982 Standing Committees in townships, wards, villages and kitongoji Act Nos. 7 and 8 ofl982 ' '' | \
    amend_error_in_article 37 'established \[2\]' 'established. [2]' | \
    #Article 38
    amend_error_in_article 38 'Worlcs ' 'Works ' | \
    amend_error_in_article 38 '\[District\] Authorities Act, \[1982\]' '(District Authorities) Act, 1982.' | \
    amend_error_in_article 38 'mutatts' 'mutatis' | \
    amend_error_in_article 38 'perform any other function or discharging' 'perform any other function or discharge' | \
    amend_error_in_article 38 'relating to ancillary or incidental to' 'relating to, ancillary or incidental to' | \
    #Article 40
    amend_error_in_article 40 'Article \[41\]' '\n\n(41)' | \
    amend_error_in_article 40 'Designation of the Township, Ward.*$' '' | \
    #Article 41
    amend_error_in_article 41 'fu' 'to' | \
    amend_error_in_article 41 'Government departments' 'government departments' | \
    amend_error_in_article 41 "any'" 'any' | \
    amend_error_in_article 41 'retoses' 'refuses' | \
    amend_error_in_article 41 'related fu' 'related to' | \
    amend_error_in_article 41 'have reasonable cause to believes' 'has reasonable cause to believe' | \
    amend_error_in_article 41 'substances believes to be pollutant' 'substances believed to be pollutant' | \
    #Article 42
    amend_error_in_article 42 '\$Overnment' 'government' | \
    amend_error_in_article 42 'junsdiction' 'jurisdiction' | \
    #Article 43
    amend_error_in_article 43 'conmued' 'construed' | \
    amend_error_in_article 43 'confonnity' 'conformity' | \
    #Article 44
    amend_error_in_article 44 'tbs' 'the' | \
    amend_error_in_article 44 'Minister;.*\[f\]' 'Minister; [f]' | \
    amend_error_in_article 44 '\[1\] provide' '[l] provide' | \
    amend_error_in_article 44 'be the, basis' 'be the basis' | \
    #Article 45
    amend_error_in_article 45 'which Environment' 'which the Environment' | \
    #Article 46
    amend_error_in_article 46 'public the' 'public of the' | \
    #Article 47
    amend_error_in_article 47 'Protected Area\. \.' 'Protected Area.' | \
    amend_error_in_article 47 'fur 1he Govennnent \[t\]o' 'for the Government to' | \
    amend_error_in_article 47 '\[t\]o' 'to' | \
    amend_error_in_article 47 'protected area under' 'protected areas under' | \
    #Article 48
    amend_error_in_article 48 'Environmental protection plan and ecosystem management plan for Environmental Protected Areas 40 Environmental Management Plans for national Protected Areas ' '' | \
    #Article 49
    amend_error_in_article 49 '\[1\] \(b \)' '[1][b]' | \
    amend_error_in_article 49 'Management measure' 'Management measures' | \
    amend_error_in_article 49 '\[1\] \[f\]' '[1][f]' | \
    amend_error_in_article 49 "person's identified" 'persons identified' | \
    amend_error_in_article 49 '\[e\] benefit' '[d] benefit' | \
    amend_error_in_article 49 '\[t\] entrance' '[e] entrance' | \
    amend_error_in_article 49 '\[g\] any other' '[f] any other' | \
    #Article 50
    sed -E 's/SO\./\n\n(50)/' | \
    #Article 51
    amend_error_in_article 51 'regula~ en:vironmentally sensiti_ve' 'regulate environmentally sensitive' | \
    amend_error_in_article 51 'area under' 'areas under' | \
    amend_error_in_article 51 'environmental sensitive areas' 'environmentally sensitive areas' | \
    #Article 52
    amend_error_in_article 52 'pwposes' 'purposes' | \
    amend_error_in_article 52 'Land utilization management.*\[i\]' '[i]' | \
    amend_error_in_article 52 '\[t\]' '[f]' | \
    #Article 53
    amend_error_in_article 53 'andagriculturalists in tenns' 'and agriculturalists in terms' | \
    #Article 54
    amend_error_in_article 54 'publishedin' 'published in' | \
    amend_error_in_article 54 "lake' or lakesliore" 'lake or lakeshore' | \
    amend_error_in_article 54 'sub~ction' 'subsection' | \
    amend_error_in_article 54 'Minisr,er' 'Minister' | \
    amend_error_in_article 54 '  ' ' ' | \
    amend_error_in_article 54 'advise' 'advice' | \
    amend_error_in_article 54 '; and any advice' '; and [c] any advice' | \
    #Article 55
    amend_error_in_article 55 'environme_ntal' 'environmental' | \
    amend_error_in_article 55 'pennit' 'permit' | \
    amend_error_in_article 55 '01' 'or' | \
    amend_error_in_article 55 'a ocean' 'an ocean' | \
    amend_error_in_article 55 'river: bank' 'river bank' | \
    amend_error_in_article 55 'Environment;' 'Environment,' | \
    amend_error_in_article 55 'any of the following activity' 'any of the following activities' | \
    amend_error_in_article 55 'lake or, lakeshore' 'lake or lakeshore' | \
    amend_error_in_article 55 'lakeshore shoreline' 'lakeshore, shoreline' | \
    sed -E 's/lake or; lakeshore/lake or lakeshore/' | \
    #Article 56
    amend_error_in_article 56 'Declaration of protected wetlands 44 Prohibit:' '' | \
    #Article 57
    amend_error_in_article 57 'a ion of ' '' | \
    amend_error_in_article 57 'hwnan' 'human' | \
    amend_error_in_article 57 'Protection of mountains, hills and landscapes Promotion of coastal zone environmental manage: ment ' '' | \
    amend_error_in_article 57 'subsection \(1 \)' 'subsection [1]' | \
    #Article 58
    amend_error_in_article 58 '_the _are_a at_ a_ rare faster ~an.' 'the area at a rate faster than' | \
    #Article 60
    amend_error_in_article 60 'Environrelevant' 'relevant' | \
    amend_error_in_article 60 ':~:aimpact' 'impact' | \
    amend_error_in_article 60 'requested under' 'requested.' | \
    amend_error_in_article 60 'p_urposes' 'purposes' | \
    amend_error_in_article 60 'abstracifon' 'abstraction' | \
    amend_error_in_article 60 'pennit' 'permit' | \
    amend_error_in_article 60 'conditio~s' 'conditions' | \
    amend_error_in_article 60 'µses' 'uses' | \
    amend_error_in_article 60 "'made" 'made' | \
    amend_error_in_article 60 'likelyimpact' 'likely impact' | \
    amend_error_in_article 60 'for water use' 'for a water use' | \
    amend_error_in_article 60 'abstraction mental' 'abstraction' | \
    #Article 63
    amend_error_in_article 63 'Minister may advise.*biological diversity ' '' | \
    #Article 64
    amend_error_in_article 64 ',: energy, promote -the use of renewable sources of energy' 'energy, promote the use of renewable sources of energy' | \
    amend_error_in_article 64 "sources '" 'sources' | \
    amend_error_in_article 64 "of '" 'of' | \
    amend_error_in_article 64 'and i' 'and' | \
    amend_error_in_article 64 'beenergy' 'be' | \
    amend_error_in_article 64 'woodlors' 'woodlots' | \
    amend_error_in_article 64 'ot as' 'or as' | \
    amend_error_in_article 64 'renewal sources' 'renewable sources' | \
    #Article 65
    amend_error_in_article 65 '\[1994\]' '1994.' | \
    amend_error_in_article 65 'the provision of the' 'the provisions of the' | \
    #Article 66
    amend_error_in_article 66 '\[I\] The' '[1] The' | \
    amend_error_in_article 66 'resources~' 'resources,' | \
    amend_error_in_article 66 'accowit' 'account' | \
    amend_error_in_article 66 '; \.' ';' | \
    amend_error_in_article 66 'cross.:sectoral' 'cross-sectoral' | \
    amend_error_in_article 66 'sustainable ~' 'sustainable use' | \
    amend_error_in_article 66 'mechanism;r' 'mechanism; of' | \
    amend_error_in_article 66 '  ' ' ' | \
    amend_error_in_article 66 'The Minister may, take into account' 'The Minister may take into account' | \
    amend_error_in_article 66 'conservations equitable sharing' 'conservation, equitable sharing' | \
    #Article 67
    amend_error_in_article 67 '\[l\] The' '[1] The' | \
    amend_error_in_article 67 'regulate\.or' 'regulate or' | \
    amend_error_in_article 67 'Conserva1ion of biological diversity in-situ 48 ' '' | \
    amend_error_in_article 67 '\.\. plans or o~~r' 'of plans or other' | \
    amend_error_in_article 67 'economic cultural' 'economic, cultural' | \
    amend_error_in_article 67 'system.or' 'system or' | \
    amend_error_in_article 67 'Environmental Management' '' | \
    amend_error_in_article 67 'of of' 'of' | \
    #Article 68
    amend_error_in_article 68 'maintainfacilities' 'maintain facilities' | \
    amend_error_in_article 68 'naturalhabitats' 'natural habitats' | \
    #Article 69
    amend_error_in_article 69 '\[l\] Without' '[1] Without' | \
    amend_error_in_article 69 '\[GMO\]' '(GMO)' | \
    amend_error_in_article 69 '_personal injury' 'personal injury' | \
    amend_error_in_article 69 'donnant' 'dormant' | \
    amend_error_in_article 69 'fonn' 'form' | \
    amend_error_in_article 69 'import or export' 'imports or exports' | \
    amend_error_in_article 69 'various, viruses' 'various viruses' | \
    #Article 70
    amend_error_in_article 70 'Conserva -tion.*\[2\]' '[2]' | \
    amend_error_in_article 70 '\[l\]' '[1]' | \
    amend_error_in_article 70 'Other' 'other' | \
    #Article 71
    amend_error_in_article 71 'loc~' 'local' | \
    amend_error_in_article 71 "' ' " '' | \
    #Article 73
    amend_error_in_article 73 'thisAct' 'this Act' | \
    amend_error_in_article 73 '\[2\].' '[2]' | \
    amend_error_in_article 73 'Protec:' '' | \
    #Article 74
    amend_error_in_article 74 'sector tion' 'sector' | \
    amend_error_in_article 74 'the atmosphere ' '' | \
    amend_error_in_article 74 'lay~r;or .' 'layer;' | \
    amend_error_in_article 74 'iikely' 'likely' | \
    amend_error_in_article 74 'aildconsiifuption ' 'and consumption ' | \
    amend_error_in_article 74 'sector of Ministry' 'sector Ministry' | \
    #Article 75
    amend_error_in_article 75 'wanning' 'warning' | \
    amend_error_in_article 75 'schot>ls' 'schools' | \
    amend_error_in_article 75 'finn' 'firm' | \
    amend_error_in_article 75 '\[s\]' '(s)' | \
    amend_error_in_article 75 'global warning' 'global warming' | \
    #Article 76
    sed -E 's/76,-\[1\]/\n\n(76) [1]/' | \
    amend_error_in_article 75 'Measures on climate.*$' '' | \
    amend_error_in_article 76 'pursu_ant' 'pursuant' | \
    amend_error_in_article 76 'ov\.er' 'over' | \
    amend_error_in_article 76 'iii' 'in' | \
    amend_error_in_article 76 'circwristances' 'circumstances' | \
    amend_error_in_article 76 'of authoriz\.ation' 'of authorization' | \
    amend_error_in_article 76 'authoriz\.ation of' 'authorization of' | \
    amend_error_in_article 76 '\. \.' '.' | \
    #Article 77
    amend_error_in_article 77 'F.nvironment' 'Environment' | \
    amend_error_in_article 77 'No. 20 Environmental Management 2004 53 ' '' | \
    amend_error_in_article 77 'to-any applicable written Jaw' 'to any applicable written law' | \
    amend_error_in_article 77 'Stockholni' 'Stockholm' | \
    amend_error_in_article 77 'replacementof persistent organic poUutants' 'replacement of persistent organic pollutants' | \
    amend_error_in_article 77 '01ganic' 'organic' | \
    amend_error_in_article 77 '\[t\] involvement' '[f] involvement' | \
    amend_error_in_article 77 'managementPractices' 'management practices' | \
    amend_error_in_article 77 '\[1\] compliance' '[l] compliance' | \
    amend_error_in_article 77 'ofhazardous' 'of hazardous' | \
    amend_error_in_article 77 '54 Prior informed consent procedures for certain hazardous chemicals and pesticides ' '' | \
    amend_error_in_article 77 'fonnulations' 'formulations' | \
    amend_error_in_article 77 'iri' 'in' | \
    amend_error_in_article 77 'incfostrial' 'industrial' | \
    amend_error_in_article 77 'shall mainstream respective parts of the National Implementation Plan and into their policies' 'shall mainstream respective parts of the National Implementation Plan into their policies' | \
    #Article 78
    amend_error_in_article 77 '78~-\( l \):' '\n\n(78) [1]' | \
    amend_error_in_article 78 'Infonned Consent \[PIC\]' 'Informed Consent (PIC)' | \
    amend_error_in_article 78 'acqvities' 'activities' | \
    amend_error_in_article 78 'in.their' 'in their' | \
    amend_error_in_article 78 'No. 20 Environmenta\/Management 2004 55 ' '' | \
    amend_error_in_article 78 'Minis.tries' 'Ministries' | \
    #Article 79
    amend_error_in_article 79 'stistmnable' 'sustainable' | \
    amend_error_in_article 79 'coµ.sumption' 'consumption' | \
    amend_error_in_article 79 '. \[d\] Economic Instruments' '\n\n(d) Economic Instruments' | \
    #Article 80
    amend_error_in_article 80 'Promotion of cleaner.*Impact Assessm ent ' '' | \
    amend_error_in_article 80 '\[t\] encourage' '[f] encourage' | \
    amend_error_in_article 80 'ofthe environment: <' 'of the environment:' | \
    amend_error_in_article 80 '\[b\] user chaige' ' [b] user charge' | \
    amend_error_in_article 80 '~cycling; and .' 'recycling; and' | \
    amend_error_in_article 80 'nuuket' 'market' | \
    #Article 82
    amend_error_in_article 82 'shal1make' 'shall make' | \
    amend_error_in_article 82 'Enviroruriental' 'Environmental' | \
    #Article 83
    amend_error_in_article 83 '_ ' '' | \
    amend_error_in_article 83 'finns' 'firms' | \
    amend_error_in_article 83 'Environmental Impact Assessm ent.*Impact Statement ' '' | \
    #Article 84
    amend_error_in_article 84 '\[l\] The' '[1] The' | \
    amend_error_in_article 84 'being _ executed, m~ed or __ operated' 'being executed, managed or operated' | \
    amend_error_in_article 84 'notifi~on' 'notification' | \
    #Article 85
    amend_error_in_article 85 '! ' '' | \
    amend_error_in_article 85 'an<I ' 'and ' | \
    amend_error_in_article 85 'consu~t.ed during the I ' 'consulted during the ' | \
    amend_error_in_article 85 'i \[c\]' '[c]' | \
    amend_error_in_article 85 'maintainedby' 'maintained by' | \
    amend_error_in_article 85 'Councilin' 'Council in' | \
    amend_error_in_article 85 'analyzing the required data' 'analyzing of the required data' | \
    amend_error_in_article 85 'contents, may be searched' 'contents may be searched' | \
    #Article 86
    amend_error_in_article 86 '\[l\] The' '[1] The' | \
    amend_error_in_article 86 '\[l\] shall' '[1] shall' | \
    #Article 87
    amend_error_in_article 87 ' of Environ:' '.' | \
    amend_error_in_article 87 'set,up' 'set up' | \
    amend_error_in_article 87 'tiie' 'the' | \
    amend_error_in_article 87 ' mental Impact Statement' '.' | \
    amend_error_in_article 87 'but not limited to' 'but is not limited to' | \
    #Article 88
    amend_error_in_article 88 "'lfflpection " '' | \
    amend_error_in_article 88 '~f pose ' '' | \
    amend_error_in_article 88 '-Impact' 'Impact' | \
    amend_error_in_article 88 '~n' 'in' | \
    amend_error_in_article 88 'for proposed project' 'for the proposed project' | \
    #Article 89
    amend_error_in_article 89 '\[l\] Without' '[1] Without' | \
    amend_error_in_article 89 'Environmental Impact Statement review.*the Minister' ':' | \
    #Article 90
    amend_error_in_article 90 'Inter a\/ta' 'inter alia' | \
    amend_error_in_article 90 're_levant reports, 4~ume~t:s' 'relevant reports, comments' | \
    amend_error_in_article 90 'mad~' 'made' | \
    #Article 92
    amend_error_in_article 92 'No. 20 Environmental Management 2004 61 ' '' | \
    amend_error_in_article 92 'fur' 'for' | \
    #Article 93
    amend_error_in_article 93 "Social, economic,'" 'social, economic,' | \
    #Article 95
    amend_error_in_article 95 'disapprove an' 'disapprove an Environmental Impact Statement' | \
    amend_error_in_article 95 'Environmental Impact Statement Environmental Impact Statement' 'Environmental Impact Statement' | \
    #Article 96
    amend_error_in_article 96 'record referred under' 'record referred to under' | \
    #Article 97
    amend_error_in_article 96 '\[97\]' '\n\n(97)' | \
    amend_error_in_article 96 'Cancellation of licence upon.*$' '' | \
    amend_error_in_article 97 'an ment' 'an' | \
    amend_error_in_article 97 'fresh Environ: ' '' | \
    amend_error_in_article 97 '_ _ Impact Assessment study wi~in' 'within' | \
    amend_error_in_article 97 "_ \. \[a\] there'" '[a] there' | \
    amend_error_in_article 97 '_ threat$' ' threats' | \
    amend_error_in_article 97 'Assessment mental study' 'Assessment study' | \
    amend_error_in_article 97 'environmental_ threat\$' 'environmental threats' | \
    #Article 98
    amend_error_in_article 97 'Offence ~8.' '\n\n(98)' | \
    amend_error_in_article 98 'di,rections for con:' 'directions' | \
    amend_error_in_article 98 ' traventing EIA Environmental monitoring' '.' | \
    #Article 99
    amend_error_in_article 99 'The_ Council' 'The Council' | \
    amend_error_in_article 99 'secto.r' 'sector' | \
    amend_error_in_article 99 'witha' 'with a' | \
    amend_error_in_article 99 'dete-rmining' 'determining' | \
    amend_error_in_article 99 'environmefit' 'environment' | \
    #Article 100
    amend_error_in_article 100 'revocatioh' 'revocation' | \
    #Article 101
    amend_error_in_article 101 'Monitoring compliance with.*' '' | \
    amend_error_in_article 101 'may; upon' 'may, upon' | \
    #Article 102
    amend_error_in_article 102 'the holder:fulfils' 'the holder fulfills' | \
    #Article 104
    amend_error_in_article 104 'Enviropmental' 'Environmental' | \
    amend_error_in_article 104 'pr~judice' 'prejudice' | \
    amend_error_in_article 104 'Every.' 'Every' | \
    amend_error_in_article 104 'manage111ent' 'management' | \
    amend_error_in_article 104 'tQ' 'to' | \
    amend_error_in_article 104 'enviromn.ent' 'environment' | \
    amend_error_in_article 104 'for.not' 'for not' | \
    amend_error_in_article 104 '66 Strategic.*\[c\]' '[c]' | \
    amend_error_in_article 104 '\. Qill, regulatio\.n' 'bill, regulation' | \
    amend_error_in_article 104 'giveeffect' 'give effect' | \
    amend_error_in_article 104 'of\.objection' 'of objection' | \
    amend_error_in_article 104 'fmal' 'final' | \
    amend_error_in_article 104 'revisedbill' 'revised bill' | \
    amend_error_in_article 104 'likely effects of such regulations' 'likely effects such regulations' | \
    amend_error_in_article 104 'policy Bills' 'policy, Bill' | \
    #Article 105
    amend_error_in_article 105 '\(1 \)' '[1]' | \
    amend_error_in_article 105 '1he' 'the' | \
    amend_error_in_article 105 'and  ' 'and ' | \
    amend_error_in_article 105 'limitatiops 9n' 'limitations on' | \
    amend_error_in_article 105 'orinadequacy' 'or inadequacy' | \
    amend_error_in_article 105 'mining,energy or w;:iter reg~ng' 'mining, energy or water regarding' | \
    amend_error_in_article 105 'io:be' 'to be' | \
    amend_error_in_article 105 'water project shall' 'water projects shall' | \
    amend_error_in_article 105 'mine or oil and gas site' 'mine or oil and gas sites' | \
    amend_error_in_article 105 'these development' 'these developments' | \
    #Article 106
    amend_error_in_article 106 'authoriz.ation' 'authorization' | \
    amend_error_in_article 106 'permitor' 'permit or' | \
    amend_error_in_article 106 "'lhe" 'the' | \
    amend_error_in_article 106 '," in' ', in' | \
    amend_error_in_article 106 'General prohibition of pollution 68 Powers of the Minister to make regulations to prevent and control pollution ' '' | \
    amend_error_in_article 106 "'Which" 'which' | \
    amend_error_in_article 106 '\. to ' 'to ' | \
    amend_error_in_article 106 'otoemit' 'or emit' | \
    amend_error_in_article 106 'contaminant,' 'contaminants,' | \
    #Article 107
    amend_error_in_article 107 'm~mitori1_1g' 'monitoring' | \
    amend_error_in_article 107 'guidefines ' 'guidelines ' | \
    amend_error_in_article 107 'and.controlling' 'and controlling' | \
    amend_error_in_article 107 '~ischarges' 'discharges' | \
    amend_error_in_article 107 'No. 20 Environmenta\/Management 2004 69 ' '' | \
    amend_error_in_article 107 'incoiporate ' 'incorporate ' | \
    amend_error_in_article 107 'iy' 'iv' | \
    amend_error_in_article 107 '< ' '' | \
    amend_error_in_article 107 'canying' 'carrying' | \
    #Article 108
    amend_error_in_article 108 'disclwge' 'discharge' | \
    amend_error_in_article 108 '_with' 'with' | \
    amend_error_in_article 108 'lrtegmted.*$' '' | \
    amend_error_in_article 108 'successfully applied' 'successfully applied.' | \
    #Article 109
    amend_error_in_article 109 'refuse-of' 'refuse of' | \
    amend_error_in_article 109 "solid'" 'solid' | \
    amend_error_in_article 109 "coinmits an' offence .." 'commits an offence.' | \
    amend_error_in_article 109 'to be earned' 'to be carried' | \
    #Article 110
    amend_error_in_article 110 'containmg' 'containing' | \
    amend_error_in_article 110 "o'r" 'or' | \
    amend_error_in_article 110 '    ' ' ' | \
    amend_error_in_article 110 'resuh of the dischalge' 'result of the discharge' | \
    amend_error_in_article 110 'fonn' 'form' | \
    amend_error_in_article 110 "toxic '" 'toxic ' | \
    amend_error_in_article 110 'the -' 'the ' | \
    amend_error_in_article 110 'this-Act.:' 'this Act.' | \
    amend_error_in_article 110 'The Council shall ~k an order of the coui:t f9r the d~~po~' ' The Council shall make an order of the court for the disposal' | \
    amend_error_in_article 110 'writtentaw, theCouncttshatl' 'written law, the Council shall' | \
    amend_error_in_article 110 'measures \.' 'measures.' | \
    amend_error_in_article 110 'energy; \[b\] industries' 'energy industries; [b]' | \
    amend_error_in_article 110 '\[b\], production' '[b] production' | \
    #Article 111
    amend_error_in_article 111 'Duty to keep.*or activity ' '' | \
    #Article 112
    amend_error_in_article 112 'pre,vention' 'prevention' | \
    amend_error_in_article 112 '\[2003\]' '2003.' | \
    amend_error_in_article 112 'conttavenes' 'contravenes' | \
    #Article 113
    amend_error_in_article 113 '.,' '.' | \
    amend_error_in_article 113 '-notice' 'notice' | \
    amend_error_in_article 113 '-: -: No. 20 Environmental Mar,agement 2004 73 ' '' | \
    amend_error_in_article 113 'activit\.' 'activity' | \
    amend_error_in_article 113 'it impose' 'it imposes' | \
    amend_error_in_article 113 'activity.,' 'activity.' | \
    amend_error_in_article 113 'ceases, to have effect' 'ceases to have effect' | \
    amend_error_in_article 113 'where, it applies' 'where it applies' | \
    #Article 114
    amend_error_in_article 114 'formechanisms' 'for mechanisms' | \
    amend_error_in_article 114 'manufucturers' 'manufacturers' | \
    amend_error_in_article 114 '\[d\]' '[c]' | \
    amend_error_in_article 114 '_the' 'the' | \
    amend_error_in_article 114 '\[1\]U1dertake' 'undertake' | \
    amend_error_in_article 114 'co~_po~ition' 'composition' | \
    amend_error_in_article 114 'Duty of local government to.*$' '' | \
    amend_error_in_article 114 'instil ' 'instill ' | \
    #Article 115
    amend_error_in_article 115 'oiganic' 'organic' | \
    amend_error_in_article 115 '. . J' '.' | \
    amend_error_in_article 115 'purpo~s' 'purpose' | \
    amend_error_in_article 115 'police,army' 'police, army' | \
    amend_error_in_article 115 'geographical areas of jurisdictions' 'geographical areas of jurisdiction' | \
    amend_error_in_article 115 '\[4\] for' '[4] For' | \
    #Article 116
    amend_error_in_article 116 'shalt' 'shall' | \
    #Article 118
    amend_error_in_article 118 'so\}id' 'solid' | \
    amend_error_in_article 118 'a11d se.cu_red to preve.nt' 'and secured to prevent' | \
    amend_error_in_article 118 'solid stations waste are generated' 'solid waste are generated' | \
    #Article 119
    amend_error_in_article 119 'me1hod' 'method' | \
    #Article 120
    amend_error_in_article 120 "'1>ublic" '"public' | \
    amend_error_in_article 120 '-land' 'land' | \
    amend_error_in_article 120 '\[a\] allow' '[b] allow' | \
    amend_error_in_article 120 'Final disposal of solid waste Interpret ation with regards to management of litter 76 Control oflitter in public places ' '' | \
    amend_error_in_article 120 "'l\)rivate" '"private' | \
    amend_error_in_article 120 "'l\)ublic" '"public' | \
    amend_error_in_article 120 'place" \[a\]' 'place": [a]' | \
    amend_error_in_article 120 'acces~' 'access' | \
    amend_error_in_article 120 'sto_rm' 'storm' | \
    amend_error_in_article 120 '\[vv\]1 .\) every whart:' '[v] every wharf,' | \
    amend_error_in_article 120 '1183' 'has' | \
    amend_error_in_article 120 '\[vi\]' '[vii]' | \
    amend_error_in_article 120 '\( any' '[vi] any' | \
    amend_error_in_article 120 'whetherpublic' 'whether public' | \
    amend_error_in_article 120 'in relation to litter; include' 'in relation to litter, includes' | \
    #Article 121
    amend_error_in_article 121 'or.escaping onto the public place.:' 'or escaping onto the public place.' | \
    amend_error_in_article 121 'subsection\[2\]' 'subsection [2]' | \
    amend_error_in_article 121 'design \.' 'design' | \
    amend_error_in_article 121 'Where it is shown that, excessive' 'Where it is shown that excessive' | \
    #Article 124
    amend_error_in_article 123 'Article \[124\]' '\n\n(124)' | \
    amend_error_in_article 123 'Occupiers of private land to clear.*$' '' | \
    #Article 126
    amend_error_in_article 126 'shalt' 'shall' | \
    #Article 127
    amend_error_in_article 127 'ascertain"' 'ascertain ' | \
    #Article 128
    amend_error_in_article 128 'regulatio~s prc:~cribing ~e' 'regulations prescribing the' | \
    amend_error_in_article 128 ' haz.ardous liquid' '-hazardous liquid' | \
    amend_error_in_article 128 'haz.ardous' 'hazardous' | \
    #Article 129
    sed -E 's/stonn/storm/g' | \
    #Article 130
    amend_error_in_article 130 '; _' ';' | \
    #Article 131
    amend_error_in_article 131 '-specifications-of chimneys and -gas controlling -devices .' 'specifications of chimneys and gas controlling devices' | \
    amend_error_in_article 131 'taking into consideration of the wind' 'taking into consideration the wind' | \
    #Article 132
    amend_error_in_article 132 '\[e\]' '\n\n(e)' | \
    #Article 133
    amend_error_in_article 133 'Gaseous wastes from.*to hazardous waste ' '' | \
    amend_error_in_article 133 '_and_appropriate' 'and appropriate' | \
    amend_error_in_article 133 'hazardouswaste' 'hazardous waste' | \
    amend_error_in_article 133 'contaminates with' 'contaminated with' | \
    #Article 134
    amend_error_in_article 134 'haz.mdous wms' 'hazardous wastes' | \
    amend_error_in_article 134 '-with' 'with' | \
    amend_error_in_article 134 'final-disposal' 'final disposal' | \
    amend_error_in_article 134 'at all the time' 'at all times' | \
    #Article 135
    amend_error_in_article 135 'healt.,' 'health,' | \
    amend_error_in_article 135 'Regulations.,' 'Regulations.' | \
    amend_error_in_article 135 '~m._gs and _the ~nv_~~onm~n~' 'beings and the environment' | \
    #Article 136
    amend_error_in_article 136 '\[l\] Subject' '[1] Subject' | \
    #Article 137
    amend_error_in_article 137 '\[l\] The' '[1] The' | \
    amend_error_in_article 137 '\[w\]PSte~ .\*111d drugs' 'wastes and' | \
    amend_error_in_article 137 'includes but not' 'includes but is not' | \
    amend_error_in_article 137 'coagulated blood wastes and' 'coagulated blood wastes and drugs' | \
    #Article 138
    amend_error_in_article 137 'Article \[138\]' '\n\n(138)' | \
    amend_error_in_article 137 'Movement of hazardous waste Environmental.*$' '' | \
    amend_error_in_article 138 '\[t\]' '[f]' | \
    #Article 138
    amend_error_in_article 138 'froni ' 'from ' | \
    #Artilce 139
    amend_error_in_article 139 'wntten' 'written' | \
    amend_error_in_article 139 'liquid,gaseous' 'liquid, gaseous' | \
    amend_error_in_article 139 'waste.management' 'waste management' | \
    amend_error_in_article 139 'the Minister\.may' 'the Minister may' | \
    amend_error_in_article 139 't9 anym~rwhi9h is p~scri~d mtc:l~r~is_P~.. .. ...' 'to any matter which is prescribed under this Part.' | \
    amend_error_in_article 139 '~rson' 'person' | \
    #Article 140
    amend_error_in_article 140 "'Committee" 'Committee' | \
    amend_error_in_article 140 "< '," '' | \
    amend_error_in_article 140 '\[t\]' '[f]' | \
    amend_error_in_article 140 'standard: \[2\]' 'standard. [2]' | \
    #Article 142
    amend_error_in_article 142 'the.Council may.-,: .. . .. .. -: ' 'the Council may:' | \
    amend_error_in_article 142 'aircraft"' 'aircraft' | \
    amend_error_in_article 142 'thatindustry' 'that industry' | \
    amend_error_in_article 142 'ofpollutants' 'of pollutants' | \
    amend_error_in_article 142 '~he' 'the' | \
    amend_error_in_article 142 'Compliance with standards.*quality standards ' '' | \
    amend_error_in_article 142 'C:ouncil shall nuuntain close collaborat,ion' 'Council shall maintain close collaboration' | \
    amend_error_in_article 142 'gases' 'gasses' | \
    amend_error_in_article 142 'may:\[a\]' 'may: [a]' | \
    amend_error_in_article 142 'area premise' 'area, premise' | \
    amend_error_in_article 142 'and criteria' '[2] Subject to the provisions of any other law, any person who pennits or causes to permit pollution or emission in excess of environmental quality standards and criteria' | \
    amend_error_in_article 142 'pennits' 'permits' | \
    #Article 143
    amend_error_in_article 143 '-water for-' 'water for ' | \
    #Article 144
    amend_error_in_article 144 'discha.J&e' 'discharge' | \
    amend_error_in_article 144 'worlcs' 'works' | \
    #Article 145
    amend_error_in_article 145 '. Environmental Standards_ Committee' ' Environmental Standards Committee' | \
    #Article 146
    amend_error_in_article 146 'detennination' 'determination' | \
    #Article 147
    amend_error_in_article 147 'detennination' 'determination' | \
    amend_error_in_article 147 'frcm soorces refurred to in paragrap:l \( e \)' 'from sources referred to in paragraph [e]' | \
    #Article 148
    amend_error_in_article 148 'detennination' 'determination' | \
    amend_error_in_article 148 'issue, guidelines' 'issue guidelines' | \
    #Article 149
    amend_error_in_article 148 '\[149\]' '\n\n(149)' | \
    amend_error_in_article 148 'Standards for the control.*$' '' | \
    amend_error_in_article 149 'shalls' 'shall: ' | \
    amend_error_in_article 149 'for minimization of radiation Soil quality standards' '' | \
    amend_error_in_article 149 '  ' '' | \
    #Article 151
    amend_error_in_article 151 '\[m\]anagement' 'management' | \
    amend_error_in_article 151 'known as' 'known as an' | \
    amend_error_in_article 151 'tenns' 'terms' | \
    amend_error_in_article 151 'Jmpose' 'impose' | \
    amend_error_in_article 151 'Environmental restoration order 88 Contents ofenvironmental restoration order ' '' | \
    amend_error_in_article 151 'haz.ard' 'hazard' | \
    amend_error_in_article 151 'haz.ard' 'hazard' | \
    amend_error_in_article 151 '\[t\] prevent' '[f] prevent' | \
    amend_error_in_article 151 'as may, enable' 'as may enable' | \
    #Article 152
    amend_error_in_article 151 '\[152\]:' '\n\n(152)' | \
    amend_error_in_article 152 'order,.within' 'order, within' | \
    amend_error_in_article 152 'h~ful' 'harmful' | \
    amend_error_in_article 152 'o6tained' 'obtained' | \
    amend_error_in_article 152 ' No. 20 Environmental Management' '' | \
    amend_error_in_article 152 'in a manner, which' 'in a manner which' | \
    #Article 153 
    amend_error_in_article 153 'tenns' 'terms' | \
    amend_error_in_article 153 'ofcnvi:' 'or' | \
    amend_error_in_article 153 'ronmcnmay' 'may' | \
    amend_error_in_article 153 'action tal ' 'action ' | \
    amend_error_in_article 153 "~:'\!oraharm " 'harm ' | \
    amend_error_in_article 153 'order order' 'order.' | \
    amend_error_in_article 153 'harm has been or Service or is likely' 'harm has been or is likely' | \
    #Article 154
    amend_error_in_article 153 'Article \[154\]' '\n\n(154)' | \
    amend_error_in_article 154 'Advice ' '' | \
    amend_error_in_article 154 'for::g a ' 'for a ' | \
    amend_error_in_article 154 'cnvironorder mental restora155.-' 'order. \n\n(155) ' | \
    #Article 156
    sed -E 's/furthe~ th~ principles of en~ironmental/further the principles of environmental/' | \
    sed -E 's/in th1s Act/in this Act/' | \
    sed -E 's/nght/the right/' | \
    sed -E 's/\[1999\] tion/1999. tion/' | \
    sed -E "s/tion order Duration.*Registration of environmental easements //" | \
    sed -E "s/particular.part ofit which is'burdened/particular part of it which is burdened/" | \
    sed -E 's/tenn of years/term of years/' | \
    sed -E 's/environmenprotection/environment protection/' | \
    sed -E 's/satisfied that, the recommendation/satisfied that the recommendation/' | \
    #Article 157
    amend_error_in_article 157 'pe~n' 'person' | \
    amend_error_in_article 157 ".. . '• . -~ .. . ., . ..... '. . . : ' .. " '' | \
    amend_error_in_article 157 'environmental easements' 'environmental easements.' | \
    #Article 158 
    amend_error_in_article 157 '.158.-' '\n\n(158) ' | \
    amend_error_in_article 158 'commencedonly' 'commenced only' | \
    amend_error_in_article 158 'whose . name' 'whose name' | \
    amend_error_in_article 158 '6fland' 'of land' | \
    amend_error_in_article 158 '  ' ' ' | \
    #Article 159
    amend_error_in_article 159 'that.system' 'that system' | \
    amend_error_in_article 159 'matte.r' 'matter' | \
    amend_error_in_article 159 '~ents' 'easements' | \
    amend_error_in_article 159 'def me ' 'define ' | \
    #Article 160
    amend_error_in_article 160 'A.cquisi#onAct, 1967an4 ~e 4m~ A~, \[1999\] ' 'Acquisition Act, 1967 and the Land Act, 1999.\n\n' | \
    sed -E 's/\[c\] Conservation Orders/(c) Conservation Orders/' | \
    #Article 161
    amend_error_in_article 161 '~ent' 'an easement' | \
    amend_error_in_article 161 'l~d; Compensation.*\[h\]' 'land; [h]' | \
    #Article 162
    amend_error_in_article 162 '::' ':' | \
    amend_error_in_article 162 'arty' 'any' | \
    #Article 163
    amend_error_in_article 162 "\[163\]:.\[i\] Ari order'designating laboratorie's forputposes" '\n\n(163) An order designating laboratories for purposes' | \
    amend_error_in_article 163 'Anorder' ' An order' | \
    amend_error_in_article 163 'laboratories.for' 'laboratories for' | \
    #Article 164
    amend_error_in_article 164 'No. 20 Environmental Management' '' | \
    #Article 166
    amend_error_in_article 166 'CoW1cil' 'Council' | \
    amend_error_in_article 166 'of the records' 'of the records.' | \
    #Article 167
    amend_error_in_article 166 'Record keeping of matters impacting on the environment Annual submission of records, \[167\],' '\n\n(167) ' | \
    amend_error_in_article 167 'Disclorequire' 'require' | \
    amend_error_in_article 167 'sure of analytiaccess' 'access' | \
    #Article 168
    amend_error_in_article 167 'Act cal Article \[168\]' 'Act.\n\n(168)' | \
    amend_error_in_article 168 'The.' 'The' | \
    amend_error_in_article 168 'Government.' 'Government' | \
    #Article 169
    amend_error_in_article 169 '\[2003\].*$' '2003.' | \
    #Article 170
    amend_error_in_article 170 'Authonty' 'Authority' | \
    amend_error_in_article 170 ':.:' ':' | \
    amend_error_in_article 170 '\[l\]' '[1]' | \
    amend_error_in_article 170 'recotds' 'records' | \
    amend_error_in_article 170 're&1ricting' 'restricting' | \
    amend_error_in_article 170 '\[l\];' '[1];' | \
    amend_error_in_article 170 "in.relation to institutions ref~med. 1:9 in sul>se9ti.<>1': \[1\]" 'in relation to institutions referred to in subsection [1]:' | \
    #Article 171
    amend_error_in_article 171 '•.. -ininimjse ~y adverse effects on the environment' 'minimise any adverse effects on the environment;' | \
    amend_error_in_article 171 'o~' 'on' | \
    amend_error_in_article 171 'prq,anxl bY, app~icants' 'prepared by applicants' | \
    amend_error_in_article 171 'accdoot' 'account' | \
    amend_error_in_article 171 'C<>.mmissioner \{or Mi~erals to Se9tor' 'Commissioner for Minerals to Sector' | 
    amend_error_in_article 171 '\[1998\]' '1998.' | \
    #Article 172
    amend_error_in_article 172 'tothe' 'to the' | \
    amend_error_in_article 172 'towater' 'to water' | \
    amend_error_in_article 172 'ofhazardous' 'of hazardous' | \
    amend_error_in_article 172 'reque~' 'request' | \
    amend_error_in_article 172 ']>e refuse,<:l:' 'be refused:' | \
    amend_error_in_article 172 'Freedom of access.*environmental information ' '' | \
    amend_error_in_article 172 '1D' 'to' | \
    amend_error_in_article 172 'fonnulated' 'formulated' | \
    amend_error_in_article 172 'Jnfonnation' 'Information' | \
    amend_error_in_article 172 '\[a\]9' 'as' | \
    amend_error_in_article 172 'oi ariy other written 1aw relating to.the' 'or any other written law relating to the' | \
    #Article 173
    amend_error_in_article 173 'natu ral' 'natural' | \
    amend_error_in_article 173 'dissemin~' 'disseminate' | \
    amend_error_in_article 173 'trend.s' 'trends' | \
    amend_error_in_article 173 'co-ominate' 'co-ordinate' | \
    amend_error_in_article 173 '\[t\]' '[f]' | \
    #Article 174
    sed -E 's/operate a which/operate a Central Environmental Information System which/' | \
    #Article 176
    amend_error_in_article 176 "'._" '.' | \
    #Article 177
    amend_error_in_article 177 'Central Environmental Information System.*decision making ' '' | \
    amend_error_in_article 177 'forecast on' 'forecasts on' | \
    #Article 178
    amend_error_in_article 178 "the environment'" 'the environment' | \
    amend_error_in_article 178 'niade.  ' 'made.' | \
    amend_error_in_article 178 'programmes;and' 'programmes; and' | \
    amend_error_in_article 178 'ariy' 'any' | \
    amend_error_in_article 178 "including'" 'including' | \
    #Article 181
    amend_error_in_article 181 'Wlthout' 'Without' | \
    amend_error_in_article 181 'International Agreements on Environment.*environmental inspectors' '' | \
    #Article 183
    amend_error_in_article 183 'air.craft' 'aircraft' | \
    amend_error_in_article 183 '• "' ': ' | \
    amend_error_in_article 183 "document' that is related 'to the:' '" 'document that is related to the ' | \
    amend_error_in_article 183 '101 ' '' | \
    amend_error_in_article 183 'explain.the ' 'explain the ' | \
    amend_error_in_article 183 'the purpose of' 'the purpose of the' | \
    amend_error_in_article 183 'subsection \[l\]' 'subsection [1]' | \
    #Article 184
    amend_error_in_article 184 'contrmy' 'contrary' | \
    amend_error_in_article 184 'thound' 'thousand' | \
    amend_error_in_article 184 '86 \[1\]' '86[1]' | \
    #Article 185
    amend_error_in_article 185 'by: products' 'by-products' | \
    #Article 186
    amend_error_in_article 186 'person_who' 'person who' | \
    amend_error_in_article 186 '110 ' 'no ' | \
    amend_error_in_article 186 'fme ' 'fine ' | \
    amend_error_in_article 186 'Offences relating to records.*$' '' | \
    amend_error_in_article 186 'Offences relating to environmenta! impact assessment' '' | \
    amend_error_in_article 186 'provided for; or' 'provided; or' | \
    #Article 187
    amend_error_in_article 187 'whorelating' 'who:' | \
    amend_error_in_article 187 'to pollu: dischatges' 'discharges' | \
    amend_error_in_article 187 'tion Offences relating to biological diversity Offences relating to environmental restoration, casement and conservation orders ' '' | \
    amend_error_in_article 187 'environm.ent' 'environment' | \
    amend_error_in_article 187 '1:he' 'the' | \
    amend_error_in_article 187 'dischatges' 'discharges' | \
    #Article 188
    amend_error_in_article 188 'commits, an offence' 'commits an offence' | \
    #Article 189
    amend_error_in_article 189 'erivironmental' 'environmental' | \
    amend_error_in_article 189 '~d 103 ' '' | \
    amend_error_in_article 189 'easement, issued' 'easement issued' | \
    #Article 190
    amend_error_in_article 189 '190,-' '\n\n(190) ' | \
    amend_error_in_article 190 '_ .... ' '' | \
    amend_error_in_article 190 'fme' 'fine' | \
    amend_error_in_article 190 'shillings \[2\]' 'shillings. [2]' | \
    amend_error_in_article 190 '11,1ay' 'may' | \
    amend_error_in_article 190 'Offences relating to litter 104 ' '' | \
    amend_error_in_article 190 'waste, \[e\]' 'waste; [e]' | \
    amend_error_in_article 190 'remove it; or;' 'remove it; or' | \
    amend_error_in_article 190 '121,or' '121; or' | \
    amend_error_in_article 190 '122, or' '122; or' | \
    amend_error_in_article 190 'imposing of penalty' 'imposing a penalty' | \
    #Article 191
    amend_error_in_article 190 ' General \[191\]' '\n\n(191)' | \
    amend_error_in_article 191 'Civil lia: ' '' | \
    amend_error_in_article 191 'provision penalty of this Act' 'provision of this Act' | \
    amend_error_in_article 191 'specifically provided for' 'specifically provided' | \
    #Article 192
    amend_error_in_article 192 'bility ' '' | \
    amend_error_in_article 192 'Forfeiture, cancellation, commu: nity service and other orders ' '' | \
    amend_error_in_article 192 'under this Act, shall' 'under this Act shall' | \
    #Article 193
    amend_error_in_article 193 'chaiged' 'charged' | \
    amend_error_in_article 193 'ofin' 'of in' | \
    amend_error_in_article 193 '105 ' '' | \
    amend_error_in_article 193 '   ' ' ' | \
    amend_error_in_article 193 'accordances' 'accordance' | \
    amend_error_in_article 193 'be or disposed of' 'be disposed of' | \
    #Article 194
    amend_error_in_article 194 'ac.cepting . ' 'accepting ' | \
    amend_error_in_article 194 'alticle' 'article' | \
    #Article 195
    amend_error_in_article 195 'ma:y ' 'may ' | \
    amend_error_in_article 195 'Compounding of offences Prevention order to protect the environment 106 Protection order against activities adverse on the environment ' '' | \
    amend_error_in_article 195 'ciroumstances' 'circumstances' | \
    amend_error_in_article 195 'emeigency' 'emergency' | \
    amend_error_in_article 195 'ofaday after the ~ ~ified inJhe ord~r' 'of a day after the date specified in the order' | \
    amend_error_in_article 195 'subsection \[3\], commits' 'subsection [3] commits' | \
    #Article 196
    amend_error_in_article 196 'order on' 'order on:' | \
    amend_error_in_article 196 'measuresthat' 'measures that' | \
    amend_error_in_article 196 'subsection \[l\]' 'subsection [1]' | \
    amend_error_in_article 196 ' 107' '' | \
    amend_error_in_article 196 'sub: section' 'subsection' | \
    amend_error_in_article 196 "pl'Qtecti~n " 'protection ' | \
    amend_error_in_article 196 'toa' 'to a' | \
    amend_error_in_article 196 '~~ng ' 'exceeding ' | \
    amend_error_in_article 196 'areview' 'a review' | \
    amend_error_in_article 196 'subsection \[3\], commits' 'subsection [3] commits' | \
    amend_error_in_article 196 'on \[a\] the' 'on: [a] the' | \
    amend_error_in_article 196 '\[e\] to prevent' '[e] prevent' | \
    amend_error_in_article 196 'is served, shall comply' 'is served shall comply' | \
    amend_error_in_article 196 'subsection \[3\], commits' 'subsection [3] commits' | \
    #Article 197
    amend_error_in_article 196 '197 .-' '\n\n(197) ' | \
    amend_error_in_article 197 'discluuge' 'discharge' | \
    amend_error_in_article 197 'owner~' 'owner' | \
    amend_error_in_article 197 'discluuge' 'discharge' | \
    amend_error_in_article 197 'Emergency protection order 108 Environmental compliance order ' '' | \
    amend_error_in_article 197 'fme' 'fine' | \
    amend_error_in_article 197 'or:der .~as' 'order has' | \
    amend_error_in_article 197 'owner manager' 'owner, manager' | \
    amend_error_in_article 197 'manager of person' 'manager or person' | \
    amend_error_in_article 197 'subsection \[3\], commits' 'subsection [3] commits' | \
    sed -E 's/one hundred thousand shilling /one hundred thousand shillings /' | \
    #Article 198
    amend_error_in_article 197 '198,-' '\n\n(198) ' | \
    amend_error_in_article 198 'breach.within' 'breach within' | \
    amend_error_in_article 198 '109 ' '' | \
    amend_error_in_article 198 'ifno ' 'if no ' | \
    amend_error_in_article 198 'compliance order on: the' 'compliance order on the' | \
    amend_error_in_article 198 'subsection \[4\], commits' 'subsection [4] commits' | \
    amend_error_in_article 198 'one hundred thousand shilling ' 'one hundred thousand shillings ' | \
    #Article 199
    amend_error_in_article 199 '110 Offences in relation to environmental inspectors Liabiiity of managers of bodies corporate Article \[200\]' '\n\n(200)' | \
    amend_error_in_article 199 'requirement Cost' 'requirement' | \
    #Article 200
    amend_error_in_article 200 "Act '" 'Act' | \
    amend_error_in_article 200 'tenn ' 'term ' | \
    amend_error_in_article 200 'Act \[c\]' 'Act; [c]' | \
    amend_error_in_article 200 'conviction, to a fine' 'conviction to a fine' | \
    #Article 201
    amend_error_in_article 201 '\[l\]Where a body corporatti colllll1its' '[1] Where a body corporate commits' | \
    amend_error_in_article 201 'pefSOn' 'person' | \
    amend_error_in_article 201 'tenn' 'term' | \
    amend_error_in_article 201 'No. 20 Environmental Management' '' | \
    amend_error_in_article 201 'management of, a body' 'management of a body' | \
    amend_error_in_article 201 'subsection \[2\], commits' 'subsection [2] commits' | \
    amend_error_in_article 201 'shall, on conviction' 'shall on conviction' | \
    #Article 202
    amend_error_in_article 202 'provisionof' 'provision of' | \
    amend_error_in_article 202 'legal persons' "legal person's" | \
    #Article 203
    amend_error_in_article 203 'perfomt' 'perform' | \
    #Article 204
    amend_error_in_article 204 'Chaimtan' 'Chairman' | \
    amend_error_in_article 204 '_;' ';' | \
    amend_error_in_article 204 'temt . ofthree' 'term of three' | \
    amend_error_in_article 204 'reappoin1rnent forJurther Qne temt' 'reappointment for further one term' | \
    amend_error_in_article 204 'Right of individual and legal.*Tribunal Jurisdiction of the Tribunal ' '' | \
    amend_error_in_article 204 'which;are' 'which are' | \
    amend_error_in_article 204 '  ' ' ' | \
    #Article 206
    amend_error_in_article 206 'subsection \[2\]' 'subsection [2].' | \
    amend_error_in_article 206 'resbiction' 'restriction' | \
    amend_error_in_article 206 '113 ' '' | \
    amend_error_in_article 206 '\[2\] \[2\]' '[2]. [2]' | \
    amend_error_in_article 206 '\[2\].,' '[2],' | \
    #Article 207
    amend_error_in_article 207 '\[1967\]' '1967.' | \
    amend_error_in_article 207 'may,for' 'may, for' | \
    amend_error_in_article 207 'Proceedings of the Tribunal Acts.*Remuneration of members of the Tribunal ' '' | \
    amend_error_in_article 207 'under-this' 'under this' | \
    amend_error_in_article 207 'sitting, \[b\]' 'sitting; [b]' | \
    #Article 208
    amend_error_in_article 207 '208~\{1\) Jbe' '\n\n(208) [1] The' | \
    #Article 210
    amend_error_in_article 209 '210.-' '\n\n(210) ' | \
    #Article 211
    amend_error_in_article 211 '115 ' '' | \
    #Article 212
    amend_error_in_article 212 'Appointthe' 'the' | \
    amend_error_in_article 212 ' mcnt of the' '.' | \
    amend_error_in_article 212 'Regi9trar ' '' | \
    amend_error_in_article 212 'Chainnan. ..,' 'Chairman.' | \
    #Article 213
    amend_error_in_article 213 'inte~ational' 'international' | \
    amend_error_in_article 213 "mann'er" 'manner' | \
    amend_error_in_article 213 'shall be paid, all moneys' 'shall be paid all moneys' | \
    #Article 214
    amend_error_in_article 213 '\[214\]:' '\n\n(214) ' | \
    amend_error_in_article 214 'Establishment of the National.*f2001 ' '' | \
    amend_error_in_article 214 'costs . of' 'costs of' | \
    amend_error_in_article 214 'N,ational' 'National' | \
    amend_error_in_article 214 "'Committee" 'Committee' | \
    amend_error_in_article 214 'AdvisoryCommittee' 'Advisory Committee' | \
    #Article 215
    amend_error_in_article 215 '\[I\]' '[1]' | \
    #Article 216
    amend_error_in_article 216 'to-' 'to' | \
    amend_error_in_article 216 '\[2001\]' '2001.' | \
    amend_error_in_article 216 '117 ' '' | \
    #Article 218
    amend_error_in_article 218 'fulfilment' 'fulfillment' | \
    #Article 219
    amend_error_in_article 219 'Tanz.ania' 'Tanzania' | \
    amend_error_in_article 219 'the opinion that, the public interest' 'the opinion that the public interest' | \
    #Article 220
    amend_error_in_article 220 'Sources of funds of.*$' '' | \
    #Article 222
    amend_error_in_article 222 'fmancial' 'financial' | \
    amend_error_in_article 222 '2001' '2001.' | \
    amend_error_in_article 222 'Annual' '' | \
    #Article 223
    amend_error_in_article 223 '119 ' '' | \
    amend_error_in_article 223 'Report the' 'the' | \
    #Article 226
    amend_error_in_article 226 ' Act to bind the.*$' '' | \
    #Article 227
    amend_error_in_article 227 ':!orm:' '' | \
    amend_error_in_article 227 'required bond' 'required.' | \
    amend_error_in_article 227 'Right to compensation the -Director ' 'the Director ' | \
    amend_error_in_article 227 'sub section \[5\],' 'subsection [5], it' | \
    amend_error_in_article 227 'activities mental or processes' 'activities or processes' | \
    #Article 228
    amend_error_in_article 228 'Environ:' '' | \
    #Article 229
    amend_error_in_article 229 'emeigences' 'emergencies' | \
    amend_error_in_article 229 'instrusions' 'intrusions' | \
    amend_error_in_article 229 '121 ' '' | \
    amend_error_in_article 229 'ofland' 'of land' | \
    amend_error_in_article 229 'management mental of' 'management of' | \
    amend_error_in_article 229 'emergency preparedness \[a\]' '[a]' | \
    amend_error_in_article 229 'refugees, and \[f\]' 'refugees; and [f]' | \
    #Article 230
    amend_error_in_article 230 'puipose of Regulatgiving' 'purpose of giving' | \
    amend_error_in_article 230 ' ions' '.' | \
    amend_error_in_article 230 'genn' 'germ' | \
    amend_error_in_article 230 'hazatdous to 1he envilooment' 'hazardous to the environment' | \
    amend_error_in_article 230 'G\)' '[g]' | \
    amend_error_in_article 230 '\[1\] provide' '[l] provide' | \
    amend_error_in_article 230 'assesment' 'assessment' | \
    amend_error_in_article 230 '122 Repeal.*Kiswahili ' '' | \
    #Article 231
    amend_error_in_article 231 '\. \.\.' '.' | \
    amend_error_in_article 231 'tenninated' 'terminated' | \
    amend_error_in_article 231 'bein.nninated' 'being terminated' | \
    #Article 233
    amend_error_in_article 233 'fonns' 'forms' | \
    sed -E 's/  / /g' 

}

function amend_errors_in_headers {
  sed -E 's/PART I /PART I - /' | \
    sed -E 's/PART II GENERAL/\n\nPART II - GENERAL/' | \
    sed -E 's/PARTill ADMINISTRATION AND INSTITUTIONAL ARRANGEMENT \[a\] National Environmental Advisory Committee/\n\nPART III - ADMINISTRATION AND INSTITUTIONAL ARRANGEMENT\n\n(a) National Environmental Advisory Committee/' | \
    sed -E 's/PART IV ENvlR.ONMENTAL. PLANNING /\n\nPART IV - ENVIRONMENTAL PLANNING/' | \
    sed -E 's/PARTV ENVIRONMENTAL MANAGEMENT \[a\] Environmental Protected Areas/\n\nPART V - ENVIRONMENTAL MANAGEMENT \n\n(a) Environmental Protected Areas/' | \
    sed -E 's/\[b\] Environmental Management Plans for National Protected Areas/\n\n(b) Environmental Management Plans for National Protected Areas/' | \
    sed -E 's/\[c\] Conservation and Protection/\n\n(c) Conservation and Protection/' | \
    sed -E 's/PART VI ENvlRONMENTAL/\n\nPART VI - ENVIRONMENTAL/' | \
    sed -E 's/PARTVII/\n\nPART VII -/' | \
    sed -E 's/PARTVill/\n\nPART VIII -/' | \
    sed -E 's/PART IX WASTE MANAGEMENT [a] Management of Solid Waste/\n\nPART IX - WASTE MANAGEMENT \n\n(a) Management of Solid Waste/' | \
    sed -E 's/\[b\] Management of Litter/\n\n(b) Management of Litter/' | \
    sed -E 's/\[c\] Management of Liquid Waste/\n\n(c) Management of Liquid Waste/' | \
    sed -E 's/\[d\] Management of Gaseous Waste/\n\n(d) Management of Gaseous Waste/' | \
    sed -E 's/\[e\] Management of Hazardous Waste/[e] Management of Hazardous Waste/' | \
    sed -E 's/PARTX ENvlR.ONMENTAL QUALITY STANDARDS/\n\nPART X - ENVIRONMENTAL QUALITY STANDARDS/' | \
    sed -E 's/PART XI ENvlR.ONMENTAL RESTORATION, EASEMENTS AND CONSERVATION ORDERS \[a\] Restoration Orders/\n\nPART XI - ENVIRONMENTAL RESTORATION, EASEMENTS AND CONSERVATION ORDERS\n\n(a) Restoration Orders/' | \
    sed -E 's/\[b\] Easements Orders _156.:/\n\n(b) Easements Order\n\n(156)/' | \
    sed -E 's/PART XII ANALYSIS AND RECORDS/\n\nPART XII - ANALYSIS AND RECORDS/' | \
    sed -E 's/PARTXIll ENvlR.ONMENTAL INFORMATION, EDUCATION AND RESEARCH/\n\nPART XIII - ENVIRONMENTAL INFORMATION, EDUCATION AND RESEARCH/' | \
    sed -E 's/PART XIV PuBLIC PARTICIPATION IN ENvlRONMENTAL DECISION MAKING/\n\nPART XIV - PUBLIC PARTICIPATION IN ENVIRONMENTAL DECISION MAKING/' | \
    sed -E 's/PART IX WASTE MANAGEMENT \[a\] Management of Solid Waste/\n\nPART IX - WASTE MANAGEMENT\n\n(a) Management of Solid Waste/' | \
    sed -E 's/PART XV INTERNATIONAL AGREEMENTS/\n\nPART XV - INTERNATIONAL AGREEMENTS/' | \
    sed -E 's/PART XVI COMPLIANCE AND ENFORCEMENT/\n\nPART XVI - COMPLIANCE AND ENFORCEMENT/' | \
    sed -E 's/PART XVII ENvlRONMENTAL APPEALS TRIBUNAL/\n\nPART XVII - ENVIRONMENTAL APPEALS TRIBUNAL/' | \
    sed -E 's/PARTXVm NATIONAL ENvlRONMENTAL TR.UST FuNo/\n\nPART XVIII - NATIONAL ENVIRONMENTAL TRUST FUND/' | \
    sed -E 's/PART XIX FINANCIAL PROVISIONS/\n\nPART XIX - FINANCIAL PROVISIONS/' | \
    sed -E 's/PART XX GENERAL AND TRANSITIONAL PROVISIONS/\n\nPART XX - GENERAL AND TRANSITIONAL PROVISIONS/' 
}

function remove_and_reinsert_article_titles {
  remove_and_reinsert_article_title 1 'Short title ' | \
    remove_and_reinsert_article_title 2 'Commencement ' | \
    remove_and_reinsert_article_title 3 'Interpretation ' | \
    remove_and_reinsert_article_title 4 'Right to a clean, safe and healthy environment ' | \
    remove_and_reinsert_article_title 5 'Right to bring an action on environment ' | \
    remove_and_reinsert_article_title 6 'Duty to protect the environment' | \
    remove_and_reinsert_article_title 7 'Principles of environmental management ' | \
    remove_and_reinsert_article_title 8 'Obligation to give effect to environmental principles ' | \
    remove_and_reinsert_article_title 9 'Promotion of the National Environmental Policy' | \
    remove_and_reinsert_article_title 10 'Environment Day ' | \
    remove_and_reinsert_article_title 11 'Establishment and composition of members of the Committee' | \
    remove_and_reinsert_article_title 12 'Functions of the National Environmental Advisory Committee ' | \
    remove_and_reinsert_article_title 13 'Powers of the Minister ' | \
    sed -z 's/(14)/Director of Environment\n(14)/' | \
    remove_and_reinsert_article_title 15 'Functions of the Director of Environment ' | \
    sed -z 's/(16)/The Council\n(16)/' | \
    remove_and_reinsert_article_title 17 'Object for establishment of the Council ' | \
    remove_and_reinsert_article_title 18 'Functions of the Council ' | \
    remove_and_reinsert_article_title 19 'Board of the Council ' | \
    remove_and_reinsert_article_title 20 'Conduct of business and affairs of the Council ' | \
    remove_and_reinsert_article_title 21 'Appointment of the Director General ' | \
    remove_and_reinsert_article_title 22 'Staff and employees of the Council ' | \
    remove_and_reinsert_article_title 23 'General powers of the Council ' | \
    remove_and_reinsert_article_title 24 'Powers of the Council in respect of other agencies ' | \
    remove_and_reinsert_article_title 25 'Powers of the Council to ensure compliance ' | \
    remove_and_reinsert_article_title 26 'Performance of the functions of the Council by other bodies ' | \
    remove_and_reinsert_article_title 27 'Common seal of the Council' | \
    remove_and_reinsert_article_title 28 'Indemnity of the Board, member, etc., from personal liability ' | \
    remove_and_reinsert_article_title 29 'Conflict of interest ' | \
    remove_and_reinsert_article_title 30 'Establishment of sector environment section ' | \
    remove_and_reinsert_article_title 31 'Functions of sector environment section ' | \
    remove_and_reinsert_article_title 32 'Submission of sector Ministries report ' | \
    remove_and_reinsert_article_title 33 'Appointment or designation of a sector environment coordinator ' | \
    remove_and_reinsert_article_title 34 'Regional coordination on environmental management ' | \
    remove_and_reinsert_article_title 35 'Appointment or designation of a regional environment management expert ' | \
    remove_and_reinsert_article_title 36 'Functions of local government environment management officers ' | \
    remove_and_reinsert_article_title 37 'Standing Committees of local government authorities ' | \
    remove_and_reinsert_article_title 38 'Standing Committees in townships, wards, villages and Kitongoji ' | \
    remove_and_reinsert_article_title 39 'Designation of the Township, Ward, Village, Mtaa and Kitongoji Environment Management Officer ' | \
    remove_and_reinsert_article_title 40 'Functions of the Township, Ward, Village, Mtaa and Kitongoji Environment Management Officer ' | \
    remove_and_reinsert_article_title 41 'General powers of the City, Municipal, District, Township, Ward, Village, Mtaa and Kitongoji Environment Management Committees ' | \
    remove_and_reinsert_article_title 42 'Local government authorities environmental action plans ' | \
    remove_and_reinsert_article_title 43 'Environmental plans at sector level ' | \
    remove_and_reinsert_article_title 44 'Environmental planning at national level ' | \
    remove_and_reinsert_article_title 45 'Regulations on preparation, adoption and implementation of action plans ' | \
    remove_and_reinsert_article_title 46 'Public participation in preparation of National Environmental Action Plan ' | \
    remove_and_reinsert_article_title 47 'Declaration of Environmental Protected Areas ' | \
    remove_and_reinsert_article_title 48 'Environmental protection plan and ecosystem management plan for Environmental Protected Areas ' | \
    sed -z 's/(49)/Environmental Management Plans for National Protected Areas\n(49)/' | \
    remove_and_reinsert_article_title 50 'Land utilization management ' | \
    remove_and_reinsert_article_title 51 'Environmentally sensitive areas ' | \
    remove_and_reinsert_article_title 52 'Identification of environmentally sensitive areas ' | \
    remove_and_reinsert_article_title 53 'Environmental conditions to village lands ' | \
    remove_and_reinsert_article_title 54 'Declaration of protected river, riverbanks, lake or lakeshore and shoreline ' | \
    remove_and_reinsert_article_title 55 'Protection and management of rivers, riverbanks, lake or lakeshore and shoreline ' | \
    remove_and_reinsert_article_title 56 'Declaration of protected wetlands ' | \
    remove_and_reinsert_article_title 57 'Prohibition of human activities in certain areas ' | \
    remove_and_reinsert_article_title 58 'Protection of mountains, hills and landscapes ' | \
    remove_and_reinsert_article_title 59 'Promotion of coastal zone environmental management ' | \
    remove_and_reinsert_article_title 60 'Environmental obligations under water laws ' | \
    remove_and_reinsert_article_title 61 'Minister may advise on the discharge of sewerage ' | \
    remove_and_reinsert_article_title 62 'Consultation on discharge ' | \
    remove_and_reinsert_article_title 63 'Management of forest resources ' | \
    remove_and_reinsert_article_title 64 'Promotion of conservation of energy ' | \
    remove_and_reinsert_article_title 65 'Promotion of conservation of fisheries and wildlife resources, etc. ' | \
    remove_and_reinsert_article_title 66 'Conservation of biological diversity ' | \
    remove_and_reinsert_article_title 67 'Conservation of biological diversity in-situ ' | \
    remove_and_reinsert_article_title 68 'Conservation of biological diversity ex-situ ' | \
    remove_and_reinsert_article_title 69 'Regulation for the development, handling, and use of Genetically Modified Organisms and their products ' | \
    remove_and_reinsert_article_title 70 'Management of rangelands ' | \
    remove_and_reinsert_article_title 71 'Environmental land use planning directives ' | \
    remove_and_reinsert_article_title 72 'Obligation to use land sustainably ' | \
    remove_and_reinsert_article_title 73 'Protection of natural and cultural heritage ' | \
    remove_and_reinsert_article_title 74 'Protection of the atmosphere ' | \
    remove_and_reinsert_article_title 75 'Measures on climate change ' | \
    remove_and_reinsert_article_title 76 'Management of working environment and dangerous materials and processes ' | \
    remove_and_reinsert_article_title 77 'Powers of the Minister to make regulations on persistent organic pollutants ' | \
    remove_and_reinsert_article_title 78 'Prior informed consent procedures for certain hazardous chemicals and pesticides ' | \
    remove_and_reinsert_article_title 79 'Promotion of cleaner production and sustainable consumption of goods and services ' | \
    remove_and_reinsert_article_title 80 'Economic incentives and instruments for the protection of the environment ' | \
    remove_and_reinsert_article_title 81 'Obligation to undertake Environmental Impact Assessment ' | \
    remove_and_reinsert_article_title 82 'Environmental Impact Assessment regulations and guidelines ' | \
    remove_and_reinsert_article_title 83 'Environmental Impact Assessment to be conducted by experts ' | \
    remove_and_reinsert_article_title 84 'Issuance of certificate not a defence in legal proceedings ' | \
    remove_and_reinsert_article_title 85 'Determination of the scope of Environmental Impact Statement ' | \
    sed -z 's/(86)/Environmental Impact Statement\n(86)/' | \
    remove_and_reinsert_article_title 87 'Review of Environmental Impact Statement ' | \
    remove_and_reinsert_article_title 88 'Inspection visit for purpose of Environmental Impact Statement review ' | \
    remove_and_reinsert_article_title 89 'Public participation in Environmental Impact Assessment ' | \
    remove_and_reinsert_article_title 90 'Public hearing and information disclosure ' | \
    remove_and_reinsert_article_title 91 'Recommendations on Environmental Impact Statement by the Council ' | \
    remove_and_reinsert_article_title 92 'Approval or disapproval of Environmental Impact Statement by the Minister' | \
    remove_and_reinsert_article_title 93 'Cancellation of licence upon disapproval of Environmental Impact Assessment ' | \
    remove_and_reinsert_article_title 94 'Delegation of powers to approve Environmental Impact Assessment ' | \
    remove_and_reinsert_article_title 95 'Appeal against decision of the Minister on Environmental Impact Assessment ' | \
    remove_and_reinsert_article_title 96 'Maintenance of records of decisions on Environmental Impact Assessment ' | \
    remove_and_reinsert_article_title 97 'Requirement of fresh Environmental Impact Assessment study ' | \
    remove_and_reinsert_article_title 98 'Offence for contravening EIA ' | \
    remove_and_reinsert_article_title 99 'Environmental monitoring ' | \
    remove_and_reinsert_article_title 100 'Monitoring compliance with Environmental Impact Statement ' | \
    remove_and_reinsert_article_title 101 'Environmental audit ' | \
    remove_and_reinsert_article_title 102 'Undertaking of safe decommissioning and site rehabilitation ' | \
    remove_and_reinsert_article_title 103 'Other assessments ' | \
    remove_and_reinsert_article_title 104 'Strategic environmental assessment of Bills, regulations, policies, strategies, programmes and plans ' | \
    remove_and_reinsert_article_title 105 'Strategic environmental assessment for mineral, petroleum, hydro-electric power and major water project plans ' | \
    remove_and_reinsert_article_title 106 'General prohibition of pollution ' | \
    remove_and_reinsert_article_title 107 'Powers of the Minister to make regulations to prevent and control pollution ' | \
    remove_and_reinsert_article_title 108 'Integrated pollution prevention and control ' | \
    remove_and_reinsert_article_title 109 'Prohibition of water pollution ' | \
    remove_and_reinsert_article_title 110 'Prohibition to discharge hazardous substances, chemicals, materials, oil, etc.' | \
    remove_and_reinsert_article_title 111 'Duty to keep abreast with technological changes ' | \
    remove_and_reinsert_article_title 112 'Duty to disclose information to prevent pollution ' | \
    remove_and_reinsert_article_title 113 'Prohibition notices on prescribed process or activity ' | \
    remove_and_reinsert_article_title 114 'Duty of local government to manage and minimize solid waste ' | \
    remove_and_reinsert_article_title 115 'Disposal of solid waste from markets, business areas and institutions ' | \
    remove_and_reinsert_article_title 116 'Storage of solid waste from industries ' | \
    remove_and_reinsert_article_title 117 'Solid waste collection in urban and rural areas ' | \
    remove_and_reinsert_article_title 118 'Waste transfer stations ' | \
    remove_and_reinsert_article_title 119 'Final disposal of solid waste ' | \
    remove_and_reinsert_article_title 120 'Interpretation with regard to management of litter ' | \
    remove_and_reinsert_article_title 121 'Control of litter in public places ' | \
    remove_and_reinsert_article_title 122 'Occupiers of private land to clear litter ' | \
    remove_and_reinsert_article_title 123 'On site disposal of liquid waste ' | \
    remove_and_reinsert_article_title 124 'Transportation and disposal of liquid waste ' | \
    remove_and_reinsert_article_title 125 'Treatment of liquid waste ' | \
    remove_and_reinsert_article_title 126 'Liquid waste disposal ' | \
    remove_and_reinsert_article_title 127 'Control and monitoring of sewerage system ' | \
    remove_and_reinsert_article_title 128 'Industrial liquid waste ' | \
    remove_and_reinsert_article_title 129 'Storm water management ' | \
    remove_and_reinsert_article_title 130 'Gaseous wastes from dwelling houses ' | \
    remove_and_reinsert_article_title 131 'Control of industrial gaseous waste ' | \
    remove_and_reinsert_article_title 132 'Gaseous and particulate wastes from vehicles ' | \
    remove_and_reinsert_article_title 133 'Importation of hazardous waste ' | \
    remove_and_reinsert_article_title 134 'Duty of local government authority in relation to hazardous waste ' | \
    remove_and_reinsert_article_title 135 'Movement of hazardous waste ' | \
    remove_and_reinsert_article_title 136 'Environment Impact Assessment for hazardous waste ' | \
    remove_and_reinsert_article_title 137 'Final disposal of health care wastes ' | \
    remove_and_reinsert_article_title 138 'Disposal of other wastes ' | \
    remove_and_reinsert_article_title 139 'General power of local government authorities to minimize waste ' | \
    remove_and_reinsert_article_title 140 'Formulation and approval of environmental quality standards ' | \
    remove_and_reinsert_article_title 141 'Compliance with standards, etc. ' | \
    remove_and_reinsert_article_title 142 'Enforcement of environmental quality standards ' | \
    remove_and_reinsert_article_title 143 'Water quality standards ' | \
    remove_and_reinsert_article_title 144 'Standards for discharge of effluent into water ' | \
    remove_and_reinsert_article_title 145 'Air quality standards ' | \
    remove_and_reinsert_article_title 146 'Standards for the control of noxious smells ' | \
    remove_and_reinsert_article_title 147 'Standards for the control of noise and vibration pollution ' | \
    remove_and_reinsert_article_title 148 'Standards for sub-sonic vibrations ' | \
    remove_and_reinsert_article_title 149 'Standards for minimization of radiation ' | \
    remove_and_reinsert_article_title 150 'Soil quality standards ' | \
    remove_and_reinsert_article_title 151 'Environmental restoration order ' | \
    remove_and_reinsert_article_title 152 'Contents of environmental restoration order ' | \
    remove_and_reinsert_article_title 153 'Service of environmental restoration order ' | \
    remove_and_reinsert_article_title 154 'Advice before issuing environmental restoration order ' | \
    remove_and_reinsert_article_title 155 'Duration of environmental restoration order ' | \
    remove_and_reinsert_article_title 156 'Environmental easements and conservation order ' | \
    remove_and_reinsert_article_title 157 'Application for environmental easements ' | \
    remove_and_reinsert_article_title 158 'Enforcement of environmental easements ' | \
    remove_and_reinsert_article_title 159 'Registration of environmental easements ' | \
    remove_and_reinsert_article_title 160 'Compensation for environmental easements ' | \
    remove_and_reinsert_article_title 161 'Imposition of environmental conservation order ' | \
    remove_and_reinsert_article_title 162 'Designation of laboratories for analysis and taking of samples ' | \
    remove_and_reinsert_article_title 163 'Designation of analysts and reference analysts ' | \
    remove_and_reinsert_article_title 164 'Certificate of analysis and its effect ' | \
    remove_and_reinsert_article_title 165 'Record keeping of matters impacting on the environment ' | \
    remove_and_reinsert_article_title 166 'Annual submission of records ' | \
    remove_and_reinsert_article_title 167 'Disclosure of analytical results ' | \
    remove_and_reinsert_article_title 168 'Environmental responsibilities of the Government Chemist ' | \
    remove_and_reinsert_article_title 169 'Prescribing mode of cooperation on chemical pollutants ' | \
    remove_and_reinsert_article_title 170 'Requirement to keep the Council informed ' | \
    remove_and_reinsert_article_title 171 'Environmental records on mining activities ' | \
    remove_and_reinsert_article_title 172 'Freedom of access to environmental information ' | \
    remove_and_reinsert_article_title 173 'Powers of the Council to collect, analyse and disseminate environmental information ' | \
    sed -z 's/(174)/Central Environmental Information System\n(174)/' | \
    remove_and_reinsert_article_title 175 'State of the Environment Report ' | \
    remove_and_reinsert_article_title 176 'Environmental education and awareness ' | \
    remove_and_reinsert_article_title 177 'Environmental research ' | \
    remove_and_reinsert_article_title 178 'Public participation in environmental decision making ' | \
    remove_and_reinsert_article_title 179 'International Agreements on Environment ' | \
    remove_and_reinsert_article_title 180 'Transboundary environmental management programmes ' | \
    remove_and_reinsert_article_title 181 'Establishment of national offices and focal points ' | \
    remove_and_reinsert_article_title 182 'Appointment and designation of environmental inspectors ' | \
    remove_and_reinsert_article_title 183 'Powers of environmental inspectors ' | \
    remove_and_reinsert_article_title 184 'Offences relating to environmental impact assessment ' | \
    remove_and_reinsert_article_title 185 'Offences relating to records ' | \
    remove_and_reinsert_article_title 186 'Offences relating to environmental standards ' | \
    remove_and_reinsert_article_title 187 'Offences relating to pollution ' | \
    remove_and_reinsert_article_title 188 'Offences relating to biological diversity ' | \
    remove_and_reinsert_article_title 189 'Offences relating to environmental restoration, easement and conservation orders ' | \
    remove_and_reinsert_article_title 190 'Offences relating to litter ' | \
    remove_and_reinsert_article_title 191 'General penalty ' | \
    remove_and_reinsert_article_title 192 'Civil liability ' | \
    remove_and_reinsert_article_title 193 'Forfeiture, cancellation, community service and other orders ' | \
    remove_and_reinsert_article_title 194 'Compounding of offences ' | \
    remove_and_reinsert_article_title 195 'Prevention order to protect the environment ' | \
    remove_and_reinsert_article_title 196 'Protection order against activities adverse on the environment ' | \
    remove_and_reinsert_article_title 197 'Emergency protection order ' | \
    remove_and_reinsert_article_title 198 'Environmental compliance order ' | \
    remove_and_reinsert_article_title 199 'Cost order ' | \
    remove_and_reinsert_article_title 200 'Offences in relation to environmental inspectors ' | \
    remove_and_reinsert_article_title 201 'Liability of managers of bodies corporate ' | \
    remove_and_reinsert_article_title 202 'Right of individual and legal persons to sue ' | \
    remove_and_reinsert_article_title 203 'Defences ' | \
    remove_and_reinsert_article_title 204 'Establishment and composition of the Tribunal ' | \
    remove_and_reinsert_article_title 205 'Sources of funds for the Tribunal ' | \
    remove_and_reinsert_article_title 206 'Jurisdiction of the Tribunal ' | \
    remove_and_reinsert_article_title 207 'Proceedings of the Tribunal ' | \
    remove_and_reinsert_article_title 208 'Awards of the Tribunal ' | \
    remove_and_reinsert_article_title 209 'Appeals to the High Court ' | \
    remove_and_reinsert_article_title 210 'Immunity of members of the Tribunal ' | \
    remove_and_reinsert_article_title 211 'Remuneration of members of the Tribunal ' | \
    remove_and_reinsert_article_title 212 'Appointment of the Registrar ' | \
    remove_and_reinsert_article_title 213 'Establishment of the National Environmental Trust Fund ' | \
    remove_and_reinsert_article_title 214 'Objectives of the Fund ' | \
    remove_and_reinsert_article_title 215 'Composition and administration of the Fund ' | \
    remove_and_reinsert_article_title 216 'Annual accounts and audit of the Fund ' | \
    remove_and_reinsert_article_title 217 'Sources of funds of the Council ' | \
    remove_and_reinsert_article_title 218 'Bank account and appropriation of funds ' | \
    remove_and_reinsert_article_title 219 'Power to raise and guarantee loans ' | \
    remove_and_reinsert_article_title 220 'Investments by the Council ' | \
    remove_and_reinsert_article_title 221 'Annual and supplementary budget ' | \
    remove_and_reinsert_article_title 222 'Accounts and audit ' | \
    remove_and_reinsert_article_title 223 'Annual Report ' | \
    remove_and_reinsert_article_title 224 'Act to bind the Government ' | \
    remove_and_reinsert_article_title 225 'Saving over recourse to civil litigation ' | \
    remove_and_reinsert_article_title 226 'Range of remedies to the injured ' | \
    remove_and_reinsert_article_title 227 'Environmental performance bond ' | \
    remove_and_reinsert_article_title 228 'Right to compensation ' | \
    remove_and_reinsert_article_title 229 'Environmental emergency preparedness ' | \
    sed -z 's/(230)/Regulations\n(230)/' | \
    remove_and_reinsert_article_title 231 'Repeal and savings ' | \
    remove_and_reinsert_article_title 232 'Inconsistency with other legislation ' | \
    remove_and_reinsert_article_title 233 'Act to be translated into Kishwahili ' 
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
    amend_errors_in_articles | \
    amend_errors_in_headers | \
    remove_and_reinsert_article_titles
}