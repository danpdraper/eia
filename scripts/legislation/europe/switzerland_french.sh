#!/bin/bash

function remove_all_text_before_first_header {
  sed -E 's/ (Titre premier: Principes)/\n\1/' | \
    sed -n '/^Titre premier: Principes/,$p'
}

function amend_errors_in_articles {
  # Article 1
  sed -E 's/ Article premier But/\n\nBut\n(1)/' | \
    amend_error_in_article 1 'La présente' '[1] La présente' | \
    amend_error_in_article 1 'loi pour' 'loi a pour' | \
    amend_error_in_article 1 'Les atteintes' '[2] Les atteintes' | \
    amend_error_in_article 1 'réduites titre' 'réduites à titre' | \
    sed -E 's/ Art\. (Principe de causalité)/\n\n\1\n(2)/' | \
    # Article 2
    sed -E "s/ Art\. (Réserve d'autres lois)/\n\n\1\n(3) [1]/" | \
    # Article 3
    amend_error_in_article 3 'Les substances' '[2] Les substances' | \
    sed -E "s/ Art\. (Prescriptions d'exécution fondées sur d'autres lois fédérales)/\n\n\1\n(4) [1]/" | \
    # Article 4
    amend_error_in_article 4 'atteintes l' 'atteintes à l' | \
    amend_error_in_article 4 'art\. \[11\]' 'article 11)' | \
    amend_error_in_article 4 'art\. 13 \[15\]' 'articles 13 à 15)' | \
    amend_error_in_article 4 'art\. \[19\]' 'article 19)' | \
    amend_error_in_article 4 'art\. 23 \[25\]' 'articles 23 à 25)' | \
    amend_error_in_article 4 'RS.*1984' '[2]' | \
    amend_error_in_article 4 'atteinte l' 'atteinte à l' | \
    amend_error_in_article 4 'art\. 26 \[28\]' 'articles 26 à 28)' | \
    sed -E 's/ Art\. (Exceptions pour la défense nationale)/\n\n\1\n(5)/' | \
    # Article 6
    sed -E 's/^Art\. (Information et conseils)/\1\n(6) [1]/' | \
    amend_error_in_article 6 'art\. \[42\]' 'article 42)' | \
    amend_error_in_article 6 'grèvent\. Ils' 'grèvent. [2] Ils' | \
    amend_error_in_article 6 'particuliers\. Ils' 'particuliers. [3] Ils' | \
    amend_error_in_article 6 'visant réduire' 'visant à réduire' | \
    # Article 7
    sed -E 's/^(Chapitre 2 - Dispositions générales) Art\. (Définitions)/\1\n\n\2\n(7) [1]/' | \
    amend_error_in_article 7 'déchets\. Les' 'déchets. [2] Les' | \
    amend_error_in_article 7 immiscions immissions | \
    amend_error_in_article 7 'effet\. Par' 'effet. [3] Par' | \
    amend_error_in_article 7 'chaleur\. Les' 'chaleur. [4] Les' | \
    amend_error_in_article 7 'bruit\. Par' 'bruit. [5] Par' | \
    amend_error_in_article 7 'assimilés\. Par' 'assimilés. [6] Par' | \
    amend_error_in_article 7 'public\. Par' 'public. [7] Par' | \
    amend_error_in_article 7 ' 1123.*1984 Art\.' '\n\n(8)' | \
    # Article 8
    sed -E 's/^\(8\) E(valuation des atteintes)/É\1\n(8)/' | \
    amend_error_in_article 8 ' Art\.' '\n\n(9)' | \
    # Article 9
    sed -E "s/^\(9\) E(tude de l'impact sur l'environnement)/É\1\n(9) [1]/" | \
    amend_error_in_article 9 "installations\. L'impact" "installations. [2] L'impact" | \
    sed -E ':start;s/^(\(9\).*[;:] )([a-z]) \.L/\1[\2] l/;t start' | \
    amend_error_in_article 9 'coût\. Le' 'coût. [3] Le' | \
    amend_error_in_article 9 "rapport\. S'il" "rapport. [4] S'il" | \
    amend_error_in_article 9 'projet\. Les' 'projet. [5] Les' | \
    amend_error_in_article 9 'mesures adopter\.' 'mesures à adopter. [6]' | \
    amend_error_in_article 9 'experts\. En' 'experts. [7] En' | \
    amend_error_in_article 9 'décision prendre' 'décision à prendre' | \
    amend_error_in_article 9 'fédéral\. Chacun' 'fédéral. [8] Chacun' | \
    # Article 10
    sed -E 's/^\(10\) (Protection contre les catastrophes)/\1\n(10) [1]/' | \
    amend_error_in_article 10 "dommages l'homme" "dommages à l'homme" | \
    amend_error_in_article 10 '1124.*1984 ' '' | \
    amend_error_in_article 10 'propres assurer' 'propres à assurer' | \
    amend_error_in_article 10 'Il notamment' 'Il y a notamment' | \
    amend_error_in_article 10 'alerte\. Les' 'alerte. [2] Les' | \
    amend_error_in_article 10 'alerte\. Le' 'alerte. [3] Le' | \
    amend_error_in_article 10 'extraordinaire\. Le' 'extraordinaire. [4] Le' | \
    amend_error_in_article 10 'propres assurer' 'propres à assurer' | \
    amend_error_in_article 10 ' Section 1:' '\n\nSection 1 -' | \
    amend_error_in_article 10 ' Chapitre premier:' '\n\nChapitre 1 -' | \
    amend_error_in_article 10 ' Titre deuxième:' '\n\nTitre deuxième -' | \
    # Article 11
    sed -E 's/^\(11\) (Principe)/\1\n(11) [1]/' | \
    amend_error_in_article 11 'prises la' 'prises à la' | \
    amend_error_in_article 11 '\)\.' '). [2]' | \
    amend_error_in_article 11 'importe, titre' 'importe, à titre' | \
    amend_error_in_article 11 'supportable\. Les' 'supportable. [3] Les' | \
    amend_error_in_article 11 'il lieu' 'il y a lieu' | \
    amend_error_in_article 11 'égard la' 'égard à la' | \
    # Article 12
    sed -E "s/^\(12\) (Limitations d'émissions)/\1\n(12) [1]/" | \
    sed -E ':start;s/^(\(12\).*[:;] )([a-z]) \.D/\1[\2] d/;t start' | \
    amend_error_in_article 12 'carburants\. Les' 'carburants. [2] Les' | \
    amend_error_in_article 12 cellesci 'celles-ci' | \
    amend_error_in_article 12 ' 1125.*$' '' | \
    # Article 13
    sed -E "s/^\(13\) (Valeurs limites d'immissions)/\1\n(13) [1]/" | \
    amend_error_in_article 13 'applicables l' 'applicables à l' | \
    amend_error_in_article 13 'incommodantes\. Ce' 'incommodantes. [2] Ce' | \
    # Article 14
    sed -E "s/^\(14\) (Valeurs limites d'immissions des pollutions atmosphériques)/\1\n(14)/" | \
    amend_error_in_article 14 'inférieures ces' 'inférieures à ces' | \
    sed -E ':start;s/^(\(14\).*[:;] )([a-z]) \.N/\1[\2] n/;t start' | \
    amend_error_in_article 14 'atteinte la' 'atteinte à la' | \
    amend_error_in_article 14 'ou la' 'ou à la' | \
    # Article 15
    sed -E "s/^\(15\) (Valeurs limites d'immissions relatives au bruit et aux vibrations)/\1\n(15)/" | \
    amend_error_in_article 15 'inférieures ces' 'inférieures à ces' | \
    # Article 16
    sed -E "s/^\(16\) (Obligation d'assainir)/\1\n(16) [1]/" | \
    amend_error_in_article 16 'appliquent la' 'appliquent à la' | \
    amend_error_in_article 16 'assainies\. Le' 'assainies. [2] Le' | \
    amend_error_in_article 16 'mesures prendre' 'mesures à prendre' | \
    amend_error_in_article 16 'procéder\. Avant' 'procéder. [3] Avant' | \
    amend_error_in_article 16 "assainissement\. S'il" "assainissement. [4] S'il y a" | \
    amend_error_in_article 16 'assainissement titre' 'assainissement à titre' | \
    amend_error_in_article 16 ' 1126.*$' '' | \
    # Article 17
    sed -E 's/^\(17\) (Allégements dans certains cas particuliers)/\1\n(17) [1]/' | \
    amend_error_in_article 17 '2° alinéa' 'alinéa [2]' | \
    amend_error_in_article 17 'proportionnalité\. Néanmoins' 'proportionnalité. [2] Néanmoins' | \
    # Article 18
    sed -E 's/^\(18\) (Transformation ou agrandissement des installations sujettes assainissement)/\1\n(18) [1]/' | \
    amend_error_in_article 18 'sujette assainissement' 'sujette à assainissement' | \
    amend_error_in_article 18 'subordonnée l' 'subordonnée à l' | \
    amend_error_in_article 18 'celui-ci\. Les' 'celui-ci. [2] Les' | \
    # Article 19
    sed -E "s/^(Section 4 .*) Art\. 19 (Valeurs d'alarme)/\1\n\n\2\n(19)/" | \
    amend_error_in_article 19 'art\. 16 et \[20\]' 'articles 16 et 20)' | \
    amend_error_in_article 19 'art\..*$' 'article 15).' | \
    # Article 20
    sed -E 's/^\(20\) (Isolation acoustique des immeubles existants)/\1\n(20) [1]/' | \
    amend_error_in_article 20 'mesures la' 'mesures à la' | \
    amend_error_in_article 20 'inférieur la' 'inférieur à la' | \
    amend_error_in_article 20 'similaires\. Les' 'similaires. [2] Les' | \
    amend_error_in_article 20 'fixes l' 'fixes à l' | \
    amend_error_in_article 20 'nécessaires l' 'nécessaires à l' | \
    sed -E ':start;s/^(\(20\).* )([a-z]) \.L/\1[\2] l/;t start' | \
    amend_error_in_article 20 'soumis l' 'soumis à l' | \
    # Article 21
    sed -E 's/^\(21\) (Isolation acoustique des nouveaux immeubles)/\1\n(21) [1]/' | \
    amend_error_in_article 21 '1127.*1984 ' '' | \
    amend_error_in_article 21 'vibrations\. Le' 'vibrations. [2] Le' | \
    amend_error_in_article 21 'minimale assurer' 'minimale à assurer' | \
    # Article 22
    sed -E 's/^\(22\) (Permis de construire dans les zones affectées par le bruit)/\1\n(22) [1]/' | \
    amend_error_in_article 22 'du 2e alinéa' "de l’alinéa [2]" | \
    amend_error_in_article 22 'dépassées\. Si' 'dépassées. [2] Si' | \
    # Article 23
    sed -E 's/^\(23\) (Valeurs de planification)/\1\n(23)/' | \
    amend_error_in_article 23 'zones bâtir' 'zones à bâtir' | \
    # Article 24
    sed -E 's/^\(24\) (Exigences quant aux zones )(bâtir)/\1à \2\n(24) [1]/' | \
    amend_error_in_article 24 'zones bâtir' 'zones à bâtir' | \
    amend_error_in_article 24 'destinées la' 'destinées à la' | \
    amend_error_in_article 24 'valeurs\. Les' 'valeurs. [2] Les' | \
    amend_error_in_article 24 'zones bâtir' 'zones à bâtir' | \
    amend_error_in_article 24 'destinées la' 'destinées à la' | \
    # Article 25
    sed -E "s/^\(25\) (Construction d'installations fixes)/\1\n(25) [1]/" | \
    amend_error_in_article 25 'bruit\. Des' 'bruit. [2] Des' | \
    amend_error_in_article 25 '1128.*1984 ' '' | \
    amend_error_in_article 25 'du 3e alinéa' "de l’alinéa [3]" | \
    amend_error_in_article 25 'dépassées\. Si' 'dépassées. [3] Si' | \
    amend_error_in_article 25 'mesures la' 'mesures à la' | \
    # Article 26
    sed -E 's/^(Chapitre 2 - Substances.*) Art\. 26 (Contrôle autonome)/\1\n\n\2\n(26) [1]/' | \
    amend_error_in_article 26 'environnement\. Le' 'environnement. [2] Le' | \
    amend_error_in_article 26 'exerce cet' 'exerce à cet' | \
    amend_error_in_article 26 'autonome\. Le' 'autonome. [3] Le' | \
    # Article 27
    sed -E "s/^\(27\) (Mode d'emploi)/\1\n(27) [1]/" | \
    amend_error_in_article 27 'il lieu' 'il y a lieu' | \
    amend_error_in_article 27 'nature menacer' 'nature à menacer' | \
    amend_error_in_article 27 'environnement\. Le' 'environnement. [2] Le' | \
    sed -E ':start;s/^(\(27\).*[:;] )([a-z]) \.L/\1[\2] l/;t start' | \
    amend_error_in_article 27 'éliminer\. Le' 'éliminer. [3] Le' | \
    amend_error_in_article 27 'conformément la' 'conformément à la' | \
    # Article 28
    sed -E "s/^\(28\) (Utilisation respectueuse de l'environnement)/\1\n(28) [1]/" | \
    amend_error_in_article 28 ellesmêmes 'elles-mêmes' | \
    amend_error_in_article 28 'environnement\. Lorsque' 'environnement. [2] Lorsque' | \
    amend_error_in_article 28 ' 1129.*$' '' | \
    # Article 29
    sed -E 's/^\(29\) (Prescriptions du Conseil fédéral)/\1\n(29) [1]/' | \
    amend_error_in_article 29 'homme\. Ces' 'homme. [2] Ces' | \
    sed -E ':start;s/^(\(29\).*[:;] )([a-z]) \.D/\1[\2] d/;t start' | \
    # Article 30
    sed -E "s/^\(30\) (Obligation de recycler, de neutraliser ou d'éliminer les déchets)/\1\n(30) [1]/" | \
    amend_error_in_article 30 'cantons\. Quiconque' 'cantons. [2] Quiconque' | \
    amend_error_in_article 30 'admis la' 'admis à la' | \
    amend_error_in_article 30 'décharge\. Les' 'décharge. [3] Les' | \
    amend_error_in_article 30 'autorisées\. Les' 'autorisées. [4] Les' | \
    amend_error_in_article 30 "remis l'intérieur" "remis à l'intérieur" | \
    amend_error_in_article 30 'autorisées prendre' 'autorisées à prendre' | \
    amend_error_in_article 30 '2 e alinéa, lettre b' 'alinéa [2], lettre [b]' | \
    # Article 31
    sed -E 's/^\(31\) (Tâches de la Confédération et des cantons)/\1\n(31) [1]/' | \
    amend_error_in_article 31 'veillent ce' 'veillent à ce' | \
    amend_error_in_article 31 'prescriptions\. Ils' 'prescriptions. [2] Ils' | \
    amend_error_in_article 31 'er alinéa' 'alinéa [1]' | \
    amend_error_in_article 31 'tâches\. Les' 'tâches. [3] Les' | \
    amend_error_in_article 31 'veillent ce' 'veillent à ce' | \
    amend_error_in_article 31 'cantons mettre la' 'cantons à mettre à la' | \
    amend_error_in_article 31 'frais\. Les' 'frais. [4] Les' | \
    amend_error_in_article 31 '1130.*1984 ' '' | \
    amend_error_in_article 31 'projets la' 'projets à la' | \
    amend_error_in_article 31 'veille la' 'veille à la' | \
    amend_error_in_article 31 'coordination\. Les' 'coordination. [5] Les' | \
    # Article 32
    sed -E 's/^\(32\) (Prescriptions du Conseil fédéral)/\1\n(32) [1]/' | \
    amend_error_in_article 32 'dangereux, compris' 'dangereux, y compris' | \
    amend_error_in_article 32 'transit\. Il' 'transit. [2] Il' | \
    sed -E ':start;s/^(\(32\).*[:;] )([a-z]) \.([A-Z])/\1[\2] \L\3/;t start' | \
    amend_error_in_article 32 "livraison l'intérieur" "livraison à l'intérieur" | \
    amend_error_in_article 32 'entreprise son' 'entreprise a son' | \
    amend_error_in_article 32 'siège\. Le' 'siège. [3] Le' | \
    amend_error_in_article 32 'décharges\. Le' 'décharges. [4] Le' | \
    amend_error_in_article 32 'mercure les' 'mercure à les' | \
    amend_error_in_article 32 "sont l'origine" "sont à l'origine" | \
    amend_error_in_article 32 'atteinte la' 'atteinte à la' | \
    amend_error_in_article 32 'ou la salubrité' 'ou à la salubrité' | \
    amend_error_in_article 32 edicter édicter | \
    amend_error_in_article 32 ' 1131.*$' '' | \
    # Article 33
    sed -E 's/^(Chapitre 4 - Atteintes portées au sol) Art\. 33 (Valeurs indicatives)/\1\n\n\2\n(33)/' | \
    amend_error_in_article 33 'inférieures ces' 'inférieures à ces' | \
    amend_error_in_article 33 'nuisent pas la' 'nuisent pas à la' | \
    amend_error_in_article 33 'même long' 'même à long' | \
    # Article 34
    sed -E 's/^\(34\) (Principe)/\1\n(34)/' | \
    # Article 35
    sed -E 's/^\(35\) (Prescriptions des cantons)/\1\n(35)/' | \
    amend_error_in_article 35 ' Chapitre premier:' '\n\nChapitre 1 -' | \
    amend_error_in_article 35 ' Titre troisième:' '\n\nTitre troisième -' | \
    # Article 36
    sed -E 's/^(Section 1 - Exécution par les cantons) Art\. 36 (Compétence exécutive des cantons)/\1\n\n\2\n(36)/' | \
    # Article 37
    sed -E "s/^\(37\) (Prescriptions d'exécution des cantons)/\1\n(37)/" | \
    amend_error_in_article 37 'art\. \[9\]' 'article 9)' | \
    amend_error_in_article 37 'art\. \[10\]' 'article 10)' | \
    amend_error_in_article 37 'art\. 16 \[18\]' 'articles 16 à 18)' | \
    amend_error_in_article 37 'art\. 20 et \[21\]' 'articles 20 et 21)' | \
    amend_error_in_article 37 'art\. 30 \[32\]' 'articles 30 à 32)' | \
    # Article 38
    sed -E 's/^\(38\) (Surveillance et coordination)/\1\n(38) [1]/' | \
    amend_error_in_article 38 '1132.*1984' '[2]' | \
    amend_error_in_article 38 'exploitations\. Le' 'exploitations. [3] Le' | \
    # Article 39
    sed -E "s/^\(39\) (Prescriptions d'exécution et accords internationaux)/\1\n(39) [1]/" | \
    amend_error_in_article 39 'exécution\. Il' 'exécution. [2] Il' | \
    sed -E ':start;s/^(\(39\).*[:;] )([a-z]) \.([A-Z])/\1[\2] \L\3/;t start' | \
    amend_error_in_article 39 'c o m \[•\] missions' commissions | \
    amend_error_in_article 39 'internationales caractère' 'internationales à caractère' | \
    amend_error_in_article 39 'formation\. Avant' 'formation. [3] Avant' | \
    # Article 40
    sed -E "s/^\(40\) (Expertise des types et marques d'épreuve)/\1\n(40) [1]/" | \
    amend_error_in_article 40 télles telles | \
    amend_error_in_article 40 'tondeuses gazon' 'tondeuses à gazon' | \
    amend_error_in_article 40 'épreuve\. De' 'épreuve. [2] De' | \
    amend_error_in_article 40 'soumises l' 'soumises à l' | \
    amend_error_in_article 40 'portent l' 'portent à l' | \
    amend_error_in_article 40 'environnement\. Le' 'environnement. [3] Le' | \
    # Article 41
    sed -E 's/^\(41\) (Compétence exécutive de la Confédération)/\1\n(41) [1]/' | \
    amend_error_in_article 41 'er alinéa' 'alinéa [1]' | \
    amend_error_in_article 41 'lettre \(' 'lettre [e] (' | \
    amend_error_in_article 41 '5e alinéa' 'alinéa [5]' | \
    amend_error_in_article 41 'le` et 2e alinéas' 'alinéas [1] et [2]' | \
    amend_error_in_article 41 '3e alinéa' 'alinéa [3]' | \
    amend_error_in_article 41 'appelés coopérer' 'appelés à coopérer à' | \
    amend_error_in_article 41 'tâches\. Les' 'tâches. [2] Les' | \
    amend_error_in_article 41 'applicables des' 'applicables à des' | \
    amend_error_in_article 41 'attributions, appliquer' 'attributions, à appliquer' | \
    amend_error_in_article 41 'veille la' 'veille à la' | \
    amend_error_in_article 41 '1133.*1984' '[3]' | \
    # Article 42
    sed -E "s/^(Section.*) Art\. 42 (Services spécialisés de la protection de l'environnement)/\1\n\n\2\n(42) [1]/" | \
    amend_error_in_article 42 'relatives la' 'relatives à la' | \
    amend_error_in_article 42 'désignent cet' 'désignent à cet' | \
    amend_error_in_article 42 'tâche\. L' 'tâche. [2] L' | \
    # Article 43
    sed -E 's/^\(43\) (Collaboration)/\1\n(43)/' | \
    amend_error_in_article 43 'confier des' 'confier à des' | \
    amend_error_in_article 43 'ou des' 'ou à des' | \
    # Article 44
    sed -E "s/^\(44\) (Enquêtes sur les nuisances grevant l'environnement)/\1\n(44) [1]/" | \
    amend_error_in_article 44 'procèdent des' 'procèdent à des' | \
    amend_error_in_article 44 'loi\. Le' 'loi. [2] Le' | \
    amend_error_in_article 44 'cantonal\. Il' 'cantonal. [3] Il' | \
    amend_error_in_article 44 'mises la' 'mises à la' | \
    # Article 45
    sed -E 's/^\(45\) (Contrôles périodiques)/\1\n(45)/' | \
    amend_error_in_article 45 'chaufferies mazout' 'chaufferies à mazout' | \
    # Article 46
    sed -E 's/^\(46\) (Obligation de renseigner)/\1\n(46) [1]/' | \
    amend_error_in_article 46 'nécessaires l' 'nécessaires à l' | \
    amend_error_in_article 46 'procéder des' 'procéder à des' | \
    amend_error_in_article 46 'tolérer\. Le' 'tolérer. [2] Le' | \
    amend_error_in_article 46 '1134.*1984 ' '' | \
    amend_error_in_article 46 'demandent\. Le' 'demandent. [3] Le' | \
    amend_error_in_article 46 'préjudiciables l' 'préjudiciables à l' | \
    # Article 47
    sed -E 's/^\(47\) (Information et obligation de garder le secret)/\1\n(47) [1]/' | \
    amend_error_in_article 47 'périodiquement\. Après' 'périodiquement. [2] Après' | \
    amend_error_in_article 47 'communiqués, moins' 'communiqués, à moins' | \
    amend_error_in_article 47 'protégé\. Toutes' 'protégé. [3] Toutes' | \
    # Article 48
    sed -E 's/^\(48\) E(moluments)/É\1\n(48) [1]/' | \
    amend_error_in_article 48 'lieu la' 'lieu à la' | \
    amend_error_in_article 48 'émoluments\. Sur' 'émoluments. [2] Sur' | \
    amend_error_in_article 48 ' pat ' ' par ' | \
    # Article 49
    sed -E "s/^(Chapitre 2 - Mesures d'encouragement) Art\. 49 (Formation et recherche)/\1\n\n\2\n(49) [1]/" | \
    amend_error_in_article 49 'loi\. Elle' 'loi. [2] Elle' | \
    # Article 50
    sed -E 's/^\(50\) (Subventions aux mesures de protection le long des routes)/\1\n(50) [1]/' | \
    amend_error_in_article 50 'environnement prendre' 'environnement à prendre' | \
    amend_error_in_article 50 '1135.*1984' '[2]' | \
    amend_error_in_article 50 'environnement prendre' 'environnement à prendre' | \
    amend_error_in_article 50 'appliquant ces' 'appliquant à ces' | \
    amend_error_in_article 50 'routes\. Le' 'routes. [3] Le' | \
    amend_error_in_article 50 'assainissements apporter' 'assainissements à apporter' | \
    amend_error_in_article 50 '30 60 pour cent' '30 à 60 pourcent' | \
    amend_error_in_article 50 'assainissement. Les' 'assainissement. [4] Les' | \
    # Article 51
    sed -E 's/^\(51\) (Installations de contrôle et de surveillance) Agait/\1\n(51)/' | \
    # Article 52
    sed -E 's/^\(52\) (Installations de traitement des déchets)/\1\n(52)/' | \
    amend_error_in_article 52 'sont la' 'sont à la' | \
    # Article 53
    sed -E 's/^\(53\) (Restitution)/\1\n(53) [1]/' | \
    amend_error_in_article 53 "requise\. ' L e" 'requise. [2] Le' | \
    amend_error_in_article 53 'ans compter' 'ans à compter' | \
    amend_error_in_article 53 'il pris' 'il a pris' | \
    # Article 54
    sed -E 's/^\(54\) (Protection juridique)/\1\n(54) [1]/' | \
    amend_error_in_article 54 "administrative'\)" administrative | \
    amend_error_in_article 54 'judiciaire2\.' 'judiciaire. [2]' | \
    amend_error_in_article 54 'visées l' 'visées à l' | \
    amend_error_in_article 54 '2e alinéa' 'alinéa [2]' | \
    # Article 55
    sed -E 's/^\(55\) (Droit de recours des organisations)/\1\n(55) [1]/' | \
    amend_error_in_article 55 "- '\) RS.*1984 " '' | \
    amend_error_in_article 55 'relatives la' 'relatives à la' | \
    amend_error_in_article 55 'la construction' 'à la construction' | \
    amend_error_in_article 55 'la modification' 'à la modification' | \
    amend_error_in_article 55 'soumises l' 'soumises à l' | \
    amend_error_in_article 55 'recours\. Le' 'recours. [2] Le' | \
    amend_error_in_article 55 'organisations\. Elles' 'organisations. [3] Elles' | \
    amend_error_in_article 55 'habilitées user' 'habilitées à user' | \
    # Article 56
    sed -E 's/^\(56\) (Droit de recours des autorités)/\1\n(56) [1]/' | \
    amend_error_in_article 56 'habilité user' 'habilité à user' | \
    amend_error_in_article 56 'exécution\. Les' 'exécution. [2] Les' | \
    amend_error_in_article 56 'territoire\. Les' 'territoire. [3] Les' | \
    # Article 57
    sed -E 's/^\(57\) (Droit de recours des communes)/\1\n(57)/' | \
    amend_error_in_article 57 'habilitées user' 'habilitées à user' | \
    amend_error_in_article 57 'protection ce' 'protection à ce' | \
    # Article 58
    sed -E 's/^\(58\) (Expropriation)/\1\n(58) [1]/' | \
    amend_error_in_article 58 'conférer des' 'conférer à des' | \
    amend_error_in_article 58 'tiers\. Dans' 'tiers. [2] Dans' | \
    amend_error_in_article 58 "expropriation'" expropriation | \
    sed -E ':start;s/^(\(58\).*[:;] )([a-z]) \.L/\1[\2] l/;t start' | \
    amend_error_in_article 58 'expropriation\. La' 'expropriation. [3] La' | \
    amend_error_in_article 58 "'\)RS711.*1984 " '' | \
    # Article 59
    sed -E "s/^\(59\) (Frais résultant de mesures de sécurité ou du rétablissement de l'état antérieur)/\1\n(59)/" | \
    amend_error_in_article 59 'mis la charge' 'mis à la charge' | \
    amend_error_in_article 59 ' Art\. 60 Délits' '\n\nDélits\n(60) [1]' | \
    amend_error_in_article 59 ' Titre quatrième:' '\n\nTitre quatrième -' | \
    # Article 60
    sed -E ':start;s/^(\(60\).*[,;] )([a-z]) \.([A-Z])/\1[\2] \L\3/;t start' | \
    amend_error_in_article 60 'recouru des' 'recouru à des' | \
    amend_error_in_article 60 'ou des procédés' 'ou à des procédés' | \
    amend_error_in_article 60 'art\. \[10\]' 'article 10)' | \
    amend_error_in_article 60 'nature menacer' 'nature à menacer' | \
    amend_error_in_article 60 'art\. \[26\]' 'article 26)' | \
    amend_error_in_article 60 'nature menacer' 'nature à menacer' | \
    amend_error_in_article 60 'art\. \[27\]' 'article 27)' | \
    amend_error_in_article 60 'art\. \[28\]' 'article 28)' | \
    amend_error_in_article 60 'art. 29' 'articles 29' | \
    amend_error_in_article 60 '4e al\., let\. f' 'alinéa [4], lettre [f]' | \
    amend_error_in_article 60 '\[35\]' '35)' | \
    amend_error_in_article 60 'art\. 30, 2e al\.' 'article 30, alinéa [2]' | \
    amend_error_in_article 60 'aura par' 'aura pas' | \
    amend_error_in_article 60 'destinés être' 'destinés à être' | \
    amend_error_in_article 60 'art\. 32, 2e al\., let\. \[a\]' 'article 32, alinéa [2], lettre [a])' | \
    amend_error_in_article 60 'remis une' 'remis à une' | \
    amend_error_in_article 60 'art\. 30, 4e al\.' 'article 30, alinéa [4]' | \
    amend_error_in_article 60 'art\. 32, 2e al\., let\. \[b\]' 'article 32, alinéa [2], lettre [b])' | \
    amend_error_in_article 60 'art\. 32, let al\.' 'article 32, alinéa [1]' | \
    amend_error_in_article 60 '\] A' '] a' | \
    amend_error_in_article 60 'art\. 32, 4e al\., let\. et \[g\]' 'article 32, alinéa [4], lettres [f] et [g])' | \
    amend_error_in_article 60 'menacés\. Si' 'menacés. [2] Si' | \
    amend_error_in_article 60 'auteur agi' 'auteur a agi' | \
    amend_error_in_article 60 ' 1138.*$' '' | \
    # Article 61
    sed -E 's/^\(61\) (Contraventions)/\1\n(61) [1]/' | \
    sed -E ':start;s/^(\(61\).* )([a-z]) \.([A-Z])/\1[\2] \L\3/;t start' | \
    amend_error_in_article 61 'art\. 12 et \[35\]' 'articles 12 et 35)' | \
    amend_error_in_article 61 'art\. \[16\]' 'article 16)' | \
    amend_error_in_article 61 'art\. \[27\]' 'article 27)' | \
    amend_error_in_article 61 'art\. \[28\]' 'article 28)' | \
    amend_error_in_article 61 'art\. 30, 3e al\.' 'article 30, alinéa [3]' | \
    amend_error_in_article 61 'art\. 32, 3e et 4e al\., let\. \[e\]' 'article 32, alinéas [3] et [4], lettre [e])' | \
    amend_error_in_article 61 'art\. 19 \[25\]' 'articles 19 à 25)' | \
    amend_error_in_article 61 'déclarations l' 'déclarations à l' | \
    amend_error_in_article 61 'art\. \[46\]' 'article 46)' | \
    amend_error_in_article 61 'art\. \[40\]' 'article 40)' | \
    amend_error_in_article 61 'amende\. Si' 'amende. [2] Si' | \
    amend_error_in_article 61 'auteur agi' 'auteur a agi' | \
    amend_error_in_article 61 'amende\. La' 'amende. [3] La' | \
    # Article 62
    sed -E 's/^\(62\) (Application du droit pénal administratif)/\1\n(62)/' | \
    amend_error_in_article 62 "administratif'>" administratif | \
    amend_error_in_article 62 'infractions la' 'infractions à la' | \
    amend_error_in_article 62 ' Art\. 63' '\n\n(63)' | \
    amend_error_in_article 62 ' Titre cinquième:' '\n\nTitre cinquième -' | \
    # Article 63
    sed -E 's/^\(63\) (Disposition transitoire sur le contrôle autonome des substances)/\1\n(63) [1]/' | \
    amend_error_in_article 63 'art\. \[26\]\.' 'article 26). [2]' | \
    # Article 64
    sed -E "s/^\(64\) (Adaptation d'ordonnances de la Confédération)/\1\n(64)/" | \
    amend_error_in_article 64 "'> RS.*1984 " '' | \
    amend_error_in_article 64 'programme déterminer' 'programme à déterminer' | \
    # Article 65
    sed -E "s/^\(65\) (Droit cantonal régissant la protection de l'environnement)/\1\n(65) [1]/" | \
    amend_error_in_article 65 'loi\. Les' 'loi. [2] Les' | \
    # Article 66
    sed -E 's/^\(66\) (Modification de lois fédérales)/\1\n(66)/' | \
    amend_error_in_article 66 'ler juillet 19669' 'premier juillet 1966' | \
    amend_error_in_article 66 'Art\. 18, al\. bis et Per' 'Article 18, alinéas [1bis] et [1ter]' | \
    amend_error_in_article 66 'Ibis I l lieu' '[1bis] Il y a lieu' | \
    amend_error_in_article 66 '\[ter S i ' '[1ter] Si' | \
    amend_error_in_article 66 ', défaut' ', à défaut' | \
    sed -E '/^\(66\)/{N;s/^(\(66\).*)\n/\1/;P;D}' | \
    sed -E '/^\(66\)/{N;s/^(\(66\).*)\n\(21\) Végétation des /\1 Article 21 /;P;D}' | \
    amend_error_in_article 66 'allurives viale' alluviale | \
    sed -E '/^\(66\)/{N;s/^(\(66\).*)\n/\1/;P;D}' | \
    sed -E '/^\(66\)/{N;s/^(\(66\).*)\n\(24\)/\1 Article 24, alinéa [1] [1]/;P;D}' | \
    amend_error_in_article 66 'lui été' 'lui a été' | \
    amend_error_in_article 66 'fédérale été' 'fédérale a été' | \
    amend_error_in_article 66 '2 e alinéa' 'alinéa [2]' | \
    amend_error_in_article 66 '1 \).*1984 celui' celui | \
    amend_error_in_article 66 '1, bis, ter, et 2' '[1], [1bis], [1ter], et [2]' | \
    amend_error_in_article 66 19599 1959 | \
    amend_error_in_article 66 'Article premier' 'Article 1 [1]' | \
    amend_error_in_article 66 routères routières | \
    amend_error_in_article 66 'subsides verser' 'subsides à verser' | \
    amend_error_in_article 66 'conformément la' 'conformément à la' | \
    amend_error_in_article 66 'montants affecter' 'montants à affecter à' | \
    sed -E ':start;s/^(\(66\).* )([0-9]) \.A/\1[\2] a/;t start' | \
    amend_error_in_article 66 'contributions la' 'contributions à la' | \
    amend_error_in_article 66 'ou la sécurité' 'ou à la sécurité' | \
    amend_error_in_article 66 'passages niveau' 'passages à niveau' | \
    amend_error_in_article 66 'environnement�1' 'environnement' | \
    amend_error_in_article 66 'annuellement 10' 'annuellement à 10' | \
    amend_error_in_article 66 '\[a\] b\.' '[a]. [b]' | \
    amend_error_in_article 66 'routier\. Le' 'routier. [2] Le' | \
    amend_error_in_article 66 'au ler alinéa, lettre \[a\].*$' "à l’alinéa [1], lettre [a]." | \
    sed -E '/^\(66\)/{N;s/^(\(66\).*)\n/\1/;P;D}' | \
    sed -E '/^\(66\)/{N;s/^(\(66\).*)\n\(4\)/\1 Article 4, alinéa [1] [1]/;P;D}' | \
    amend_error_in_article 66 'projets, compris' 'projets, y compris' | \
    amend_error_in_article 66 'dits, compris' 'dits, y compris' | \
    amend_error_in_article 66 'imputables la' 'imputables à la' | \
    amend_error_in_article 66 'redevances caractère' 'redevances à caractère' | \
    sed -E '/^\(66\)/{N;s/^(\(66\).*)\n/\1/;P;D}' | \
    sed -E '/^\(66\)/{N;s/^(\(66\).*)\n\(10\)/\1 Article 10/;P;D}' | \
    amend_error_in_article 66 'devis, compris' 'devis, y compris' | \
    amend_error_in_article 66 'dits, compris' 'dits, y compris' | \
    sed -E '/^\(66\)/{N;s/^(\(66\).*)\n/\1/;P;D}' | \
    sed -E '/^\(66\)/{N;s/^(\(66\).*)\n\(15\)/\1 Article 15, alinéa [1], lettre [b] [1]/;P;D}' | \
    amend_error_in_article 66 'affectées la' 'affectées à la' | \
    amend_error_in_article 66 'cantons, compris' 'cantons, y compris' | \
    amend_error_in_article 66 '1142.*1984 3 \.' '[3] ' | \
    amend_error_in_article 66 '\[19711\]' 1971 | \
    amend_error_in_article 66 'Art\. 3, al\. ibis Ibis' 'Article 3, alinéa [1bis] [1bis]' | \
    amend_error_in_article 66 'alinéa, lettre a' 'alinéa [1], lettre [a]' | \
    amend_error_in_article 66 'veille ce' 'veille à ce' | \
    amend_error_in_article 66 "\}'article 23, 2 e alinéa" "à l'article 23, alinéa [2]" | \
    amend_error_in_article 66 'appelés coopérer' 'appelés à coopérer à' | \
    sed -E '/^\(66\)/{N;s/^(\(66\).*)\n/\1/;P;D}' | \
    sed -E '/^\(66\)/{N;s/^(\(66\).*)\n\(5\)/\1 Article 5, alinéa [1] [1]/;P;D}' | \
    amend_error_in_article 66 "alinéa 1b's" "alinéa [1bis]" | \
    amend_error_in_article 66 "défini l'article" "défini à l'article" | \
    sed -E '/^\(66\)/{N;s/^(\(66\).*)\n/\1/;P;D}' | \
    sed -E '/^\(66\)/{N;s/^(\(66\).*)\n\(23\) 3e al\. I l/\1 Article 23, alinéa [3] [3] Il/;P;D}' | \
    amend_error_in_article 66 'au er alinéa' "à l'alinéa [1]" | \
    amend_error_in_article 66 'sont mises la' 'sont mises à la' | \
    sed -E '/^\(66\)/{N;s/^(\(66\).*)\n/\1/;P;D}' | \
    sed -E '/^\(66\)/{N;s/^(\(66\).*)\n\(27\) 2e al\. Abrogé 4 \./\1 Article 27, alinéa [2] Abrogé [4] /;P;D}' | \
    amend_error_in_article 66 '\[19692\]' 1969 | \
    amend_error_in_article 66 'suit: Mesures.*$' 'suit:' | \
    sed -E '/^\(66\)/{N;s/^(\(66\).*)\n/\1/;P;D}' | \
    sed -E '/^\(66\)/{N;s/^(\(66\).*)\n\(16\)/\1 Article 16 [1]/;P;D}' | \
    amend_error_in_article 66 'veille ce' 'veille à ce' | \
    amend_error_in_article 66 'inoffensifs. Les' 'inoffensifs. [2] Les' | \
    amend_error_in_article 66 "public. 'L" 'public. [3] L' | \
    amend_error_in_article 66 '1143.*1984 ' '' | \
    amend_error_in_article 66 "travail'\)" travail | \
    amend_error_in_article 66 'Art\. 6, 1" al\.' 'Article 6, alinéa [1] [1]' | \
    amend_error_in_article 66 'santé�1' santé | \
    amend_error_in_article 66 'expérience démontré' 'expérience a démontré' | \
    # Article 67
    sed -E 's/^\(67\) (Délai référendaire et entrée en vigueur)/\1\n(67) [1]/' | \
    amend_error_in_article 67 'facultatif\. Le' 'facultatif. [2]' | \
    amend_error_in_article 67 'vigueur\. Conseil.*$' 'vigueur.' | \
    sed '/^Art\. Infractions/d'
}

function amend_errors_in_headers {
  sed -E 's/^(Titre premier):( Principes.*) (Chapitre premier):/\1 -\2\n\n\3 -/' | \
    sed -E 's/^(Section 1 - )E(missions)/\1É\2/'
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
