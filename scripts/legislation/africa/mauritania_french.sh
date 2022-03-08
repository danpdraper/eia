#!/bin/bash

function remove_all_text_before_first_header {
  sed -E 's/ TITRE I/\nTITRE I -/' | \
    sed -n '/^TITRE I /,$p'
}

function amend_errors_in_articles {
  local stdin="$(</dev/stdin)"

  local article_39_text='Les installations de déversement établies '
  article_39_text+='postérieurement à la promulgation de la présente loi '
  article_39_text+='doivent, dès leur mise en service, assurer'

  local article_47_text="Les vendeurs et les utilisateurs des pesticides ou "
  article_47_text+="d'autres substances chimiques à effets nuisibles sont "
  article_47_text+="tenus de ne vendre et de n'utiliser que des produits "
  article_47_text+="entrant dans la nomenclature légalement admise par les "
  article_47_text+="organismes compétents."

  echo "$stdin" | \
    sed -E 's/present/présent/g' | \
    sed -E 's/etabli/établi/g' | \
    sed -E 's/genera/généra/g' | \
    sed -E 's/matiere/matière/g' | \
    sed -E 's/developpement/développement/g' | \
    sed -E 's/defini/défini/g' | \
    sed -E 's/element/élément/g' | \
    sed -E "s/I'/l'/g" | \
    sed -E 's/imperati/impérati/g' | \
    sed -E 's/ecolo/écolo/g' | \
    sed -E 's/econo/écono/g' | \
    sed -E 's/immediat/immédiat/g' | \
    sed -E 's/visee/visée/g' | \
    sed -E 's/diversite/diversité/g' | \
    sed -E 's/desertification/désertification/g' | \
    sed -E 's/amelior/amélior/g' | \
    sed -E 's/integ/intég/g' | \
    sed -E 's/ pre/ pré/g' | \
    sed -E 's/regle/règle/g' | \
    sed -E 's/ Ie / le /g' | \
    sed -E 's/equilibre/équilibre/g' | \
    sed -E 's/precis/précis/g' | \
    sed -E 's/egal/égal/g' | \
    sed -E 's/elabor/élabor/g' | \
    sed -E 's/execut/exécut/g' | \
    sed -E 's/apres/après/g' | \
    sed -E 's/different/différent/g' | \
    sed -E 's/concernee/concernée/g' | \
    sed -E 's/arrete/arrête/g' | \
    sed -E 's/precaution/précaution/g' | \
    sed -E 's/necessaire/nécessaire/g' | \
    sed -E 's/evit/évit/g' | \
    sed -E 's/degrad/dégrad/g' | \
    sed -E 's/privee/privée/g' | \
    sed -E 's/charge/chargé/g' | \
    sed -E 's/repar/répar/g' | \
    sed -E 's/regi/régi/g' | \
    sed -E 's/result/résult/g' | \
    sed -E 's/utilite/utilité/g' | \
    sed -E 's/ ete / été /g' | \
    sed -E 's/reseau/réseau/g' | \
    sed -E 's/energie/énergie/g' | \
    sed -E 's/dechet/déchet/g' | \
    sed -E 's/adequat/adéquat/g' | \
    sed -E "s/\/'/l'/g" | \
    sed -E 's/collectivite/collectivité/g' | \
    sed -E 's/concernes/concernés/g' | \
    sed -E 's/defense/défense/g' | \
    sed -E 's/modalite/modalité/g' | \
    sed -E 's/ fa / la /g' | \
    sed -E 's/Etat/État/g' | \
    sed -E 's/concertee/concertée/g' | \
    sed -E 's/ it / il /g' | \
    sed -E 's/developpe/développe/g' | \
    sed -E 's/competence/compétence/g' | \
    sed -E 's/decret/décret/g' | \
    sed -E 's/determine/détermine/g' | \
    sed -E 's/coheren/cohéren/g' | \
    sed -E 's/defin/défin/g' | \
    sed -E 's/interessee/intéressée/g' | \
    sed -E 's/activite/activité/g' | \
    sed -E 's/Ministere/Ministère/g' | \
    sed -E 's/accordee/accordée/g' | \
    sed -E 's/etude/étude/g' | \
    sed -E 's/revis/révis/g' | \
    sed -E 's/autorite/autorité/g' | \
    sed -E 's/deci/déci/g' | \
    sed -E 's/special/spécial/g' | \
    sed -E 's/apprec/appréc/g' | \
    sed -E 's/consequence/conséquence/g' | \
    sed -E "s/\\\'/l'/g" | \
    sed -E 's/etre/être/g' | \
    sed -E 's/touchee/touchée/g' | \
    sed -E 's/foret/forêt/g' | \
    sed -E 's/paturage/pâturage/g' | \
    sed -E 's/erosion/érosion/g' | \
    sed -E 's/deboisement/déboisement/g' | \
    sed -E 's/aggraves/aggravés/g' | \
    sed -E 's/vulnerable/vulnérable/g' | \
    sed -E 's/Iiste/liste/g' | \
    sed -E 's/etat/état/g' | \
    sed -E 's/proposee/proposée/g' | \
    sed -E 's/evalu/évalu/g' | \
    sed -E 's/utilises/utilisés/g' | \
    sed -E 's/echeant/échéant/g' | \
    sed -E 's/sante/santé/g' | \
    sed -E 's/rencontree/rencontrée/g' | \
    sed -E 's/resume/résumé/g' | \
    sed -E 's/enquete/enquête/g' | \
    sed -E 's/maniere/manière/g' | \
    sed -E 's/etud/étud/g' | \
    sed -E 's/attenu/atténu/g' | \
    sed -E 's/notifiee/notifiée/g' | \
    sed -E 's/ecri/écri/g' | \
    sed -E 's/reduire/réduire/g' | \
    sed -E 's/degats/dégâts/g' | \
    sed -E 's/communiquee/communiquée/g' | \
    sed -E 's/motivee/motivée/g' | \
    sed -E 's/realis/réalis/g' | \
    sed -E 's/reserv/réserv/g' | \
    sed -E 's/liee/liée/g' | \
    sed -E 's/constituee/constituée/g' | \
    sed -E 's/prononcee/prononcée/g' | \
    sed -E 's/cooper/coopér/g' | \
    sed -E 's/lateral/latéral/g' | \
    sed -E 's/generee/générée/g' | \
    sed -E 's/interet/intérêt/g' | \
    sed -E 's/tresor/trésor/g' | \
    sed -E 's/Developpement/Développement/g' | \
    sed -E 's/Etude/Étude/g' | \
    sed -E 's/ a / à /g' | \
    sed -E 's/protegee/protégée/g' | \
    sed -E 's/ocean/océan/g' | \
    sed -E 's/geree/gérée/g' | \
    sed -E 's/genetique/génétique/g' | \
    sed -E 's/miniere/minière/g' | \
    sed -E 's/entrain/entraîn/g' | \
    sed -E 's/fixee/fixée/g' | \
    sed -E 's/recreation/récréation/g' | \
    sed -E 's/qualite/qualité/g' | \
    sed -E 's/interieur/intérieur/g' | \
    sed -E 's/espece/espèce/g' | \
    sed -E 's/vegeta/végéta/g' | \
    sed -E 's/competent/compétent/g' | \
    sed -E 's/etant/étant/g' | \
    sed -E 's/exploitee/exploitée/g' | \
    sed -E 's/emission/émission/g' | \
    sed -E 's/atmosphere/atmosphère/g' | \
    sed -E 's/fumee/fumée/g' | \
    sed -E 's/securite/sécurité/g' | \
    sed -E 's/caractere/caractère/g' | \
    sed -E 's/superieur/supérieur/g' | \
    sed -E 's/reduction/réduction/g' | \
    sed -E 's/vehicule/véhicule/g' | \
    sed -E 's/alinea/alinéa/g' | \
    sed -E 's/poussiere/poussière/g' | \
    sed -E 's/delai/délai/g' | \
    sed -E 's/control/contrôl/g' | \
    sed -E 's/classee/classée/g' | \
    sed -E 's/equip/équip/g' | \
    sed -E 's/destinee/destinée/g' | \
    sed -E 's/présents/présente/g' | \
    sed -E 's/possedes/possédés/g' | \
    sed -E 's/exploites/exploités/g' | \
    sed -E 's/deten/déten/g' | \
    sed -E 's/legislation/législation/g' | \
    sed -E 's/recept/récept/g' | \
    sed -E 's/ecoul/écoul/g' | \
    sed -E 's/depot/dépôt/g' | \
    sed -E 's/accroit/accroît/g' | \
    sed -E 's/caracterist/caractérist/g' | \
    sed -E 's/degre/degré/g' | \
    sed -E 's/critere/critère/g' | \
    sed -E 's/procedure/procédure/g' | \
    sed -E 's/specification/spécification/g' | \
    sed -E 's/bacterio/bactério/g' | \
    sed -E 's/repond/répond/g' | \
    sed -E 's/imposee/imposée/g' | \
    sed -E 's/deversement/déversement/g' | \
    sed -E 's/subordonnes/subordonnés/g' | \
    sed -E 's/epuration/épuration/g' | \
    sed -E 's/delivree/délivrée/g' | \
    sed -E 's/erection/érection/g' | \
    sed -E 's/nocivite/nocivité/g' | \
    sed -E 's/effectues/effectués/g' | \
    sed -E 's/peril/péril/g' | \
    sed -E 's/minera/minéra/g' | \
    sed -E 's/carriere/carrière/g' | \
    sed -E 's/concu/conçu/g' | \
    sed -E 's/exécutes/exécutés/g' | \
    sed -E 's/creer/créer/g' | \
    sed -E 's/phenomene/phénomène/g' | \
    sed -E 's/depos/dépos/g' | \
    sed -E 's/devers/dévers/g' | \
    sed -E 's/eparpill/éparpill/g' | \
    sed -E 's/residu/résidu/g' | \
    sed -E 's/facon/façon/g' | \
    sed -E 's/depredateur/déprédateur/g' | \
    sed -E 's/methode/méthode/g' | \
    sed -E 's/appropriee/appropriée/g' | \
    sed -E 's/evacu/évacu/g' | \
    sed -E 's/alter/altér/g' | \
    sed -E 's/debit/débit/g' | \
    sed -E 's/epidem/épidém/g' | \
    sed -E 's/particuliere/particulière/g' | \
    sed -E 's/elevage/élevage/g' | \
    sed -E 's/agrement/agrément/g' | \
    sed -E 's/geographique/géographique/g' | \
    sed -E 's/inconvenient/inconvénient/g' | \
    sed -E 's/préscri/prescri/g' | \
    sed -E 's/autorisee/autorisée/g' | \
    sed -E 's/préndre/prendre/g' | \
    sed -E 's/donnee/donnée/g' | \
    sed -E 's/demandes/demandés/g' | \
    sed -E 's/delivr/délivr/g' | \
    sed -E 's/interesses/intéressés/g' | \
    sed -E 's/aupres/auprès/g' | \
    sed -E 's/ministeriel/ministériel/g' | \
    sed -E 's/restee/restée/g' | \
    sed -E 's/responsabilite/responsabilité/g' | \
    sed -E 's/penal/pénal/g' | \
    sed -E 's/detritus/détritus/g' | \
    sed -E 's/denomination/dénomination/g' | \
    sed -E 's/menagere/ménagère/g' | \
    sed -E 's/debris/débris/g' | \
    sed -E 's/poses/posés/g' | \
    sed -E 's/recipient/récipient/g' | \
    sed -E 's/entree/entrée/g' | \
    sed -E 's/usee/usée/g' | \
    sed -E 's/meme/même/g' | \
    sed -E 's/dependance/dépendance/g' | \
    sed -E 's/rassembles/rassemblés/g' | \
    sed -E 's/termines/terminés/g' | \
    sed -E 's/appropries/appropriés/g' | \
    sed -E 's/abandonnes/abandonnés/g' | \
    sed -E 's/afferent/afférent/g' | \
    sed -E 's/elimination/élimination/g' | \
    sed -E 's/denommes/dénommés/g' | \
    sed -E 's/obsolete/obsolète/g' | \
    sed -E 's/traitee/traitée/g' | \
    sed -E 's/emanation/émanation/g' | \
    sed -E 's/epave/épave/g' | \
    sed -E 's/quantite/quantité/g' | \
    sed -E 's/assimilee/assimilée/g' | \
    sed -E 's/propriete/propriété/g' | \
    sed -E 's/installee/installée/g' | \
    sed -E 's/intensite/intensité/g' | \
    sed -E 's/depass/dépass/g' | \
    sed -E 's/fixes/fixés/g' | \
    sed -E 's/edifice/édifice/g' | \
    sed -E 's/prives/privés/g' | \
    sed -E 's/équipes/équipés/g' | \
    sed -E 's/systeme/système/g' | \
    sed -E 's/nauseabonde/nauséabonde/g' | \
    sed -E 's/atmospherique/atmosphérique/g' | \
    sed -E 's/autorises/autorisés/g' | \
    sed -E 's/emett/émett/g' | \
    sed -E 's/agglomeration/agglomération/g' | \
    sed -E 's/epaisse/épaisse/g' | \
    sed -E 's/buee/buée/g' | \
    sed -E 's/dela/delà/g' | \
    sed -E 's/esthetique/esthétique/g' | \
    sed -E 's/facade/façade/g' | \
    sed -E 's/dument/dûment/g' | \
    sed -E 's/realite/réalité/g' | \
    sed -E 's/proteges/protégés/g' | \
    sed -E 's/constatees/constatées/g' | \
    sed -E 's/habilites/habilités/g' | \
    sed -E 's/requete/requête/g' | \
    sed -E 's/batiment/bâtiment/g' | \
    sed -E 's/operer/opérer/g' | \
    sed -E 's/requerir/requérir/g' | \
    sed -E 's/arret /arrêt /g' | \
    sed -E 's/contrôlee/contrôlée/g' | \
    sed -E 's/vises/visés/g' | \
    sed -E 's/materi/matéri/g' | \
    sed -E 's/fabriques/fabriqués/g' | \
    sed -E 's/impossibilite/impossibilité/g' | \
    sed -E 's/proces-/procès-/g' | \
    sed -E 's/ministere/ministère/g' | \
    sed -E 's/cidessus/ci-dessus/g' | \
    sed -E 's/etai/étai/g' | \
    sed -E 's/amenagement/aménagement/g' | \
    sed -E 's/capacite/capacité/g' | \
    sed -E 's/portee/portée/g' | \
    sed -E 's/errones/erronés/g' | \
    sed -E 's/grossierement/grossièrement/g' | \
    sed -E 's/organises/organisés/g' | \
    sed -E 's/reclusion/réclusion/g' | \
    sed -E 's/perpetuelle/perpétuelle/g' | \
    sed -E 's/societe/société/g' | \
    sed -E 's/negligence/négligence/g' | \
    sed -E 's/peche/pêche/g' | \
    sed -E 's/eliminer/éliminer/g' | \
    sed -E 's/causes/causés/g' | \
    sed -E 's/illega/illéga/g' | \
    sed -E 's/imputes/imputés/g' | \
    # Article 1
    amend_error_in_article 1 écoloqiques écologiques | \
    amend_error_in_article 1 éconornique économique | \
    # Article 2
    amend_error_in_article 2 renvironnement "l'environnement" | \
    amend_error_in_article 2 naturets naturels | \
    amend_error_in_article 2 'eccnorniques\.' 'économiques,' | \
    amend_error_in_article 2 eftet effet | \
    amend_error_in_article 2 aterme 'à terme' | \
    amend_error_in_article 2 'naturel\/es' naturelles | \
    amend_error_in_article 2 'f~' le | \
    # Article 3
    amend_error_in_article 3 politiquenationale 'politique nationale' | \
    amend_error_in_article 3 Jutte lutte | \
    amend_error_in_article 3 '"amélioration' "l’amélioration" | \
    amend_error_in_article 3 'fa protection' 'la protection' | \
    amend_error_in_article 3 développernent développement | \
    amend_error_in_article 3 ' CHAPITRE \/I' '\n\nCHAPITRE II -' | \
    sed -E ':start;s/^(\(3\).*)([0-9])°\):/\1[\2]/;t start' | \
    # Article 4
    amend_error_in_article 4 dedéveloppement 'de développement' | \
    # Article 5
    amend_error_in_article 5 équilibre équilibré | \
    amend_error_in_article 5 ' lis' ' Ils' | \
    amend_error_in_article 5 "\('implication" "l'implication" | \
    amend_error_in_article 5 'po\)itiques' politiques | \
    # Article 6
    amend_error_in_article 6 proteqer protéger | \
    amend_error_in_article 6 irreverslbles irréversibles | \
    amend_error_in_article 6 aéviter 'à éviter' | \
    # Article 7
    amend_error_in_article 7 cause causé | \
    # Article 8
    amend_error_in_article 8 concerns concerné | \
    # Article 9
    amend_error_in_article 9 'le Ministère' 'Le Ministère' | \
    sed -E ':start;s/^(\(9\).*)([0-9]):/\1[\2]/;t start' | \
    amend_error_in_article 9 expioner exploiter | \
    amend_error_in_article 9 'd~gradation' dégradation | \
    amend_error_in_article 9 ainsique 'ainsi que' | \
    amend_error_in_article 9 ' ales ' ' à les ' | \
    amend_error_in_article 9 "al'adoption" "à l'adoption" | \
    amend_error_in_article 9 ' ala ' ' à la ' | \
    amend_error_in_article 9 '"amélioration' "l'amélioration" | \
    amend_error_in_article 9 pUblic public | \
    # Article 10
    amend_error_in_article 10 établissernents établissements | \
    amend_error_in_article 10 '·' '' | \
    amend_error_in_article 10 arexécution "à l'exécution" | \
    amend_error_in_article 10 edlctees édictées | \
    # Article 11
    amend_error_in_article 11 'I est institue' 'Il est institué' | \
    amend_error_in_article 11 denomme dénommé | \
    amend_error_in_article 11 Developpernent Développement | \
    amend_error_in_article 11 strateqle stratégie | \
    amend_error_in_article 11 'A ce titre' 'À ce titre' | \
    amend_error_in_article 11 gouvemêment gouvernement | \
    amend_error_in_article 11 développernent développement | \
    amend_error_in_article 11 Developpernent Développement | \
    # Article 12
    amend_error_in_article 12 'if la' 'à la' | \
    amend_error_in_article 12 "if l'ameiloration" "à l'amélioration" | \
    amend_error_in_article 12 définlt définit | \
    amend_error_in_article 12 ' if ' ' à ' | \
    amend_error_in_article 12 associe associé | \
    # Article 13
    amend_error_in_article 13 intégre intègre | \
    amend_error_in_article 13 "!'environnement" "l'environnement" | \
    amend_error_in_article 13 'de-Iutte' 'de lutte' | \
    amend_error_in_article 13 ceuvre oeuvre | \
    amend_error_in_article 13 Desertification Désertification | \
    # Article 14
    amend_error_in_article 14 environnernent environnement | \
    amend_error_in_article 14 "l'Autortsation" "L'Autorisation" | \
    amend_error_in_article 14 'E\.' 'E.).' | \
    # Article 15
    amend_error_in_article 15 Ministare Ministère | \
    amend_error_in_article 15 acttvites activités | \
    amend_error_in_article 15 nultite nullité | \
    amend_error_in_article 15 aueune aucune | \
    amend_error_in_article 15 autorlsation autorisation | \
    amend_error_in_article 15 "disposerd'une" "disposer d'une" | \
    amend_error_in_article 15 "J'environnement" "l'environnement" | \
    # Article 16
    amend_error_in_article 16 vise visé | \
    amend_error_in_article 16 'cl-dessus' 'ci-dessus' | \
    amend_error_in_article 16 ': l' ': [•] l' | \
    amend_error_in_article 16 actlvites activités | \
    amend_error_in_article 16 'environnement, les' 'environnement; [•] les' | \
    amend_error_in_article 16 '\\istes' listes | \
    amend_error_in_article 16 revétant revêtant | \
    amend_error_in_article 16 'partlcullere ' 'particulière ' | \
    amend_error_in_article 16 partlculierernent particulièrement | \
    amend_error_in_article 16 Pares Parcs | \
    amend_error_in_article 16 'touchées\. Les' 'touchées; [•] les' | \
    amend_error_in_article 16 ressourees ressources | \
    amend_error_in_article 16 'attectees, Les' 'affectées; [•] les' | \
    amend_error_in_article 16 'problernes écoloqiques partlcullerernent' 'problèmes écologiques particulièrement' | \
    amend_error_in_article 16 'sols\.' 'sols,' | \
    amend_error_in_article 16 'aggravés; Les' 'aggravés; [•] les' | \
    amend_error_in_article 16 impaet impact | \
    amend_error_in_article 16 reatisee réalisée | \
    # Article 17
    amend_error_in_article 17 'LIEI\.E' "L'E.I.E." | \
    amend_error_in_article 17 'minimum: une' 'minimum: [•] une' | \
    amend_error_in_article 17 'site; une' 'site; [•] une' | \
    amend_error_in_article 17 'proposée: une' 'proposée; [•] une' | \
    amend_error_in_article 17 'affects\.' 'affecté,' | \
    amend_error_in_article 17 specltiques spécifiques | \
    amend_error_in_article 17 proposes proposée | \
    amend_error_in_article 17 'environnement; une' 'environnement; [•] une' | \
    amend_error_in_article 17 'ecneant; une' 'échéant; [•] une' | \
    amend_error_in_article 17 altérnatives alternatives | \
    amend_error_in_article 17 'échéant; Une' 'échéant; [•] une' | \
    amend_error_in_article 17 '"environnement' "l'environnement" | \
    amend_error_in_article 17 'publique\.' 'publique; [•]' | \
    amend_error_in_article 17 'mesures;' 'mesures; [•]' | \
    amend_error_in_article 17 'nécessaire: un bret' 'nécessaire; [•] un bref' | \
    amend_error_in_article 17 toumie fournie | \
    amend_error_in_article 17 'précedentes,' 'précédentes.' | \
    amend_error_in_article 17 ' Article 18:' '\n\n(18)' | \
    # Article 18
    amend_error_in_article 18 "l'article14" "l'article 14" | \
    amend_error_in_article 18 précedes précédée | \
    amend_error_in_article 18 pubnque publique | \
    amend_error_in_article 18 gouvemêmentaux gouvernementaux | \
    amend_error_in_article 18 'et\.' et | \
    amend_error_in_article 18 apropos 'à propos' | \
    amend_error_in_article 18 "l'EI\.E\.\." "l'E.I.E." | \
    amend_error_in_article 18 'delà;' délai | \
    amend_error_in_article 18 observe observé | \
    amend_error_in_article 18 renquste "l’enquête" | \
    amend_error_in_article 18 aétudier 'à étudier' | \
    amend_error_in_article 18 présentees présentées | \
    # Article 19
    amend_error_in_article 19 'E\.\!\.E\.' 'E.I.E.' | \
    amend_error_in_article 19 motives motivée | \
    amend_error_in_article 19 'échéant\.' 'échéant,' | \
    amend_error_in_article 19 'prévenir\.:' 'prévenir,' | \
    amend_error_in_article 19 Gette Cette | \
    amend_error_in_article 19 interesses intéressés | \
    # Article 20
    amend_error_in_article 20 avolr avoir | \
    amend_error_in_article 20 aun 'à un' | \
    amend_error_in_article 20 'impact·' impact | \
    amend_error_in_article 20 recuser récuser | \
    amend_error_in_article 20 Cornite Comité | \
    amend_error_in_article 20 Developpement Développement | \
    amend_error_in_article 20 lmpact Impact | \
    amend_error_in_article 20 'reconnue Section 1\/1' 'reconnue.\n\nSection III -' | \
    # Article 21
    amend_error_in_article 21 estinstitue 'est institué' | \
    amend_error_in_article 21 'F\.I\.E' 'F.I.E.' | \
    amend_error_in_article 21 réserve réservé | \
    # Article 22
    sed -E ':start;s/^(\(22\).*)([0-9]) \[•\]/\1[\2]/;t start' | \
    amend_error_in_article 22 'État:' 'État;' | \
    amend_error_in_article 22 aftectees affectées | \
    amend_error_in_article 22 "f'environnement" "l'environnement" | \
    amend_error_in_article 22 'activités:' 'activités;' | \
    amend_error_in_article 22 'trésorerie:' 'trésorerie;' | \
    # Article 23
    amend_error_in_article 23 modatites modalités | \
    amend_error_in_article 23 amsi ainsi | \
    amend_error_in_article 23 determmees déterminées | \
    # Article 24
    sed -E ':start;s/^(\(24\).*[;:]) l/\1 [•] l/;t start' | \
    amend_error_in_article 24 conslderees considérées | \
    # Article 25
    amend_error_in_article 25 tacon façon | \
    amend_error_in_article 25 equlnbree équilibrée | \
    amend_error_in_article 25 "de'" de | \
    amend_error_in_article 25 necesslte nécessité | \
    amend_error_in_article 25 equiliores équilibres | \
    amend_error_in_article 25 écoloqiques écologiques | \
    amend_error_in_article 25 contormernent conformément | \
    # Article 26
    amend_error_in_article 26 fndustrielles industrielles | \
    # Article 27
    amend_error_in_article 27 aqrernent agrément | \
    amend_error_in_article 27 '"amélioration' "l'amélioration" | \
    amend_error_in_article 27 ralr "l’air" | \
    amend_error_in_article 27 locatites localités | \
    amend_error_in_article 27 batirnents bâtiments | \
    amend_error_in_article 27 amenaqes aménagés | \
    amend_error_in_article 27 contormêment conformément | \
    amend_error_in_article 27 arnenaqernents aménagements | \
    # Article 28
    amend_error_in_article 28 naturals naturels | \
    amend_error_in_article 28 'rentorcee\.,' 'renforcée.' | \
    amend_error_in_article 28 introCiuction introduction | \
    amend_error_in_article 28 veqetales végétales | \
    amend_error_in_article 28 'etJou transqenicues.' 'et\/ou transgéniques,' | \
    amend_error_in_article 28 juqees jugées | \
    amend_error_in_article 28 'au végétales' 'ou végétales' | \
    amend_error_in_article 28 contormernent conformément | \
    # Article 30
    amend_error_in_article 30 particuheres particulières | \
    amend_error_in_article 30 renvironnement "l'environnement" | \
    amend_error_in_article 30 préiudiciable préjudiciable | \
    amend_error_in_article 30 aqrernent agrément | \
    # Article 31
    sed -E ':start;s/^(\(31\).*[;:]) l/\1 [•] l/;t start' | \
    amend_error_in_article 31 atrnosphere atmosphère | \
    amend_error_in_article 31 ' ala ' ' à la ' | \
    amend_error_in_article 31 atrnosphere atmosphère | \
    amend_error_in_article 31 rentorcernent renforcement | \
    amend_error_in_article 31 eftet effet | \
    amend_error_in_article 31 assfmiles assimilés | \
    # Article 32
    amend_error_in_article 32 'au autres' 'ou autres' | \
    amend_error_in_article 32 exploltes exploités | \
    amend_error_in_article 32 rnaniere manière | \
    amend_error_in_article 32 '\.aux' aux | \
    # Article 33
    amend_error_in_article 33 ceuvre oeuvre | \
    amend_error_in_article 33 ' Articles 34:' '\n\n(34)' | \
    # Article 34
    sed -E ':start;s/^(\(34\).*)([0-9])°:/\1[\2]/;t start' | \
    amend_error_in_article 34 reqlernentes règlementés | \
    amend_error_in_article 34 '"émission' "l'émission" | \
    amend_error_in_article 34 'iI doit' 'il doit' | \
    amend_error_in_article 34 pubtlcation publication | \
    amend_error_in_article 34 'décret\.' 'décret;' | \
    amend_error_in_article 34 'règlementes et contrôles' 'règlementés et contrôlés' | \
    amend_error_in_article 34 '32<' 32 | \
    amend_error_in_article 34 'présente lol' 'présente loi' | \
    amend_error_in_article 34 cornpris compris | \
    amend_error_in_article 34 "f'intervention" "l'intervention" | \
    amend_error_in_article 34 afaire 'à faire' | \
    amend_error_in_article 34 ' CHAPITRE"' '\n\nCHAPITRE II -' | \
    # Article 35
    amend_error_in_article 35 regénération régénération | \
    amend_error_in_article 35 inteqree intégrée | \
    amend_error_in_article 35 contormêment conformément | \
    amend_error_in_article 35 déversernents déversements | \
    amend_error_in_article 35 pius plus | \
    amend_error_in_article 35 "qu'i1 s'agisse" "qu'il s'agisse" | \
    amend_error_in_article 35 'souterraines Article36:' 'souterraines.\n\n(36)' | \
    # Article 36
    amend_error_in_article 36 etanqs étangs | \
    amend_error_in_article 36 etabfis établis | \
    amend_error_in_article 36 bactertoloqlques bactériologiques | \
    amend_error_in_article 36 'elles\. \.' 'elles.' | \
    amend_error_in_article 36 'gemerale perlodique' 'générale périodique' | \
    amend_error_in_article 36 irnperatit impératif | \
    # Article 37
    amend_error_in_article 37 'définit, la' 'définit: la' | \
    amend_error_in_article 37 etabtissernent établissement | \
    amend_error_in_article 37 "visés al'article" "visés à l'article" | \
    amend_error_in_article 37 'ci-dessus,' 'ci-dessus;' | \
    amend_error_in_article 37 "d'eau; lacs ou etanqs" "d'eau, lacs ou étangs" | \
    amend_error_in_article 37 "\('alimentation" "l'alimentation" | \
    amend_error_in_article 37 lequella 'lequel la' | \
    amend_error_in_article 37 'dolt être arneliore' 'doit être amélioré' | \
    amend_error_in_article 37 "définit al'article" "définis à l'article" | \
    amend_error_in_article 37 'lei\.' 'loi.' | \
    sed -E ':start;s/^(\(37\).*[;:]) l/\1 [•] l/;t start' | \
    # Article 38
    amend_error_in_article 38 "proprlétaires d'lnstaltations" "propriétaires d'installations" | \
    amend_error_in_article 38 déversernent déversement | \
    amend_error_in_article 38 anterieurernent antérieurement | \
    amend_error_in_article 38 prornulqation promulgation | \
    amend_error_in_article 38 fixe fixé | \
    amend_error_in_article 38 vise visé | \
    amend_error_in_article 38 aleur 'à leur' | \
    # Article 39
    sed -E "s/^(\(39\))/\1 $article_39_text/" | \
    amend_error_in_article 39 conformernent conformément | \
    amend_error_in_article 39 'loi, Les' 'loi. Les' | \
    amend_error_in_article 39 préliwements prélèvements | \
    amend_error_in_article 39 aune 'à une' | \
    amend_error_in_article 39 préalabte préalable | \
    amend_error_in_article 39 'installations\.,' 'installations;' | \
    amend_error_in_article 39 dépuration "d'épuration" | \
    amend_error_in_article 39 'préalablernent approuve,' 'préalablement approuvé\.' | \
    sed -E ':start;s/^(\(39\).*[;:]) à/\1 [•] à/;t start' | \
    # Article 40
    amend_error_in_article 40 règlementes règlementés | \
    amend_error_in_article 40 déversernents déversements | \
    amend_error_in_article 40 'atterer la qualita' 'altérer la qualité' | \
    amend_error_in_article 40 n3glementees règlementées | \
    amend_error_in_article 40 déversernents déversements | \
    amend_error_in_article 40 regJementation règlementation | \
    amend_error_in_article 40 ' 1° ' ' premier ' | \
    amend_error_in_article 40 '\. L' '. l' | \
    amend_error_in_article 40 controtes contrôles | \
    amend_error_in_article 40 caracterlstiques caractéristiques | \
    amend_error_in_article 40 bactérioloqlques bactériologiques | \
    amend_error_in_article 40 'précede aux prélevernents' 'procédé aux prélèvements' | \
    amend_error_in_article 40 "d'echanfitions: \[40\]" "d'échantillons; 4°\." | \
    amend_error_in_article 40 'imrnediatement exécutolres' 'immédiatement exécutoires' | \
    amend_error_in_article 40 "qui'" qui | \
    amend_error_in_article 40 'salubrtte pubfique' 'salubrité publique' | \
    sed -E ':start;s/^(\(40\).*[;:] )([0-9])°\./\1[\2]/;t start' | \
    # Article 41
    amend_error_in_article 41 rernontee remontée | \
    amend_error_in_article 41 aqricole agricole | \
    # Article 42
    amend_error_in_article 42 'necessalrement respsctees:' 'nécessairement respectées.' | \
    amend_error_in_article 42 partitulier particulier | \
    amend_error_in_article 42 substance substances | \
    # Article 43
    amend_error_in_article 43 sylvlcoles sylvicoles | \
    amend_error_in_article 43 contormernent conformément | \
    amend_error_in_article 43 'pede-climatiques' 'pédo-climatiques' | \
    # Article 44
    amend_error_in_article 44 'rnaniere a' 'manière à' | \
    amend_error_in_article 44 exploftes exploités | \
    amend_error_in_article 44 rnodatltes modalités | \
    amend_error_in_article 44 exécutlon exécution | \
    # Article 45
    amend_error_in_article 45 'I est' 'Il est' | \
    amend_error_in_article 45 'acet ettet' 'à cet effet' | \
    # Article 46
    amend_error_in_article 46 chimiquesnocives 'chimiques nocives' | \
    # Article 47
    sed -E "s/^(\(47\) )(CHAPITRE IV)/\1$article_47_text\n\n\2 -/" | \
    # Article 48
    amend_error_in_article 48 regEmeration régénération | \
    amend_error_in_article 48 '\. \[2\] A' '; [2] a' | \
    amend_error_in_article 48 desnnees destinées | \
    amend_error_in_article 48 'agarantir la stablllte' 'à garantir la stabilité' | \
    amend_error_in_article 48 consecutlf consécutif | \
    amend_error_in_article 48 'exploitation Article 49:' 'exploitation.\n\n(49)' | \
    # Article 49
    amend_error_in_article 49 'so\/ides, Iiquides' 'solides, liquides' | \
    # Article 50
    amend_error_in_article 50 arnenaqernents aménagements | \
    amend_error_in_article 50 equllibres équilibres | \
    amend_error_in_article 50 'arnenaqements ettectues' 'aménagements effectués' | \
    amend_error_in_article 50 '\(e\(lit' 'le lit' | \
    amend_error_in_article 50 rnaniere manière | \
    amend_error_in_article 50 erniqration émigration | \
    # Article 51
    amend_error_in_article 51 catamite calamité | \
    amend_error_in_article 51 ceuvre oeuvre | \
    amend_error_in_article 51 décreta décrets | \
    amend_error_in_article 51 deterrninent déterminent | \
    # Article 52
    amend_error_in_article 52 "f'environnement" "l'environnement" | \
    # Article 53
    amend_error_in_article 53 arrête arrêté | \
    amend_error_in_article 53 cateqorie catégorie | \
    amend_error_in_article 53 précedes procédés | \
    # Article 54
    amend_error_in_article 54 'classes\. complete' 'classée, complète' | \
    amend_error_in_article 54 'échéant ,' 'échéant,' | \
    amend_error_in_article 54 acette 'à cette' | \
    # Article 55
    amend_error_in_article 55 "\('" "l'" | \
    # Article 56
    amend_error_in_article 56 cornpetents compétents | \
    # Article 57
    amend_error_in_article 57 arrête arrêté | \
    amend_error_in_article 57 classes classée | \
    amend_error_in_article 57 '·territoire' territoire | \
    amend_error_in_article 57 "J'installation" "l'installation" | \
    amend_error_in_article 57 'échéant\.' 'échéant,' | \
    sed -E ':start;s/^(\(57\).*)\. \[/\1; [/;t start' | \
    # Article 58
    amend_error_in_article 58 'cas ou un' 'cas où un' | \
    amend_error_in_article 58 'ractivtte de \(' "l’activité de l" | \
    amend_error_in_article 58 "jusqu'a" "jusqu'à" | \
    amend_error_in_article 58 necessalres nécessaires | \
    amend_error_in_article 58 'ta fermeture' 'la fermeture' | \
    amend_error_in_article 58 '\{' 'l' | \
    # Article 59
    amend_error_in_article 59 apparait apparaît | \
    amend_error_in_article 59 aqricole agricole | \
    amend_error_in_article 59 OU ou | \
    amend_error_in_article 59 activlte activité | \
    amend_error_in_article 59 'instaliation\.S' 'installation. S' | \
    amend_error_in_article 59 prénd prend | \
    # Article 60
    amend_error_in_article 60 llquide liquide | \
    amend_error_in_article 60 structuresesstmtles 'structures assimilés' | \
    amend_error_in_article 60 etabllssement établissement | \
    amend_error_in_article 60 urbalns urbains | \
    amend_error_in_article 60 places placés | \
    amend_error_in_article 60 excreta excréta | \
    amend_error_in_article 60 oecnets déchets | \
    amend_error_in_article 60 "non'" non | \
    amend_error_in_article 60 assimtles assimilés | \
    amend_error_in_article 60 etabflssernents établissements | \
    amend_error_in_article 60 detinis définis | \
    amend_error_in_article 60 établissernents établissements | \
    amend_error_in_article 60 prlves privés | \
    amend_error_in_article 60 'rnenaqeres\):' 'ménagères);' | \
    amend_error_in_article 60 listers lisiers | \
    amend_error_in_article 60 amrnaux animaux | \
    amend_error_in_article 60 fayon façon | \
    amend_error_in_article 60 abanconnees abandonnées | \
    amend_error_in_article 60 'pares, cirnetieres' 'parcs, cimetières' | \
    amend_error_in_article 60 resious résidus | \
    amend_error_in_article 60 eccles écoles | \
    amend_error_in_article 60 bfltiments bâtiments | \
    amend_error_in_article 60 lecas 'le cas' | \
    # Article 61
    amend_error_in_article 61 JI Il | \
    amend_error_in_article 61 détenlr détenir | \
    amend_error_in_article 61 dammages dommages | \
    # Article 62
    amend_error_in_article 62 detlent détient | \
    amend_error_in_article 62 ala 'à la' | \
    amend_error_in_article 62 '"homme at' "l'homme et" | \
    amend_error_in_article 62 envlronnement environnement | \
    amend_error_in_article 62 contormernent conformément | \
    # Article 63
    amend_error_in_article 63 arrête arrêté | \
    amend_error_in_article 63 'Environnernent etaborera' 'Environnement élaborera' | \
    amend_error_in_article 63 compétentos compétentes | \
    # Article 64
    amend_error_in_article 64 SOUS sous | \
    amend_error_in_article 64 i1 il | \
    amend_error_in_article 64 'industriel\/e' industrielle | \
    amend_error_in_article 64 "c'épuration" "d'épuration" | \
    amend_error_in_article 64 usaqees usagées | \
    amend_error_in_article 64 pathoqenes pathogènes | \
    amend_error_in_article 64 hopttaux hôpitaux | \
    amend_error_in_article 64 asslrniles assimilés | \
    amend_error_in_article 64 'hurnaines\.je' 'humaines, le' | \
    amend_error_in_article 64 encourage encouragé | \
    amend_error_in_article 64 'tes conditions' 'les conditions' | \
    amend_error_in_article 64 pnses prises | \
    amend_error_in_article 64 assimilées assimilés | \
    # Article 65
    amend_error_in_article 65 présume présumé | \
    amend_error_in_article 65 'des lors' 'dès lors' | \
    amend_error_in_article 65 reacnvite réactivité | \
    # Article 66
    amend_error_in_article 66 'chargés général, élabore' 'charges général, élaboré' | \
    amend_error_in_article 66 'lndustrie,' 'Industrie,' | \
    amend_error_in_article 66 Sante Santé | \
    amend_error_in_article 66 'chargés général' 'charges général' | \
    amend_error_in_article 66 eliminatlon élimination | \
    amend_error_in_article 66 lndustriets industriels | \
    amend_error_in_article 66 hyqiene hygiène | \
    # Article 67
    amend_error_in_article 67 decnet déchet | \
    amend_error_in_article 67 "r'etranger" "l'étranger" | \
    amend_error_in_article 67 présume présumé | \
    # Article 68
    amend_error_in_article 68 irnportation importation | \
    amend_error_in_article 68 etranqer étranger | \
    # Article 70
    amend_error_in_article 70 etabllssements établissements | \
    amend_error_in_article 70 enqins engins | \
    amend_error_in_article 70 "qU'i1s" "qu'ils" | \
    amend_error_in_article 70 lntensite intensité | \
    amend_error_in_article 70 quallte qualité | \
    amend_error_in_article 70 contormêment conformément | \
    # Article 71
    amend_error_in_article 71 contraIe contrôle | \
    amend_error_in_article 71 adrnissibles admissibles | \
    # Article 72
    amend_error_in_article 72 Lesodeurs 'Les odeurs' | \
    amend_error_in_article 72 supprirnees supprimées | \
    amend_error_in_article 72 'ta mesure' 'la mesure' | \
    # Article 73
    amend_error_in_article 73 contormêment conformément | \
    amend_error_in_article 73 caractenstiques caractéristiques | \
    amend_error_in_article 73 "tes conditions d'impfantation" "les conditions d'implantation" | \
    amend_error_in_article 73 dechargés décharges | \
    # Article 74
    amend_error_in_article 74 'dans\.tout' 'dans tout' | \
    amend_error_in_article 74 'tumees épaisses\.' 'fumées épaisses,' | \
    amend_error_in_article 74 tacon façon | \
    amend_error_in_article 74 comrnodlte commodité | \
    amend_error_in_article 74 vole voie | \
    # Article 75
    amend_error_in_article 75 rayonnernents rayonnements | \
    # Article 76
    amend_error_in_article 76 lei loi | \
    amend_error_in_article 76 envlronnementale environnementale | \
    amend_error_in_article 76 aavilir 'à avilir' | \
    amend_error_in_article 76 'que\/que' quelque | \
    amend_error_in_article 76 queletue quelque | \
    amend_error_in_article 76 scient soient | \
    amend_error_in_article 76 '"obstruction' "l'obstruction" | \
    amend_error_in_article 76 "!'occupation" "l'occupation" | \
    amend_error_in_article 76 voles voies | \
    # Article 77
    amend_error_in_article 77 habiletes habilités | \
    # Article 78
    amend_error_in_article 78 'iI est' 'il est' | \
    amend_error_in_article 78 atoute 'à toute' | \
    amend_error_in_article 78 regJes règles | \
    amend_error_in_article 78 éconorniques économiques | \
    amend_error_in_article 78 decoupaqes découpages | \
    amend_error_in_article 78 attectees affectées | \
    amend_error_in_article 78 'résidus: ' 'résidus\.\n\n' | \
    # Article 79
    amend_error_in_article 79 "J'Environnement" "l'Environnement" | \
    amend_error_in_article 79 '\(a' la | \
    amend_error_in_article 79 etrnonuments 'et monuments' | \
    # Article 80
    amend_error_in_article 80 "\('" "l'" | \
    amend_error_in_article 80 habllite habilités | \
    # Article 81
    amend_error_in_article 81 "rnentionnes a\('article" "mentionnés à l'article" | \
    amend_error_in_article 81 'spectate:' 'spéciale;' | \
    amend_error_in_article 81 préter prêter | \
    amend_error_in_article 81 ala 'à la' | \
    amend_error_in_article 81 vatidlte validité | \
    amend_error_in_article 81 'reg\/ementaire' règlementaire | \
    # Article 82
    amend_error_in_article 82 penêtrer pénétrer | \
    amend_error_in_article 82 amenaqements aménagements | \
    amend_error_in_article 82 prélevernents prélèvements | \
    amend_error_in_article 82 releves relevés | \
    amend_error_in_article 82 '\/a' la | \
    sed -E ':start;s/^(\(82\).*[:;])( [a-z])/\1 [•]\2/;t start' | \
    # Article 83
    amend_error_in_article 83 tacon façon | \
    amend_error_in_article 83 gene gène | \
    amend_error_in_article 83 ' lis ' ' Ils ' | \
    # Article 84
    amend_error_in_article 84 i1s ils | \
    amend_error_in_article 84 constate constaté | \
    amend_error_in_article 84 "al'article" "à l'article" | \
    amend_error_in_article 84 'orocss verbal' 'procès-verbal' | \
    amend_error_in_article 84 'lis procederont' 'Ils procéderont' | \
    amend_error_in_article 84 préuves preuves | \
    amend_error_in_article 84 irnportes importés | \
    amend_error_in_article 84 Ia la | \
    amend_error_in_article 84 matenelle matérielle | \
    amend_error_in_article 84 "\('" "l'" | \
    amend_error_in_article 84 'lis préndront' 'Ils prendront' | \
    amend_error_in_article 84 'de dommages' 'des dommages' | \
    amend_error_in_article 84 '"environnement' "l'environnement" | \
    # Article 85
    amend_error_in_article 85 salsis saisis | \
    # Article 86
    amend_error_in_article 86 '\.chargé' chargé | \
    amend_error_in_article 86 interEH intérêt | \
    # Article 87
    amend_error_in_article 87 "f'" "l'" | \
    amend_error_in_article 87 cotlectlvites collectivités | \
    # Article 88
    amend_error_in_article 88 préuve preuve | \
    amend_error_in_article 88 penaie pénale | \
    # Article 89
    amend_error_in_article 89 abandonne abandonné | \
    amend_error_in_article 89 et91 'et 61' | \
    amend_error_in_article 89 effectue effectué | \
    # Article 90
    amend_error_in_article 90 'neglige de rémettre' 'négligé de remettre' | \
    amend_error_in_article 90 i1s ils | \
    amend_error_in_article 90 détenaient détiennent | \
    amend_error_in_article 90 'des chargés' 'des charges' | \
    amend_error_in_article 90 ararncle "à l'article" | \
    amend_error_in_article 90 eftecfue effectué | \
    amend_error_in_article 90 'effectue ' 'effectué ' | \
    amend_error_in_article 90 autorisationen 'autorisation en' | \
    amend_error_in_article 90 '"article' "l'article" | \
    amend_error_in_article 90 eftectue effectué | \
    amend_error_in_article 90 creuse creusé | \
    amend_error_in_article 90 'reqlernentaire:' 'règlementaire;' | \
    amend_error_in_article 90 'implante au aqrandi' 'implanté ou agrandi' | \
    amend_error_in_article 90 modifie modifié | \
    amend_error_in_article 90 'au auront commence' 'ou auront commencé' | \
    amend_error_in_article 90 aces 'à ces' | \
    amend_error_in_article 90 "\)'" "l'" | \
    amend_error_in_article 90 'rneconnu les rt3glements' 'méconnu les règlements' | \
    amend_error_in_article 90 'titulaires. \[5\] I' 'titulaires; [5] i' | \
    amend_error_in_article 90 tente tenté | \
    amend_error_in_article 90 "al'article \[28\] 6\. E" "à l'article 28; \[6\] e" | \
    amend_error_in_article 90 'Loi\. \[7\] S' 'loi; [7] s' | \
    amend_error_in_article 90 "coupablesd'une" "coupables d'une" | \
    amend_error_in_article 90 '"esthétique' "l’esthétique" | \
    amend_error_in_article 90 "J'article76" "l'article 76" | \
    amend_error_in_article 90 'Lot\.' 'loi.' | \
    # Article 91
    amend_error_in_article 91 '\{ente' tenté | \
    amend_error_in_article 91 contr61es contrôles | \
    amend_error_in_article 91 '\. \[' '; [' | \
    amend_error_in_article 91 'detrutt ou tente de detrulre' 'détruit ou tenté de détruire' | \
    # Article 92
    amend_error_in_article 92 'auront: \.mporte: achete: vend~;' 'auront importé, acheté, vendu,' | \
    amend_error_in_article 92 'transports: entrepose ou; stocke\. D' 'transporté, entreposé ou stocké d' | \
    amend_error_in_article 92 'etranqer,' 'étranger.' | \
    amend_error_in_article 92 activtte activité | \
    amend_error_in_article 92 responsabiJite responsabilité | \
    amend_error_in_article 92 Toutetols Toutefois | \
    amend_error_in_article 92 neanrnoins néanmoins | \
    amend_error_in_article 92 gestibn gestion | \
    amend_error_in_article 92 contrôls contrôle | \
    amend_error_in_article 92 activne activité | \
    amend_error_in_article 92 a60 'à 60' | \
    # Article 93
    amend_error_in_article 93 visés visée | \
    amend_error_in_article 93 'prémier allnea de \(' 'premier alinéa de l' | \
    amend_error_in_article 93 'à entralne' 'a entraîné' | \
    # Article 94
    amend_error_in_article 94 'reprirnees conformêment' 'réprimées conformément' | \
    amend_error_in_article 94 toret forêt | \
    amend_error_in_article 94 '\(' l | \
    # Article 95
    amend_error_in_article 95 vtsees visées | \
    amend_error_in_article 95 entraîne entraîné | \
    amend_error_in_article 95 besoms besoins | \
    amend_error_in_article 95 "zoned'environnement" "zone d'environnement" | \
    amend_error_in_article 95 aun 'à un' | \
    amend_error_in_article 95 "a\('article prémier" "à l'article premier" | \
    # Article 96
    amend_error_in_article 96 "Lcrsqu'a ia" "Lorsqu'à la" | \
    amend_error_in_article 96 '89;' '89,' | \
    amend_error_in_article 96 engage engagé | \
    amend_error_in_article 96 'arnenaqernents et rémettre' 'aménagements et remettre' | \
    amend_error_in_article 96 dégrade dégradé | \
    amend_error_in_article 96 'iIIegaW\(' illégaux | \
    amend_error_in_article 96 '" en sera de merne' 'Il en sera de même' | \
    amend_error_in_article 96 'auteur au le' 'auteur ou le' | \
    amend_error_in_article 96 etagents 'et agents' | \
    amend_error_in_article 96 'a"article prémier' "à l'article premier" | \
    # Article 97
    amend_error_in_article 97 "en'vue" 'en vue' | \
    amend_error_in_article 97 préndront prendront | \
    amend_error_in_article 97 resuiter résulter | \
    # Article 98
    amend_error_in_article 98 "al'application" "à l'application" | \
    # Article 99
    amend_error_in_article 99 abroqees abrogées | \
    amend_error_in_article 99 anterieures antérieures | \
    amend_error_in_article 99 aIa 'à la' | \
    # Article 100
    amend_error_in_article 100 'exécutés comme loi de "État' "exécutée comme loi de l'État" | \
    amend_error_in_article 100 ' LE.*$' ''
}

