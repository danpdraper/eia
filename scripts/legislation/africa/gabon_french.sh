#!/bin/bash

function remove_all_text_before_first_title_header {
  sed -E 's/ (TITRE I)/\n\1/' | \
    sed -n '/^TITRE I/,$p'
}

function amend_errors_in_articles {
  local stdin="$(</dev/stdin)"

  local article_68_text="L'étude d'impact est un instrument d'analyse et de "
  article_68_text+="prévision qui vise à identifier, évaluer et éviter les "
  article_68_text+="incidences néfastes, directes et indirectes, des projets "
  article_68_text+="de travaux, ouvrages ou aménagements, sur la santé, la "
  article_68_text+="qualité de l'environnement, les ressources naturelles et "
  article_68_text+="les équilibres écologiques."

  echo "$stdin" | sed -E "s/I'/l'/g" | \
    sed -E 's/determiner/déterminer/g' | \
    sed -E 's/generaux/généraux/g' | \
    sed -E 's/matiere/matière/g' | \
    sed -E 's/amelioration/amélioration/g' | \
    sed -E 's/preservation/préservation/g' | \
    sed -E 's/generatrice/génératrice/g' | \
    sed -E 's/liee/liée/g' | \
    sed -E 's/presente/présente/g' | \
    sed -E 's/element/élément/g' | \
    sed -E 's/activite/activité/g' | \
    sed -E 's/interet/intérêt/g' | \
    sed -E 's/general/général/g' | \
    sed -E 's/preoccupation/préoccupation/g' | \
    sed -E 's/amenagement/aménagement/g' | \
    sed -E 's/perennite/pérennité/g' | \
    sed -E 's/equilibre/équilibre/g' | \
    sed -E 's/different/différent/g' | \
    sed -E 's/prevention/prévention/g' | \
    sed -E 's/ a la / à la /g' | \
    sed -E 's/realisation/réalisation/g' | \
    sed -E 's/creation/création/g' | \
    sed -E 's/approprie/approprié/g' | \
    sed -E 's/defense/défense/g' | \
    sed -E 's/collectivite/collectivité/g' | \
    sed -E 's/etablissement/établissement/g' | \
    sed -E 's/elaboration/élaboration/g' | \
    sed -E 's/execution/exécution/g' | \
    sed -E 's/modalite/modalité/g' | \
    sed -E 's/legal/légal/g' | \
    sed -E 's/edictee/édictée/g' | \
    sed -E 's/ocean/océan/g' | \
    sed -E 's/protegee/protégée/g' | \
    sed -E 's/souverainete/souveraineté/g' | \
    sed -E 's/prevenir/prévenir/g' | \
    sed -E 's/entrainer/entraîner/g' | \
    sed -E 's/sante/santé/g' | \
    sed -E 's/ ala / à la /g' | \
    sed -E 's/legitime/légitime/g' | \
    sed -E 's/constituee/constituée/g' | \
    sed -E 's/edifice/édifice/g' | \
    sed -E "s/ al'/ à l'/g" | \
    sed -E 's/etre/être/g' | \
    sed -E 's/facon/façon/g' | \
    sed -E 's/qualite/qualité/g' | \
    sed -E 's/defini/défini/g' | \
    sed -E 's/necessaire/nécessaire/g' | \
    sed -E 's/maniere/manière/g' | \
    sed -E 's/conformement/conformément/g' | \
    sed -E 's/reparer/réparer/g' | \
    sed -E 's/équilibree/équilibrée/g' | \
    sed -E 's/fixee/fixée/g' | \
    sed -E 's/evacuer/évacuer/g' | \
    sed -E 's/degradee/dégradée/g' | \
    sed -E 's/dechet/déchet/g' | \
    sed -E 's/residu/résidu/g' | \
    sed -E 's/evacuation/évacuation/g' | \
    sed -E 's/economique/économique/g' | \
    sed -E 's/econornique/économique/g' | \
    sed -E 's/regime/régime/g' | \
    sed -E 's/ecoulement/écoulement/g' | \
    sed -E 's/operation/opération/g' | \
    sed -E 's/execute/exécute/g' | \
    sed -E 's/prevu/prévu/g' | \
    sed -E 's/alinea/alinéa/g' | \
    sed -E 's/respectee/respectée/g' | \
    sed -E 's/geologique/géologique/g' | \
    sed -E 's/reglementaire/réglementaire/g' | \
    sed -E 's/carriere/carrière/g' | \
    sed -E 's/autorisee/autorisée/g' | \
    sed -E 's/erosion/érosion/g' | \
    sed -E 's/exces/excès/g' | \
    sed -E 's/auxdispositions/aux dispositions/g' | \
    sed -E 's/ainsiqu/ainsi qu/g' | \
    sed -E 's/conformernent/conformément/g' | \
    sed -E 's/developpernent/développement/g' | \
    sed -E 's/deposer/déposer/g' | \
    sed -E 's/deverser/déverser/g' | \
    sed -E 's/eparpiller/éparpiller/g' | \
    sed -E 's/textesen/textes en/g' | \
    sed -E 's/competent/compétent/g' | \
    sed -E 's/methode/méthode/g' | \
    sed -E 's/regeneration/régénération/g' | \
    sed -E 's/appelee/appelée/g' | \
    sed -E 's/destinee/destinée/g' | \
    sed -E 's/degradation/dégradation/g' | \
    sed -E 's/consecutive/consécutive/g' | \
    sed -E 's/reserve/réserve/g' | \
    sed -E 's/denaturer/dénaturer/g' | \
    sed -E 's/ecosysteme/écosystème/g' | \
    sed -E 's/vehicule/véhicule/g' | \
    sed -E 's/equiper/équiper/g' | \
    sed -E 's/reduire/réduire/g' | \
    sed -E 's/eviter/éviter/g' | \
    sed -E 's/cornpetent/compétent/g' | \
    sed -E 's/repartir/répartir/g' | \
    sed -E 's/consequence/conséquence/g' | \
    sed -E 's/quantite/quantité/g' | \
    sed -E 's/emettre/émettre/g' | \
    sed -E 's/au-dela/au-delà/g' | \
    sed -E 's/fumee/fumée/g' | \
    sed -E 's/poussiere/poussière/g' | \
    sed -E 's/geree/gérée/g' | \
    sed -E 's/necessite/nécessité/g' | \
    sed -E 's/genetique/génétique/g' | \
    sed -E 's/ecologique/écologique/g' | \
    sed -E 's/Ie/le/g' | \
    sed -E 's/lestextes/les textes/g' | \
    sed -E 's/prealable/préalable/g' | \
    sed -E 's/agrement/agrément/g' | \
    sed -E 's/batiment/bâtiment/g' | \
    sed -E 's/interieur/intérieur/g' | \
    sed -E 's/espece/espèce/g' | \
    sed -E 's/vegetale/végétale/g' | \
    sed -E 's/renforcee/renforcée/g' | \
    sed -E 's/reglementee/réglementée/g' | \
    sed -E 's/contormement/conformément/g' | \
    sed -E 's/auxtextes/aux textes/g' | \
    sed -E 's/jugee/jugée/g' | \
    sed -E 's/autorite/autorité/g' | \
    sed -E 's/presentant/présentant/g' | \
    sed -E 's/archeologique/archéologique/g' | \
    sed -E 's/esthetique/esthétique/g' | \
    sed -E 's/delimitee/délimitée/g' | \
    sed -E 's/erigee/érigée/g' | \
    sed -E 's/integrite/intégrité/g' | \
    sed -E 's/delimitation/délimitation/g' | \
    sed -E 's/legislati/législati/g' | \
    sed -E 's/airesprotégées/aires protégées/g' | \
    sed -E 's/n0/numéro/g' | \
    sed -E 's/deseaux/des eaux/g' | \
    sed -E 's/foret/forêt/g' | \
    sed -E 's/biosphere/biosphère/g' | \
    sed -E 's/vegetation/végétation/g' | \
    sed -E 's/beaute/beauté/g' | \
    sed -E 's/deteriorer/détériorer/g' | \
    sed -E 's/classee/classée/g' | \
    sed -E 's/sensde/sens de/g' | \
    sed -E 's/ministre charge/ministre chargé/g' | \
    sed -E 's/departement/département/g' | \
    sed -E 's/hygiene/hygiène/g' | \
    sed -E 's/salubrite/salubrité/g' | \
    sed -E 's/elimination/élimination/g' | \
    sed -E 's/dansles/dans les/g' | \
    sed -E 's/eliminer/éliminer/g' | \
    sed -E 's/recuperation/récupération/g' | \
    sed -E 's/reutilisation/réutilisation/g' | \
    sed -E 's/implantee/implantée/g' | \
    sed -E 's/control/contrôl/g' | \
    sed -E 's/contrôlee/contrôlée/g' | \
    sed -E 's/contormernent/conformément/g' | \
    sed -E 's/vigueuret/vigueur et/g' | \
    sed -E 's/vuede/vue de/g' | \
    sed -E 's/generat/générat/g' | \
    sed -E 's/presents loi/présente loi/g' | \
    sed -E 's/soitsoumis/soit soumis/g' | \
    sed -E 's/aautorisation/à autorisation/g' | \
    sed -E 's/precaution/précaution/g' | \
    sed -E 's/unite/unité/g' | \
    sed -E 's/concernee/concernée/g' | \
    sed -E 's/epuration/épuration/g' | \
    sed -E 's/repand/répand/g' | \
    sed -E 's/intensite/intensité/g' | \
    sed -E 's/depass/dépass/g' | \
    sed -E 's/prevoi/prévoi/g' | \
    sed -E 's/systeme/système/g' | \
    sed -E 's/privee/privée/g' | \
    sed -E 's/etabli/établi/g' | \
    sed -E 's/inconvenient/inconvénient/g' | \
    sed -E 's/commodite/commodité/g' | \
    sed -E 's/declaration/déclaration/g' | \
    sed -E 's/obei/obéi/g' | \
    sed -E 's/reglementation/réglementation/g' | \
    sed -E 's/accordee/accordée/g' | \
    sed -E 's/apres/après/g' | \
    sed -E 's/etud/étud/g' | \
    sed -E 's/effectuee/effectuée/g' | \
    sed -E 's/proprietaire/propriétaire/g' | \
    sed -E 's/preven/préven/g' | \
    sed -E 's/causee/causée/g' | \
    sed -E 's/entree/entrée/g' | \
    sed -E 's/delai/délai/g' | \
    sed -E 's/degre/degré/g' | \
    sed -E 's/facade/façade/g' | \
    sed -E 's/ministere/ministère/g' | \
    sed -E 's/habilite/habilité/g' | \
    sed -E 's/apprecie/apprécie/g' | \
    sed -E 's/realite/réalité/g' | \
    sed -E 's/realise/réalise/g' | \
    sed -E 's/decoul/découl/g' | \
    sed -E 's/decoup/découp/g' | \
    sed -E 's/affectee/affectée/g' | \
    sed -E 's/depot/dépôt/g' | \
    sed -E 's/agglomeration/agglomération/g' | \
    sed -E 's/evolution/évolution/g' | \
    sed -E 's/nauseabonde/nauséabonde/g' | \
    sed -E 's/supprimee/supprimée/g' | \
    sed -E 's/atmospherique/atmosphérique/g' | \
    sed -E 's/precis/précis/g' | \
    sed -E 's/epais/épais/g' | \
    sed -E 's/buee/buée/g' | \
    sed -E 's/general/général/g' | \
    sed -E 's/emanation/émanation/g' | \
    sed -E 's/etat/état/g' | \
    sed -E 's/penal/pénal/g' | \
    sed -E 's/attenuer/atténuer/g' | \
    sed -E 's/nefast/néfast/g' | \
    sed -E 's/capacite/capacité/g' | \
    sed -E 's/recepteu/récepteu/g' | \
    sed -E 's/severe/sévère/g' | \
    sed -E 's/region/région/g' | \
    sed -E 's/exposee/exposée/g' | \
    sed -E 's/reseau/réseau/g' | \
    sed -E 's/categorie/catégorie/g' | \
    sed -E 's/publicite/publicité/g' | \
    sed -E 's/delivrance/délivrance/g' | \
    sed -E 's/portee/portée/g' | \
    sed -E 's/duree/durée/g' | \
    sed -E 's/utilisee/utilisée/g' | \
    sed -E 's/reguli/réguli/g' | \
    sed -E 's/verifier/vérifier/g' | \
    sed -E 's/priorite/priorité/g' | \
    sed -E 's/procedure/procédure/g' | \
    sed -E 's/adaptee/adaptée/g' | \
    sed -E 's/etant/étant/g' | \
    sed -E 's/imperative/impérative/g' | \
    sed -E 's/operat/opérat/g' | \
    sed -E 's/constatee/constatée/g' | \
    sed -E "s/a l'article/à l'article/g" | \
    sed -E 's/competence/compétence/g' | \
    sed -E 's/special/spécial/g' | \
    sed -E 's/requete/requête/g' | \
    sed -E 's/validite/validité/g' | \
    sed -E 's/proceder/procéder/g' | \
    sed -E 's/enquete/enquête/g' | \
    sed -E 's/prelev/prélèv/g' | \
    sed -E 's/requerir/requérir/g' | \
    sed -E 's/proces-/procès-/g' | \
    sed -E "s/jusqu'a /jusqu'à /g" | \
    sed -E 's/immediate/immédiate/g' | \
    sed -E 's/reclam/réclamation/g' | \
    sed -E 's/examinee/examinée/g' | \
    sed -E 's/fondee/fondée/g' | \
    sed -E 's/prejudice/préjudice/g' | \
    sed -E 's/prerogati/prérogati/g' | \
    sed -E 's/rninistere/ministère/g' | \
    sed -E 's/eventuel/éventuel/g' | \
    sed -E 's/debut/début/g' | \
    sed -E 's/regle/règle/g' | \
    sed -E 's/emission/émission/g' | \
    sed -E 's/remission/rémission/g' | \
    sed -E 's/meconnaissance/méconnaissance/g' | \
    sed -E 's/articles([0-9]+)/articles \1/g' | \
    sed -E 's/alterer/altérer/g' | \
    sed -E 's/prononcee/prononcée/g' | \
    # Article 1
    amend_error_in_article 1 pourobjetde 'pour objet de' | \
    amend_error_in_article 1 'notamment a' 'notamment à' | \
    amend_error_in_article 1 naturelies naturelles | \
    amend_error_in_article 1 arnelloration amélioration | \
    amend_error_in_article 1 actvites activités | \
    amend_error_in_article 1 avecla 'avec la' | \
    # Article 2
    amend_error_in_article 2 lemilieu 'le milieu' | \
    amend_error_in_article 2 'lebien-être' 'le bien-être' | \
    # Article 3
    amend_error_in_article 3 "pourl'ensemble" "pour l'ensemble" | \
    amend_error_in_article 3 droitset 'droits et' | \
    amend_error_in_article 3 arnelioration amélioration | \
    amend_error_in_article 3 'unémission' 'une mission' | \
    amend_error_in_article 3 'a prendre' 'à prendre' | \
    amend_error_in_article 3 systernatlquernent systématiquement | \
    # Article 4
    amend_error_in_article 4 "definis al'article" "définis à l'article" | \
    amend_error_in_article 4 'la miseen' 'la mise en' | \
    amend_error_in_article 4 'unepolitique' 'une politique' | \
    amend_error_in_article 4 "afind'en garantirla" "afin d'en garantir la" | \
    amend_error_in_article 4 'pérennité:' 'pérennité;' | \
    amend_error_in_article 4 lemaintien 'le maintien' | \
    amend_error_in_article 4 'lesdifférents' 'les différents' | \
    amend_error_in_article 4 inteqrant intégrant | \
    amend_error_in_article 4 nonpolluants 'non polluants' | \
    amend_error_in_article 4 arnenaqernent aménagement | \
    amend_error_in_article 4 privlleqiant privilégiant | \
    amend_error_in_article 4 '\[5\]de' '[5] de' | \
    amend_error_in_article 4 devulqarisatton 'de vulgarisation' | \
    # Article 5
    amend_error_in_article 5 rEtat "l'État" | \
    amend_error_in_article 5 'visesci-dessus' 'visés ci-dessus' | \
    amend_error_in_article 5 "al'élaboration" "à l'élaboration" | \
    amend_error_in_article 5 "al'exécution" "à l'exécution" | \
    amend_error_in_article 5 n§glementaires réglementaires | \
    amend_error_in_article 5 ' TITRE' '\n\nTITRE' | \
    # Article 6
    amend_error_in_article 6 Sontqualities 'Sont qualifiés' | \
    amend_error_in_article 6 natureliesau 'naturelles au' | \
    amend_error_in_article 6 'loi,les' 'loi, les' | \
    amend_error_in_article 6 merset 'mers et' | \
    amend_error_in_article 6 lesol 'le sol' | \
    amend_error_in_article 6 "-l'air" "[•] l'air" | \
    amend_error_in_article 6 fauneet 'faune et' | \
    amend_error_in_article 6 ' Chapitre' '\n\nChapitre' | \
    # Article 7
    amend_error_in_article 7 océanlque océanique | \
    amend_error_in_article 7 'construepar: \.' 'constitué par:' | \
    amend_error_in_article 7 'places sous la' 'placés sous la' | \
    amend_error_in_article 7 'juridietion nationale\.' 'juridiction nationale,' | \
    amend_error_in_article 7 leursressources 'leurs ressources' | \
    amend_error_in_article 7 nonbiologiques 'non biologiques' | \
    # Article 8
    amend_error_in_article 8 actessusceptibles 'actes susceptibles' | \
    amend_error_in_article 8 porteratteinte 'porter atteinte' | \
    amend_error_in_article 8 pollatlon pollution | \
    amend_error_in_article 8 aqrernent agrément | \
    amend_error_in_article 8 ' Chapitre' '\n\nChapitre' | \
    # Article 9
    amend_error_in_article 9 eauxsouterraines 'eaux souterraines' | \
    amend_error_in_article 9 'litset les rivesdes' 'lits et les rives des' | \
    amend_error_in_article 9 ecosystsmes écosystèmes | \
    amend_error_in_article 9 trouveou 'trouve ou' | \
    # Article 10
    amend_error_in_article 10 Leseaux 'Les eaux' | \
    amend_error_in_article 10 "tellesqu'elles sontdéfinies" "telles qu'elles sont définies" | \
    amend_error_in_article 10 'gerE~es' gérées | \
    amend_error_in_article 10 equllioree équilibrée | \
    amend_error_in_article 10 leurqualité 'leur qualité' | \
    amend_error_in_article 10 "de !'industrie" "de l'industrie" | \
    amend_error_in_article 10 toutesautres 'toutes autres' | \
    amend_error_in_article 10 gEmeral général | \
    # Article 11
    amend_error_in_article 11 Pourprévenir 'Pour prévenir' | \
    amend_error_in_article 11 luttercontre 'lutter contre' | \
    amend_error_in_article 11 leministre 'le ministre' | \
    amend_error_in_article 11 'a:.' 'à:' | \
    amend_error_in_article 11 systematiquernent systématiquement | \
    amend_error_in_article 11 leseaux 'les eaux' | \
    amend_error_in_article 11 'etabllr leurdegréde' 'établir leur degré de' | \
    amend_error_in_article 11 'etabllrla Iistedes' 'établir la liste des' | \
    amend_error_in_article 11 prsatable préalable | \
    amend_error_in_article 11 'règlernentaires edidees' 'réglementaires édictées' | \
    amend_error_in_article 11 aautorisation 'à autorisation' | \
    amend_error_in_article 11 'lestravaux de prospedion' 'les travaux de prospection' | \
    amend_error_in_article 11 'destinées aprévenir, amitiger' 'destinées à prévenir, à mitiger' | \
    amend_error_in_article 11 'lecasecheant, a' 'le cas échéant, à' | \
    amend_error_in_article 11 unepolitique 'une politique' | \
    amend_error_in_article 11 'detellesorte quesoitrespectée' 'de telle sorte que soit respectée' | \
    amend_error_in_article 11 capadtede 'capacité de' | \
    amend_error_in_article 11 'desstocks dans lesconditions' 'des stocks dans les conditions' | \
    amend_error_in_article 11 'parles textes' 'par les textes' | \
    # Article 12
    amend_error_in_article 12 dejeter 'de jeter' | \
    amend_error_in_article 12 eauxde 'eaux de' | \
    amend_error_in_article 12 'produit If\\' produit | \
    amend_error_in_article 12 "alnsiqu'a" "ainsi qu'à" | \
    amend_error_in_article 12 'entraînerdes nsques' 'entraîner des risques' | \
    amend_error_in_article 12 'pourla santéque' 'pour la santé que' | \
    amend_error_in_article 12 'precede a' 'procédé à' | \
    amend_error_in_article 12 "a l'injection" "à l'injection" | \
    amend_error_in_article 12 autreproduit 'autre produit' | \
    amend_error_in_article 12 leseauxsoumises 'les eaux soumises' | \
    amend_error_in_article 12 "a l'exploitation des adivites" "à l'exploitation des activités" | \
    amend_error_in_article 12 qualitédes 'qualité des' | \
    amend_error_in_article 12 aune 'à une' | \
    amend_error_in_article 12 'serontdefinles par vole' 'seront définies par voie' | \
    amend_error_in_article 12 'reqlementaire, Chapitre' 'réglementaire.\n\nChapitre' | \
    # Article 13
    amend_error_in_article 13 "\\\'utilisation" "l'utilisation" | \
    amend_error_in_article 13 rninerales minérales | \
    # Article 14
    amend_error_in_article 14 'agricolas at' 'agricoles et' | \
    amend_error_in_article 14 'mineset' 'mines et' | \
    amend_error_in_article 14 pedeclimatiques pédoclimatiques | \
    amend_error_in_article 14 Lesutilisateurs 'Les utilisateurs' | \
    amend_error_in_article 14 'desterrains aquelque' 'des terrains à quelque' | \
    amend_error_in_article 14 titrequece 'titre que ce' | \
    amend_error_in_article 14 soitdoiventexécuter 'soit doivent exécuter' | \
    amend_error_in_article 14 cornpetents compétents | \
    amend_error_in_article 14 hurnidite humidité | \
    amend_error_in_article 14 catamite calamité | \
    # Article 15
    amend_error_in_article 15 'déchetsde résidua' 'déchets de résidus' | \
    amend_error_in_article 15 touteautresubstance 'toute autre substance' | \
    amend_error_in_article 15 lesol 'le sol' | \
    amend_error_in_article 15 ceuxexclusivement 'ceux exclusivement' | \
    amend_error_in_article 15 'acet effetpar' 'à cet effet par' | \
    # Article 16
    amend_error_in_article 16 "sonttenusd'en" "sont tenus d'en" | \
    amend_error_in_article 16 faireusagede 'faire usage de' | \
    amend_error_in_article 16 pourcombattre 'pour combattre' | \
    amend_error_in_article 16 lesmaladies 'les maladies' | \
    amend_error_in_article 16 lesanimaux 'les animaux' | \
    amend_error_in_article 16 pourfavoriser 'pour favoriser' | \
    # Article 17
    amend_error_in_article 17 aeffets 'à effets' | \
    amend_error_in_article 17 admisepar 'admise par' | \
    amend_error_in_article 17 ', Article \[18\]-' '.\n\n(18)' | \
    # Article 18
    amend_error_in_article 18 entrelevolume 'entre le volume' | \
    amend_error_in_article 18 levolume 'le volume' | \
    amend_error_in_article 18 'aêtre exploltees:' 'à être exploitées;' | \
    amend_error_in_article 18 'a prévenir' 'à prévenir' | \
    amend_error_in_article 18 stabllite stabilité | \
    # Article 19
    amend_error_in_article 19 '\. ou toute autresubstance' ', ou toute autre substance' | \
    amend_error_in_article 19 ' Chapitre' '\n\nChapitre' | \
    # Article 20
    amend_error_in_article 20 quallte qualité | \
    amend_error_in_article 20 "l'aircontre touteforme" "l'air contre toute forme" | \
    amend_error_in_article 20 'santéet au cadrebati' 'santé et au cadre bâti' | \
    amend_error_in_article 20 amoteurs 'à moteurs' | \
    amend_error_in_article 20 'aréduire ou a éviterla' 'à réduire ou à éviter la' | \
    amend_error_in_article 20 '"air' "l'air" | \
    amend_error_in_article 20 precedes procédés | \
    amend_error_in_article 20 afinde 'afin de' | \
    amend_error_in_article 20 poiluants polluants | \
    amend_error_in_article 20 '\[3\]atoutagentéconomique' '[3] à tout agent économique' | \
    amend_error_in_article 20 "d'éviterd'émettre dansl'air" "d'éviter d'émettre dans l'air" | \
    amend_error_in_article 20 desseuilsréglementaires 'des seuils réglementaires' | \
    amend_error_in_article 20 telleque 'telle que' | \
    amend_error_in_article 20 lesgazstoxiques 'les gaz toxiques' | \
    # Article 21
    amend_error_in_article 21 "Destextesd'application" "Des textes d'application" | \
    amend_error_in_article 21 prisenvertudela 'pris en vertu de la' | \
    amend_error_in_article 21 loipréciserom 'loi préciseront' | \
    amend_error_in_article 21 'demise en vigueurde' 'de mise en vigueur de' | \
    amend_error_in_article 21 ' Chapitre' '\n\nChapitre' | \
    # Article 22
    amend_error_in_article 22 equilioree équilibrée | \
    amend_error_in_article 22 "d'evlterleursurexploitation" "d'éviter leur surexploitation" | \
    amend_error_in_article 22 leurextinction 'leur extinction' | \
    amend_error_in_article 22 lepatrimoine 'le patrimoine' | \
    amend_error_in_article 22 'le maintien' 'le maintien' | \
    # Article 23
    amend_error_in_article 23 Lesactivités 'Les activités' | \
    amend_error_in_article 23 mlnleres minières | \
    amend_error_in_article 23 ouautres 'ou autres' | \
    amend_error_in_article 23 'alafaune etalaflore' 'à la faune et à la flore' | \
    amend_error_in_article 23 ladestruction 'la destruction' | \
    amend_error_in_article 23 sontsoit 'sont soit' | \
    amend_error_in_article 23 'a autorisation' 'à autorisation' | \
    amend_error_in_article 23 'parles textes' 'par les textes' | \
    amend_error_in_article 23 lesdispositions 'les dispositions' | \
    # Article 24
    amend_error_in_article 24 "Envued'assurer lesconditions" "En vue d'assurer les conditions" | \
    amend_error_in_article 24 "dutourisme, del'embellissement" "du tourisme, de l'embellissement" | \
    amend_error_in_article 24 'arneloranon de laqualité' 'amélioration de la qualité' | \
    amend_error_in_article 24 lesespaces 'les espaces' | \
    amend_error_in_article 24 'auxalentours des localtes' 'aux alentours des localités' | \
    amend_error_in_article 24 êtrearnenaqes 'être aménagés' | \
    amend_error_in_article 24 auxplans 'aux plans' | \
    # Article 25
    amend_error_in_article 25 'anima\/es' animales | \
    amend_error_in_article 25 rnenacees menacées | \
    amend_error_in_article 25 'au leur exportation' 'ou leur exportation' | \
    amend_error_in_article 25 'a autorisation' 'à autorisation' | \
    amend_error_in_article 25 leursmilieux 'leurs milieux' | \
    # Article 26
    amend_error_in_article 26 'vegeta\/es' végétales | \
    amend_error_in_article 26 cornpetemes compétentes | \
    amend_error_in_article 26 étantsusceptibles 'étant susceptibles' | \
    amend_error_in_article 26 auxespèces 'aux espèces' | \
    amend_error_in_article 26 'au végétales' 'ou végétales' | \
    amend_error_in_article 26 'soitinterdite, soit soumisea' 'soit interdite, soit soumise à' | \
    amend_error_in_article 26 ' Chapitre' '\n\nChapitre' | \
    # Article 27
    amend_error_in_article 27 consttuee constituée | \
    amend_error_in_article 27 pointde 'point de' | \
    amend_error_in_article 27 'sccio-économique' 'socio-économique' | \
    amend_error_in_article 27 préserves préservée | \
    # Article 28
    amend_error_in_article 28 sousdiverses 'sous diverses' | \
    amend_error_in_article 28 'pares nationaux, pares naturels' 'parcs nationaux, parcs naturels' | \
    amend_error_in_article 28 'telsquedéfinis auxarticles' 'tels que définis aux articles' | \
    amend_error_in_article 28 a40 'à 40' | \
    amend_error_in_article 28 1982dite '1982 dite' | \
    amend_error_in_article 28 'eauxet forêts:' 'eaux et forêts;' | \
    amend_error_in_article 28 'pares marins' 'parcs marins' | \
    amend_error_in_article 28 oonstituees constituées | \
    amend_error_in_article 28 voiede 'voie de' | \
    # Article 29
    amend_error_in_article 29 proteqer protéger | \
    amend_error_in_article 29 menerala 'mener à la' | \
    amend_error_in_article 29 lafauneet 'la faune et' | \
    amend_error_in_article 29 saufautorisation 'sauf autorisation' | \
    # Article 30
    amend_error_in_article 30 'laprésente loi,lestermes' 'la présente loi, les termes' | \
    amend_error_in_article 30 touslesfacteurs 'tous les facteurs' | \
    amend_error_in_article 30 poureffetou 'pour effet ou' | \
    amend_error_in_article 30 "sesceptioles d'avoirpoureffetde" "susceptibles d'avoir pour effet de" | \
    amend_error_in_article 30 lespopulations 'les populations' | \
    amend_error_in_article 30 aqreables agréables | \
    # Article 31
    amend_error_in_article 31 'ci-c!essus' 'ci-dessus' | \
    amend_error_in_article 31 êtreconsideres 'être considérés' | \
    amend_error_in_article 31 '-les' '[•] les' | \
    amend_error_in_article 31 lurnieres lumières | \
    amend_error_in_article 31 ' Chapitre' '\n\nChapitre' | \
    # Article 32
    amend_error_in_article 32 consideres considérés | \
    amend_error_in_article 32 pourson 'pour son' | \
    amend_error_in_article 32 rnenaqeres ménagères | \
    # Article 33
    amend_error_in_article 33 'rnlnisteriels interesses' 'ministériels intéressés' | \
    amend_error_in_article 33 etabllssements établissements | \
    # Article 34
    amend_error_in_article 34 Lesmesures 'Les mesures' | \
    amend_error_in_article 34 '33ci-dessus' '33 ci-dessus' | \
    amend_error_in_article 34 afixerlesconditions 'à fixer les conditions' | \
    # Article 35
    amend_error_in_article 35 rejetdans 'rejet dans' | \
    amend_error_in_article 35 qualitéde 'qualité de' | \
    amend_error_in_article 35 soitinterdit 'soit interdit' | \
    amend_error_in_article 35 soumisà 'soumis à' | \
    amend_error_in_article 35 fxees fixées | \
    # Article 36
    amend_error_in_article 36 decnets déchets | \
    amend_error_in_article 36 rnniere minière | \
    amend_error_in_article 36 'collsctes, rarnasses, traites' 'collectés, ramassés, traités' | \
    amend_error_in_article 36 'a éliminer ou a réduire' 'à éliminer ou à réduire' | \
    amend_error_in_article 36 'leurseffets nocifssur' 'leurs effets nocifs sur' | \
    # Article 37
    amend_error_in_article 37 letri 'le tri' | \
    amend_error_in_article 37 lestockaqo 'le stockage' | \
    amend_error_in_article 37 letransport 'le transport' | \
    amend_error_in_article 37 eliminatlon élimination | \
    amend_error_in_article 37 'déchetsdoiventêtre assures' 'déchets doivent être assurés' | \
    # Article 38
    amend_error_in_article 38 Lesdecharqes 'Les décharges' | \
    amend_error_in_article 38 déchetsdoiventêtreimplantées 'déchets doivent être implantées' | \
    amend_error_in_article 38 arnenaqees aménagées | \
    amend_error_in_article 38 'rnaniere a' 'manière à' | \
    amend_error_in_article 38 'a reouire' 'à réduire' | \
    amend_error_in_article 38 '\\a santé' 'la santé' | \
    amend_error_in_article 38 'fa présente' 'la présente' | \
    # Article 39
    amend_error_in_article 39 lesquantités 'les quantités' | \
    amend_error_in_article 39 activltes activités | \
    amend_error_in_article 39 lerecours 'le recours' | \
    amend_error_in_article 39 encourage encouragé | \
    amend_error_in_article 39 ' Chapitre' '\n\nChapitre' | \
    # Article 40
    amend_error_in_article 40 rnatieres matières | \
    amend_error_in_article 40 'nocvite, la toxlcite' 'nocivité, la toxicité' | \
    amend_error_in_article 40 'a nuire afa' 'à nuire à la' | \
    amend_error_in_article 40 quahte qualité | \
    amend_error_in_article 40 prisesen 'prises en' | \
    # Article 41
    amend_error_in_article 41 Iiste liste | \
    amend_error_in_article 41 letransport 'le transport' | \
    amend_error_in_article 41 lerejetdanslemilieu 'le rejet dans le milieu' | \
    amend_error_in_article 41 sontsoitinterdits 'sont soit interdits' | \
    amend_error_in_article 41 soumisà 'soumis à' | \
    amend_error_in_article 41 'rnodaltes c:le contr61e' 'modalités de contrôle' | \
    amend_error_in_article 41 'a prendre' 'à prendre' | \
    # Article 42
    amend_error_in_article 42 chargéde 'chargé de' | \
    amend_error_in_article 42 unitésconcernées 'unités concernées' | \
    # Article 43
    amend_error_in_article 43 oepassantles 'dépassant les' | \
    amend_error_in_article 43 ' Chapitre' '\n\nChapitre' | \
    # Article 44
    amend_error_in_article 44 Ilest 'Il est' | \
    amend_error_in_article 44 bruitsayantdes 'bruits ayant des' | \
    amend_error_in_article 44 'lesseuils fixespar' 'les seuils fixés par' | \
    amend_error_in_article 44 'normeslecales ou reclernentaires' 'normes légales ou réglementaires' | \
    # Article 45
    amend_error_in_article 45 prives privés | \
    amend_error_in_article 45 'equipes, exploites, utilises' 'équipés, exploités, utilisés' | \
    amend_error_in_article 45 'rnaniere asupprimerou aréduire' 'manière à supprimer ou à réduire' | \
    amend_error_in_article 45 bruitset 'bruits et' | \
    amend_error_in_article 45 causentou 'causent ou' | \
    amend_error_in_article 45 'suscept\\bles' susceptibles | \
    amend_error_in_article 45 intenslte intensité | \
    amend_error_in_article 45 nuireala 'nuire à la' | \
    amend_error_in_article 45 porteratteinte 'porter atteinte' | \
    amend_error_in_article 45 qualitéde 'qualité de' | \
    amend_error_in_article 45 conformament conformément | \
    # Article 46
    amend_error_in_article 46 anepasdépasser 'à ne pas dépasser' | \
    amend_error_in_article 46 'lessystèmes demesure' 'les systèmes de mesure' | \
    amend_error_in_article 46 'lesmoyens de contr61e' 'les moyens de contrôle' |
    amend_error_in_article 46 'amettre enoeuvre' 'à mettre en oeuvre' | \
    amend_error_in_article 46 'assurerle' 'assurer le' | \
    amend_error_in_article 46 ' Chapitre' '\n\nChapitre' | \
    # Article 47
    amend_error_in_article 47 rninieres minières | \
    # Article 48
    amend_error_in_article 48 'a autorisation' 'à autorisation' | \
    amend_error_in_article 48 gravespour 'graves pour' | \
    amend_error_in_article 48 adéclaration 'à déclaration' | \
    amend_error_in_article 48 aoreee agréée | \
    amend_error_in_article 48 'lieude leurimplantation, obéirala' 'lieu de leur implantation, obéir à la' | \
    amend_error_in_article 48 gimerale générale | \
    amend_error_in_article 48 cornmodite commodité | \
    # Article 49
    amend_error_in_article 49 estaccordée 'est accordée' | \
    amend_error_in_article 49 "étuded'impact" "étude d'impact" | \
    amend_error_in_article 49 a71 'à 71' | \
    # Article 50
    amend_error_in_article 50 dassees classées | \
    amend_error_in_article 50 sonttenuesde 'sont tenues de' | \
    amend_error_in_article 50 "del'article" "de l'article" | \
    amend_error_in_article 50 pourprévenr 'pour prévenir' | \
    amend_error_in_article 50 lespollutions 'les pollutions' | \
    # Article 51
    amend_error_in_article 51 lorsde 'lors de' | \
    amend_error_in_article 51 'a ses' 'à ses' | \
    amend_error_in_article 51 'rnodalites fixéespar' 'modalités fixées par' | \
    amend_error_in_article 51 prisespour 'prises pour' | \
    # Article 52
    amend_error_in_article 52 destine destiné | \
    amend_error_in_article 52 "aassurer l'alertedes" "à assurer l'alerte des" | \
    amend_error_in_article 52 afaciliter 'à faciliter' | \
    amend_error_in_article 52 'apermettre la miseen' 'à permettre la mise en' | \
    amend_error_in_article 52 acirconscrire 'à circonscrire' | \
    amend_error_in_article 52 ' Chapitre' '\n\nChapitre' | \
    # Article 53
    amend_error_in_article 53 environnemntale environnementale | \
    amend_error_in_article 53 tendanta 'tendant à' | \
    amend_error_in_article 53 'a quelque' 'à quelque' | \
    amend_error_in_article 53 'soient\.' 'soient,' | \
    amend_error_in_article 53 Iieux lieux | \
    # Article 54
    amend_error_in_article 54 charge chargé | \
    amend_error_in_article 54 dement dûment | \
    amend_error_in_article 54 ledegréde 'le degré de' | \
    # Article 55
    amend_error_in_article 55 assurerla 'assurer la' | \
    amend_error_in_article 55 'faitobligation atoute' 'fait obligation à toute' | \
    amend_error_in_article 55 '\[1\]de' '[1] de' | \
    amend_error_in_article 55 réaliserdes 'réaliser des' | \
    amend_error_in_article 55 lesplanscadastraux 'les plans cadastraux' | \
    amend_error_in_article 55 lerespect 'le respect' | \
    amend_error_in_article 55 "reqlesd'urbanisme" "règles d'urbanisme" | \
    amend_error_in_article 55 combattretoutes 'combattre toutes' | \
    amend_error_in_article 55 aussibien 'aussi bien' | \
    amend_error_in_article 55 'activltes econornlques' 'activités économiques' | \
    amend_error_in_article 55 socialesque 'sociales que' | \
    amend_error_in_article 55 déterminerrationnellement 'déterminer rationnellement' | \
    amend_error_in_article 55 découpaqes découpages | \
    amend_error_in_article 55 "d'habitatou" "d'habitat ou" | \
    amend_error_in_article 55 dépôtspour 'dépôts pour' | \
    amend_error_in_article 55 déchetset 'déchets et' | \
    amend_error_in_article 55 deqradeeset 'dégradées et' | \
    amend_error_in_article 55 ' Chapitre' '\n\nChapitre' | \
    # Article 56
    amend_error_in_article 56 odeursnauséabondes 'odeurs nauséabondes' | \
    amend_error_in_article 56 doiventêtre 'doivent être' | \
    amend_error_in_article 56 mesuredu 'mesure du' | \
    # Article 58
    amend_error_in_article 58 "prévuesal'article" "prévues à l'article" | \
    amend_error_in_article 58 caracterisriques caractéristiques | \
    amend_error_in_article 58 équipernents équipements | \
    amend_error_in_article 58 autorises autorisés | \
    amend_error_in_article 58 decharqes décharges | \
    amend_error_in_article 58 "d'émettredes" "d'émettre des" | \
    amend_error_in_article 58 odeursnauséabondes 'odeurs nauséabondes' | \
    amend_error_in_article 58 ' Chapitre' '\n\nChapitre' | \
    # Article 59
    amend_error_in_article 59 furneesépaisses 'fumées épaisses' | \
    amend_error_in_article 59 cornmodite commodité | \
    amend_error_in_article 59 ' Article \[60\]-' '\n\n(60)' | \
    amend_error_in_article 59 ' Chapitre' '\n\nChapitre' | \
    # Article 60
    amend_error_in_article 60 'a rayonnements' 'à rayonnements' | \
    # Article 61
    amend_error_in_article 61 naturedes 'nature des' | \
    amend_error_in_article 61 rayonnements 'rayonnements.\n' | \
    # Article 62
    amend_error_in_article 62 autresfacteursde 'autres facteurs de' | \
    amend_error_in_article 62 soumisaux 'soumis aux' | \
    amend_error_in_article 62 techniqueet 'technique et' | \
    amend_error_in_article 62 a93 'à 93' | \
    amend_error_in_article 62 ' Chapitre' '\n\nChapitre' | \
    # Article 63
    amend_error_in_article 63 prisesen 'prises en' | \
    amend_error_in_article 63 'normesarespecterpour' 'normes à respecter pour' | \
    amend_error_in_article 63 assurerle 'assurer le' | \
    amend_error_in_article 63 qualitéde 'qualité de' | \
    amend_error_in_article 63 '111 2 ' '' | \
    amend_error_in_article 63 'equloements destines' 'équipements destinés' | \
    amend_error_in_article 63 'aanalyser, aprévenir' 'à analyser, à prévenir' | \
    amend_error_in_article 63 'aatténuer et aéliminer' 'à atténuer et à éliminer' | \
    amend_error_in_article 63 "a l'environnement" "à l'environnement" | \
    amend_error_in_article 63 objetdes 'objet des' | \
    amend_error_in_article 63 impad impact | \
    amend_error_in_article 63 "plansd'urgence amettre" "plans d'urgence à mettre" | \
    # Article 64
    amend_error_in_article 64 sontflxees 'sont fixées' | \
    amend_error_in_article 64 tenantcompte 'tenant compte' | \
    amend_error_in_article 64 "l'étatdes milieuxrécepteurs" "l'état des milieux récepteurs" | \
    amend_error_in_article 64 leurcapacité 'leur capacité' | \
    # Article 65
    amend_error_in_article 65 qualitéplussévèresque 'qualité plus sévères que' | \
    amend_error_in_article 65 êtreedietees 'être édictées' | \
    amend_error_in_article 65 particullerernent particulièrement | \
    # Article 66
    amend_error_in_article 66 établissernent établissement | \
    amend_error_in_article 66 actuallsatlon actualisation | \
    amend_error_in_article 66 sontmis 'sont mis' | \
    # Article 67
    amend_error_in_article 67 arnenaqements aménagements | \
    amend_error_in_article 67 enveprisparles 'entrepris par les' | \
    amend_error_in_article 67 lesentreprises 'les entreprises' | \
    amend_error_in_article 67 quirisquent 'qui risquent' | \
    amend_error_in_article 67 "!'importance de leurdimension" "l'importance de leur dimension" | \
    amend_error_in_article 67 'leursincidences ecoloqiques' 'leurs incidences écologiques' | \
    amend_error_in_article 67 porteratteinte 'porter atteinte' | \
    amend_error_in_article 67 "a l'environnement" "à l'environnement" | \
    amend_error_in_article 67 doiventdonnerlieua 'doivent donner lieu à' | \
    amend_error_in_article 67 "uneétuded'impad" "une étude d'impact" | \
    # Article 68
    amend_error_in_article 68 "l'environnement.*$" "$article_68_text" | \
    # Article 69
    amend_error_in_article 69 'textesprévus ararncie' "textes prévus à l'article" | \
    amend_error_in_article 69 fixentnotamment 'fixent notamment' | \
    amend_error_in_article 69 Iiste liste | \
    amend_error_in_article 69 "a l'obligation" "à l'obligation" | \
    amend_error_in_article 69 "rnodalltes d'etabflssement" "modalités d'établissement" | \
    amend_error_in_article 69 ', Article \[70\]-' '\n\n(70)' | \
    # Article 70
    amend_error_in_article 70 impad impact | \
    amend_error_in_article 70 "n'esttoutefois" "n'est toutefois" | \
    amend_error_in_article 70 portéeet 'portée et' | \
    amend_error_in_article 70 rcperaton "l'opération" | \
    amend_error_in_article 70 lieuadeseffetsnéfastes 'lieu à des effets néfastes' | \
    # Article 71
    amend_error_in_article 71 'que tes' 'que les' | \
    amend_error_in_article 71 'respectées:' 'respectées;' | \
    amend_error_in_article 71 'éventuel\/ement' 'éventuellement' | \
    # Article 72
    amend_error_in_article 72 pouvoirfaire 'pouvoir faire' | \
    amend_error_in_article 72 rnarees marées | \
    amend_error_in_article 72 "plansd'urgence" "plans d'urgence" | \
    amend_error_in_article 72 êtreétablis 'être établis' | \
    amend_error_in_article 72 aveclesdeparternents 'avec les départements' | \
    amend_error_in_article 72 'rninisteriels concernes' 'ministériels concernés' | \
    # Article 73
    amend_error_in_article 73 'pourfaire faceaux' 'pour faire face aux' | \
    amend_error_in_article 73 aentraînerla 'à entraîner la' | \
    amend_error_in_article 73 effetsdommageables 'effets dommageables' | \
    # Article 74
    amend_error_in_article 74 "s'assurerque" "s'assurer que" | \
    amend_error_in_article 74 'ales etaborer' 'à les élaborer' | \
    amend_error_in_article 74 'prendreeux-rnernes' 'prendre eux-mêmes' | \
    amend_error_in_article 74 mesuresqui 'mesures qui' | \
    amend_error_in_article 74 efficaceset 'efficaces et' | \
    amend_error_in_article 74 informede 'informé de' | \
    amend_error_in_article 74 natureet 'nature et' | \
    amend_error_in_article 74 'qualitédes mesuresprises' 'qualité des mesures prises' | \
    amend_error_in_article 74 opsrateurs opérateurs | \
    amend_error_in_article 74 respecte respecté | \
    # Article 75
    amend_error_in_article 75 concement concernent | \
    amend_error_in_article 75 "modalitésd'élaboration" "modalités d'élaboration" | \
    amend_error_in_article 75 'miseen oeuvredes' 'mise en oeuvre des' | \
    amend_error_in_article 75 ' Chapitre' '\n\nChapitre' | \
    # Article 76
    amend_error_in_article 76 applicatiOn application | \
    amend_error_in_article 76 constatéespar 'constatées par' | \
    amend_error_in_article 76 'partous officers' 'par tous officiers' | \
    # Article 77
    amend_error_in_article 77 Lesagentsde 'Les agents de' | \
    amend_error_in_article 77 mentionnes mentionnés | \
    amend_error_in_article 77 officers officiers | \
    amend_error_in_article 77 policejudiciairea 'police judiciaire à' | \
    amend_error_in_article 77 jlsdoiventpreterserment 'ils doivent prêter serment ' | \
    amend_error_in_article 77 devantlajuridictjon 'devant la juridiction' | \
    amend_error_in_article 77 requêtedu 'requête du' | \
    amend_error_in_article 77 ministrechargede 'ministre chargé de' | \
    # Article 78
    amend_error_in_article 78 'a: \[1\]' 'à: [1]' | \
    amend_error_in_article 78 necessalre nécessaire | \
    amend_error_in_article 78 assurerdu 'assurer du' | \
    amend_error_in_article 78 respectdes 'respect des' | \
    amend_error_in_article 78 'mesuresrelatives a' 'mesures relatives à' | \
    amend_error_in_article 78 "besoin,l'assistance" "besoin, l'assistance" | \
    amend_error_in_article 78 "l'avisdespersonnes" "l'avis des personnes" | \
    amend_error_in_article 78 lacompétence 'la compétence' | \
    amend_error_in_article 78 "l'ezpenence peuventêtre" "l'expérience peuvent être" | \
    amend_error_in_article 78 temoiqnaqe témoignage | \
    amend_error_in_article 78 "requenrl'assistance" "requérir l'assistance" | \
    amend_error_in_article 78 pubtique publique | \
    # Article 79
    amend_error_in_article 79 Touteinfraction 'Toute infraction' | \
    amend_error_in_article 79 "l'objetd'un" "l'objet d'un" | \
    amend_error_in_article 79 preuvecontraire 'preuve contraire' | \
    amend_error_in_article 79 relatesou 'relatés ou' | \
    amend_error_in_article 79 "autremotif d'irreqularite" "autre motif d'irrégularité" | \
    # Article 80
    amend_error_in_article 80 compétentdu 'compétent du' | \
    amend_error_in_article 80 'rrmistere charge' 'ministère chargé' | \
    amend_error_in_article 80 notifierau 'notifier au' | \
    amend_error_in_article 80 celuici 'celui-ci' | \
    amend_error_in_article 80 'vingtjours a compterde' 'vingt jours à compter de' | \
    amend_error_in_article 80 'contesterleprocès-verbal' 'contester le procès-verbal' | \
    amend_error_in_article 80 'passe ce délai' 'passé ce délai' | \
    amend_error_in_article 80 conservesa 'conserve sa' | \
    amend_error_in_article 80 delats délais | \
    amend_error_in_article 80 réclamationation réclamation | \
    amend_error_in_article 80 'ministère charge' 'ministère chargé' | \
    amend_error_in_article 80 'au la' 'ou la' | \
    amend_error_in_article 80 classesans 'classé sans' | \
    amend_error_in_article 80 'il est precede' 'il est précédé' | \
    amend_error_in_article 80 'ci-aores' 'ci-après' | \
    # Article 81
    amend_error_in_article 81 préjudicedes 'préjudice des' | \
    amend_error_in_article 81 agentsassermentes 'agents assermentés' | \
    amend_error_in_article 81 charges chargés | \
    amend_error_in_article 81 "matièred'atteinteal'environnement" "matière d'atteintes à l'environnement." | \
    # Article 82
    amend_error_in_article 82 'préjudicedu droitde' 'préjudice du droit de' | \
    amend_error_in_article 82 'collectlvites localesou' 'collectivités locales ou' | \
    amend_error_in_article 82 cornmunautes communautés | \
    # Article 83
    amend_error_in_article 83 rechercheet 'recherche et' | \
    amend_error_in_article 83 'saisiset sontsusceptibles' 'saisis et sont susceptibles' | \
    amend_error_in_article 83 'restitues aleur' 'restitués à leur' | \
    amend_error_in_article 83 'lepaiementdes fraisde' 'le paiement des frais de' | \
    amend_error_in_article 83 'éventuels:' 'éventuels;' | \
    amend_error_in_article 83 i1s ils | \
    amend_error_in_article 83 detrults détruits | \
    amend_error_in_article 83 '"administration' administration | \
    amend_error_in_article 83 "f'environnement" "l'environnement" | \
    amend_error_in_article 83 '\(raisdu' 'frais du' | \
    # Article 84
    amend_error_in_article 84 élémentsde 'éléments de' | \
    amend_error_in_article 84 preuvepeuventêtre 'preuve peuvent être' | \
    amend_error_in_article 84 'restitues aleur propnetaire' 'restitués à leur propriétaire' | \
    amend_error_in_article 84 detrults détruits | \
    # Article 85
    amend_error_in_article 85 "s'appliquentala poursuiteet" "s'appliquent à la poursuite" | \
    amend_error_in_article 85 juqernent jugement | \
    amend_error_in_article 85 'application \.' 'application.' | \
    # Article 86
    amend_error_in_article 86 'a vingt-quatre' 'à vingt-quatre' | \
    amend_error_in_article 86 emprisonnementde 'emprisonnement de' | \
    amend_error_in_article 86 cinqatrentejours 'cinq à trente jours' | \
    amend_error_in_article 86 unede 'une de' | \
    amend_error_in_article 86 deuxpeinesseulement 'deux peines seulement' | \
    amend_error_in_article 86 ceuxquiSe 'ceux qui se' | \
    amend_error_in_article 86 'abandon\.' 'abandon,' | \
    amend_error_in_article 86 rnenaqeres ménagères | \
    amend_error_in_article 86 'toutes\.' 'toutes' | \
    amend_error_in_article 86 "émissiond'odeurs" "émission d'odeurs" | \
    amend_error_in_article 86 naussabondesnrevues 'nauséabondes prévues' | \
    amend_error_in_article 86 'vibrationsau-deledes' 'vibrations au-delà des' | \
    amend_error_in_article 86 intensitésnormalesprévues 'intensités normales prévues' | \
    # Article 87
    amend_error_in_article 87 adeux 'à deux' | \
    amend_error_in_article 87 'a trois' 'à trois' | \
    amend_error_in_article 87 'peiCles seu\/ement' 'peines seulement' | \
    amend_error_in_article 87 '\/es infradions ci-epres' 'les infractions ci-après' | \
    amend_error_in_article 87 dispositionsdes 'dispositions des' | \
    amend_error_in_article 87 'ci-dessus:' 'ci-dessus;' | \
    amend_error_in_article 87 'ci-clessus' 'ci-dessus' | \
    amend_error_in_article 87 'paragraphe 4' 'paragraphe [4]' | \
    amend_error_in_article 87 'a autorisation' 'à autorisation' | \
    amend_error_in_article 87 'préalableen matièrede' 'préalable en matière de' | \
    amend_error_in_article 87 fonctionsdevoluespar 'fonctions dévolues par' | \
    amend_error_in_article 87 cidessus 'ci-dessus' | \
    amend_error_in_article 87 'ministère charge' 'ministère chargé' | \
    amend_error_in_article 87 "qu'a taus" "qu'à tous" | \
    amend_error_in_article 87 "a l'esthétique" "à l'esthétique" | \
    amend_error_in_article 87 '\[6\] le non-respectdes' '[6] le non-respect des' | \
    amend_error_in_article 87 '\/aprésente lei' 'la présente loi' | \
    amend_error_in_article 87 'lol au' 'loi ou' | \
    amend_error_in_article 87 méconnaissancedes 'méconnaissance des' | \
    amend_error_in_article 87 moosees imposées | \
    amend_error_in_article 87 '\[8\] le non-respectdes' '[8] le non-respect des' | \
    amend_error_in_article 87 a38 'à 38' | \
    amend_error_in_article 87 'relativesaux decnets' 'relatives aux déchets' | \
    amend_error_in_article 87 "a l'établissement" "à l'établissement" | \
    amend_error_in_article 87 '"étude' "l’étude" | \
    amend_error_in_article 87 '\[10]\lenon-respectdes' '[10] le non-respect des' | \
    amend_error_in_article 87 'furnees, poussleres et lurnieres' 'fumées, poussières et lumières' | \
    # Article 88
    amend_error_in_article 88 amendede 'amende de' | \
    amend_error_in_article 88 cinquantemillefrancs 'cinquante mille francs' | \
    amend_error_in_article 88 adeux 'à deux' | \
    amend_error_in_article 88 emprisonnementde 'emprisonnement de' | \
    amend_error_in_article 88 asix 'à six' | \
    amend_error_in_article 88 unede 'une de' | \
    amend_error_in_article 88 altérerau 'altérer au' | \
    amend_error_in_article 88 qualitédes 'qualité des' | \
    amend_error_in_article 88 'eaux,ainsi' 'eaux, ainsi' | \
    amend_error_in_article 88 ressourcesnaturelles 'ressources naturelles' | \
    amend_error_in_article 88 chimiquesaeffets 'chimiques à effets' | \
    amend_error_in_article 88 'nocifsau rnepris' 'nocifs au mépris' | \
    amend_error_in_article 88 effJuents effluents | \
    amend_error_in_article 88 'soumls ainterdiction' 'soumis à interdiction' | \
    amend_error_in_article 88 '\[4\] le non-respectdes' '[4] le non-respect des' | \
    amend_error_in_article 88 "matièred'exploitation" "matière d'exploitation" | \
    amend_error_in_article 88 'classées:' 'classées;' | \
    amend_error_in_article 88 '\[5\] le non-respectdes' '[5] le non-respect des' | \
    amend_error_in_article 88 'paragraphe 5' 'paragraphe [5]' | \
    amend_error_in_article 88 astreinteOn 'astreinte un' | \
    amend_error_in_article 88 delal délai | \
    amend_error_in_article 88 dassees classées | \
    amend_error_in_article 88 '"tenus' tenus | \
    amend_error_in_article 88 Passe Passé | \
    amend_error_in_article 88 derneuree demeurée | \
    # Article 89
    amend_error_in_article 89 amendede 'amende de' | \
    amend_error_in_article 89 'a cinquante' 'à cinquante' | \
    amend_error_in_article 89 'de rune' "de l'une" | \
    amend_error_in_article 89 'a une' 'à une' | \
    amend_error_in_article 89 prononcéepar 'prononcée par' | \
    amend_error_in_article 89 normesde 'normes de' | \
    amend_error_in_article 89 équipernent équipement | \
    amend_error_in_article 89 a65 'à 65' | \
    amend_error_in_article 89 présenteloi 'présente loi' | \
    amend_error_in_article 89 prisesen 'prises en' | \
    amend_error_in_article 89 'paragraphe 2' 'paragraphe [2]' | \
    amend_error_in_article 89 'relative~' 'relative à' | \
    amend_error_in_article 89 nocivesinterdites 'nocives interdites' | \
    # Article 90
    amend_error_in_article 90 nonprévuespar 'non prévues par' | \
    amend_error_in_article 90 presentsloi 'présente loi' | \
    amend_error_in_article 90 'milieumarinet cotier' 'milieu marin et côtier' | \
    amend_error_in_article 90 'at des' 'et des' | \
    amend_error_in_article 90 'reorlmees conformémentala' 'réprimées conformément à la' | \
    amend_error_in_article 90 rnatieres matières | \
    # Article 91
    amend_error_in_article 91 recidive récidive | \
    amend_error_in_article 91 'a90 cidessus sont portéesau' 'à 90 ci-dessus sont portées au' | \
    # Article 92
    amend_error_in_article 92 repressives répressives | \
    amend_error_in_article 92 peuvententraîner 'peuvent entraîner' | \
    amend_error_in_article 92 mesuresadministratives 'mesures administratives' | \
    amend_error_in_article 92 définiespar 'définies par' | \
    # Article 93
    amend_error_in_article 93 amendesprévuespar 'amendes prévues par' | \
    amend_error_in_article 93 'parles textesprispourson' 'par les textes pris pour son' | \
    amend_error_in_article 93 'recouvrees commeen' 'recouvrées comme en' | \
    amend_error_in_article 93 "matièred'enregistrement" "matière d'enregistrement" | \
    # Article 95
    amend_error_in_article 95 acellesde 'à celles de' | \
    amend_error_in_article 95 'abroqees,' 'abrogées.' | \
    amend_error_in_article 95 ' Article 96,-' '\n\n(96)' | \
    # Article 96
    amend_error_in_article 96 enreqistree enregistrée | \
    amend_error_in_article 96 exécutes exécutée | \
    amend_error_in_article 96 "loi de l'Etat" "loi de l'État" | \
    amend_error_in_article 96 ' FaitaLibreville.*' ''
}

