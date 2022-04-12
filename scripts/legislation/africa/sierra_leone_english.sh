function remove_all_text_before_first_header {
  sed -n '/^Interprelation/,$p' | \
    sed -n '/^PART I - PRELIMINARY/,$p'
}

function prefix_article_numbers_with_article_literal {
  sed -E 's/^([0-9]+\.)/Article \1/'
}

function replace_parentheses_around_article_delimiters_with_square_brackets {
  sed -E 's/^\(([A-Za-z0-9]+)\)/[\1]/'
}

function remove_all_text_after_last_article {
  sed -z 's/2 \.\.\..*$//' 
}

function amend_errors_in_articles {
  sed -E 's/- /: /g' | \
    sed -E 's/of([a-z]+)/of \1/g' | \
    sed -E 's/\[•\] //g' | \
    sed -E 's/ \(1\)/ \[1\]/g' | \
    sed -E 's/Siena Leone/Sierra Leone/g' | \
    sed -E 's/SierraLeone/Sierra Leone/g' | \
    sed -E 's/anyof/any of/g' | \
    sed -E 's/of fice/office/g' | \
    sed -E 's/of fence/offence/g' | \
    #Article 1
    sed -E 's/\(1\) In/Interpretation.\n(1) In/' | \
    amend_error_in_article 1 '... _ __.*Act 2000' '' | \
    amend_error_in_article 1 'thisAct' 'this Act' | \
    amend_error_in_article 1 'contextotherwise' 'context otherwise' | \
    amend_error_in_article 1 'orstructure' 'or structure' | \
    amend_error_in_article 1 'theair spaceofSierra Leone' 'the airspace of Sierra Leone' | \
    amend_error_in_article 1 'fimits' 'limits' | \
    amend_error_in_article 1 'meanstheDirectorfortheDepartmentof' ' means the Director for the Department of' | \
    amend_error_in_article 1 'deposit,emissionor' 'deposit, emission or' | \
    amend_error_in_article 1 'limitation"meansany' 'limitation" means any' | \
    amend_error_in_article 1 'theMinistry' 'the Ministry' | \
    amend_error_in_article 1 'ratesandconcentration' 'rates and concentration' | \
    amend_error_in_article 1 'othercoostituents' 'other constituents' | \
    amend_error_in_article 1 'land,air, waterand' 'land, air, water and' | \
    amend_error_in_article 1 'existsamong' 'exists among' | \
    amend_error_in_article 1 'wi th' 'with' | \
    amend_error_in_article 1 'fordle' 'for the' | \
    amend_error_in_article 1 'ofanyenvironmental' 'of any environmental' | \
    amend_error_in_article 1 'inanylocality' 'in any locality' | \
    amend_error_in_article 1 'facility"meansany' 'facility" means any' | \
    amend_error_in_article 1 'anyenvironmental' 'any environmental' | \
    amend_error_in_article 1 'A "of fshore' 'An "offshore' | \
    amend_error_in_article 1 'over,in,on,or underany of the watersofSietTaLeone' 'over, in, on, or under any of the waters of Sierra Leone' | \
    amend_error_in_article 1 'withinSierra' 'within Sierra' | \
    amend_error_in_article 1 '\[t\] ' '' | \
    amend_error_in_article 1 'facilityor an of fshore' 'facility or an offshore' | \
    amend_error_in_article 1 'operatorof' 'operator of' | \
    amend_error_in_article 1 'thecaseof anyabandoned of fshorefacility' 'the case of any abandoned offshore facility' | \
    amend_error_in_article 1 't,. \(d\)' '[d]' | \
    amend_error_in_article 1 'controllingsuch' 'controlling such' | \
    amend_error_in_article 1 '"meansany' '" means any' | \
    amend_error_in_article 1 'alte\~on of thechemical,physical orbiol<>\$ical' 'alteration of the chemical, physical or biological' | \
    amend_error_in_article 1 'theenvironntent' 'the environment' | \
    amend_error_in_article 1 'detrimentalto# . \(' 'detrimental to t' | \
    amend_error_in_article 1 '"",.. ' '' | \
    amend_error_in_article 1 'construedaccordingly' 'construed accordingly' | \
    amend_error_in_article 1 '. "prescribe' '"prescribe' | \
    amend_error_in_article 1 'reqU!res' 'requires' | \
    amend_error_in_article 1 ',-.~ ' '' | \
    amend_error_in_article 1 '; I' ';' | \
    amend_error_in_article 1 "I t from the air,landor water,including'shorelines or the I " "from the air, land or water, including shorelines or the" | \
    amend_error_in_article 1 'necessary:to I: minimize damageto public~th or' 'necessary to minimize damage to public' | \
    amend_error_in_article 1 '--.,. 4 EnvironmelJI Protection Act' '' | \
    amend_error_in_article 1 'ofSierra' 'of Sierra' | \
    amend_error_in_article 1 'resourcesin .' 'resources in' | \
    amend_error_in_article 1 'subswface' 'sub-surface' | \
    amend_error_in_article 1 'Leone,' 'Leone.' | \
    amend_error_in_article 1 'thetaking' 'the taking' | \
    amend_error_in_article 1 "air'" 'air"' | \
    amend_error_in_article 1 '. "environment' '; "environment' | \
    amend_error_in_article 1 '; , "licence' '; "licence' | \
    amend_error_in_article 1 ' " licence;' ' licence;' | \
    amend_error_in_article 1 'means"' 'means' | \
    amend_error_in_article 1 'inspection,"' 'inspection,' | \
    amend_error_in_article 1 'An "' 'an "' | \
    amend_error_in_article 1 "project'" "project" | \
    amend_error_in_article 1 ' ,' '' | \
    amend_error_in_article 1 'water-resources' 'water resources' | \
    amend_error_in_article 1 'an "offshore' '"offshore' | \
    #Article 2
    sed -E "s/Establis~t~ \[1\] There is hereby established the National Environment ~~r:'= ProtectionBoard <hereinafter referredto as//" | \
    sed -E 's/"theBoard"\), Protection Board Composition and tenure of officeof the Board.//' | \
    sed -E 's/\(3\)/Establishment of the National Environment Protection Board.\n(2) There is hereby established the National Environment Protection Board (hereinafter referred to as "the Board").\n\n(3)/' | \
    #Article 3
    sed -E 's/\(3\) \[1\]/Composition and tenure of office of the Board.\n(3) [1]/' | \
    amend_error_in_article 3 'r \[a\] achairmanwhobas' '[a] a chairman who has' | \
    amend_error_in_article 3 'otherpersons,' 'other persons.' | \
    amend_error_in_article 3 'Thechairman' 'The chairman' | \
    amend_error_in_article 3 'othermembers' 'other members' | \
    amend_error_in_article 3 'thePresident' 'the President' | \
    amend_error_in_article 3 'Parliament \[3\]' 'Parliament. [3] A' | \
    amend_error_in_article 3 'office for a termof' 'office for a term of' | \
    amend_error_in_article 3 'bere-appointed. ' ' be re-appointed' | \
    amend_error_in_article 3 '\(4\) The' '[4] The' | \
    amend_error_in_article 3 'cbairman ' 'chairman ' | \
    amend_error_in_article 3 'officeby written' 'office by written' | \
    amend_error_in_article 3 "Ministerand may beremoved fromofficeby aTribunal'forinability" "Minister and may be removed from office by a Tribunal for inability" | \
    amend_error_in_article 3 '   ' ' ' | \
    amend_error_in_article 3 'Tribunalshall beconstituted by theMinisterand shall consistof' 'Tribunal shall be constituted by the Minister and shall consist of' | \
    #Article 4
    sed -E 's/FUDdians eX \[4\] The Board sbaUtbeBalrd./\n\nFunctions of the Board.\n(4) The Board shall:/' | \
    amend_error_in_article 4 'andothergovernmental' 'and other governmental' | \
    amend_error_in_article 4 '-. .;\} h No. 2 Environment Protection Act 5 ~, r . t ' '' | \
    amend_error_in_article 4 'enviroDmeDtaI' 'environmental' | \
    amend_error_in_article 4 'recoDUDeIMIa1io' 'recommendations' | \
    amend_error_in_article 4 'neoessaJy tothe' 'necessary to the' | \
    amend_error_in_article 4 '.to ' 'to' | \
    amend_error_in_article 4 'mate appropriaterecommendations to theDim:tor' 'make appropriate recommendations to the Director' | \
    amend_error_in_article 4 'investipted. 38y activity, occurrence or transaetioa' 'investigated any activity, occurrence or transaction' | \
    amend_error_in_article 4 'bave' 'have' | \
    amend_error_in_article 4 'hanDful consequences to the environmentaod' 'harmful consequences to the environment and' | \
    amend_error_in_article 4 'Oft measures neoessaJy to preventorminimisesuch' 'on measures necessary to prevent or minimise such' | \
    amend_error_in_article 4 'enviroDmentai' 'environmental' | \
    amend_error_in_article 4 'requiriDg special or additioDal' 'requiring special or additional' | \
    amend_error_in_article 4 'iDdialtiDg the pioIi1iesand specificgoalsto' 'indicating the priorities and specific goals to be achieved' | \
    amend_error_in_article 4 '\[I\] undertake or cause to be undeJtataI' '[f] undertake or cause to be undertaken' | \
    amend_error_in_article 4 'aimed_' 'aimed' | \
    amend_error_in_article 4 'stlategies for theprotectiOll of theeaviromneat' 'strategies for the protection of the environment' | \
    amend_error_in_article 4 'recom~' 'recommendations' | \
    amend_error_in_article 4 'oonsideranyodlermanerswbidlmayberefened' 'consider any other matters which may be referred' | \
    amend_error_in_article 4 'recommendations or it' 'recommendations or proposals it' | \
    amend_error_in_article 4 '.to this' 'to this' | \
    amend_error_in_article 4 'achieved be achieved' 'achieved' | \
    #Article 5
    amend_error_in_article 4 'proposals1hI::moo.. \[s\] \(I\)' 'proposals thereon. \n\nMeetings of the Board.\n(5) [1]' | \
    amend_error_in_article 5 'Subjectto theprovisioDsofIbis seclim, theBc.dshall Mrs;".of' 'Subject to the provisions of this section, the Board shall' | \
    amend_error_in_article 5 'suchtimes' 'such times' | \
    amend_error_in_article 5 'expedientfortbe traIJSaCIion dieBoad.. of its business' 'expedient for the transaction of its business' | \
    amend_error_in_article 5 'theBaud may be CODveued' 'the Board may be convened' | \
    amend_error_in_article 5 'meetingm1heBoanI shaD' 'meeting of the Board shall' | \
    amend_error_in_article 5 'Tbecbairmanshall presideatmeehDSSof tbeBoaRIaod' 'The chairman shall preside at meetings of the Board and' | \
    amend_error_in_article 5 '80aRI appointed by die membem' 'Board appointed by the members' | \
    amend_error_in_article 5 '6 No.2 Environment Protection Act &' '' | \
    amend_error_in_article 5 'Boardbutshall' 'Board but shall' | \
    amend_error_in_article 5 'voteonany matterfor decision bythe' 'vote on any matter for decision by the' | \
    amend_error_in_article 5 'meetingsof' 'meetings of' | \
    amend_error_in_article 5 'thememberspresentand votingandthechairman' 'the members present and voting and the chairman' | \
    amend_error_in_article 5 'eventof equalityin' 'event of equality in' | \
    #Article 6
    amend_error_in_article 5 'v~. . Committees. \[5\]' 'vote. \n\nCommittees.\n(6)' | \
    amend_error_in_article 6 'thereoftoperform' 'thereof to perform' | \
    amend_error_in_article 6 'asit may thinknecessary' 'as it may think necessary' | \
    #Article 7
    amend_error_in_article 6 'Pr~ure d' '\n\nProcedure of Board and Committees.\n(7)' | \
    amend_error_in_article 7 'Subjecttotheprovisionsof thisAct,theBoardcudcommittees ~a:.. ' 'Subject to the provisions of this Act, the Board and committees ' | \
    #Article 8
    amend_error_in_article 7 'Honorarium. \[8\]' '\n\nHonorarium.\n(8)' | \
    amend_error_in_article 8 'Boardand' 'Board and' | \
    amend_error_in_article 8 's~ll be paid suchhonorarium as theMinisterafterconsultation withtheMnisterfor' 'shall be paid such honorarium as the Minister after consultation with the Minister for' | \
    #Article 9
    sed -z 's/: L Dutiesc1 Minister.\n/\n\nDuties of Minister./' | \
    amend_error_in_article 9 'goak' 'goals' | \
    amend_error_in_article 9 'JX\*ies on all aspects concerning environme.tal ptoteetion' 'policies on all aspects concerning environmental protection' | \
    amend_error_in_article 9 'frot GovernmentMinistries' 'from Government Ministries' | \
    amend_error_in_article 9 'andothel' 'and other' | \
    amend_error_in_article 9 'Ministersuch' 'Minister such' | \
    amend_error_in_article 9 'provrsrons' 'provisions' | \
    amend_error_in_article 9 '< No.2 linvironment Protection Act 7 .. \(d\)' '[d]' | \
    amend_error_in_article 9 '. advice,technical or otherassistance' ' advice, technical or other assistance' | \
    amend_error_in_article 9 'GovernmentMinistries.local authoritiesand' 'Government Ministries, local authorities and' | \
    amend_error_in_article 9 'actionsto be takenor' 'actions to be taken or' | \
    amend_error_in_article 9 'and ,the' 'and, the' | \
    amend_error_in_article 9 'actionif in theopinion' 'action if in the opinion' | \
    amend_error_in_article 9 '. anyactiontaken, beingtakenor planneddoes' ', any action taken, being taken or planned does' | \
    amend_error_in_article 9 '\(0 reviewing the prog-ress' '[f] reviewing the progress' | \
    amend_error_in_article 9 'Ministershall' 'Minister shall' | \
    amend_error_in_article 9 'promoteco' 'promote co' | \
    amend_error_in_article 9 'otherMinisters' 'other Ministers' | \
    amend_error_in_article 9 'bodiesconcerned' 'bodies concerned' | \
    amend_error_in_article 9 'impactQIl' 'impact on' | \
    amend_error_in_article 9 'fco-operate~·' 'co-operate ' | \
    amend_error_in_article 9 'forprotecting theenvironmentand identifyingandpublicising' 'for protecting the environment and identifying and publicising' | \
    amend_error_in_article 9 'information advice' 'information, advice' | \
    amend_error_in_article 9 'environment \[3\]' 'environment. [3]' | \
    #Article 10
    sed -E 's/\(10\)/Power to Delegate.\n(10)/' | \
    amend_error_in_article 10 'Subjectto subsection\(2\), theMinistermaydelegate' 'Subject to subsection [2], the Minister may delegate' | \
    amend_error_in_article 10 'hispowers' 'his powers' | \
    amend_error_in_article 10 'underthisAclto theDirectorOrsuch' 'under this Act to the Director or such' | \
    amend_error_in_article 10 'fit \[2\]' 'fit. [2]' | \
    amend_error_in_article 10 'PQwer' 'power' | \
    amend_error_in_article 10 'Power to ' '' | \
    amend_error_in_article 10 'delegate. ' '' | \
    amend_error_in_article 10 'section41. 8 No.2 Environment Protection Act L Deparlmentof \[11\] -.' 'section 41.\n\nDepartment of the Environment.\n(11)' | \
    #Article 11
    amend_error_in_article 11 'the:VilODIDeIlt' 'the environment' | \
    amend_error_in_article 11 'Department of the EnvironmenL \[2\] .' '\[2\] ' | \
    amend_error_in_article 11 'Tbe Directorshall be prof essionally' 'The Director shall be professionally' | \
    amend_error_in_article 11 'environmen1al' 'environmental' | \
    amend_error_in_article 11 'Ministry the environment' 'Ministry the Department of the Environment' | \
    #Article 12
    amend_error_in_article 11 'Respomibilities 11' '\n\nResponsibilities of the Department.\n(12)' | \
    amend_error_in_article 12 'The Deparlment of the Environment shall, subject to \~lDd1t.' 'The Department of the Environment shall, subject to this' | \
    amend_error_in_article 12 'andact' 'and act' | \
    amend_error_in_article 12 'aU Didional' 'all national' | \
    amend_error_in_article 12 '< \(2\)' '[2]' | \
    amend_error_in_article 12 '\(I\), the Departmentshall: \[a\] 1"ro\~ote' '[1], the Department shall: [a] promote' | \
    amend_error_in_article 12 'tDonitor' 'monitor' | \
    amend_error_in_article 12 'progmmmesand projects,standards' 'programmes and projects, standards' | \
    amend_error_in_article 12 'advi\~' 'advise' | \
    amend_error_in_article 12 'groupsto' 'groups to' | \
    amend_error_in_article 12 '; 4 \[e\]' '; [e]' | \
    amend_error_in_article 12 '\(0 pat1icipate' '[f] participate' | \
    amend_error_in_article 12 ' , revieW' 'review' | \
    amend_error_in_article 12 'Environment Protection Act 9 \(h\) cooRlinate and monitor tile implementation cI' '[h] coordinate and monitor the implementation of' | \
    amend_error_in_article 12 'andotheragencies onmatterS rdating' 'and other agencies on matters relating' | \
    amend_error_in_article 12 'and"management; fj\)' 'and management; [j]' | \
    amend_error_in_article 12 'appqxiate meansand in ooopemtion with publicor private0tpniDti0ns' 'appropriate means and in cooperation with public or private organizations' | \
    amend_error_in_article 12 'dataand' 'data and' | \
    amend_error_in_article 12 'nationa] environmental standan:Is; \[1\]' 'national environmental standards; [l]' | \
    amend_error_in_article 12 'othersubsidiary' 'other subsidiary' | \
    amend_error_in_article 12 'canyomotherduliesasarenecessaryorexpedient' 'carry out other duties as are necessary or expedient' | \
    amend_error_in_article 12 '" its duties underthis Act' 'its duties under this Act.' | \
    amend_error_in_article 12 'dischargeits' 'discharge of its' | \
    amend_error_in_article 12 "government'sreview" "government's review" | \
    amend_error_in_article 12 'Siam' 'Sierra' | \
    amend_error_in_article 12 '\.monitor' 'monitor' | \
    amend_error_in_article 12 'this this' 'this' | \
    amend_error_in_article 12 'environmental Policies' 'environmental policies' | \
    #Article 13
    sed -E 's/\(13\)/Duties of the Director.\n(13)/' | \
    amend_error_in_article 13 '\(I\) The Directorshall,sUbject to the policy guiclana:of the \~es' '[1] The Director shall, subject to the policy guidance' | \
    amend_error_in_article 13 'implementationof the" National DiRdor.' 'implementation of the National' | \
    amend_error_in_article 13 'TheDirector~y in writing designate any officere#the' 'The Director may in writing designate any officer of the' | \
    amend_error_in_article 13 '\)llay' 'may' | \
    amend_error_in_article 13 'andmay' 'and may' | \
    amend_error_in_article 13 'conferredon him by thisAct' 'conferred on him by this Act.' | \
    #Article 14
    sed -E 's/\(14\)/Prohibition of certain activites.\n(14)/' | \
    amend_error_in_article 14 "Prohibitionof'" "" | \
    amend_error_in_article 14 'setout in the actiVIties. RntSchedule' 'set out in the First Schedule' | \
    amend_error_in_article 14 'respectof' 'respect of' | \
    amend_error_in_article 14 '-Anypersonwbooonbavenesdteprovisionsdsubsection \[I\] commits an offence' 'Any person who contravenes the provisions of subsection [1] commits an offence' | \
    amend_error_in_article 14 'exceedingfivemillionleonesin the caseof' 'exceeding five million leones in the case of' | \
    amend_error_in_article 14 'citizenorSienaLeoneand' 'citizen of Sierra Leone and' | \
    amend_error_in_article 14 'thecaseof noo-citizens cLSierra Leooeorto a termof' 'the case of non-citizens of Sierra Leone or to a term of' | \
    amend_error_in_article 14 'notexceeding two yearsorto' 'not exceeding two years or to' | \
    amend_error_in_article 14 '. No.1 10 No. 2 Environment Protection Act 2000' '' | \
    amend_error_in_article 14 'and  ' 'and ' | \
    amend_error_in_article 14 'beholds' 'he holds' | \
    amend_error_in_article 14 'to"' 'to' | \
    #Article 15
    sed -z 's/Application forand issue of licences.\n\n/\n\nApplication for and issue of licences.\n/' | \
    amend_error_in_article 15 'causeto be undertaken-' 'cause to be undertaken ' | \
    amend_error_in_article 15 'shallapply' 'shall apply' | \
    amend_error_in_article 15 'Anapplication' 'An application' | \
    amend_error_in_article 15 'bya descriptionof' 'by a description of' | \
    #Article 16
    amend_error_in_article 15 'Director to \[16\]' '\n\nDirector to decide on need for environmental impact assessments.\n(16)' | \
    amend_error_in_article 16 'Directorshall, within fourteen daysof receiving an t;ide on need' 'Director shall, within fourteen days of receiving an' | \
    amend_error_in_article 16 'environmental environmental' 'environmental' | \
    amend_error_in_article 16 'isrequiredin' 'is required in' | \
    amend_error_in_article 16 'the project impact. assessments. \(2\)' 'of the project. [2]' | \
    amend_error_in_article 16 'intoconsideration' 'into consideration' | \
    amend_error_in_article 16 'asto' 'as to' | \
    amend_error_in_article 16 'of of' 'of' | \
    #Article 17
    sed -z 's/Director to issue licence. Applicant to prepare environmental impect" assessment. Public comments.\n\n/\n\nDirector to issue licence.\n/' | \
    amend_error_in_article 17 'notrequired' 'not required' | \
    amend_error_in_article 17 'anyproject theDirector shallissue' 'any project the Director shall issue' | \
    #Article 18
    sed -E 's/\(18\)/Applicant to prepare environmental impact assessment.\n(18)/' | \
    amend_error_in_article 18 'Anapplicantshall' 'An applicant shall' | \
    amend_error_in_article 18 'beentaken' 'been taken' | \
    amend_error_in_article 18 'Directoran' 'Director an' | \
    amend_error_in_article 18 'impactassessment' 'impact assessment' | \
    #Article 19
    sed -E 's/\(19\)/Public comments.\n(19)/' | \
    amend_error_in_article 19 'TheDirectorshall, afterreceiving ap environmentimpact' 'The Director shall, after receiving an environment impact' | \
    amend_error_in_article 19 'prof essional' 'professional' | \
    sed -E 's/Directorshall/Director shall/' | \
    amend_error_in_article 19 'impactassessment openfor' 'impact assessment open for' | \
    amend_error_in_article 19 'andcomments andheshall givenotice tothateffect' 'and comments and he shall give notice to that effect' | \
    amend_error_in_article 19 'twoconsecutive' 'two consecutive' | \
    amend_error_in_article 19 'twoissues' 'two issues' | \
    amend_error_in_article 19 'exceptthat' 'except that' | \
    amend_error_in_article 19 '1:1t' 'at' | \
    amend_error_in_article 19 'secondpublications. No.1 Environment Protection Act 11' 'second publications.' | \
    amend_error_in_article 19 'underthissection' 'under this section' | \
    amend_error_in_article 19 'daysof the lastpublication in theGazette' 'days of the last publication in the Gazette' | \
    amend_error_in_article 19 'may beto' 'may be to' | \
    amend_error_in_article 19 ', to the Director. r \[20\]' ' to the Director.\n\n(20)' | \
    #Article 20
    sed -E 's/\(20\)/Director to submit comments etc. to Board.\n(20)/' | \
    amend_error_in_article 20 'Directorshall,after recel\~\~ng the commentson' 'Director shall, after reading the comments on' | \
    amend_error_in_article 20 'Director to environmental' 'environmental' | \
    amend_error_in_article 20 'submit th .th th " th h B d f comments etc. assessment' '' | \
    amend_error_in_article 20 'loge er wr e comments ereon to t e oar lor Its to Board. consideration.' 'together with the comments thereon to the Board for its consideration.' | \
    amend_error_in_article 20 'assessmentand' 'assessment and' | \
    amend_error_in_article 20 ', \(a\) referthem backto' '[a] refer them back to' | \
    amend_error_in_article 20 'witha direction to issuea licenceon suchterms' 'with a direction to issue a licence on such terms' | \
    amend_error_in_article 20 'considersappropriate' 'considers appropriate' | \
    amend_error_in_article 20 'theenvironmental' 'the environmental' | \
    amend_error_in_article 20 'theassessment willhave' 'the assessment will have' | \
    amend_error_in_article 20 'peopleor society.; ""' 'people or society. ' | \
    amend_error_in_article 20 "\!' " "" | \
    amend_error_in_article 20 'assessmentreferred: hack to' 'assessment referred back to' | \
    amend_error_in_article 20 '\(b\) of subsection \(2\)' '[b] of subsection [2]' | \
    amend_error_in_article 20 'withintwenty-one daysof' 'within twenty-one days of' | \
    amend_error_in_article 20 '" \[4\]' '[4]' | \
    amend_error_in_article 20 '"been disapproved the applicationin respectof the projectshall be rejected .' 'been disapproved the application in respect of the project shall be rejected' | \
    amend_error_in_article 20 'impact  together with' 'impact assessment together with' | \
    #Article 21
    sed -E 's/\(21\)/Director to issue licences.\n(21)/' | \
    amend_error_in_article 21 'Yithout Prejudice' 'Without prejudice' | \
    amend_error_in_article 21 'Director shall, wherethe Directorto Boardso directs,issuea licenceto' 'Director shall, where the Board so directs, issue a licence to' | \
    amend_error_in_article 21 'respectof a project. issue licences' 'respect of a project' | \
    #Article 22
    sed -E 's/\(22\)/Effect of licences.\n(22)/' | \
    amend_error_in_article 22 'FIfeet of this Actshall: . licences. 12 No.2 ._--: Eavironmenl Protection Act \[a\] bein' 'this Act shall: [a] be in' | \
    amend_error_in_article 22 'thelicensee' 'the licensee' | \
    amend_error_in_article 22 'bespecifiedtherein; \[c\] tJe·validfor' 'be specified therein; [c] be valid for' | \
    amend_error_in_article 22 'fromthedate of issue orsuchperiodastheDirectormaydetermine' 'from the date of issue or such period as the Director may determine' | \
    amend_error_in_article 22 'sucb conditionsas' 'such conditions as' | \
    amend_error_in_article 22 'protectionof' 'protection of' | \
    #Article 23
    sed -z 's/.1 Reoewalof licences.\n\n/\n\nRenewal of licences.\n/' | \
    amend_error_in_article 23 'licencemay at expirationof theperiod specifiedinit' 'licence may at expiration of the period specified in it' | \
    amend_error_in_article 23 'theDirector' 'the Director' | \
    amend_error_in_article 23 'theowner of' 'the owner of' | \
    #Article 24
    amend_error_in_article 23 'A~ against \[24\] Any person aggrievedby' '\n\nAppeal against decision.\n(24) Any person aggrieved by' | \
    amend_error_in_article 24 'aggrievedby' 'aggrieved by' | \
    amend_error_in_article 24 'deciSIOIL' 'decision' | \
    amend_error_in_article 24 'to-the' 'to the' | \
    #Article 25
    amend_error_in_article 24 'Licence fees. \[25\] The Ministermay by regulationsprescribe' '\n\nLicence fees. \n(25) The Minister may by regulations prescribe' | \
    amend_error_in_article 25 'issued under this Act' 'issued under this Act.' | \
    #Article 26
    amend_error_in_article 25 '. \[26\] \[1\] Where: .' '\n\nCancellation, suspension or modification or licences.\n(26) [1] Where:' | \
    amend_error_in_article 26 'andconditions of a licence are notbeing' 'and conditions of a licence are not being' | \
    amend_error_in_article 26 'isa' 'is a' | \
    amend_error_in_article 26 'No.Z .. Environment Protection Act ·13 . , [\] ' '' | \
    amend_error_in_article 26 'Director shallnotify the holderof \~rlicence-wbielr---------.--.----:' 'Director shall notify the holder of a licence which' | \
    amend_error_in_article 26 'cancelled.suspendedor onwhich~tional' 'cancelled, suspended or on which additional' | \
    amend_error_in_article 26 'imposed,of such canceUati\~' 'imposed, of such cancellation' | \
    amend_error_in_article 26 'impositionof' 'imposition of' | \
    amend_error_in_article 26 '\~"' '' | \
    amend_error_in_article 26 "' \[3\] The Directormay" "[3] The Director may" | \
    amend_error_in_article 26 'confened undersubsection \(I\) prescribemeasuresto be by theownerof' 'conferred under subsection [1] prescribe measures to be by the owner of' | \
    amend_error_in_article 26 'adverseeffectson or anydamage the environment' 'adverse effects on or any damage the environment.' | \
    amend_error_in_article 26 'Directormay imposesuch tenus andconditioos as f he maythinknecessary forthe' 'Director may impose such terms and conditions as he may think necessary for the' | \
    amend_error_in_article 26 'operatiOns of a projectin respectof whicha licence bas been cancelledors\~' 'operations of a project in respect of which a licence has been cancelled or suspended.' | \
    amend_error_in_article 26 'personaggrieved by adecision tocancel orsuspend' 'person aggrieved by a decision to cancel or suspend' | \
    amend_error_in_article 26 'licencemay,withinfourteendaysof' 'licence may, within fourteen days of' | \
    amend_error_in_article 26 'notificatiolidthe\~ncellalioo' 'notification of the cancellation' | \
    amend_error_in_article 26 'to be by' 'to be taken by' | \
    amend_error_in_article 26 'any damage the' 'remedy any damage to the' | \
    #Article 27
    sed -E 's/\(11\) \(I\) Subjectto theprovisions of sedion,licencesare/Transferability of licences.\n(27) [1] Subject to the provisions of this section, licences are/' | \
    amend_error_in_article 27 'Traasferability uansferable. of licences.' 'transferable.' | \
    sed -E 's/oontrol or/control or/' | \
    amend_error_in_article 27 'thatprojectchanges,. the previous ownel"and thenew ownersball' 'that project changes, the previous owner and the new owner shall' | \
    amend_error_in_article 27 'Directorin' 'Director in' | \
    amend_error_in_article 27 'oontrol or . management' 'control or management.' | \
    amend_error_in_article 27 'subsedion \(2\), the new ownershall' 'subsection [2], the new owner shall' | \
    amend_error_in_article 27 'afterthe' 'after the' | \
    amend_error_in_article 27 'respectof' 'respect of' | \
    amend_error_in_article 27 '\~wnersbip, conttolor' 'ownership, control or' | \
    amend_error_in_article 27 'poject' 'project' | \
    amend_error_in_article 27 'preVIOUSownerand the newownershallboth' 'previous owner and the new owner shall both' | \
    amend_error_in_article 27 'theDirectorwithin' 'the Director within' | \
    amend_error_in_article 27 'daysof the tnmsferof' 'days of the transfer of' | \
    amend_error_in_article 27 'con\~ or managemenL' 'control or management.' | \
    amend_error_in_article 27 'TheDirectorsbaIl, upondue' 'The Director shall, upon due' | \
    amend_error_in_article 27 'the.new' 'the new' | \
    amend_error_in_article 27 "endorsement '" "endorsement." | \
    amend_error_in_article 27 'IM"-,----------------------......---....: .... 14 No.2 Environment Protection Act Register. Directorto monitor . projects.' '' | \
    amend_error_in_article 27 'Any; person' 'Any person' | \
    amend_error_in_article 27 'ownerof' 'owner of' | \
    amend_error_in_article 27 'transferto' 'transfer to' | \
    amend_error_in_article 27 'Directoras' 'Director as' | \
    amend_error_in_article 27 'commitsan offence' 'commits an offence' | \
    amend_error_in_article 27 'projectshall' 'project shall' | \
    #Article 28
    sed -E 's/\(28\)/Register.\n(28)/' | \
    amend_error_in_article 28 'beprescribed' 'be prescribed' | \
    #Article 29
    sed -E 's/\(29\)/Director to monitor projects.\n(29)/' | \
    amend_error_in_article 29 'Forthe' 'For the' | \
    amend_error_in_article 29 'powersin' 'powers in' | \
    amend_error_in_article 29 '.\(b\)' '[b]' | \
    sed -z 's/(2) There is hereby established the National Environment Protection Board (hereinafter referred to as "the Board").\n\n(3) Where/\n\n(3) Where/' | \
    sed -z 's/. Establishment of the National Environment Protection Board.\n\n\n//' | \
    amend_error_in_article 29 ' _ .. --------------: No.2 Environment Protection Act' '' | \
    amend_error_in_article 29 '\(3\) Where' '[3] Where' | \
    amend_error_in_article 29 'groundsto' 'grounds to' | \
    amend_error_in_article 29 'offence has been oris' 'offence has been or is' | \
    amend_error_in_article 29 'performtests' 'perform tests' | \
    amend_error_in_article 29 'itemorsubstance' 'item or substance' | \
    amend_error_in_article 29 'thecommissionof suchoffence orin' 'the commission of such offence or in' | \
    amend_error_in_article 29 '15 ,. ' '' | \
    amend_error_in_article 29 'Direshall' 'Director shall' | \
    #Article 30
    amend_error_in_article 29 'JO. ' '\n\nDuties of owners of projects.\n(30) ' | \
    amend_error_in_article 30 'penni t' 'permit' | \
    amend_error_in_article 30 'whenev er' 'whenever' | \
    amend_error_in_article 30 '...r five' 'five' | \
    amend_error_in_article 30 'yeato' 'year to' | \
    amend_error_in_article 30 'owners u\( projects. ' '' | \
    amend_error_in_article 30 'Imprisonment' 'imprisonment' | \
    amend_error_in_article 30 'oof ' 'owner of' | \
    amend_error_in_article 30 'Duties of Director' 'Director' | \
    amend_error_in_article 30 'Ad;' 'Act;' | \
    amend_error_in_article 30 'tine' 'fine' | \
    #Article 31
    sed -E 's/\(31\)/Identification of authorised officers.\n(31)/' | \
    amend_error_in_article 31 'of ffiauthorised o cers. ' '' | \
    amend_error_in_article 31 'Identification conferred ' 'conferred ' | \
    #Article 32
    amend_error_in_article 31 '\( \[1\]. b 16 No.2 Environment Protection Act 2000 -"·_-\~·\~Pffitecuooor--\~··__ ·"32:---' '[1].\n\nProtection of officers.\n(32) ' | \
    amend_error_in_article 32 'Noperson' 'No person' | \
    amend_error_in_article 32 'thefunctions' 'the functions' | \
    amend_error_in_article 32 '<ificers. ' '' | \
    #Article 33
    sed -z 's/Financial _ security. Environmental standards.\n\n/\n\nFinancial security.\n/' | \
    amend_error_in_article 33 "'regulations" "regulations" | \
    amend_error_in_article 33 'orother' 'or other' | \
    amend_error_in_article 33 'seeurity' 'security' | \
    amend_error_in_article 33 'paymentof' 'payment of' | \
    amend_error_in_article 33 'partof' 'part of' | \
    amend_error_in_article 33 '"restorative' 'restorative' | \
    #Article 34
    sed -E 's/\(34\)/Environmental standards.\n(34)/' | \
    amend_error_in_article 34 ',\(ii\)' '[ii]' | \
    amend_error_in_article 34 'No.2 Environment Protection Act' '' | \
    #Article 35
    sed -E 's/\(35\)/Toxic and hazardous substances.\n(35)/' | \
    amend_error_in_article 35 'MiniSter mayon the adViCe' 'Minister may on the advice' | \
    amend_error_in_article 35 'Boa1iI prescribe Toxic and' 'Board prescribe' | \
    amend_error_in_article 35 'beconsidered hazardous. su\~' 'be considered hazardous' | \
    amend_error_in_article 35 'Ministershall' 'Minister shall' | \
    amend_error_in_article 35 'hazanloussubstances, includingtoxic' 'hazardous substances, including toxic' | \
    amend_error_in_article 35 'wastesintoSierra' 'wastes into Sierra' | \
    amend_error_in_article 35 'forstorageordisposal byanymeans' 'for storage or disposal by any means' | \
    amend_error_in_article 35 'promhited' 'prohibited' | \
    amend_error_in_article 35 'Anyperson whocontravenesthe provisionsof' 'Any person who contravenes the provisions of' | \
    amend_error_in_article 35 '\(4\) or \(5\) commits an offenceand' '[4] or [5] commits an offence and' | \
    amend_error_in_article 35 'imprisonment \[7\]' 'imprisonment. [7]' | \
    amend_error_in_article 35 '\(5\),' '[5],' | \
    amend_error_in_article 35 'ifit' 'if it' | \
    amend_error_in_article 35 'thatthe dischrage wascausedsolely' 'that the discharge was caused solely' | \
    amend_error_in_article 35 'war. I' 'war.' | \
    amend_error_in_article 35 'beforeit thatthe' 'before it that the' | \
    amend_error_in_article 35 'wascausedsolely' 'was caused solely' | \
    amend_error_in_article 35 'thatthe' 'that the' | \
    #Article 36
    amend_error_in_article 35 'environment Article \[36\] \(' 'environment.\n\nNotification to the Minister.\n(36)' | \
    amend_error_in_article 36 'oronshore or of fshore ' 'or on shore or offshore ' | \
    amend_error_in_article 36 'Noti\~onto ' '' | \
    amend_error_in_article 36 '\(5\) of the Mimster.' '[5] of the Minister of' | \
    amend_error_in_article 36 'of fshore' 'offshore' | \
    amend_error_in_article 36 '18 No.2 Environment Protection Act ' '' | \
    amend_error_in_article 36 '\(I\)' '[1]' | \
    amend_error_in_article 36 'on shore' 'onshore' | \
    amend_error_in_article 36 'of the Minister ' '' | \
    #Article 37
    amend_error_in_article 36 'Legal \[37\]' '\n\nLegal proceedings.\n(37)' | \
    amend_error_in_article 37 'proceedings. any memberof' 'proceedings any member of' | \
    amend_error_in_article 37 'finn ' 'firm ' | \
    amend_error_in_article 37 '. with the Act' 'with the Act' | \
    amend_error_in_article 37 'company or by proceedings any member' 'company or by any member' | \
    #Article 38
    sed -E 's/ Establishment \[38\]/Establishment of the National Environment Fund.\n(38)/' | \
    amend_error_in_article 38 'Nationtal ' '' | \
    amend_error_in_article 38 'ofEn\~e ' '' | \
    amend_error_in_article 38 'vironmen Fund. ' '' | \
    amend_error_in_article 38 'I I No.2 Environment Protection Act 19 ' '' | \
    amend_error_in_article 38 '\(4\), .' '[4],' | \
    amend_error_in_article 38 'iis' 'is' | \
    amend_error_in_article 38 'There ts' 'There is' | \
    amend_error_in_article 38 "''" '"' | \
    amend_error_in_article 38 '\[4\],no' '[4], no' | \
    #Article 39
    sed -E 's/\(39\)/Objectives of the Fund.\n(39)/' | \
    amend_error_in_article 39 '\(0' '[f]' | \
    amend_error_in_article 39 'Objectives of the Fund.' '' | \
    #Article 40
    sed -E 's/\(40\)/Accounts and audit.\n(40)/' | \
    amend_error_in_article 40 '\( \[1\]' '[1]' | \
    amend_error_in_article 40 'audit. ,' '' | \
    amend_error_in_article 40 'hy the AuditorI ' 'by the Auditor-' | \
    amend_error_in_article 40 'submitto' 'submit to' | \
    amend_error_in_article 40 'annuaJstatement' 'annual statement' | \
    amend_error_in_article 40 '20 No.2 Environment Protection Act 2000 ' '' | \
    amend_error_in_article 40 'Ministershall' 'Minister shall' | \
    amend_error_in_article 40 'copyof' 'copy of' | \
    amend_error_in_article 40 'maymake' 'may make' | \
    amend_error_in_article 40 'Cabinet \[5\]' 'Cabinet. [5]' | \
    amend_error_in_article 40 '.me use of the Fund' 'the use of the Fund.' | \
    amend_error_in_article 40 'MInister' 'Minister' | \
    amend_error_in_article 40 '  \[2\]' ' [2]' | \
    amend_error_in_article 40 'records in Accounts and relation' 'records in relation' | \
    #Article 41
    sed -E 's/Regulations. \[41\]/\n\nRegulations.\n(41)/' | \
    amend_error_in_article 41 'Act \[2\]' 'Act. [2]' | \
    amend_error_in_article 41 'Regulationsmadepursuanttosubsection\(1\)mayprovide' 'Regulations made pursuant to subsection [1] may provide' | \
    amend_error_in_article 41 'anyproject' 'any project' | \
    amend_error_in_article 41 "I' \[c\]" "[c]" | \
    amend_error_in_article 41 'theregulations' 'the regulations' | \
    amend_error_in_article 41 'penaltiesfor' 'penalties for' | \
    amend_error_in_article 41 '\[1\] anyother' '[f] any other' | \
    sed -E 's/  / /g'
}

function amend_errors_in_headers {
  sed -E 's/PART III/\n\nPART III -/' | \
    sed -E 's/PART II-/\n\nPART II - /' | \
    sed -E 's/PART I : PRELIMINARY/PART I - PRELIMINARY/' | \
    sed -E 's/PART IV THE NATIONAL ENVIRONMENT FUND/\n\nPART IV - THE NATIONAL ENVIRONMENT FUND\n\n/' | \
    sed -E 's/." PART V REGULATIONS/\n\nPART V - REGULATIONS/' 
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
    amend_errors_in_headers
}
