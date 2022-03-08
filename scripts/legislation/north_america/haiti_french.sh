#!/bin/bash

function remove_all_text_before_first_header {
  sed -n '/^TITRE I /,$p'
}

function amend_errors_in_headers {
  sed -E 's/GENERAL/GÉNÉRAL/g' | \
    sed -E 's/DEFINITION/DÉFINITION/g' | \
    sed -E 's/^(CHAPITRE I .*DÉFINITIONS )/\1\n\n/' | \
    sed -E 's/^(CHAPITRE II - DES PRINCIPES DE BASE) /\1\n\n(3) /' | \
    sed -E 's/^(CHAPITRE UNIQUE) - (Le Systeme)/\1\n\n(14) \2/' | \
    sed -E 's/GÉNÉRALITE/GÉNÉRALITÉ/g' | \
    sed -E 's/AMENAGEMENT/AMÉNAGEMENT/g' | \
    sed -E 's/^(Section )1( -)\.-/\1I\2/' | \
    sed -E "s/^\(35\) Sectlon II> (De l'Habitat) Article/Section II - \1/" | \
    sed -E 's/PROTEGEE/PROTÉGÉE/g' | \
    sed -E 's/^(CHAPITRE III - .*PROTÉGÉES) /\1\n\n(48)/' | \
    sed -E 's/EVALUATION/ÉVALUATION/g' | \
    sed -E 's/^(CHAPITRE IV - .*ENVIRONNEMENTALE) /\1\n\n(56)/' | \
    sed -E 's/^(CHAPITRE V - .*ENVIRONNEMENTALE) /\1\n\n(62)/' | \
    sed -E 's/^(CHAPITRE VI - .*ENVIRONNEMENTALE) /\1\n\n(68)/' | \
    sed -E 's/EDUCATION/ÉDUCATION/g' | \
    sed -E 's/^(CHAPITRE VII)( - DES)(FONDS)(ENVIRONNEMENTAUX) /\1I\2 \3 \4\n\n(77)/' | \
    sed -E 's/ECONOMIQUE/ÉCONOMIQUE/g' | \
    sed -E 's/MARCHE/MARCHÉ/g' | \
    sed -E 's/^(CHAPITRE )I(X - .*TECHNIQUE) /\1\2\n\n(87)/' | \
    sed -E 's/^(CHAPITRE I - NORMES.*) Article/\1/' | \
    sed -E 's/ECOSYSTEME/ÉCOSYSTÈME/g' | \
    sed -E 's/^(Section I .*)\. Article/\1/' | \
    sed -E 's/^(Section )11(-)\.-(.*)spectat(.*)fa(.*)ses(.*)tes(.*) Ar/\1II\2\3spécial\4la\5sés\6tés\7\n\n/' | \
    sed -E 's/^(Section )1 -\/1\.-(.*)spec(.*)La(.*)foret(.*) Ar/\1III - \2spéc\3la\4forêt\5\n\n/' | \
    sed -E 's/MINERAL/MINÉRAL/g' | \
    sed -E 's/DIVERSITE/DIVERSITÉ/g' | \
    sed -E 's/RESIDU/RÉSIDU/g' | \
    sed -E 's/^(CHAPITRE IX - .*ET)DECHETS/\1 DÉCHETS/' | \
    sed -E 's/^(CHAPITRE X - .*)LIES(.*)PHENOMENES/\1LIÉS\2PHÉNOMÈNES/' | \
    sed -E 's/COMPETENCE/COMPÉTENCE/g' | \
    sed -E 's/RESPONSABILITE/RESPONSABILITÉ/g' | \
    sed -E 's/PENAL/PÉNAL/g'
}

