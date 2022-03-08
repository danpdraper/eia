#!/bin/bash

function remove_all_text_before_first_article {
  sed -E 's/ Art\. 1"\. -/\n(1)/' | \
    sed -En '/^\(1\)/,$p'
}

function amend_errors_in_articles {
  sed -E 's/Etat/État/g' | \
    # Article 1
    amend_error_in_article 1 natureLs naturels | \
    amend_error_in_article 1 'paysages,es' paysages | \
    amend_error_in_article 1 préçervation préservation | \
    amend_error_in_article 1 vbgétales végétales | \
    amend_error_in_article 1 maintten maintien | \
    amend_error_in_article 1 11 Il | \
    amend_error_in_article 1 doiveht doivent | \
    amend_error_in_article 1 '- L' L | \
    amend_error_in_article 1 équiibre équilibre | \
    amend_error_in_article 1 réjidant résidant | \
    amend_error_in_article 1 milieuxirbains 'milieux urbains' | \
    # Article 2
    amend_error_in_article 2 environnemeiit environnement | \
    amend_error_in_article 2 zpprécier apprécier | \
    amend_error_in_article 2 ": D'une" ": d'une" | \
    amend_error_in_article 2 'I églementaires' règlementaires | \
    amend_error_in_article 2 "; 15 no.*D'autre" "; d'autre" | \
    amend_error_in_article 2 ': L' ': l' | \
    amend_error_in_article 2 élude étude | \
    amend_error_in_article 2 'environnement,\.l' 'environnement, l' | \
    amend_error_in_article 2 'modi,fications' modifications | \
    amend_error_in_article 2 proict projet | \
    amend_error_in_article 2 '; L' '; l' | \
    amend_error_in_article 2 lesquelrès lesquelles | \
    amend_error_in_article 2 '; L' '; l' | \
    amend_error_in_article 2 "étude, d'impact" "étude d'impact" | \
    amend_error_in_article 2 11 Il | \
    amend_error_in_article 2 requêk requête | \
    amend_error_in_article 2 adminisQative administrative | \
    amend_error_in_article 2 "1\"'" premier | \
    amend_error_in_article 2 'constatée\. selon' 'constatée selon' | \
    amend_error_in_article 2 ' De la pro[^ ]+' '\n\nCHAPITRE I - De la protection' | \
    # Article 3
    amend_error_in_article 3 '4& ' '' | \
    amend_error_in_article 3 intér8t intérêt | \
    amend_error_in_article 3 domedtiques domestiques | \
    sed -E ':start;s/^(\(3\).*[;:] )L/\1l/;t start' | \
    amend_error_in_article 3 'des oeufs ou d,p ni\*' 'des oeufs ou des nids,' | \
    amend_error_in_article 3 ' Ia ' ' la ' | \
    amend_error_in_article 3 'destruction\.' 'destruction,' | \
    amend_error_in_article 3 ' athat' ' achat' | \
    amend_error_in_article 3 cifeiilette cueillette | \
    amend_error_in_article 3 ',pu' ', ou' | \
    amend_error_in_article 3 'd-dation' 'dégradation' | \
    amend_error_in_article 3 'parti culier' particulier | \
    amend_error_in_article 3 prem2ères premières | \
    # Article 4
    amend_error_in_article 4 'déc&t' décret | \
    sed -E ':start;s/^(\(4\).*[;:] )L/\1l/;t start' | \
    amend_error_in_article 4 ',sont particuliPrement' 'sont particulièrement' | \
    amend_error_in_article 4 dofnaine domaine | \
    amend_error_in_article 4 ' de\.' ' de' | \
    amend_error_in_article 4 'recherche\.' 'recherche,' | \
    amend_error_in_article 4 'poursuite-' poursuite | \
    amend_error_in_article 4 régleinentation règlementation | \
    amend_error_in_article 4 dehûrs dehors | \
    amend_error_in_article 4 'de Ces zones' 'de ces zones' | \
    # Article 5
    amend_error_in_article 5 "I'utilisiltion" "l'utilisation" | \
    amend_error_in_article 5 "i'" "l'" | \
    amend_error_in_article 5 'des non cultivées' "des végétaux d’espèces non cultivées" | \
    amend_error_in_article 5 'semences ou' 'semences ou parties de plantes, dont la liste est fixée par arrêtés' | \
    amend_error_in_article 5 duministre 'conjoints du ministre' | \
    amend_error_in_article 5 'besoin\.' 'besoin,' | \
    amend_error_in_article 5 'com~étents\.' 'compétents,' | \
    amend_error_in_article 5 'fa demande' 'la demande' | \
    amend_error_in_article 5 "d~'autor~ation" "d'autorisation" | \
    amend_error_in_article 5 'moda i iixees' 'modalités fixées' | \
    amend_error_in_article 5 aecrkt décret | \
    # Article 6
    amend_error_in_article 6 "I'environnement" "l'environnement" | \
    amend_error_in_article 6 '\[•\].*\[•\] ' '' | \
    amend_error_in_article 6 'transit\. ainsi' 'transit, ainsi' | \
    amend_error_in_article 6 'loca&' locale | \
    amend_error_in_article 6 ' B ' ' à ' | \
    amend_error_in_article 6 étre être | \
    amend_error_in_article 6 eniretien entretien | \
    amend_error_in_article 6 éiablissements établissements | \
    # Article 7
    amend_error_in_article 7 "cide'ssus" 'ci-dessus' | \
    amend_error_in_article 7 ': \.L' ': L' | \
    sed -E ':start;s/^(\(7\).*[:;] )L/\1l/;t start' | \
    amend_error_in_article 7 cidessus 'ci-dessus' | \
    amend_error_in_article 7 'poursuit@' poursuites | \
    amend_error_in_article 7 'peuver\$ Qre exer- ' 'peuvent être exer' | \
    amend_error_in_article 7 ' kt\. 8; \[•\]' '\n\n(8)' | \
    # Article 8
    amend_error_in_article 8 ' De la protection' '\n\nCHAPITRE II - De la protection' | \
    # Article 10
    amend_error_in_article 10 "A l'article" "à l'article" | \
    amend_error_in_article 10 cidessus 'ci-dessus' | \
    amend_error_in_article 10 Ioi loi | \
    amend_error_in_article 10 pttblic public | \
    amend_error_in_article 10 'ani- maux' animaux | \
    amend_error_in_article 10 fenmeture fermeture | \
    amend_error_in_article 10 '#pénales' pénales | \
    # Article 11
    amend_error_in_article 11 'TITRE \[V\] \[•\]' '"TITRE V. -' | \
    amend_error_in_article 11 'déS animauz' 'des animaux' | \
    amend_error_in_article 11 'anitnaux saitvages' 'animaux sauvages' | \
    amend_error_in_article 11 '\.' '."' | \
    # Article 12
    amend_error_in_article 12 '\[•\] te' Le | \
    amend_error_in_article 12 'remplacé par\. les' 'remplacé par les' | \
    amend_error_in_article 12 ': Les maires' ': "Les maires' | \
    amend_error_in_article 12 'fa empêcher' 'à empêcher' | \
    amend_error_in_article 12 'conduits A la' 'conduits à la' | \
    amend_error_in_article 12 propribtaire propriétaire | \
    amend_error_in_article 12 "b'i\]~" "s'ils" | \
    amend_error_in_article 12 '&té' été | \
    amend_error_in_article 12 delai délai | \
    amend_error_in_article 12 'francç aiprds' 'francs après' | \
    amend_error_in_article 12 dkfini défini | \
    amend_error_in_article 12 portk 'porté à' | \
    amend_error_in_article 12 '\. \[II\] \[•\]' '." [2]' | \
    amend_error_in_article 12 'reinplack par\.' 'remplacé par' | \
    amend_error_in_article 12 'dispc sitions' dispositions | \
    amend_error_in_article 12 'c Art\. \[276\] \[•\] 11 est-interdit' '"Art. 276. - Il est interdit' | \
    amend_error_in_article 12 'trani ments' traitements | \
    amend_error_in_article 12 'an maux' animaux | \
    amend_error_in_article 12 apprivojsks apprivoisés | \
    amend_error_in_article 12 'c Des' 'Des' | \
    amend_error_in_article 12 dkterminenk déterminent | \
    amend_error_in_article 12 'mesure propres' 'mesures propres' | \
    amend_error_in_article 12 'le mauvais' 'les mauvais' | \
    amend_error_in_article 12 'B leur évitc' 'à leur éviter' | \
    amend_error_in_article 12 'inhérent&' inhérentes | \
    amend_error_in_article 12 'diversr techni ues' 'diverses techniques' | \
    amend_error_in_article 12 'di animwSz' 'des animaux.' | \
    amend_error_in_article 12 inême même | \
    amend_error_in_article 12 exbérienct expériences | \
    amend_error_in_article 12 'limité<' limitées | \
    amend_error_in_article 12 'nécessité\.' 'nécessité."' | \
    # Article 13
    amend_error_in_article 13 '\[1\] \[•\]' '[1]' | \
    amend_error_in_article 13 'coC pknal' 'code pénal' | \
    amend_error_in_article 13 ': ' ': "' | \
    amend_error_in_article 13 'exen des' 'exercé des' | \
    amend_error_in_article 13 'L animal' 'un animal' | \
    amend_error_in_article 13 'sera pu' 'sera puni' | \
    amend_error_in_article 13 '6 000' '6.000' | \
    amend_error_in_article 13 '\( quinze' 'de quinze' | \
    amend_error_in_article 13 'de-ces' 'de ces' | \
    amend_error_in_article 13 'seul ment' seulement | \
    amend_error_in_article 13 '\. \[II\] \[•\]' '." [2]' | \
    amend_error_in_article 13 'appi voisé' apprivoisé | \
    amend_error_in_article 13 'destin au' 'destinés au' | \
    amend_error_in_article 13 '4\!' 453 | \
    # Article 14
    amend_error_in_article 14 recopnu reconnues | \
    amend_error_in_article 14 'la part' 'la partie' | \
    amend_error_in_article 14 rtirticle "l'article" | \
    amend_error_in_article 14 ' coi ' ' code ' | \
    amend_error_in_article 14 intéri intérêts | \
    # Article 15
    amend_error_in_article 15 '\?a loi no' 'la loi numéro' | \
    amend_error_in_article 15 novemb novembre | \
    amend_error_in_article 15 qbmgé abrogé | \
    # Article 16
    amend_error_in_article 16 '\.ou dq plusiei' 'ou de plusieurs' | \
    amend_error_in_article 16 'nabpelle lonque' 'naturelle lorsque la' | \
    amend_error_in_article 16 éaux eaux | \
    amend_error_in_article 16 'c gisements' 'des gisements' | \
    amend_error_in_article 16 'du milj' 'du milieu' | \
    amend_error_in_article 16 particuliére particulière | \
    amend_error_in_article 16 'convic ' 'convient ' | \
    amend_error_in_article 16 'à foute' 'à toute' | \
    amend_error_in_article 16 'arüficietlé susceatible' 'artificielle susceptible de' | \
    amend_error_in_article 16 'Id domaine pub' 'le domaine public' | \
    amend_error_in_article 16 '\*s' les | \
    sed -E ':start;s/^(\(16\).*[;:] )L/\1l/;t start' | \
    amend_error_in_article 16 espéces espèces | \
    amend_error_in_article 16 'habit en' 'habitats en' | \
    amend_error_in_article 16 'natio ou' 'national ou' | \
    amend_error_in_article 16 reinarquables remarquables | \
    amend_error_in_article 16 aniniales animales | \
    amend_error_in_article 16 'végétales de' 'végétales ou de' | \
    amend_error_in_article 16 'con tuant' constituant | \
    amend_error_in_article 16 'an- voie de dispariti' 'en voie de disparition,' | \
    amend_error_in_article 16 géoiogiqt 'géologiques,' | \
    amend_error_in_article 16 'spéléolo\.giques' spéléologiques | \
    amend_error_in_article 16 'gran voies' 'grandes voies' | \
    amend_error_in_article 16 'dc loppement' développement | \
    amend_error_in_article 16 'particu ' 'particulier ' | \
    amend_error_in_article 16 'activ ' 'activités ' | \
    amend_error_in_article 16 ' ~tt\. \[17\] \[•\]' '\n\n(17)' | \
    # Article 17
    amend_error_in_article 17 'déc ' 'décret ' | \
    amend_error_in_article 17 'intéress A deiaut' 'intéressées\. À défaut' | \
    amend_error_in_article 17 'classement prononcé' 'classement est prononcé' | \
    # Article 18
    amend_error_in_article 18 'A un rég' 'à un régime' | \
    amend_error_in_article 18 "B i'int4rieur" "à l'intérieur" | \
    amend_error_in_article 18 'rést toute' 'réserve toute' | \
    amend_error_in_article 18 Iiaturel 'naturel de' | \
    amend_error_in_article 18 caractère 'le caractère' | \
    amend_error_in_article 18 'pê les' 'pêche, les' | \
    amend_error_in_article 18 'pasto~ales' pastorales | \
    amend_error_in_article 18 industrie 'industrielles,' | \
    amend_error_in_article 18 'exkcution de trai.*4205' 'exécution de travaux' | \
    amend_error_in_article 18 privb privés | \
    amend_error_in_article 18 'lc moyen' 'le moyen' | \
    amend_error_in_article 18 ziesure mesure | \
    amend_error_in_article 18 "dbfinis à l'.irticle" "définis à l'article" | \
    # Article 19
    amend_error_in_article 19 '-1\.' la | \
    amend_error_in_article 19 "revision du'cadasire" 'révision du cadastre' | \
    amend_error_in_article 19 'tt de' 'et de' | \
    amend_error_in_article 19 roncière foncière | \
    amend_error_in_article 19 tituIaires titulaires | \
    amend_error_in_article 19 '.eels' réels | \
    # Article 20
    amend_error_in_article 20 'le nature' 'de nature' | \
    amend_error_in_article 20 Iéterminant déterminant | \
    amend_error_in_article 20 'certain,il' 'certain, il' | \
    amend_error_in_article 20 lioit droit | \
    amend_error_in_article 20 'titulaircs le' 'titulaires de' | \
    amend_error_in_article 20 ' ians ' ' dans ' | \
    amend_error_in_article 20 '&\.dater' 'à dater' | \
    amend_error_in_article 20 ' ,de la déciion' ', de la décision' | \
    amend_error_in_article 20 ' A ' ' À ' | \
    amend_error_in_article 20 ' ixée' ' fixée' | \
    # Article 21
    amend_error_in_article 21 ' rotection' ' protection' | \
    amend_error_in_article 21 itention intention | \
    amend_error_in_article 21 modifiation modification | \
    amend_error_in_article 21 ' endant' ' pendant' | \
    amend_error_in_article 21 iiriistre ministre | \
    amend_error_in_article 21 'réserve e ' 'réserve de ' | \
    amend_error_in_article 21 ' mt\. \[22\]-' '\n\n(22)' | \
    # Article 22
    amend_error_in_article 22 'classé\. i' 'classé, en' | \
    amend_error_in_article 22 'cn:azrve,' 'en réserve' | \
    amend_error_in_article 22 ' cataire' ' locataire' | \
    amend_error_in_article 22 '\)it' doit | \
    amend_error_in_article 22 '\.de' de | \
    amend_error_in_article 22 etre être | \
    amend_error_in_article 22 iargé chargé | \
    # Article 23
    amend_error_in_article 23 'ne rivent' 'ne peuvent' | \
    amend_error_in_article 23 'pcct\.' 'aspect,' | \
    amend_error_in_article 23 oieetion protection | \
    amend_error_in_article 23 'cq-et' décret | \
    amend_error_in_article 23 notaminent notamment | \
    amend_error_in_article 23 éalable préalable | \
    # Article 24
    amend_error_in_article 24 protbger protéger | \
    amend_error_in_article 24 'ie-' espèces | \
    amend_error_in_article 24 niculier particulier | \
    amend_error_in_article 24 bcologique écologique | \
    amend_error_in_article 24 lvent peuvent | \
    amend_error_in_article 24 'rhserves urelles' 'réserves naturelles' | \
    amend_error_in_article 24 'protection la nature' 'protection de la nature' | \
    amend_error_in_article 24 'E,-essées\. JI' 'intéressées\. Un' | \
    amend_error_in_article 24 '\.ces: ' ' ces terri' | \
    amend_error_in_article 24 rnatiére 'en matière' | \
    amend_error_in_article 24 'égard tiers\. ,FS' 'égard des tiers. Les' | \
    amend_error_in_article 24 CS 'à ces' | \
    amend_error_in_article 24 ' ,-t\. 251 \[•\]' '\n\n(25)' | \
    # Article 25
    amend_error_in_article 25 'nature les' 'nature fixe les' | \
    amend_error_in_article 25 ',relie' naturelle | \
    amend_error_in_article 25 ' s ' ' dans ' | \
    amend_error_in_article 25 'I-iiques' techniques | \
    amend_error_in_article 25 'passer conventions' 'passer des conventions' | \
    amend_error_in_article 25 ' siations' ' associations' | \
    amend_error_in_article 25 '1"' premier | \
    amend_error_in_article 25 '\!aiectivnes' 'des collectivités' | \
    amend_error_in_article 25 '&serves' 'des réserves' | \
    amend_error_in_article 25 'établis-; nts' établissements | \
    amend_error_in_article 25 'cr& h' 'créés à' | \
    # Article 26
    amend_error_in_article 26 'État te' 'État. Le' | \
    amend_error_in_article 26 'commumqu6 ,aux' 'communiqué aux' | \
    amend_error_in_article 26 'communes concernée' 'communes concernées' | \
    # Article 27
    amend_error_in_article 27 'Les\. articles' 'Les articles' | \
    amend_error_in_article 27 'de\$' des | \
    amend_error_in_article 27 bistorique historique | \
    amend_error_in_article 27 'min@€-' ministre | \
    amend_error_in_article 27 ' De la protectio\?t' '\n\nCHAPITRE IV - De la protection' | \
    # Article 28
    amend_error_in_article 28 '\[1\] \[•\]' '[1]' | \
    amend_error_in_article 28 '\[a\] \.L' '[a] l' | \
    amend_error_in_article 28 'c la' '"la' | \
    amend_error_in_article 28 'bois \* est' 'bois" est' | \
    amend_error_in_article 28 'par a la' 'par "la' | \
    amend_error_in_article 28 'complètent; \[b\]\. L' 'complètent"; [b] l' | \
    amend_error_in_article 28 '8"' 8 | \
    amend_error_in_article 28 ' cou ' ' "ou ' | \
    amend_error_in_article 28 ' S\. \[II\] \[•\] B' '". [2] Il' | \
    amend_error_in_article 28 'forvstier Un' 'forestier un' | \
    amend_error_in_article 28 'Art\.' '"Art.' | \
    amend_error_in_article 28 'bis\. \[•\]' 'bis. -' | \
    amend_error_in_article 28 'utilité.publique' 'utilité publique' | \
    amend_error_in_article 28 "'bois" bois | \
    amend_error_in_article 28 'situés A la' 'situés à la' | \
    amend_error_in_article 28 'dés grandes' 'des grandes' | \
    amend_error_in_article 28 '\. \* \[III\] \[•\]' '." [3]' | \
    amend_error_in_article 28 "alinéa'supplémentaire" 'alinéa supplémentaire' | \
    amend_error_in_article 28 'a Le' '"Le' | \
    amend_error_in_article 28 '\.iderdit' ' interdit' | \
    amend_error_in_article 28 'boisemepts\. w ' 'boisements."\n\nCHAPITRE V - ' | \
    # Article 29
    amend_error_in_article 29 'Qeq doujims' 'des douanes' | \
    sed -E ':start;s/^(\(29\).*[:;] )([A-Z])/\1\L\2/;t start' | \
    amend_error_in_article 29 fonctionnabes fonctionnaires | \
    amend_error_in_article 29 'com- missionnés' commissionnés | \
    amend_error_in_article 29 '\.commissionnés' commissionnés | \
    amend_error_in_article 29 '\.infractions' infractions | \
    amend_error_in_article 29 "1'" "l'" | \
    amend_error_in_article 29 vbgétaux végétaux | \
    amend_error_in_article 29 'asser- mentés' assermentés | \
    amend_error_in_article 29 '~tionaux' nationaux | \
    amend_error_in_article 29 ' no ' ' numéro ' | \
    amend_error_in_article 29 reglementation règlementation | \
    amend_error_in_article 29 "i'" "l'" | \
    # Article 30
    amend_error_in_article 30 'proces-verbaux dresshs' 'procès-verbaux dressés' | \
    amend_error_in_article 30 "A l'article 29 cidessus" "à l'article 29 ci-dessus" | \
    amend_error_in_article 30 're-mis ou envoyks' 'remis ou envoyés' | \
    amend_error_in_article 30 R6publique République | \
    amend_error_in_article 30 nullite nullité | \
    amend_error_in_article 30 '4200 JOURNAL OFFICIEL DE L Le,' Les | \
    amend_error_in_article 30 ' ies ' ' les ' | \
    # Article 31
    amend_error_in_article 31 "h I'article 29 cidessiis" "à l'article 29 ci-dessus" | \
    amend_error_in_article 31 auxqqelles auxquelles | \
    amend_error_in_article 31 "'ces" ces | \
    amend_error_in_article 31 refuslnt refusant | \
    amend_error_in_article 31 'passi,ble' passible | \
    # Article 32
    amend_error_in_article 32 '2000 à 40000' '2.000 à 40.000' | \
    amend_error_in_article 32 '62 7' '6, 7' | \
    amend_error_in_article 32 "I'amende" "l'amende" | \
    amend_error_in_article 32 80000 '80.000' | \
    # Article 33
    amend_error_in_article 33 LES Les | \
    # Article 34
    amend_error_in_article 34 'prévu-' prévues | \
    amend_error_in_article 34 '21-2 a 21-8' '21-2 à 21-8' | \
    amend_error_in_article 34 ' no ' ' numéro ' | \
    amend_error_in_article 34 '1"' premier | \
    amend_error_in_article 34 'n"' numéro | \
    # Article 35
    amend_error_in_article 35 cidessus 'ci-dessus' | \
    amend_error_in_article 35 "I'article" "l'article" | \
    amend_error_in_article 35 ' Dispositions' '\n\nCHAPITRE VI - Dispositions' | \
    # Article 36
    amend_error_in_article 36 '\[1\] \[•\]' '[1]' | \
    amend_error_in_article 36 "I'article" "l'article" | \
    amend_error_in_article 36 'nouvel\. alinéa' 'nouvel alinéa' | \
    amend_error_in_article 36 ' e Dans' ' "Dans' | \
    amend_error_in_article 36 'pafcs-' 'parcs ' | \
    amend_error_in_article 36 "'de" de | \
    amend_error_in_article 36 ' D \[II\] \[•\]' '" [2]' | \
    amend_error_in_article 36 'Art\. \[366\] \[•\]' '"Art. 366. -' | \
    amend_error_in_article 36 1è le | \
    amend_error_in_article 36 cômmunication communication | \
    amend_error_in_article 36 "I'homme. e" "l'homme." | \
    amend_error_in_article 36 "1''" premier | \
    amend_error_in_article 36 '\. e ' '. ' | \
    amend_error_in_article 36 ' D, Art\. \[37\] \[•\]' '"\n\n(37)' | \
    # Article 37
    amend_error_in_article 37 habilitks habilités | \
    sed -E ':start;s/^(\(37\).*[:;] )L/\1l/;t start' | \
    amend_error_in_article 37 'nationaux; dans' 'nationaux, dans' | \
    amend_error_in_article 37 'ils Appartiennent' 'ils appartiennent' | \
    amend_error_in_article 37 ',agents' agents | \
    amend_error_in_article 37 ' dane ' ' dans ' | \
    amend_error_in_article 37 'A laquelle' 'à laquelle' | \
    amend_error_in_article 37 'A cet' 'à cet' | \
    amend_error_in_article 37 ' A R.*•\]' '\n\n(38)' | \
    # Article 38
    amend_error_in_article 38 "i 'constater" 'à constater' | \
    amend_error_in_article 38 'zoee marititiic do' 'zone maritime de' | \
    amend_error_in_article 38 'parcs\. et' 'parcs et' | \
    amend_error_in_article 38 '-inhaetions -aux' ' infractions aux' | \
    amend_error_in_article 38 'con~missibnn~s etassermcntés' 'commissionnés et assermentés' | \
    amend_error_in_article 38 16 la | \
    # Article 39
    amend_error_in_article 39 aifx aux | \
    amend_error_in_article 39 'Ils\.' Ils | \
    amend_error_in_article 39 'au- procureur deJra' 'au procureur de la' | \
    amend_error_in_article 39 'dresses en-' 'dressés en ' | \
    # Article 40
    amend_error_in_article 40 '\.dans' dans | \
    amend_error_in_article 40 charge chargé | \
    amend_error_in_article 40 'fi participer \?i' 'à participer à' | \
    amend_error_in_article 40 'ayant, le' 'ayant le' | \
    amend_error_in_article 40 't~ut' tout | \
    amend_error_in_article 40 15s les | \
    amend_error_in_article 40 '\[6\]' '6,' | \
    amend_error_in_article 40 intérbts intérêts | \
    # Article 41
    amend_error_in_article 41 193Q 1930 | \
    amend_error_in_article 41 ' ne ' ' numéro ' | \
    amend_error_in_article 41 '1"' premier | \
    amend_error_in_article 41 ' nq ' ' numéro ' | \
    # Article 42
    amend_error_in_article 42 'décrets\.' décrets | \
    amend_error_in_article 42 "application'd" 'application d' | \
    # Article 43
    amend_error_in_article 43 ' lai ' ' loi ' | \
    amend_error_in_article 43 'ai\$plicables' applicables | \
    amend_error_in_article 43 "1'" "l'" | \
    amend_error_in_article 43 ' Fait.*$' ''
}

function amend_errors_in_headers {
  sed -E 's/^(CHAPITRE .*)\./\1/' | \
    sed -E 's/^(CHAPITRE III - .*)résemes/\1réserves/'
}

function preprocess_state_and_language_input_file {
  if [ "$#" -ne 2 ] ; then
    echo_usage_error "$*" '<input_file_path> <language>'
    return 1
  fi
  local input_file_path="$1"
  local language="$2"

  apply_common_transformations "$input_file_path" "$language" | \
    remove_all_text_before_first_article | \
    amend_errors_in_articles | \
    amend_errors_in_headers
}