function amend_errors_in_headers {
  sed -E 's/^(TITRE I): DISPOSIllONS(.*)\./\1 - DISPOSITIONS\2/' | \
    sed -E 's/^TITRE \(I: (.*)\./TITRE II - \1/' | \
    sed -E 's/^(Chapitre premier): (Les mers.*)\./\1 - \2/' | \
    sed -E 's/^Chapitre deuxlsme: (Les eaux.*)\./Chapitre deuxième - \1/' | \
    sed -E 's/^Chapitre trolslerne: (Le sol.*)\./Chapitre troisième - \1/' | \
    sed -E "s/^Chapitre quatrierne: L'air\./Chapitre quatrième - L'air/" | \
    sed -E 's/^Chapitre cinquieme: (La faune.*)\./Chapitre cinquième - \1/' | \
    sed -E 's/^Chapitre slxteme: (Les aires.*)\./Chapitre sixième - \1/' | \
    sed -E 's/^(TITRE III - )POLLU1l0N(.*)\./\1POLLUTION\2/' | \
    sed -E 's/^(Chapitre premier) \[•\] Dechets\./\1 - Déchets/' | \
    sed -E 's/^Chapitre deuxieme \[•\] (Substances.*)\./Chapitre deuxième - \1/' | \
    sed -E 's/^Chapitre troislerne \[•\] (Bruits.*)\./Chapitre troisième - \1/' | \
    sed -E 's/^Chapitre quatrieme \[•\] (Installations.*)\./Chapitre quatrième - \1/' | \
    sed -E 's/^Chapitre cinquieme \[•\] Degradations(.*)\./Chapitre cinquième - Dégradations\1/' | \
    sed -E 's/^Chapitre sixierne \[•\] Odeurs\./Chapitre sixième - Odeurs/' | \
    sed -E 's/^Chapitre septierne \[•\] Fumees(.*)\./Chapitre septième - Fumées\1/' | \
    sed -E 's/^Chapitre hultlerne \[•\] Lumleres,/Chapitre huitième - Lumières/' | \
    sed -E 's/^(TITRE IV) \[•\] DISPOSIllONS(.*)\./\1 - DISPOSITIONS\2/' | \
    sed -E 's/^(Chapitre premier) \[•\] (.*)\./\1 - \2/' | \
    sed -E 's/^Chapitre deuxieme \[•\] (Dispositions.*)\./Chapitre deuxième - \1/' | \
    sed -E 's/^(Titre V.*)serontprisen tantque/\1seront pris en tant que/' | \
    sed -E 's/^(Titre V.*)fa présente/\1la présente/' | \
    sed -E 's/^(Titre V.*) Article \[94\]- Lestextes/\1\n\n(94) Les textes/' | \
    sed -E 's/^Titre V - - Dispositions finales,/TITRE V - DISPOSITIONS FINALES/'
}

function preprocess_state_and_language_input_file {
  if [ "$#" -ne 2 ] ; then
    echo_usage_error "$*" '<input_file_path> <language>'
    return 1
  fi
  local input_file_path="$1"
  local language="$2"

  apply_common_transformations "$input_file_path" "$language" | \
    remove_all_text_before_first_title_header | \
    amend_errors_in_articles | \
    amend_errors_in_headers
}