function amend_errors_in_articles {
  local stdin="$(</dev/stdin)"

  local missing_article_2_text="[a] de provoquer une situation préjudiciable "
  missing_article_2_text+="à la santé, à la sécurité, au bien-être de l'humain, "
  missing_article_2_text+="de la flore et de la faune, ou à"

  local missing_article_31_text="des schémas directeurs d'aménagement et de "
  missing_article_31_text+="gestion de"

  local missing_article_49_text="[b] de protéger l'intégrité de certains "
  missing_article_49_text+="systèmes écologiques, des paysages, et\/ou de "
  missing_article_49_text+="valeurs culturelles liées à la biodiversité, "
  missing_article_49_text+="menacés de disparition; [c] de protéger des unités "
  missing_article_49_text+="hydrographiques, zones aquifères et réduire la "
  missing_article_49_text+="vulnérabilité aux risques d'inondation; [d] de "
  missing_article_49_text+="contribuer à"

  echo "$stdin" | \
    sed -E 's/present/présent/g' | \
    sed -E 's/Decret/Décret/g' | \
    sed -E 's/defini/défini/g' | \
    sed -E 's/matiere/matière/g' | \
    sed -E "s/I'/l'/g" | \
    sed -E 's/regul/régul/g' | \
    sed -E 's/develop/dévelop/g' | \
    sed -E 's/prev/prév/g' | \
    sed -E 's/"LE MONITEUR" No\. .{2} (-|\[•\]) Jeudi 26 Janvier 2006 //' | \
    sed -E 's/irnmediat/immédiat/g' | \
    sed -E 's/qualite/qualité/g' | \
    sed -E 's/etroit/étroit/g' | \
    sed -E 's/control/contrôl/g' | \
    sed -E 's/degrad/dégrad/g' | \
    sed -E 's/negati/négati/g' | \
    sed -E 's/ sante/ santé/g' | \
    sed -E 's/forestiere/forestière/g' | \
    sed -E 's/declive/déclive/g' | \
    sed -E 's/Ie/le/g' | \
    sed -E 's/systeme/système/g' | \
    sed -E 's/protegee/protégée/g' | \
    sed -E 's/diversite/diversité/g' | \
    sed -E 's/amenag/aménag/g' | \
    sed -E 's/amelior/amélior/g' | \
    sed -E 's/ eco/ éco/g' | \
    sed -E 's/education/éducation/g' | \
    sed -E 's/rehabilit/réhabilit/g' | \
    sed -E 's/\]-/]/g' | \
    sed -E 's/Etat/État/g' | \
    sed -E 's/collectivite/collectivité/g' | \
    sed -E 's/organises/organisés/g' | \
    sed -E 's/societe/société/g' | \
    sed -E 's/ dus/ dûs/g' | \
    sed -E 's/desastre/désastre/g' | \
    sed -E 's/patrirnoine/patrimoine/g' | \
    sed -E 's/preserv/préserv/g' | \
    sed -E 's/espece/espèce/g' | \
    sed -E 's/veget/végét/g' | \
    sed -E 's/associes/associés/g' | \
    sed -E 's/elimination/élimination/g' | \
    sed -E 's/dechet/déchet/g' | \
    sed -E 's/Atmosphere/Atmosphère/g' | \
    sed -E 's/atmospherique/atmosphérique/g' | \
    sed -E 's/etre/être/g' | \
    sed -E 's/general/général/g' | \
    sed -E 's/delimitee/délimitée/g' | \
    sed -E 's/consacree/consacrée/g' | \
    sed -E 's/ ala / à la /g' | \
    sed -E 's/specifiques/spécifiques/g' | \
    sed -E 's/reglernentation/règlementation/g' | \
    sed -E 's/Amenag/Aménag/g' | \
    sed -E 's/evalu/évalu/g' | \
    sed -E 's/basee/basée/g' | \
    sed -E 's/repart/répart/g' | \
    sed -E 's/activite/activité/g' | \
    sed -E 's/maniere/manière/g' | \
    sed -E 's/capacite/capacité/g' | \
    sed -E 's/No\. .{2} (-|\[•\]) Jeudi 26 Janvier 2006 "LE MONITEUR" //' | \
    sed -E 's/norrne/norme/g' | \
    sed -E 's/variabilite/variabilité/g' | \
    sed -E 's/cornpr/compr/g' | \
    sed -E 's/écosysterne/écosystème/g' | \
    sed -E 's/Capacite/Capacité/g' | \
    sed -E 's/regener/régénér/g' | \
    sed -E 's/delai/délai/g' | \
    sed -E 's/redui/rédui/g' | \
    sed -E 's/foret/forêt/g' | \
    sed -E 's/decharg/décharg/g' | \
    sed -E 's/peril/péril/g' | \
    sed -E 's/etabl/établ/g' | \
    sed -E 's/legal/légal/g' | \
    sed -E 's/Desert/Désert/g' | \
    sed -E 's/seche/sèche/g' | \
    sed -E 's/situes/situés/g' | \
    sed -E 's/meme/même/g' | \
    sed -E 's/regroupes/regroupés/g' | \
    sed -E 's/cout/coût/g' | \
    sed -E 's/unite/unité/g' | \
    sed -E 's/geree/gérée/g' | \
    sed -E 's/alter/altér/g' | \
    sed -E 's/au dela/au-delà/g' | \
    sed -E 's/strateg/stratég/g' | \
    sed -E 's/Develop/Dévelop/g' | \
    sed -E 's/continuite/continuité/g' | \
    sed -E 's/gener/génér/g' | \
    sed -E 's/etang/étang/g' | \
    sed -E "s/qu'a/qu'à/g" | \
    sed -E 's/decen/décen/g' | \
    sed -E 's/cornmunaute/communauté/g' | \
    sed -E 's/organisrne/organisme/g' | \
    sed -E 's/element/élément/g' | \
    sed -E 's/éconornique/économique/g' | \
    sed -E 's/Etude/Étude/g' | \
    sed -E 's/realis/réalis/g' | \
    sed -E 's/réalisee/réalisée/g' | \
    sed -E 's/regle/règle/g' | \
    sed -E 's/procedure/procédure/g' | \
    sed -E 's/destinee/destinée/g' | \
    sed -E 's/etude/étude/g' | \
    sed -E 's/présentee/présentée/g' | \
    sed -E 's/autorite/autorité/g' | \
    sed -E 's/competen/compéten/g' | \
    sed -E 's/Evaluation/Évaluation/g' | \
    sed -E 's/apprec/appréc/g' | \
    sed -E 's/consequen/conséquen/g' | \
    sed -E 's/Foret/Forêt/g' | \
    sed -E 's/arboree/arborée/g' | \
    sed -E 's/predornin/prédomin/g' | \
    sed -E 's/redui/rédui/g' | \
    sed -E 's/nefast/néfast/g' | \
    sed -E 's/arnelior/amélior/g' | \
    sed -E 's/regi/régi/g' | \
    sed -E 's/régistre/registre/g' | \
    sed -E 's/desig/désig/g' | \
    sed -E 's/désignee/désignée/g' | \
    sed -E 's/marecage/marécage/g' | \
    sed -E 's/tourbiere/tourbière/g' | \
    sed -E 's/rnaniere/manière/g' | \
    sed -E 's/perrnanent/permanent/g' | \
    sed -E 's/episod/épisod/g' | \
    sed -E 's/ternporaire/temporaire/g' | \
    sed -E 's/salee/salée/g' | \
    sed -E 's/cotiere/côtière/g' | \
    sed -E 's/mêtre/mètre/g' | \
    sed -E 's/maree/marée/g' | \
    sed -E 's/Ministere/Ministère/g' | \
    sed -E 's/accordee/accordée/g' | \
    sed -E 's/deliv/déliv/g' | \
    sed -E 's/cooper/coopér/g' | \
    sed -E 's/decharg/décharg/g' | \
    sed -E 's/déchargernent/déchargement/g' | \
    sed -E "s/ al'/ à l'/g" | \
    sed -E 's/onereu/onéreu/g' | \
    sed -E 's/prive/privé/g' | \
    sed -E 's/acces/accès/g' | \
    sed -E 's/reserv/réserv/g' | \
    sed -E 's/saumatre/saumâtre/g' | \
    sed -E "s/ al'/ à l'/g" | \
    sed -E 's/perrnis/permis/g' | \
    sed -E 's/etat/état/g' | \
    sed -E 's/securite/sécurité/g' | \
    sed -E 's/ Ia / la /g' | \
    sed -E 's/defavor/défavor/g' | \
    sed -E 's/défavorablernent/défavorablement/g' | \
    sed -E 's/epuis/épuis/g' | \
    sed -E 's/caracteristique/caractéristique/g' | \
    sed -E 's/envirorinement/environnement/g' | \
    sed -E 's/ratifies/ratifiés/g' | \
    sed -E 's/développernent/développement/g' | \
    sed -E 's/limitee/limitée/g' | \
    sed -E 's/utilisee/utilisée/g' | \
    sed -E 's/productivite/productivité/g' | \
    sed -E 's/integ/intég/g' | \
    sed -E 's/intégrite/intégrité/g' | \
    sed -E 's/depend/dépend/g' | \
    sed -E "s/l' /l'/g" | \
    sed -E 's/refleter/refléter/g' | \
    sed -E 's/proteger/protéger/g' | \
    sed -E 's/responsabilite/responsabilité/g' | \
    sed -E 's/partagee/partagée/g' | \
    sed -E 's/vis-a-vis/vis-à-vis/g' | \
    sed -E 's/merne/même/g' | \
    sed -E 's/differen/différen/g' | \
    sed -E 's/différenciee/différenciée/g' | \
    sed -E 's/separ/sépar/g' | \
    sed -E 's/maitrise/maîtrise/g' | \
    sed -E 's/entite/entité/g' | \
    sed -E 's/ministeriel/ministériel/g' | \
    sed -E 's/ charge/ chargé/g' | \
    sed -E 's/depass/dépass/g' | \
    sed -E 's/depart/départ/g' | \
    sed -E 's/geographique/géographique/g' | \
    sed -E 's/impliques/impliqués/g' | \
    sed -E 's/evit/évit/g' | \
    sed -E "s/d' /d'/g" | \
    sed -E 's/managerial/managérial/g' | \
    sed -E 's/ceuvre/oeuvre/g' | \
    sed -E 's/ ii / à /g' | \
    sed -E 's/agreable/agréable/g' | \
    sed -E 's/propriete/propriété/g' | \
    sed -E 's/liberte/liberté/g' | \
    sed -E 's/privilege/privilège/g' | \
    sed -E 's/conditionnee/conditionnée/g' | \
    sed -E 's/prej/préj/g' | \
    sed -E 's/depens/dépens/g' | \
    sed -E 's/causee/causée/g' | \
    sed -E 's/execut/exécut/g' | \
    sed -E 's/Conforrnernent/Conformément/g' | \
    sed -E 's/proportionnee/proportionnée/g' | \
    sed -E 's/Systeme/Système/g' | \
    sed -E 's/reseau/réseau/g' | \
    sed -E 's/necess/nécess/g' | \
    sed -E 's/Entite/Entité/g' | \
    sed -E "s/1'/l'/g" | \
    sed -E 's/Arnenag/Aménag/g' | \
    sed -E 's/Environnernent/Environnement/g' | \
    sed -E 's/Unite/Unité/g' | \
    sed -E 's/Collectivite/Collectivité/g' | \
    sed -E 's/Eco/Éco/g' | \
    sed -E 's/Aménagernent/Aménagement/g' | \
    sed -E 's/Secretaire/Secrétaire/g' | \
    sed -E 's/Executi/Exécuti/g' | \
    sed -E 's/cornpe/compé/g' | \
    sed -E 's/critere/critère/g' | \
    sed -E 's/gerer/gérer/g' | \
    sed -E 's/resou/résou/g' | \
    sed -E 's/aménagernent/aménagement/g' | \
    sed -E 's/Scherna/Schéma/g' | \
    sed -E 's/Region/Région/g' | \
    sed -E 's/decoul/découl/g' | \
    sed -E 's/equit/équit/g' | \
    sed -E 's/concernes/concernés/g' | \
    sed -E 's/presid/présid/g' | \
    sed -E 's/ministere/ministère/g' | \
    sed -E 's/interet/intérêt/g' | \
    sed -E 's/elabor/élabor/g' | \
    sed -E 's/Etabli/Établi/g' | \
    sed -E 's/scherna/schéma/g' | \
    sed -E 's/clabor/élabor/g' | \
    sed -E 's/identifies/identifiés/g' | \
    sed -E 's/générate/générale/g' | \
    sed -E 's/revis/révis/g' | \
    sed -E 's/Ministerc/Ministère/g' | \
    sed -E 's/conforrnite/conformité/g' | \
    sed -E 's/environnernent/environnement/g' | \
    sed -E 's/period/périod/g' | \
    sed -E 's/places/placés/g' | \
    sed -E 's/deterrninee/déterminée/g' | \
    sed -E 's/conforrnement/conformément/g' | \
    sed -E 's/creation/création/g' | \
    sed -E 's/adaptee/adaptée/g' | \
    sed -E 's/realite/réalité/g' | \
    sed -E 's/marches/marchés/g' | \
    sed -E 's/creer/créer/g' | \
    sed -E 's/deja/déjà/g' | \
    sed -E 's/efficacite/efficacité/g' | \
    sed -E 's/Systerne/Système/g' | \
    sed -E 's/cree /créé /g' | \
    sed -E 's/requete/requête/g' | \
    sed -E "s/!'/l'/g" | \
    sed -E 's/proposee/proposée/g' | \
    sed -E 's/deleg/délég/g' | \
    sed -E 's/Ministeriel/Ministériel/g' | \
    sed -E 's/présidee/présidée/g' | \
    sed -E 's/General/Général/g' | \
    sed -E 's/defaut/défaut/g' | \
    sed -E 's/theme/thème/g' | \
    sed -E 's/liee/liée/g' | \
    sed -E 's/envircnnement/environnement/g' | \
    sed -E 's/deci/déci/g' | \
    sed -E 's/coheren/cohéren/g' | \
    sed -E 's/appropriee/appropriée/g' | \
    sed -E 's/priorite/priorité/g' | \
    sed -E 's/ cles / clés /g' | \
    sed -E 's/Superieur/Supérieur/g' | \
    sed -E 's/special/spécial/g' | \
    sed -E 's/spécialises/spécialisés/g' | \
    sed -E 's/Haiti/Haïti/g' | \
    sed -E 's/Depart/Départ/g' | \
    sed -E 's/irnposee/imposée/g' | \
    sed -E 's/départernent/département/g' | \
    sed -E 's/comrnun/commun/g' | \
    sed -E 's/ a la / à la /g' | \
    sed -E 's/hygiene/hygiène/g' | \
    sed -E 's/salubrite/salubrité/g' | \
    sed -E 's/archeologique/archéologique/g' | \
    sed -E 's/decouv/découv/g' | \
    sed -E 's/echange/échange/g' | \
    sed -E 's/départemcnt/département/g' | \
    sed -E "s/a l'/à l'/g" | \
    sed -E 's/cimetiere/cimetière/g' | \
    sed -E 's/appropriee/appropriée/g' | \
    sed -E 's/consideree/considérée/g' | \
    sed -E 's/règlement/règlement/g' | \
    sed -E 's/ lies/ liés/g' | \
    sed -E 's/appropries/appropriés/g' | \
    sed -E 's/réguliere/régulière/g' | \
    sed -E 's/donnee/donnée/g' | \
    sed -E 's/généree/générée/g' | \
    sed -E 's/traitee/traitée/g' | \
    sed -E 's/reéval/rééval/g' | \
    sed -E 's/apres/après/g' | \
    sed -E 's/specifique/spécifique/g' | \
    sed -E 's/spécifiquernent/spécifiquement/g' | \
    sed -E 's/concernee/concernée/g' | \
    sed -E 's/dotee/dotée/g' | \
    sed -E 's/personnalite/personnalité/g' | \
    sed -E 's/preempt/préempt/g' | \
    sed -E 's/ bati/ bâti/g' | \
    sed -E 's/règlernent/règlement/g' | \
    sed -E 's/decern/décern/g' | \
    sed -E 's/benefici/bénéfici/g' | \
    sed -E 's/Arrete/Arrêté/g' | \
    sed -E 's/schema/schéma/g' | \
    sed -E 's/penal/pénal/g' | \
    sed -E 's/declares/déclarés/g' | \
    sed -E 's/Utilite/Utilité/g' | \
    sed -E 's/mecanisme/mécanisme/g' | \
    sed -E 's/energie/énergie/g' | \
    sed -E 's/intégree/intégrée/g' | \
    sed -E 's/phenomene/phénomène/g' | \
    sed -E 's/meteo/météo/g' | \
    sed -E 's/minera/minéra/g' | \
    sed -E 's/adoptee/adoptée/g' | \
    sed -E 's/consideration/considération/g' | \
    sed -E 's/eccnomique/économique/g' | \
    sed -E 's/validee/validée/g' | \
    sed -E 's/assemblee/assemblée/g' | \
    sed -E 's/juridiquernent/juridiquement/g' | \
    sed -E 's/concu/conçu/g' | \
    sed -E 's/ameneg/aménag/g' | \
    sed -E 's/echelle/échelle/g' | \
    sed -E 's/etudiee/étudiée/g' | \
    sed -E 's/equilibre/équilibre/g' | \
    sed -E 's/deséquilibre/déséquilibre/g' | \
    sed -E 's/miniere/minière/g' | \
    sed -E 's/specificite/spécificité/g' | \
    sed -E 's/potentialite/potentialité/g' | \
    sed -E 's/paysagere/paysagère/g' | \
    sed -E 's/Assemblee/Assemblée/g' | \
    sed -E 's/Interieur/Intérieur/g' | \
    sed -E 's/particularite/particularité/g' | \
    sed -E 's/environncment/environnement/g' | \
    sed -E 's/precisee/précisée/g' | \
    sed -E 's/demarch/démarch/g' | \
    sed -E 's/eeuvre/oeuvre/g' | \
    sed -E 's/scheme/schéma/g' | \
    sed -E 's/municipalite/municipalité/g' | \
    sed -E 's/modalite/modalité/g' | \
    sed -E 's/declar/déclar/g' | \
    sed -E 's/déclaree/déclarée/g' | \
    sed -E 's/cavite/cavité/g' | \
    sed -E 's/ geo/ géo/g' | \
    sed -E 's/ paleo/ paléo/g' | \
    sed -E 's/ arcneo/ archéo/g' | \
    sed -E 's/materia/matéria/g' | \
    sed -E 's/etrange/étrange/g' | \
    sed -E 's/declass/déclass/g' | \
    sed -E 's/Protegee/Protégée/g' | \
    sed -E 's/creee/créée/g' | \
    sed -E 's/réservee/réservée/g' | \
    sed -E 's/classes/classés/g' | \
    sed -E 's/educaticn/éducation/g' | \
    sed -E 's/beaute/beauté/g' | \
    sed -E 's/fragilite/fragilité/g' | \
    sed -E 's/nécessite/nécessité/g' | \
    sed -E 's/genetique/génétique/g' | \
    sed -E 's/classee/classée/g' | \
    sed -E 's/categor/catégor/g' | \
    sed -E 's/compétentc/compétente/g' | \
    sed -E 's/arret/arrêt/g' | \
    sed -E 's/arrêtee/arrêtée/g' | \
    sed -E 's/prepar/prépar/g' | \
    sed -E 's/arnenag/aménag/g' | \
    sed -E 's/etudi/étudi/g' | \
    sed -E 's/anirnal/animal/g' | \
    sed -E 's/interess/intéress/g' | \
    sed -E 's/intéressee/intéressée/g' | \
    sed -E 's/délivree/délivrée/g' | \
    sed -E 's/requierent/requièrent/g' | \
    sed -E 's/celere/célère/g' | \
    sed -E 's/enclenches/enclenchés/g' | \
    sed -E 's/ emis/ émis/g' | \
    sed -E 's/numero/numéro/g' | \
    sed -E 's/systerne/système/g' | \
    sed -E 's/traites/traités/g' | \
    sed -E 's/ ete / été /g' | \
    sed -E 's/respectee/respectée/g' | \
    sed -E 's/refusee/refusée/g' | \
    sed -E 's/sanctionnee/sanctionnée/g' | \
    sed -E 's/ releve/ relève/g' | \
    sed -E 's/metrique/métrique/g' | \
    sed -E 's/erosion/érosion/g' | \
    sed -E 's/carriere/carrière/g' | \
    sed -E 's/règlerncnt/règlement/g' | \
    sed -E 's/établissemcnt/établissement/g' | \
    sed -E 's/residu/résidu/g' | \
    sed -E 's/interieur/intérieur/g' | \
    sed -E 's/vehicule/véhicule/g' | \
    sed -E 's/cnquete/enquête/g' | \
    sed -E 's/proces-/procès-/g' | \
    sed -E 's/consignes/consignés/g' | \
    sed -E 's/assermentes/assermentés/g' | \
    sed -E 's/aerien/aérien/g' | \
    sed -E 's/cote/côte/g' | \
    sed -E 's/ aero/ aéro/g' | \
    sed -E 's/registres/registrés/g' | \
    sed -E 's/communiquee/communiquée/g' | \
    sed -E 's/périodiquernent/périodiquement/g' | \
    sed -E 's/décentralisee/décentralisée/g' | \
    sed -E 's/inforrn/inform/g' | \
    sed -E 's/operation/opération/g' | \
    sed -E 's/fixee/fixée/g' | \
    sed -E 's/accèssible/accessible/g' | \
    sed -E 's/passee/passée/g' | \
    sed -E 's/périodicite/périodicité/g' | \
    sed -E 's/générent/génèrent/g' | \
    sed -E 's/gerent/gèrent/g' | \
    sed -E 's/rnettre/mettre/g' | \
    sed -E 's/caractere/caractère/g' | \
    sed -E 's/defen/défen/g' | \
    sed -E 's/geres/gérés/g' | \
    sed -E 's/coordonnes/coordonnés/g' | \
    sed -E 's/entiere/entière/g' | \
    sed -E 's/ethique/éthique/g' | \
    sed -E 's/media/média/g' | \
    sed -E 's/dixieme/dixième/g' | \
    sed -E 's/écoûte/écoute/g' | \
    sed -E 's/affectee/affectée/g' | \
    sed -E 's/crees/créés/g' | \
    sed -E 's/attaches/attachés/g' | \
    sed -E 's/annee/année/g' | \
    sed -E 's/encouragee/encouragée/g' | \
    sed -E 's/fiscalite/fiscalité/g' | \
    sed -E 's/utilite/utilité/g' | \
    sed -E 's/legaux/légaux/g' | \
    sed -E 's/emission/émission/g' | \
    sed -E 's/reduction/réduction/g' | \
    sed -E 's/assumes/assumés/g' | \
    sed -E 's/financiere/financière/g' | \
    sed -E 's/développcment/développement/g' | \
    sed -E 's/décernes/décernés/g' | \
    sed -E 's/journee/journée/g' | \
    sed -E 's/desert/désert/g' | \
    sed -E 's/vulnerabilite/vulnérabilité/g' | \
    sed -E 's/recompens/récompens/g' | \
    sed -E 's/pauvrete/pauvreté/g' | \
    sed -E 's/associee/associée/g' | \
    sed -E 's/universite/université/g' | \
    sed -E 's/edicte/édicte/g' | \
    sed -E 's/autorises/autorisés/g' | \
    sed -E 's/perimètre/périmètre/g' | \
    sed -E 's/depot/dépôt/g' | \
    sed -E 's/devers/dévers/g' | \
    sed -E 's/menacee/menacée/g' | \
    sed -E 's/exposes/exposés/g' | \
    sed -E 's/prealable/préalable/g' | \
    sed -E 's/notifiee/notifiée/g' | \
    sed -E 's/propriet/propriét/g' | \
    sed -E 's/indemnite/indemnité/g' | \
    sed -E 's/determin/détermin/g' | \
    sed -E 's/détermines/déterminés/g' | \
    sed -E 's/particuliere/particulière/g' | \
    sed -E 's/endemiques/endémiques/g' | \
    sed -E 's/assumee/assumée/g' | \
    sed -E 's/jugee/jugée/g' | \
    sed -E 's/metal/métal/g' | \
    sed -E 's/Energie/Énergie/g' | \
    sed -E 's/decri/décri/g' | \
    sed -E 's/perennite/pérennité/g' | \
    sed -E 's/riviere/rivière/g' | \
    sed -E 's/stockee/stockée/g' | \
    sed -E 's/debit/débit/g' | \
    sed -E 's/precites/précités/g' | \
    sed -E 's/alien/alién/g' | \
    sed -E 's/accordes/accordés/g' | \
    sed -E 's/Sante/Santé/g' | \
    sed -E 's/cree/créé/g' | \
    sed -E 's/facon/façon/g' | \
    sed -E 's/penurie/pénurie/g' | \
    sed -E 's/priorises/priorisés/g' | \
    sed -E 's/situee/située/g' | \
    sed -E 's/electricite/électricité/g' | \
    sed -E 's/recreati/récréati/g' | \
    sed -E 's/reconnait/reconnaît/g' | \
    sed -E 's/benefic/bénéfic/g' | \
    sed -E 's/boises/boisés/g' | \
    sed -E 's/croitre/croître/g' | \
    sed -E 's/degre/degré/g' | \
    sed -E 's/bacteri/bactéri/g' | \
    sed -E 's/depollution/dépollution/g' | \
    sed -E 's/usee/usée/g' | \
    sed -E 's/recept/récept/g' | \
    sed -E 's/agree/agréé/g' | \
    sed -E 's/resultat/résultat/g' | \
    sed -E 's/communiques/communiqués/g' | \
    sed -E 's/Iibre/libre/g' | \
    sed -E 's/peche/pêche/g' | \
    sed -E 's/agrement/agrément/g' | \
    sed -E 's/déversee/déversée/g' | \
    sed -E 's/rnenee/menée/g' | \
    sed -E 's/haitien/haïtien/g' | \
    sed -E 's/evenement/événement/g' | \
    sed -E 's/au-dela/au-delà/g' | \
    sed -E 's/utilises/utilisés/g' | \
    sed -E 's/caracteris/caractéris/g' | \
    sed -E 's/élaboree/élaborée/g' | \
    sed -E 's/édictee/édictée/g' | \
    sed -E 's/visee/visée/g' | \
    sed -E 's/alinea/alinéa/g' | \
    sed -E 's/liber/libér/g' | \
    sed -E 's/prelev/prélèv/g' | \
    sed -E 's/proteg/protég/g' | \
    sed -E 's/protéges/protégés/g' | \
    sed -E 's/eventuel/éventuel/g' | \
    sed -E 's/destines/destinés/g' | \
    sed -E 's/specimen/spécimen/g' | \
    sed -E 's/étrangere/étrangère/g' | \
    sed -E 's/Residu/Résidu/g' | \
    sed -E 's/reutilis/réutilis/g' | \
    sed -E 's/faisabilite/faisabilité/g' | \
    sed -E 's/economie/économie/g' | \
    sed -E 's/manufactures/manufacturés/g' | \
    sed -E 's/recycles/recyclés/g' | \
    sed -E 's/aupres/auprès/g' | \
    sed -E 's/operat/opérat/g' | \
    sed -E 's/etend/étend/g' | \
    sed -E 's/medica/médica/g' | \
    sed -E 's/Genetique/Génétique/g' | \
    sed -E 's/Modifies/Modifiés/g' | \
    sed -E 's/prélèves/prélevés/g' | \
    sed -E 's/prélèvee/prélevée/g' | \
    sed -E 's/Impot/Impôt/g' | \
    sed -E 's/coiffee/coiffée/g' | \
    sed -E 's/President/Président/g' | \
    sed -E 's/deuxieme/deuxième/g' | \
    sed -E 's/gerant/gérant/g' | \
    sed -E 's/agglomer/agglomér/g' | \
    sed -E 's/inferieur/inférieur/g' | \
    sed -E 's/impliquee/impliquée/g' | \
    sed -E 's/connaitre/connaître/g' | \
    sed -E 's/Prevention/Prévention/g' | \
    sed -E 's/Reponse/Réponse/g' | \
    sed -E 's/Desastre/Désastre/g' | \
    sed -E 's/identifiee/identifiée/g' | \
    sed -E 's/cartographiee/cartographiée/g' | \
    sed -E 's/Republique/République/g' | \
    sed -E 's/ pres / près /g' | \
    sed -E 's/ repar/ répar/g' | \
    sed -E 's/causes/causés/g' | \
    sed -E 's/gravite/gravité/g' | \
    sed -E 's/qualifiee/qualifiée/g' | \
    sed -E 's/delit/délit/g' | \
    sed -E 's/severe/sévère/g' | \
    sed -E 's/reprim/réprim/g' | \
    sed -E 's/réprimee/réprimée/g' | \
    sed -E 's/entrain/entraîn/g' | \
    sed -E 's/lesee/lésée/g' | \
    sed -E 's/etlou/et\/ou/g' | \
    sed -E 's/inherent/inhérent/g' | \
    sed -E 's/ etai/ étai/g' | \
    sed -E 's/equivalent/équivalent/g' | \
    sed -E 's/retention/rétention/g' | \
    sed -E 's/transferee/transférée/g' | \
    sed -E 's/geologi/géologi/g' | \
    sed -E 's/repression/répression/g' | \
    sed -E 's/Securite/Sécurité/g' | \
    sed -E 's/Education/Éducation/g' | \
    # Chapter I preamble
    sed -E 's/durable\. 4 II/durable. Il/' | \
    sed -E 's/(Il vise notamment )ii/\1à/' | \
    sed -E "s/entrel'environnement/entre l'environnement/" | \
    sed -E 's/santéhumaine/santé humaine/' | \
    sed -E 's/surles/sur les/' | \
    sed -E 's/penteet déclives/pente et déclives/' | \
    sed -E 's/milieux endommages/milieux endommagés/' | \
    sed -E "s/encouragerl'utilisation/encourager l'utilisation/" | \
    sed -E 's/écologiquernent rationnelledes/écologiquement rationnelle des/' | \
    sed -E "s/l'environnementet/l'environnement et/" | \
    sed -E "s/développement\.d'une/développement d'une/" | \
    sed -E 's/environnemenl/environnement/' | \
    # Article 1
    amend_error_in_article 1 ' Article \[2\]' '.\n\n(2)' | \
    amend_error_in_article 1 'it des' 'à des' | \
    amend_error_in_article 1 végétates végétales | \
    # Article 2
    amend_error_in_article 2 touteportion 'toute portion' | \
    amend_error_in_article 2 'et\/ouecologiques' 'et\/ou écologiques' | \
    amend_error_in_article 2 acette 'à cette' | \
    amend_error_in_article 2 aune 'à une' | \
    amend_error_in_article 2 "d' évaluation" "d'évaluation" | \
    amend_error_in_article 2 'manière it' 'manière à' | \
    amend_error_in_article 2 'un territoire donne' 'un territoire donné' | \
    amend_error_in_article 2 '5 \[' '[' | \
    amend_error_in_article 2 coursvisantafaireressortir 'cours visant à faire ressortir' | \
    amend_error_in_article 2 dansquelle 'dans quelle' | \
    amend_error_in_article 2 unsystème 'un système' | \
    amend_error_in_article 2 'gestion aude' 'gestion ou de' | \
    amend_error_in_article 2 'Biodiversité:Iavariabilité' '\[•\] Biodiversité: la variabilité' | \
    amend_error_in_article 2 touteorigine 'toute origine' | \
    amend_error_in_article 2 entreautres 'entre autres' | \
    amend_error_in_article 2 'celie des' 'celle des' | \
    amend_error_in_article 2 'écosystèmes, \[' 'écosystèmes. [' | \
    amend_error_in_article 2 "d'exploitation donne" "d'exploitation donné" | \
    amend_error_in_article 2 acteadministratifatitre 'acte administratif à titre' | \
    amend_error_in_article 2 'onéreux au gratuit' 'onéreux ou gratuit' | \
    amend_error_in_article 2 cahierde 'cahier de' | \
    amend_error_in_article 2 'a une personne' 'à une personne' | \
    amend_error_in_article 2 "' au privé laccès a" " ou privé l'accès à" | \
    amend_error_in_article 2 emissicns émissions | \
    amend_error_in_article 2 'nature!' naturel | \
    amend_error_in_article 2 'Conservation ln-situr' '[•] Conservation in-situ:' | \
    amend_error_in_article 2 biologiquedanssonecosystème 'biologique dans son écosystème' | \
    amend_error_in_article 2 Infraction '[•] Infraction' | \
    amend_error_in_article 2 ' \[•\] • \[•\] • \[•\]' '' | \
    amend_error_in_article 2 adégrader 'à dégrader' | \
    amend_error_in_article 2 'auamettre en périllasante' 'ou à mettre en péril la santé ' | \
    amend_error_in_article 2 'au végétate' 'ou végétale' | \
    amend_error_in_article 2 Désertification '[•] Désertification' | \
    amend_error_in_article 2 'scrni-arides' 'semi-arides' | \
    amend_error_in_article 2 'au la mauvaiseutilisation' 'ou la mauvaise utilisation' | \
    amend_error_in_article 2 District '[•] District' | \
    amend_error_in_article 2 "géréed'un" "gérée d'un" | \
    amend_error_in_article 2 Contaminant '[•] Contaminant' | \
    amend_error_in_article 2 'Iiquide au gazeuse' 'liquide ou gazeuse' | \
    amend_error_in_article 2 'unrayonnement' 'un rayonnement' | \
    amend_error_in_article 2 'au toutecombinaison' 'ou toute combinaison' | \
    amend_error_in_article 2 daltérer "d'altérer" | \
    amend_error_in_article 2 'environnement; D' 'environnement. [•] D' | \
    amend_error_in_article 2 ': U' ': u' | \
    amend_error_in_article 2 aassurer 'à assurer' | \
    amend_error_in_article 2 Eaux '[•] Eaux' | \
    amend_error_in_article 2 "toutesles réservesd'eaux" "toutes les réserves d'eau" | \
    amend_error_in_article 2 'dansle sons-sol\.' 'dans le sous-sol,' | \
    amend_error_in_article 2 eauxde 'eaux de' | \
    amend_error_in_article 2 'douces au saumâtres' 'douces ou saumâtres' | \
    amend_error_in_article 2 "niveaudes coursd'eau" "niveau des cours d'eau" | \
    amend_error_in_article 2 Iagunes lagunes | \
    amend_error_in_article 2 eauxen 'eaux en' | \
    amend_error_in_article 2 Ecosystème '[•] Ecosystème' | \
    amend_error_in_article 2 'dynamique forme' 'dynamique formé' | \
    amend_error_in_article 2 'vivantqui, parleur' 'vivant qui, par leur' | \
    amend_error_in_article 2 '6 Envimnnement' '[•] Environnement' | \
    amend_error_in_article 2 vivantset 'vivants et' | \
    amend_error_in_article 2 '; Étude' '. [•] Étude' | \
    amend_error_in_article 2 dactivités "d'activités" | \
    amend_error_in_article 2 contr61e contrôle | \
    amend_error_in_article 2 'un projet détermine' 'un projet déterminé' | \
    amend_error_in_article 2 documentjuridique 'document juridique' | \
    amend_error_in_article 2 'estre-ecrite' 'est ré-écrite' | \
    amend_error_in_article 2 'SOliS uneformeclaireet' 'sous une forme claire et' | \
    amend_error_in_article 2 pourfaire 'pour faire' | \
    amend_error_in_article 2 "présentée à l'autorité" "présenté à l'autorité" | \
    amend_error_in_article 2 'compétente, Dans' 'compétente. Dans' | \
    amend_error_in_article 2 dimpact "d'impact" | \
    amend_error_in_article 2 'sectorielles\. \.' 'sectorielles.' | \
    amend_error_in_article 2 'maritime\. couverte' 'maritime, couverte' | \
    amend_error_in_article 2 uneunité 'une unité' | \
    amend_error_in_article 2 'laquelleinterviennent uneou' 'laquelle interviennent une ou' | \
    amend_error_in_article 2 "al'environnement;" "à l'environnement." | \
    amend_error_in_article 2 indûstrielles industrielles | \
    amend_error_in_article 2 Milieu '[•] Milieu' | \
    amend_error_in_article 2 lesecosystèmes 'les écosystèmes' | \
    amend_error_in_article 2 'ce\.soit' 'ce soit' | \
    amend_error_in_article 2 'naturelle au artificielle' 'naturelle ou artificielle' | \
    amend_error_in_article 2 eausoit 'eau soit' | \
    amend_error_in_article 2 'stagnante au courante' 'stagnante ou courante' | \
    amend_error_in_article 2 'saumfitre au' 'saumâtre ou' | \
    amend_error_in_article 2 'rnesures amarée' 'mesurés à marée' | \
    amend_error_in_article 2 'telsles riziercs au' 'tels les rizières ou' | \
    amend_error_in_article 2 etJou 'et\/ou' | \
    amend_error_in_article 2 'gestion places' 'gestion placés' | \
    amend_error_in_article 2 Non '[•] Non' | \
    amend_error_in_article 2 'pourun projet au une' 'pour un projet ou une' | \
    amend_error_in_article 2 "n' est" "n'est" | \
    amend_error_in_article 2 uutorisations autorisations | \
    amend_error_in_article 2 '• \[•\] • ' '' | \
    amend_error_in_article 2 'touteentire physiqueou moralesoit' 'toute entité physique ou morale soit' | \
    amend_error_in_article 2 'individu,une' 'individu, une' | \
    amend_error_in_article 2 'line organisation\.' 'une organisation,' | \
    amend_error_in_article 2 'association\. unorganisme public\.' 'association, un organisme public,' | \
    amend_error_in_article 2 'territoriale; P' 'territoriale. [•] P' | \
    amend_error_in_article 2 'pollution; P' 'pollution. [•] P' | \
    amend_error_in_article 2 'line contamination au' 'une contamination ou' | \
    amend_error_in_article 2 'environnernent; P' 'environnement. [•] P' | \
    amend_error_in_article 2 'Pollution le' 'Pollution: le' | \
    amend_error_in_article 2 ' No\. 11.*$' '' | \
    sed -E '/^\(2\)/,/^\(8\)/{/^\(2\)/!{/^\(8\)/!d}}' | \
    sed -E "/^\(2\)/{$!{N;s/^(\(2\).*)\n\(8\)/\1 ${missing_article_2_text}/;t;P;D}}" | \
    amend_error_in_article 2 'individuels\. \[' 'individuels; [' | \
    amend_error_in_article 2 '; R' '. [•] R' | \
    amend_error_in_article 2 'natureJle Ilmitee' 'naturelle limitée' | \
    amend_error_in_article 2 'actuelles \[' 'actuelles. [' | \
    amend_error_in_article 2 deehet déchet | \
    amend_error_in_article 2 'chimique\. sa' 'chimique, sa' | \
    amend_error_in_article 2 "au de l'environnement au" "ou de l'environnement ou" | \
    amend_error_in_article 2 'qui est identifie' 'qui est identifié' | \
    amend_error_in_article 2 'conventions au traités' 'conventions ou traités' | \
    # Article 3
    amend_error_in_article 3 'différents\. Les' 'différents.\n\n(8) Les' | \
    amend_error_in_article 3 "progressivement\. L'obligation" "progressivement.\n\n(7) L'obligation" | \
    amend_error_in_article 3 'indissociables\. Les' 'indissociables.\n\n(6) Les' | \
    amend_error_in_article 3 'intégrité\. La' 'intégrité.\n\n(5) La' | \
    amend_error_in_article 3 'pays\. Les' 'pays.\n\n(4) Les' | \
    # Article 4
    amend_error_in_article 4 natureUes naturelles | \
    amend_error_in_article 4 'limitées doivent' 'limitées, doivent' | \
    amend_error_in_article 4 utilisées utilisés | \
    amend_error_in_article 4 aassurer 'à assurer' | \
    # Article 6
    amend_error_in_article 6 naturelies naturelles | \
    # Article 7
    amend_error_in_article 7 'a toutes' 'à toutes' | \
    amend_error_in_article 7 'locales\. chacune' 'locales, chacune' | \
    amend_error_in_article 7 lequelles 'lequel les' | \
    amend_error_in_article 7 ' ades ' ' à des ' | \
    # Article 8
    amend_error_in_article 8 "1'É" "l'É" | \
    amend_error_in_article 8 derégulation 'de régulation' | \
    amend_error_in_article 8 '\. d' ', d' | \
    amend_error_in_article 8 entire entité | \
    amend_error_in_article 8 'ou la ressource' 'où la ressource' | \
    amend_error_in_article 8 ' 8.*$' '' | \
    # Article 9
    sed -E '/^\(8\)/,/^\(16\)/{/^\(8\)/!{/^\(16\)/!d}}' | \
    sed -E '/^\(8\)/{$!{N;s/^(\(8\).*)\n\(16\)/\1\n\n(9)/;t;P;D}}' | \
    amend_error_in_article 9 'environnement\. Conformément' 'environnement\.\n\n(13) Conformément' | \
    amend_error_in_article 9 'loi\. Les' 'loi.\n\n(12) Les' | \
    amend_error_in_article 9 'vigueur\. Tout' 'vigueur\.\n\n(11) Tout' | \
    amend_error_in_article 9 'environnement, Le' 'environnement.\n\n(10) Le' | \
    # Article 10
    amend_error_in_article 10 libérté liberté | \
    # Article 11
    amend_error_in_article 11 'environnementengage' 'environnement engage' | \
    amend_error_in_article 11 1apersonne 'la personne' | \
    amend_error_in_article 11 occasionne occasionné | \
    amend_error_in_article 11 'applique conformêment' 'appliqué conformément' | \
    # Article 12
    amend_error_in_article 12 différentcs différentes | \
    amend_error_in_article 12 poiitique politique | \
    # Article 13
    amend_error_in_article 13 'it assurer' 'à assurer' | \
    amend_error_in_article 13 "l'environnement it" "l'environnement à" | \
    # Article 14
    amend_error_in_article 14 '\. Le Conseil' '.\n\n(16) Le Conseil' | \
    amend_error_in_article 14 '\. Les organes' '.\n\n(15) Les organes' | \
    amend_error_in_article 14 constitue constitué | \
    amend_error_in_article 14 11 à | \
    amend_error_in_article 14 etfaciliter 'et faciliter' | \
    amend_error_in_article 14 taus tous | \
    amend_error_in_article 14 'ou cela' 'où cela' | \
    # Article 15
    sed -E ':start;s/^(\(15\).*\] )([A-Z])/\1\L\2/;t start' | \
    amend_error_in_article 15 groupesorganisés 'groupes organisés' | \
    amend_error_in_article 15 travaillantdans 'travaillant dans' | \
    amend_error_in_article 15 ledomaine 'le domaine' | \
    # Article 16
    amend_error_in_article 16 'Inter-Ministericl' 'Inter-Ministériel' | \
    amend_error_in_article 16 'compose:' 'composé: [•]' | \
    amend_error_in_article 16 ' No.*$' '' | \
    # Article 17
    sed -E '/^\(16\)/,/^\(19\)/{/^\(16\)/!{/^\(19\)/!d}}' | \
    sed -E '/^\(16\)/{$!{N;s/^(\(16\).*)\n\(19\)/\1\n\n(17)/;t;P;D}}' | \
    amend_error_in_article 17 'Décret\.' 'Décret.\n\n(19)' | \
    amend_error_in_article 17 'environnementales\.' 'environnementales.\n\n(18)' | \
    amend_error_in_article 17 daménagement "d'aménagement" | \
    amend_error_in_article 17 'touch ant' touchant | \
    amend_error_in_article 17 ' aun ' ' à un ' | \
    # Article 18
    amend_error_in_article 18 LeConseil 'Le Conseil' | \
    amend_error_in_article 18 préside présidé | \
    amend_error_in_article 18 leMinistre 'le Ministre' | \
    amend_error_in_article 18 passe passé | \
    amend_error_in_article 18 'ministères,' 'ministères.' | \
    # Article 19
    sed -E ':start;s/^(\(19\).*\] )([A-Z])/\1\L\2/;t start' | \
    amend_error_in_article 19 'territoire au d' 'territoire ou d' | \
    amend_error_in_article 19 'toutajustement au' 'tout ajustement ou' | \
    amend_error_in_article 19 révisionaintroduire 'révision à introduire' | \
    amend_error_in_article 19 "\[d'O" "à l'0" | \
    amend_error_in_article 19 aprendre 'à prendre' | \
    amend_error_in_article 19 motive motivé | \
    amend_error_in_article 19 quiluisontsoumisence 'qui lui sont soumis en ce' | \
    amend_error_in_article 19 motive motivé | \
    amend_error_in_article 19 sournis soumis | \
    amend_error_in_article 19 'au soumettre' 'ou soumettre' | \
    amend_error_in_article 19 ledomaine 'le domaine' | \
    amend_error_in_article 19 'protection au de' 'protection ou de' | \
    amend_error_in_article 19 ' 10.*$' '' | \
    # Article 20
    sed -E '/^\(19\)/,/^\(23\)/{/^\(19\)/!{/^\(23\)/!d}}' | \
    sed -E '/^\(19\)/{$!{N;s/^(\(19\).*)\n\(23\)/\1\n\n(20)/;t;P;D}}' | \
    amend_error_in_article 20 'Environnement\.' 'Environnement.\n\n(23)' | \
    amend_error_in_article 20 'secteurs\.' 'secteurs.\n\n(22)' | \
    amend_error_in_article 20 'moment\.' 'moment.\n\n(21)' | \
    sed -E ':start;s/^(\(20\).*\] )([A-Z])/\1\L\2/;t start' | \
    amend_error_in_article 20 veiIle veille | \
    amend_error_in_article 20 ' gere ' ' gère ' | \
    amend_error_in_article 20 pourfaire 'pour faire' | \
    amend_error_in_article 20 aleur 'à leur' | \
    amend_error_in_article 20 '\[t\]' '[f]' | \
    amend_error_in_article 20 '; L' '. L' | \
    amend_error_in_article 20 ', L' '. L' | \
    # Article 21
    amend_error_in_article 21 auregroupements 'ou regroupements' | \
    amend_error_in_article 21 decollcctivites 'de collectivités' | \
    amend_error_in_article 21 "quiantunémissiond'exécution" "qui ont une mission d'exécution" | \
    amend_error_in_article 21 'dépassation démarchés' ' de passation de marchés' | \
    amend_error_in_article 21 'a celles' 'à celles' | \
    amend_error_in_article 21 aleurinstitution 'à leur institution' | \
    sed -E ':start;s/^(\(21\).*\] )([A-Z])/\1\L\2/;t start' | \
    amend_error_in_article 21 projetset 'projets et' | \
    amend_error_in_article 21 'au à la' 'ou à la' | \
    amend_error_in_article 21 'a assurer' 'à assurer' | \
    amend_error_in_article 21 motive motivé | \
    amend_error_in_article 21 "al'approbation" "à l'approbation" | \
    amend_error_in_article 21 "pard'autres" "par d'autres" | \
    # Article 22
    amend_error_in_article 22 approuve approuvé | \
    # Article 23
    amend_error_in_article 23 ' No.*$' '' | \
    sed -E '/^\(23\)/,/^\(25\)/{/^\(23\)/!{/^\(25\)/!d}}' | \
    sed -E '/^\(23\)/{$!{N;s/^(\(23\).*)\n\(25\)/\1 [a] les responsables des/;t;P;D}}' | \
    amend_error_in_article 23 'environnements\.' 'environnements.\n\n(25)' | \
    amend_error_in_article 23 'environnement\.' 'environnement.\n\n(24)' | \
    amend_error_in_article 23 Environnementont 'Environnement ont' | \
    amend_error_in_article 23 'a défaut' 'à défaut' | \
    amend_error_in_article 23 concerne concerné | \
    amend_error_in_article 23 traite traité | \
    amend_error_in_article 23 regroupcnt regroupent | \
    amend_error_in_article 23 'a défaut' 'à défaut' | \
    amend_error_in_article 23 'res ponsabies' responsables | \
    amend_error_in_article 23 'au influant' 'ou influant' | \
    # Article 24
    amend_error_in_article 24 'L-' '[1]' | \
    amend_error_in_article 24 problernatiques problématiques | \
    amend_error_in_article 24 "a \\\'0" "à l'0" | \
    amend_error_in_article 24 implique impliqué | \
    amend_error_in_article 24 'a impacts' 'à impacts' | \
    amend_error_in_article 24 nssurer assurer | \
    amend_error_in_article 24 ' ies ' ' les ' | \
    amend_error_in_article 24 impactenvironnemental 'impact environnemental' | \
    amend_error_in_article 24 '51 besoinest' 'si besoin est' | \
    amend_error_in_article 24 assainisserrient assainissement | \
    amend_error_in_article 24 Justiceen 'Justice en' | \
    amend_error_in_article 24 'concernent, \[' 'concernent; [' | \
    amend_error_in_article 24 'tes cadres' 'les cadres' | \
    amend_error_in_article 24 dessubstituts 'des substituts' | \
    amend_error_in_article 24 gouvernementspécialisés 'gouvernement spécialisés' | \
    # Article 25
    amend_error_in_article 25 ' 12.*$' '' | \
    sed -E '/^\(25\)/,/^\(27\)/{/^\(25\)/!{/^\(27\)/!d}}' | \
    sed -E '/^\(25\)/{$!{N;s/^(\(25\).*)\n\(27\)/\1/;t;P;D}}' | \
    amend_error_in_article 25 'concernées\.' 'concernées.\n\n(27)' | \
    amend_error_in_article 25 'environnement\.' 'environnement.\n\n(26)' | \
    amend_error_in_article 25 'Départements\.' 'Départements,' | \
    amend_error_in_article 25 'Centrala\.' 'Central à ' | \
    amend_error_in_article 25 "del'environnement,al'aménagement" "de l'environnement, à l'aménagement" | \
    amend_error_in_article 25 "etal'amélioration" "et à l'amélioration" | \
    amend_error_in_article 25 'L-' '[1]' | \
    amend_error_in_article 25 lélaboration "l'élaboration" | \
    amend_error_in_article 25 '~chemas' schémas | \
    amend_error_in_article 25 etabiissements établissements | \
    amend_error_in_article 25 "pland'occupation" "plan d'occupation" | \
    amend_error_in_article 25 ': \[' '; [' | \
    amend_error_in_article 25 ' eta ' ' et à ' | \
    amend_error_in_article 25 réhabilitationdes 'réhabilitation des' | \
    amend_error_in_article 25 'pares municipaux' 'parcs municipaux' | \
    amend_error_in_article 25 'a leur' 'à leur' | \
    amend_error_in_article 25 'au altérations' 'ou altérations' | \
    amend_error_in_article 25 Integrer intégrer | \
    amend_error_in_article 25 'a une' 'à une' | \
    amend_error_in_article 25 'respectdes normesen' 'respect des normes en' | \
    amend_error_in_article 25 leurjuridiction 'leur juridiction' | \
    amend_error_in_article 25 'stationset garesde' 'stations et gares de' | \
    amend_error_in_article 25 'public\. cimetières etc\.\.\.' 'public, cimetières, etc.;' | \
    amend_error_in_article 25 'airet aux nuisancessonores' 'air et aux nuisances sonores' | \
    amend_error_in_article 25 surtoutaménagement 'surtout aménagement' | \
    amend_error_in_article 25 relatifauxsites 'relatif aux sites' | \
    amend_error_in_article 25 trouvantsurleur 'trouvant sur leur' | \
    amend_error_in_article 25 'i! est envisage' 'il est envisagé' | \
    # Article 26
    amend_error_in_article 26 satisfaitaux 'satisfait aux' | \
    amend_error_in_article 26 'a but' 'à but' | \
    amend_error_in_article 26 'au traitées' 'ou traitées' | \
    amend_error_in_article 26 écologistes 'écologiste"' | \
    amend_error_in_article 26 décerne décerné | \
    amend_error_in_article 26 réévalue réévalué | \
    # Article 27
    amend_error_in_article 27 'Les\.organisations' 'Les organisations' | \
    amend_error_in_article 27 'personnalitéjuridique,' 'personnalité juridique' | \
    # Article 28
    amend_error_in_article 28 ' No.*$' '' | \
    sed -E '/^\(28\)/,/^\(30\)/{/^\(28\)/!{/^\(30\)/!d}}' | \
    sed -E '/^\(28\)/{$!{N;s/^(\(28\).*)\n\(30\)/\1/;t;P;D}}' | \
    amend_error_in_article 28 ENVIRONNEMENTALE 'ENVIRONNEMENTALE\n\n(29)' | \
    amend_error_in_article 28 '; CHAPITREII' '.\n\nCHAPITRE II -' | \
    amend_error_in_article 28 "del'" "de l'" | \
    amend_error_in_article 28 disposedu 'dispose du' | \
    amend_error_in_article 28 indique indiqué | \
    amend_error_in_article 28 '1-\.' '[1]' | \
    amend_error_in_article 28 'it protéger' 'à protéger' | \
    amend_error_in_article 28 'daires' "d'aires" | \
    amend_error_in_article 28 "relativeal'environnement" "relative à l'environnement" | \
    amend_error_in_article 28 'it vocation' 'à vocation' | \
    amend_error_in_article 28 marche marché | \
    # Article 29
    amend_error_in_article 29 'sous-sol\.' 'sous-sol.\n\n(30)' | \
    amend_error_in_article 29 '2005 \[•\] 2020' '2005 - 2020' | \
    amend_error_in_article 29 niveauxde 'niveaux de' | \
    amend_error_in_article 29 'bassins-versantset' 'bassins-versants et' | \
    # Article 30
    amend_error_in_article 30 AdministrationPublique 'Administration Publique' | \
    # Article 31
    amend_error_in_article 31 ' 14.*$' '' | \
    sed -E '/^\(31\)/,/^\(38\)/{/^\(31\)/!{/^\(38\)/!d}}' | \
    sed -E "/^\(31\)/{$!{N;s/^(\(31\).*)\n\(38\)/\1 ${missing_article_31_text}/;t;P;D}}" | \
    amend_error_in_article 31 'collectivité\.' 'collectivité.\n\n(38)' | \
    amend_error_in_article 31 'vie\.' 'vie.\n\n(37)' | \
    amend_error_in_article 31 'établis\.' "établis.\n\nSection II - De l'Habitat\n\n(36)" | \
    amend_error_in_article 31 'loi\.' 'loi.\n\n(35)' | \
    amend_error_in_article 31 'zone\.' 'zone.\n\n(34)' | \
    amend_error_in_article 31 'durable\.' 'durable.\n\n(33)' | \
    amend_error_in_article 31 'contraignants\.' 'contraignants.\n\n(32)' | \
    amend_error_in_article 31 'territoire et; des' 'territoire; et des' | \
    amend_error_in_article 31 'au district' 'ou district' | \
    amend_error_in_article 31 hydrographiques hydrographique | \
    amend_error_in_article 31 'économiques\.' 'économiques,' | \
    # Article 32
    amend_error_in_article 32 reuvre oeuvre | \
    # Article 33
    amend_error_in_article 33 aquelque 'à quelque' | \
    amend_error_in_article 33 tenantcompte 'tenant compte' | \
    amend_error_in_article 33 'de chargé' 'de charge' | \
    amend_error_in_article 33 accèssibles accessibles | \
    amend_error_in_article 33 mteret intérêt | \
    amend_error_in_article 33 'au paysagères' 'ou paysagères' | \
    # Article 34
    amend_error_in_article 34 'bassinsversants au' 'bassin-versants ou' | \
    # Article 35
    amend_error_in_article 35 entreeux 'entre eux' | \
    # Article 36
    amend_error_in_article 36 "J'accès" "l'accès" | \
    # Article 37
    amend_error_in_article 37 achaque 'à chaque' | \
    # Article 38
    amend_error_in_article 38 ' No.*$' '' | \
    # Article 39
    amend_error_in_article 39 daménagement "d'aménagement" | \
    amend_error_in_article 39 'au des' 'ou des' | \
    amend_error_in_article 39 'communaux au' 'communaux ou' | \
    amend_error_in_article 39 ' Section.*$' "\n\nSection III - De l'Urbanisme" | \
    sed -E '/^Section III - De/,/^Article/{/^Section III - De/!d}' | \
    # Article 40
    sed -E 's/^\(42\)/(40)/' | \
    sed -E '/^\(40\)/,/^\(49\)/{/^\(40\)/!{/^\(49\)/!d}}' | \
    sed -E "/^\(40\)/{$!{N;s/^(\(40\).*)\n\(49\)/\1/;t;P;D}}" | \
    amend_error_in_article 40 'existant\.' 'existant.\n\n(47)' | \
    amend_error_in_article 40 'folkloriques\.' 'folkloriques.\n\n(46)' | \
    amend_error_in_article 40 'urbain\.' 'urbain.\n\n(45)' | \
    amend_error_in_article 40 'activité\.' 'activité.\n\n(44)' | \
    amend_error_in_article 40 'culturel Article' 'culturel.\n\n(43)' | \
    amend_error_in_article 40 'publiques, S.*$' 'publiques.\n\nSection IV - Du patrimoine naturel et culturel' | \
    amend_error_in_article 40 'obligation, P' 'obligation.\n\n(42) P' | \
    amend_error_in_article 40 'urbain\.' 'urbain.\n\n(41)' | \
    amend_error_in_article 40 uoivent doivent | \
    amend_error_in_article 40 ', 11' '. Il' | \
    # Article 41
    amend_error_in_article 41 'isolen\.ent au' 'isolément ou' | \
    amend_error_in_article 41 regroupementsuivant 'regroupement suivant' | \
    amend_error_in_article 41 "ill'échelle" "à l'échelle" | \
    # Article 43
    amend_error_in_article 43 lirnites limites | \
    # Article 44
    amend_error_in_article 44 mscription inscription | \
    amend_error_in_article 44 'au classes' 'ou classés' | \
    amend_error_in_article 44 ',les' ', les' | \
    # Article 45
    amend_error_in_article 45 cultureIles culturelles | \
    # Article 46
    amend_error_in_article 46 culturelies culturelles | \
    # Article 48
    sed -E 's/^\(48\)L/(48) L/' | \
    amend_error_in_article 48 ' 16.*$' '' | \
    sed -E '/^\(48\)/,/^\(56\)/{/^\(48\)/!{/^\(56\)/!d}}' | \
    sed -E "/^\(48\)/{$!{N;s/^(\(48\).*)\n\(56\)/\1 ${missing_article_49_text}/;t;P;D}}" | \
    amend_error_in_article 48 'juridiction\.' 'juridiction.\n\n(55)' | \
    amend_error_in_article 48 'Environnement\.' 'Environnement.\n\n(54)' | \
    amend_error_in_article 48 'matière\.' 'matière.\n\n(53)' | \
    amend_error_in_article 48 'adéfinir,' 'à définir.\n\n(52)' | \
    amend_error_in_article 48 'règlementaire, L' 'règlementaire.\n\n(51) L' | \
    amend_error_in_article 48 'ressources\.' 'ressources.\n\n(50)' | \
    amend_error_in_article 48 'protection\.' 'protection.\n\n(49)' | \
    amend_error_in_article 48 constitue constitué | \
    amend_error_in_article 48 dejil déjà | \
    amend_error_in_article 48 ' pares ' ' parcs ' | \
    # Article 49
    amend_error_in_article 49 aau au | \
    amend_error_in_article 49 ' aces ' ' à ces ' | \
    # Article 51
    amend_error_in_article 51 'etl au' 'et\/ou' | \
    # Article 52
    amend_error_in_article 52 veutétablir 'veut établir' | \
    # Article 54
    amend_error_in_article 54 "L' Agenee" "L'Agence" | \
    amend_error_in_article 54 etla 'et la' | \
    amend_error_in_article 54 daménagement "d'aménagement" | \
    amend_error_in_article 54 relevantde 'relevant de' | \
    amend_error_in_article 54 Jeur leur | \
    amend_error_in_article 54 SOliS sous | \
    amend_error_in_article 54 SOliS sous | \
    amend_error_in_article 54 auxairesprotégées 'aux aires protégées' | \
    amend_error_in_article 54 SOllS sous | \
    amend_error_in_article 54 sajuridiction 'sa juridiction' | \
    amend_error_in_article 54 auxressources 'aux ressources' | \
    amend_error_in_article 54 etles 'et les' | \
    # Article 56
    sed -E 's/^\(56\)L/(56) L/' | \
    amend_error_in_article 56 '\. No.*$' '' | \
    sed -E '/^\(56\)/,/^\(63\)/{/^\(56\)/!{/^\(63\)/!d}}' | \
    sed -E "/^\(56\)/{$!{N;s/^(\(56\).*)\n\(63\) ArticleM\.-/\1/;t;P;D}}" | \
    amend_error_in_article 56 'UTES\.' 'UTES.\n\n(61)' | \
    amend_error_in_article 56 'environnemental\.' 'environnemental.\n\n(60)' | \
    amend_error_in_article 56 'population\.' 'population.\n\n(59)' | \
    amend_error_in_article 56 'Environnement\.' 'Environnement.\n\n(58)' | \
    amend_error_in_article 56 'environnementaux\.' 'environnementaux.\n\n(57)' | \
    amend_error_in_article 56 acharge 'à charge' | \
    amend_error_in_article 56 lmpact Impact | \
    # Article 57
    amend_error_in_article 57 environnementales environnementale | \
    amend_error_in_article 57 11 à | \
    amend_error_in_article 57 11 à | \
    amend_error_in_article 57 chargé charge | \
    # Article 58
    amend_error_in_article 58 Institutionnaliser institutionnaliser | \
    # Article 60
    amend_error_in_article 60 'de taus' 'de tous' | \
    amend_error_in_article 60 délivre délivré | \
    amend_error_in_article 60 'enregistrement a' 'enregistrement à' | \
    # Article 61
    amend_error_in_article 61 'les non-objection' 'les non-objections' | \
    amend_error_in_article 61 'respectées, II' 'respectées. II' | \
    amend_error_in_article 61 'des non-objection' 'des non-objections' | \
    amend_error_in_article 61 'celie des' 'celle des' | \
    amend_error_in_article 61 etmoraies 'et morales' | \
    amend_error_in_article 61 'au judiciaire' 'ou judiciaire' | \
    amend_error_in_article 61 moraies morales | \
    # Article 62
    sed -E 's/^\(62\)L/(62) L/' | \
    amend_error_in_article 62 ', 18.*$' ';' | \
    sed -E '/^\(62\)/,/^\(68\)/{/^\(62\)/!{/^\(68\)/!d}}' | \
    sed -E "/^\(62\)/{$!{N;s/^(\(62\).*)\n\(68\)/\1/;t;P;D}}" | \
    amend_error_in_article 62 'judiciaires\.' 'judiciaires.\n\n(67)' | \
    amend_error_in_article 62 'environnementales\.' 'environnementales.\n\n(66)' | \
    amend_error_in_article 62 'résidus; L' 'résidus.\n\n(65) L' | \
    amend_error_in_article 62 'publiques\.' 'publiques.\n\n(64)' | \
    amend_error_in_article 62 'environnement\.' 'environnement.\n\n(63)' | \
    amend_error_in_article 62 'laidcr a' "l'aider à" | \
    # Article 63
    amend_error_in_article 63 atous 'à tous' | \
    amend_error_in_article 63 'co-geres' 'co-gérés' | \
    # Article 64
    amend_error_in_article 64 'a trait a' 'a trait à' | \
    sed -E ':start;s/^(\(64\).*), \[/\1; [/;t start' | \
    amend_error_in_article 64 ' 11 ' ' à ' | \
    amend_error_in_article 64 ' lotte ' ' lutte ' | \
    amend_error_in_article 64 cchelle échelle | \
    amend_error_in_article 64 bassinsversants 'bassins-versants' | \
    amend_error_in_article 64 ressourceeau 'ressource eau' | \
    amend_error_in_article 64 'respectdes normesde' 'respect des normes de' | \
    amend_error_in_article 64 "P'QUf" pour | \
    amend_error_in_article 64 cadrede 'cadre de' | \
    amend_error_in_article 64 Iieux lieux | \
    amend_error_in_article 64 ' pardes ' ' par des ' | \
    amend_error_in_article 64 senores sonores | \
    # Article 65
    amend_error_in_article 65 'a trait a' 'a trait à' | \
    amend_error_in_article 65 alintérieur "à l'intérieur" | \
    amend_error_in_article 65 'Iasupervisiondu respectdes' 'la supervision du respect des' | \
    amend_error_in_article 65 amoteur 'à moteur' | \
    amend_error_in_article 65 dinfractions "d'infractions" | \
    # Article 66
    amend_error_in_article 66 registrés registres | \
    amend_error_in_article 66 leMinistère 'le Ministère' | \
    amend_error_in_article 66 'lis font' 'Ils font' | \
    amend_error_in_article 66 lesjuridictions 'les juridictions' | \
    # Article 67
    amend_error_in_article 67 contr61e contrôle | \
    amend_error_in_article 67 lagestion 'la gestion' | \
    amend_error_in_article 67 relativesaux 'relatives aux' | \
    amend_error_in_article 67 dinfraction "d'infraction" | \
    amend_error_in_article 67 'Minis\.ere' Ministère | \
    # Article 68
    sed -E 's/^(\(68\))II/\1 Il/' | \
    amend_error_in_article 68 'a définir' 'à définir' | \
    amend_error_in_article 68 ' No\..*$' '' | \
    sed -E '/^\(68\)/,/^\(77\)/{/^\(68\)/!{/^\(77\)/!d}}' | \
    sed -E "/^\(68\)/{$!{N;s/^(\(68\).*)\n\(77\)/\1\n\n(69)/;t;P;D}}" | \
    # Article 69
    amend_error_in_article 69 ' 11 est créé' '\n\n(76) Il est créé' | \
    amend_error_in_article 69 "bâti, L'éducation" "bâti.\n\n(75) L'éducation" | \
    amend_error_in_article 69 "ENVIRONNEMENT L'État" "ENVIRONNEMENT\n\n(74) L'État" | \
    sed -E 's/^(\(69\).*) CHAPITREVI(.*) A /\1.\n\nCHAPITRE VII -\2 À /' | \
    amend_error_in_article 69 'concernée, Le' 'concernée.\n\n(73) Le' | \
    amend_error_in_article 69 'CONATE\. Toutes' 'CONATE.\n\n(72) Toutes' | \
    amend_error_in_article 69 'passées, Avec' 'passées.\n\n(71) Avec' | \
    amend_error_in_article 69 'règlementaire\. Le' 'règlementaire.\n\n(70) Le' | \
    amend_error_in_article 69 institue institué | \
    amend_error_in_article 69 pUbliques publiques | \
    amend_error_in_article 69 dévaluatton "d'évaluation" | \
    amend_error_in_article 69 'environnementale,' 'environnementale.' | \
    # Article 70
    amend_error_in_article 70 laRépublique 'la République' | \
    amend_error_in_article 70 COUfS cours | \
    # Article 71
    amend_error_in_article 71 'Avec line' 'Avec une' | \
    amend_error_in_article 71 "rr'excedant" "n'excédant" | \
    amend_error_in_article 71 atravers 'à travers' | \
    # Article 72
    amend_error_in_article 72 '\[•\]' '-' | \
    amend_error_in_article 72 Information information | \
    # Article 73
    amend_error_in_article 73 "d'!nformations" "d'Informations" | \
    # Article 74
    amend_error_in_article 74 '\[3\]' '[a]' | \
    # Article 75
    amend_error_in_article 75 'a tous' 'à tous' | \
    amend_error_in_article 75 'éducation, Les' 'éducation. Les' | \
    amend_error_in_article 75 ' ades ' ' à des ' | \
    amend_error_in_article 75 ' aIii ' ' à la ' | \
    amend_error_in_article 75 mains moins | \
    # Article 76
    amend_error_in_article 76 lePrix 'le Prix' | \
    amend_error_in_article 76 'décerne annue1lement' 'décerné annuellement' | \
    amend_error_in_article 76 ' aune ' ' à une ' | \
    amend_error_in_article 76 'contribue afaire' 'contribué à faire' | \
    amend_error_in_article 76 Rani Haïti | \
    # Article 77
    sed -E 's/^(\(77\))II/\1 Il/' | \
    amend_error_in_article 77 'cree,' 'créé,' | \
    amend_error_in_article 77 Rehabilitation Réhabilitation | \
    amend_error_in_article 77 Hartien Haïtien | \
    amend_error_in_article 77 alimente alimenté | \
    amend_error_in_article 77 acaractère 'à caractère' | \
    amend_error_in_article 77 Tresor Trésor | \
    amend_error_in_article 77 ' 20.*$' '' | \
    sed -E '/^\(77\)/,/^\(87\)/{/^\(77\)/!{/^\(87\)/!d}}' | \
    sed -E "/^\(77\)/{$!{N;s/^(\(77\).*)\n\(87\)/\1\n\n(78)/;t;P;D}}" | \
    # Article 78
    amend_error_in_article 78 "privées\. L'État" "privées.\n\n(86) L'État" | \
    amend_error_in_article 78 'naturelles\. Le Ministère' 'naturelles.\n\n(85) Le Ministère' | \
    amend_error_in_article 78 'matière\. Le Ministère' 'matière.\n\n(84) Le Ministère' | \
    amend_error_in_article 78 'diligente\. Outre' 'diligente.\n\n(83) Outre' | \
    amend_error_in_article 78 'environnementa1e\. Les' 'environnementale.\n\n(82) Les' | \
    amend_error_in_article 78 'Environnement\. La fiscalité' 'Environnement.\n\n(81) La fiscalité' | \
    amend_error_in_article 78 'MARCHÉ Sur' 'MARCHÉ\n\n(80) Sur' | \
    amend_error_in_article 78 'indépendant, CHAPITRE VIII' 'indépendant.\n\nCHAPITRE IX -' | \
    amend_error_in_article 78 'Environnement\. Les' 'Environnement.\n\n(79) Les' | \
    amend_error_in_article 78 élabore élaboré | \
    # Article 79
    amend_error_in_article 79 Initiative initiative | \
    amend_error_in_article 79 'bcneficieront de taus' 'bénéficieront de tous' | \
    amend_error_in_article 79 ' ace ' ' à ce ' | \
    amend_error_in_article 79 JIs Ils | \
    amend_error_in_article 79 prépare préparé | \
    # Article 80
    amend_error_in_article 80 marche marché | \
    amend_error_in_article 80 comrnemoyenpour 'comme moyen pour' | \
    amend_error_in_article 80 Iaqualité 'la qualité' | \
    amend_error_in_article 80 produitset 'produits et' | \
    amend_error_in_article 80 'protectiondes consomrnateurs,sera' 'protection des consommateurs, sera' | \
    amend_error_in_article 80 'encouragée,' 'encouragée.' | \
    amend_error_in_article 80 1apromotion 'la promotion' | \
    amend_error_in_article 80 1aprotection 'la protection' | \
    amend_error_in_article 80 '1a gestion' 'la gestion' | \
    # Article 81
    amend_error_in_article 81 'publique,' 'publique.' | \
    amend_error_in_article 81 'État, établit' 'État établit' | \
    amend_error_in_article 81 'au de marche' 'ou de marché' | \
    amend_error_in_article 81 'it la' 'à la' | \
    # Article 82
    amend_error_in_article 82 écologiquc écologique | \
    amend_error_in_article 82 '1a partie 1a' 'la partie la' | \
    # Article 83
    amend_error_in_article 83 '.Ia re-utilisation etle' ', la ré-utilisation et le' | \
    # Article 84
    amend_error_in_article 84 C02 CO2 | \
    amend_error_in_article 84 urilisation utilisation | \
    # Article 85
    amend_error_in_article 85 acharge 'à charge' | \
    amend_error_in_article 85 cyele cycle | \
    amend_error_in_article 85 'calculs,l' 'calculs, l' | \
    amend_error_in_article 85 apromouvoir 'à promouvoir' | \
    # Article 86
    amend_error_in_article 86 ': \[a\] L' ': [a] l' | \
    amend_error_in_article 86 '\. \[b\] L' '; [b] l' | \
    # Article 87
    sed -E 's/^\(87\)L/(87) L/' | \
    amend_error_in_article 87 atravers 'à travers' | \
    amend_error_in_article 87 ' No\..*$' '' | \
    # Article 88
    amend_error_in_article 88 'supporter au faire' 'supporter ou faire' | \
    # Article 89
    sed -E '/^\(90\)/,/^\(93\)/{/^\(90\)/!{/^\(93\)/!d}}' | \
    sed -E "/^\(90\)/{$!{N;s/^\(90\) Article\n\(93\)/(89)/;t;P;D}}" | \
    amend_error_in_article 89 'nationales, CHAPITREII' 'nationales.\n\nCHAPITRE II -' | \
    amend_error_in_article 89 'naturelles\. Les' 'naturelles.\n\n(93) Les' | \
    amend_error_in_article 89 'compétente\. Le' 'compétente.\n\n(92) Le' | \
    amend_error_in_article 89 'règlements\. Les' 'règlements.\n\n(91) Les' | \
    amend_error_in_article 89 'correspondants\. Les' 'correspondants.\n\n(90) Les' | \
    amend_error_in_article 89 'a réduire' 'à réduire' | \
    # Article 91
    amend_error_in_article 91 ressourcesnaturelles 'ressources naturelles' | \
    amend_error_in_article 91 'commerciale au' 'commerciale ou' | \
    amend_error_in_article 91 'line concession emanant' 'une concession émanant' | \
    # Article 92
    amend_error_in_article 92 Ministers Ministère | \
    # Article 94
    sed -E '/^Article$/,/^\(96\)/{/^Article$/!{/^\(96\)/!d}}' | \
    sed -E "/^Article$/{$!{N;s/^Article\n\(96\)/(94)/;t;P;D}}" | \
    amend_error_in_article 94 'conversion\. Tout' 'conversion.\n\n(96) Tout' | \
    amend_error_in_article 94 'environnement\. Pour' 'environnement.\n\n(95) Pour' | \
    amend_error_in_article 94 ' ades ' ' à des ' | \
    amend_error_in_article 94 'a une' 'à une' | \
    # Article 95
    amend_error_in_article 95 risqucs risques | \
    amend_error_in_article 95 'Territcriales concemees' 'Territoriales concernées' | \
    # Article 96
    amend_error_in_article 96 'au enfouissement' 'ou enfouissement' | \
    amend_error_in_article 96 'rernis en état,' 'remis en état.' | \
    amend_error_in_article 96 'la chargé' 'la charge' | \
    # Article 97
    sed -E 's/^(Section )11( -)\.-( Normes )spectates(.*)f(.*)Article \[97\]/\1II\2\3spéciales\4l\5\n\n(97)/' | \
    amend_error_in_article 97 lulle lutte | \
    amend_error_in_article 97 'A cette' 'À cette' | \
    amend_error_in_article 97 'eire réalise\..*$' 'être réalisé.' | \
    # Article 98
    amend_error_in_article 98 dintérêt "d'intérêt" | \
    # Article 99
    amend_error_in_article 99 environnemenrales environnementales | \
    amend_error_in_article 99 dessols 'des sols' | \
    # Article 100
    amend_error_in_article 100 'proprieraire concerne' 'propriétaire concerné' | \
    # Article 101
    amend_error_in_article 101 lajuridiction 'la juridiction' | \
    amend_error_in_article 101 'approprie dereboisement et\/oude' 'approprié de reboisement et\/ou de' | \
    amend_error_in_article 101 'concernésrecevront unejuste' 'concernés recevront une juste' | \
    # Article 102
    sed -E 's/^(Section III - Normes.*) Article 102,-/\1\n\n(102)/' | \
    amend_error_in_article 102 constitue constitué | \
    amend_error_in_article 102 'catégories\.on' 'catégories, on' | \
    amend_error_in_article 102 'cornmunales, C\.-' 'communales, [c]' | \
    amend_error_in_article 102 'privé,' 'privé.' | \
    # Article 103
    sed -E 's/^ticle \[103\]/(103)/' | \
    amend_error_in_article 103 rnodalites modalités | \
    # Article 104
    amend_error_in_article 104 gere géré | \
    amend_error_in_article 104 'ani males' animales | \
    amend_error_in_article 104 'au migratrices' 'ou migratrices' | \
    amend_error_in_article 104 parles 'par les' | \
    # Article 105
    sed -E 's/^Article 10S\.-/(105)/' | \
    amend_error_in_article 105 daménagement "d'aménagement" | \
    amend_error_in_article 105 élabore élaboré | \
    amend_error_in_article 105 "j'Environnement" "l'Environnement" | \
    amend_error_in_article 105 'avec res' 'avec les' | \
    amend_error_in_article 105 sanspréjudice 'sans préjudice' | \
    amend_error_in_article 105 droitsattachés 'droits attachés' | \
    # Article 106
    amend_error_in_article 106 ' Article lO8\.-' '\n\n(108)' | \
    amend_error_in_article 106 ', Article \[107\]' '.\n\n(107)' | \
    amend_error_in_article 106 intégranre intégrante | \
    amend_error_in_article 106 pnve privé | \
    amend_error_in_article 106 hauien haïtien | \
    # Article 107
    amend_error_in_article 107 conformêment conformément | \
    amend_error_in_article 107 Itla 'à la' | \
    amend_error_in_article 107 'évaluation·environnementale' 'évaluation environnementale' | \
    # Article 108
    amend_error_in_article 108 rninerales minérales | \
    amend_error_in_article 108 'compétentes,' 'compétentes.' | \
    amend_error_in_article 108 rnodalites modalités | \
    amend_error_in_article 108 'a soumettre' 'à soumettre' | \
    amend_error_in_article 108 ' No\..*$' '' | \
    # Article 110
    amend_error_in_article 110 'a usages' 'à usages' | \
    amend_error_in_article 110 aleur 'à leur' | \
    amend_error_in_article 110 'naturels au' 'naturels ou' | \
    # Article 112
    amend_error_in_article 112 'compose du domainepublic' 'composé du domaine public' | \
    amend_error_in_article 112 'nature!' naturel | \
    amend_error_in_article 112 '\[3\] les COUfS' '[a] les cours' | \
    amend_error_in_article 112 '~Huviales' alluviales | \
    amend_error_in_article 112 rninerales minérales | \
    amend_error_in_article 112 'ou passeiltO~l soot' 'où passent ou sont' | \
    amend_error_in_article 112 'appartenant a un' 'appartenant à un' | \
    amend_error_in_article 112 soot sont | \
    # Article 113
    amend_error_in_article 113 dornaine domaine | \
    amend_error_in_article 113 expressernent expressément | \
    amend_error_in_article 113 justifie justifié | \
    amend_error_in_article 113 accorde accordé | \
    amend_error_in_article 113 Interet intérêt | \
    # Article 114
    amend_error_in_article 114 dornaine domaine | \
    amend_error_in_article 114 gere géré | \
    # Article 116
    amend_error_in_article 116 11 Il | \
    amend_error_in_article 116 Initiative initiative | \
    amend_error_in_article 116 acelle 'à celle' | \
    amend_error_in_article 116 bassinsversants 'bassins-versants' | \
    amend_error_in_article 116 cquilibree équilibrée | \
    amend_error_in_article 116 ' 24.*$' '' | \
    # Article 117
    amend_error_in_article 117 'aquiculture ades' 'aquaculture à des' | \
    amend_error_in_article 117 ' ades ' ' à des ' | \
    amend_error_in_article 117 ' ades ' ' à des ' | \
    # Article 118
    amend_error_in_article 118 prélèvemenr prélèvement | \
    amend_error_in_article 118 effectue effectué | \
    amend_error_in_article 118 ledomaine 'le domaine' | \
    amend_error_in_article 118 line une | \
    # Article 119
    amend_error_in_article 119 'A cet' 'À cet' | \
    amend_error_in_article 119 '\[1\] II' '[1] il' | \
    amend_error_in_article 119 aune 'à une' | \
    amend_error_in_article 119 Irnpacts impacts | \
    amend_error_in_article 119 'au appui afournir' 'ou appui à fournir' | \
    # Article 120
    amend_error_in_article 120 rneme même | \
    amend_error_in_article 120 domainepublic 'domaine public' | \
    # Article 121
    amend_error_in_article 121 'déversernents, écoulernents' 'déversements, écoulements' | \
    amend_error_in_article 121 'provoquer au' 'provoquer ou' | \
    amend_error_in_article 121 'au maritimes' 'ou maritimes' | \
    # Article 122
    amend_error_in_article 122 révise révisé | \
    # Article 124
    amend_error_in_article 124 'préalablernent aleur' 'préalablement à leur' | \
    amend_error_in_article 124 vole voie | \
    # Article 125
    amend_error_in_article 125 ' ades ' ' à des ' | \
    amend_error_in_article 125 Iaboratoire laboratoire | \
    amend_error_in_article 125 "legouvernement ha'itien" 'le gouvernement haïtien' | \
    amend_error_in_article 125 aqui 'à qui' | \
    # Article 126
    amend_error_in_article 126 ' No\..*$' '' | \
    # Article 127
    amend_error_in_article 127 IIsera 'Il sera' | \
    amend_error_in_article 127 ' Ii ' ' à ' | \
    # Article 128
    amend_error_in_article 128 mtroduction introduction | \
    amend_error_in_article 128 'au indirecte' 'ou indirecte' | \
    amend_error_in_article 128 Incineration incinération | \
    amend_error_in_article 128 ' Ii ' ' à ' | \
    amend_error_in_article 128 "etd'entraver" "et d'entraver" | \
    amend_error_in_article 128 'maritimes\.y' 'maritimes, y' | \
    amend_error_in_article 128 daltérer "d'altérer" | \
    amend_error_in_article 128 Ics les | \
    # Article 129
    amend_error_in_article 129 ' Ii ' ' à ' | \
    amend_error_in_article 129 precedent précédent | \
    amend_error_in_article 129 'applicables\.aux' 'applicables aux' | \
    amend_error_in_article 129 paries 'par les' | \
    # Article 130
    amend_error_in_article 130 'capitaine au' 'capitaine ou' | \
    amend_error_in_article 130 'ason bard' 'à son bord' | \
    amend_error_in_article 130 'hydrocarbures au' 'hydrocarbures ou' | \
    amend_error_in_article 130 'obl igation' obligation | \
    amend_error_in_article 130 'a constituer' 'à constituer' | \
    # Article 131
    amend_error_in_article 131 'avaries au' 'avaries ou' | \
    amend_error_in_article 131 hartienne haïtienne | \
    amend_error_in_article 131 'engin au' 'engin ou' | \
    amend_error_in_article 131 Iison 'à son' | \
    amend_error_in_article 131 'hydrocarbures au' 'hydrocarbures ou' | \
    amend_error_in_article 131 hattien haïtien | \
    amend_error_in_article 131 ' it ' ' à ' | \
    # Article 132
    amend_error_in_article 132 etcombattre 'et combattre' | \
    amend_error_in_article 132 'règlementaire, CHAPITREVI DE' 'règlementaire.\n\nCHAPITRE VI - DE ' | \
    # Article 133
    amend_error_in_article 133 ' Ii ' ' à ' | \
    # Article 134
    amend_error_in_article 134 'acombustion au' 'à combustion ou' | \
    # Article 135
    amend_error_in_article 135 Hattien Haïtien | \
    # Article 136
    amend_error_in_article 136 ' Ii ' ' à ' | \
    amend_error_in_article 136 'la chargé' 'la charge' | \
    amend_error_in_article 136 notamrnent notamment | \
    amend_error_in_article 136 locaies locales | \
    # Article 137
    amend_error_in_article 137 'en chargé' 'en charge' | \
    # Article 138
    amend_error_in_article 138 ', Article 139,-' '.\n\n(139)' | \
    amend_error_in_article 138 ': 26.*2006' ':' | \
    amend_error_in_article 138 Iiste liste | \
    amend_error_in_article 138 végétates végétales | \
    amend_error_in_article 138 "bénéficierd'une" "bénéficier d'une" | \
    amend_error_in_article 138 particuiiere particulière | \
    amend_error_in_article 138 leurmilieu 'leur milieu' | \
    amend_error_in_article 138 precedent précédent | \
    amend_error_in_article 138 queUe quelle | \
    amend_error_in_article 138 'au aleurs' 'ou à leurs' | \
    amend_error_in_article 138 'particuliers\.' 'particuliers;' | \
    amend_error_in_article 138 'a des' 'à des' | \
    amend_error_in_article 138 'anirnaux Oil' 'animaux ou' | \
    amend_error_in_article 138 'règlementarion hailienne' 'règlementation haïtienne' | \
    # Article 139
    amend_error_in_article 139 delevage "d'élevage" | \
    amend_error_in_article 139 parle 'par le' | \
    # Article 140
    amend_error_in_article 140 denornme dénommé | \
    amend_error_in_article 140 avocationde 'à vocation de' | \
    amend_error_in_article 140 ' eet ' ' cet ' | \
    amend_error_in_article 140 'cornme ' 'comme ' | \
    amend_error_in_article 140 philosophic philosophie | \
    amend_error_in_article 140 cornmercants commerçants | \
    amend_error_in_article 140 'le marche' 'le marché' | \
    amend_error_in_article 140 prornouvoir promouvoir | \
    amend_error_in_article 140 educarifs éducatifs | \
    amend_error_in_article 140 atravers 'à travers' | \
    amend_error_in_article 140 'erarecommander aux aurorites' 'et à recommander aux autorités' | \
    amend_error_in_article 140 aatteindre 'à atteindre' | \
    amend_error_in_article 140 'rotalite des dcchers' 'totalité des déchets' | \
    amend_error_in_article 140 catégoric catégorie | \
    amend_error_in_article 140 comrnerciaux commerciaux | \
    amend_error_in_article 140 circonstancie circonstancié | \
    amend_error_in_article 140 Minisrere Ministère | \
    amend_error_in_article 140 'roures les dernandes' 'toutes les demandes' | \
    amend_error_in_article 140 'au ces labeks\)' 'ou ces label(s)' | \
    amend_error_in_article 140 'au régionaux' 'ou régionaux' | \
    amend_error_in_article 140 '27 I0\.-' '[10]' | \
    amend_error_in_article 140 'pource secteur danstoutes' 'pour ce secteur dans toutes' | \
    amend_error_in_article 140 'internationaux; Le' 'internationaux. Le' | \
    # Article 141
    amend_error_in_article 141 'mis it' 'mis à' | \
    # Article 142
    amend_error_in_article 142 cornme comme | \
    amend_error_in_article 142 ' it ' ' à ' | \
    amend_error_in_article 142 '30,000-habitants' '30,000 habitants' | \
    amend_error_in_article 142 parses 'par ses' | \
    amend_error_in_article 142 cornme comme | \
    amend_error_in_article 142 '; ,' ';' | \
    amend_error_in_article 142 'L-' '[i]' | \
    amend_error_in_article 142 parleurs 'par leurs' | \
    amend_error_in_article 142 mernbres membres | \
    amend_error_in_article 142 remplacerrient remplacement | \
    sed -E ':start;s/^(\(142\).*\] )([A-Z])/\1\L\2/;t start' | \
    # Article 144
    amend_error_in_article 144 suhstances substances | \
    # Article 145
    amend_error_in_article 145 édicte édicté | \
    # Article 146
    amend_error_in_article 146 ', 28.*$' '.' | \
    # Article 147
    amend_error_in_article 147 Strategic Stratégie | \
    # Article 148
    amend_error_in_article 148 SOliS sous | \
    # Article 149
    amend_error_in_article 149 'a risque' 'à risque' | \
    amend_error_in_article 149 ctimatique climatique | \
    amend_error_in_article 149 'la chargé' 'la charge' | \
    amend_error_in_article 149 aménagernent aménagement | \
    amend_error_in_article 149 'terri toire' territoire | \
    amend_error_in_article 149 aquelque 'à quelque' | \
    # Article 150
    amend_error_in_article 150 afferent afférent | \
    # Article 151
    amend_error_in_article 151 Minisrere Ministère | \
    amend_error_in_article 151 approprie approprié | \
    # Article 152
    amend_error_in_article 152 spécialise spécialisé | \
    amend_error_in_article 152 spécialise spécialisé | \
    amend_error_in_article 152 decoordination 'de coordination' | \
    amend_error_in_article 152 auniveau 'au niveau' | \
    # Article 153
    amend_error_in_article 153 'au de nuireala' 'ou de nuire à la' | \
    amend_error_in_article 153 'nature\.' 'nature,' | \
    amend_error_in_article 153 pénalernent pénalement | \
    # Article 154
    amend_error_in_article 154 conformêment conformément | \
    amend_error_in_article 154 règlemenraires règlementaires | \
    amend_error_in_article 154 aprotéger 'à protéger' | \
    amend_error_in_article 154 ' No\..*$' '' | \
    # Article 155
    amend_error_in_article 155 responsabilitépénaleexpose 'responsabilité pénale expose' | \
    amend_error_in_article 155 'auteurs,co-auteurset complicesdes' 'auteurs, co-auteurs et complices des' | \
    amend_error_in_article 155 proporttonnee proportionnée | \
    amend_error_in_article 155 '10\$' les | \
    amend_error_in_article 155 infractionsenvironnementaies 'infractions environnementales' | \
    amend_error_in_article 155 ' aIa ' ' à la ' | \
    amend_error_in_article 155 "avantl'infraction" "avant l'infraction" | \
    # Article 156
    amend_error_in_article 156 dornmage dommage | \
    amend_error_in_article 156 'caleuls de cofits' 'calculs de coûts' | \
    # Article 157
    amend_error_in_article 157 "a i'environnement" "à l'environnement" | \
    amend_error_in_article 157 'a leurs' 'à leurs' | \
    # Article 158
    amend_error_in_article 158 accèssoires accessoires | \
    amend_error_in_article 158 ', TITRE VI' '.\n\nTITRE VI -' | \
    # Article 160
    amend_error_in_article 160 "\\\'Environnement" "l'Environnement" | \
    amend_error_in_article 160 'approprie~s' appropriées | \
    # Article 161
    amend_error_in_article 161 etle 'et le' | \
    amend_error_in_article 161 gouvernernentale gouvernementale | \
    amend_error_in_article 161 ', TITRE VII' '.\n\nTITRE VII -' | \
    # Article 162
    amend_error_in_article 162 ' Donne au Palais.*$' '' | \
    amend_error_in_article 162 'publie et exécute' 'publié et exécuté' | \
    amend_error_in_article 162 'fa Planification' 'la Planification' | \
    amend_error_in_article 162 Deveioppement Développement | \
    amend_error_in_article 162 'et 30 du' 'et du'
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
    amend_errors_in_headers | \
    amend_errors_in_articles
}