function amend_errors_in_headers {
  sed -E 's/^(TITRE I -.*)GENERALES/\1GÉNÉRALES/' | \
    sed -E 's/^(CHAPITRE I - )DEFINITION/\1DÉFINITION/' | \
    sed -E 's/^(TITRE|CHAPITRE|SECTION)(.*)\./\1\2/' | \
    sed -E 's/^(TITRE II -.*)GEST\/ON(.*)POUT\/QUE NAT10NALE/\1GESTION\2POLITIQUE NATIONALE/' | \
    sed -E 's/^(CHAPITRE II -.*)DEGESTION/\1DE GESTION/' | \
    sed -E 's/^(Section II -.*)lmpact/\1Impact/' | \
    sed -E 's/^TITRE 1 -\\1:/TITRE III -/' | \
    sed -E 's/^(CHAPITRE I -.*)ATMOSPHERE/\1ATMOSPHÈRE/' | \
    sed -E 's/^(TITRE IV -.*)DEGRADATIONS D1VERSES/\1DÉGRADATIONS DIVERSES/' | \
    sed -E 's/^(CHAPITRE I -.*)CLASSEESPOUR/\1CLASSÉES POUR/' | \
    sed -E 's/DECHET/DÉCHET/' | \
    sed -E 's/CHAPITRE 1 -\//CHAPITRE II -/' | \
    sed -E 's/^(SECTION III -.*)ETRANGER/\1ÉTRANGER/' | \
    sed -E 's/^(CHAPITRE IV - )OOEURS, POUSSIERES ETLUMIERES/\1ODEURS, POUSSIÈRES ET LUMIÈRES/' | \
    sed -E "s/^(CHAPITRE V - )DEGRADATIONS DE L'ESTHETIQUE/\1DÉGRADATIONS DE L'ESTHÉTIQUE/" | \
    sed -E 's/^(CHAPITRE VI)( DE)/\1 -\2/' | \
    sed -E 's/^(TITRE V -.*)PENALES/\1PÉNALES/'
}

function preprocess_state_and_language_input_file {
  if [ "$#" -ne 2 ] ; then
    echo_usage_error "$*" '<input_file_path> <language>'
    return 1
  fi
  local input_file_path="$1"
  local language="$2"

  apply_common_transformations "$input_file_path" "$language" | \
    remove_all_text_before_first_header | \
    amend_errors_in_articles | \
    amend_errors_in_headers
}
