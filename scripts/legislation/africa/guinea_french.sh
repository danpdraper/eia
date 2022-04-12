function remove_all_text_before_first_header {
  sed -E 's/ (Titre 1 )/\n\1/' | \
    sed -n '/^Titre 1 /,$p'
}

function add_newlines_between_titles_and_chapters_and_articles {
  sed -E 's/^(Titre .*) (Chapitre )/\1\n\n\2/' | \
    sed -E 's/^(Titre .*) Art\.([0-9]+)\.-/\1\n\n(\2)/' | \
    sed -E ':start;s/^(Chapitre .*) Art\.([0-9]+)\.-/\1\n\n(\2)/;t start'
}

function amend_errors_in_articles {
  sed -E 's/Energie/Énergie/g' | \
    sed -E 's/Etat/État/g' | \
    sed -E 's/n°/numéro /g' | \
    # Article 2
    amend_error_in_article 2 'le quel' lequel | \
    # Article 3
    sed -E ':start;s/^(\(3\).*)\[•\] /\1/;t start' | \
    sed -E ':start;s/^(\(3\).*)([0-9])°/\1[\2]/;t start' | \
    amend_error_in_article 3 '"Polluant"' '"Polluant":' | \
    # Article 7
    amend_error_in_article 7 'informa-.*2\/13 ' informa | \
    amend_error_in_article 7 "d l'environnement" "de l'environnement" | \
    # Article 8
    amend_error_in_article 8 'national, \[' 'national; [' | \
    amend_error_in_article 8 'porter sectorielle' 'portée sectorielle' | \
    # Article 9
    amend_error_in_article 9 '19 Mars fixant' '19 Mars 1986 fixant' | \
    amend_error_in_article 9 '008\/PRG\/du' '008\/PRG\/86 du' | \
    # Article 11
    amend_error_in_article 11 'environnement elle' 'environnement, elle' | \
    # Article 14
    amend_error_in_article 14 ' www.*3\/13' '' | \
    # Article 16
    amend_error_in_article 16 alinéas alinéa | \
    # Article 20
    amend_error_in_article 20 '076\/PRG' '076\/PRG\/86' | \
    # Article 25
    amend_error_in_article 25 ' www.*4\/13' '' | \
    amend_error_in_article 25 chargée chargé | \
    # Article 34
    amend_error_in_article 34 'dernières\. \[' 'dernières; [' | \
    amend_error_in_article 34 ' www.*Art\.35\.-' '\n\n(35)' | \
    # Article 36
    amend_error_in_article 36 plateforme 'plate-forme' | \
    amend_error_in_article 36 'e recouvrir' recouvrir | \
    # Article 39
    amend_error_in_article 39 Equipement Équipement | \
    # Article 41
    amend_error_in_article 41 Code 'Code.' | \
    # Article 42
    amend_error_in_article 42 'industriels,commerciaux' 'industriels, commerciaux' | \
    # Article 43
    amend_error_in_article 43 'au delà' 'au-delà' | \
    amend_error_in_article 43 ' www.*6\/13' '' | \
    # Article 49
    amend_error_in_article 49 interdit interdite | \
    amend_error_in_article 49 susceptible susceptibles | \
    # Article 50
    sed -E ':start;s/^(\(50\).*), \[/\1; [/;t start' | \
    # Article 52
    amend_error_in_article 52 'terrestre,maritime' 'terrestre, maritime' | \
    # Article 53
    amend_error_in_article 53 ' www.*7\/13' '' | \
    # Article 54
    amend_error_in_article 54 aliéna alinéa | \
    amend_error_in_article 54 '\[52\]' '52.' | \
    # Article 55
    amend_error_in_article 55 'privées sont u bien' 'privées, sont un bien' | \
    # Article 56
    amend_error_in_article 56 'national; doivent' 'national, doivent' | \
    # Article 57
    amend_error_in_article 57 53et '53 et' | \
    amend_error_in_article 57 'ayant \[•\] droits' 'ayant-droits' | \
    # Article 64
    amend_error_in_article 64 agglomération agglomérations | \
    # Article 65
    amend_error_in_article 65 '- www.*8\/13 ' '' | \
    # Article 66
    amend_error_in_article 66 'Code ces' 'Code. Ces' | \
    # Article 67
    amend_error_in_article 67 'détention la' 'détention, la' | \
    amend_error_in_article 67 'nécessité les' 'nécessité, les' | \
    # Article 68
    amend_error_in_article 68 parvenir prévenir | \
    # Article 69
    amend_error_in_article 69 ';publique ou privée;' ', publique ou privée,' | \
    amend_error_in_article 69 "publique l'agriculture" "publique, l'agriculture" | \
    amend_error_in_article 69 'Les établissement' 'Les établissements' | \
    amend_error_in_article 69 susceptible susceptibles | \
    amend_error_in_article 69 '\[69\]' '69.' | \
    amend_error_in_article 69 ' Art\.71\.-' '.\n\n(71)' | \
    amend_error_in_article 69 ' Art\.70\.-' '.\n\n(70)' | \
    # Article 73
    amend_error_in_article 73 ' www.*9\/13' '' | \
    amend_error_in_article 73 1ne '1 ne' | \
    # Article 77
    amend_error_in_article 77 'fraudes; les' 'fraudes, les' | \
    # Article 79
    amend_error_in_article 79 'toute les' 'toutes les' | \
    # Article 81
    amend_error_in_article 81 'les quels' lesquels | \
    amend_error_in_article 81 '- www.*10\/13 ' '' | \
    # Article 83
    sed -E ':start;s/^(\(83\).*\] )u/\1U/;t start' | \
    # Article 84
    amend_error_in_article 84 'faire face' 'faisant face' | \
    # Article 85
    amend_error_in_article 85 69et '69 et' | \
    # Article 86
    amend_error_in_article 86 élaborations élaboration | \
    amend_error_in_article 86 '\[85\]' '85.' | \
    # Article 87
    amend_error_in_article 87 ' www.*$' '' | \
    # Article 88
    amend_error_in_article 88 '; \[' ', [' | \
    # Article 90
    amend_error_in_article 90 aliéna alinéa | \
    amend_error_in_article 90 majeure 'majeure.' | \
    # Article 91
    amend_error_in_article 91 solidement solidairement | \
    amend_error_in_article 91 amandes amendes | \
    # Article 92
    amend_error_in_article 92 contraire 'contraire.' | \
    # Article 93
    amend_error_in_article 93 '\. sont' '. Sont' | \
    amend_error_in_article 93 ', \[' '; [' | \
    amend_error_in_article 93 'atterrissage,après' 'atterrissage, après' | \
    # Article 94
    amend_error_in_article 94 ' www.*12\/13 Chapitre 3 \[•\]' '\n\nChapitre 3 -' | \
    # Article 96
    amend_error_in_article 96 amande amende | \
    amend_error_in_article 96 'FG à' à | \
    # Article 97
    amend_error_in_article 97 1000 '1.000' | \
    amend_error_in_article 97 1à '1 à' | \
    # Article 99
    amend_error_in_article 99 0à '0 à' | \
    amend_error_in_article 99 0000 000 | \
    # Article 102
    amend_error_in_article 102 3ans '3 ans' | \
    # Article 106
    amend_error_in_article 106 '2 5' 5 | \
    # Article 109
    amend_error_in_article 109 '61,62' '61, 62' | \
    amend_error_in_article 109 '67.*$' '67 alinéa 1.' | \
    # Article 110
    amend_error_in_article 110 25 "Est punie d'une amende de 25" | \
    amend_error_in_article 110 '\[100\]' 100 | \
    amend_error_in_article 110 'al\.2' 'alinéa 2' | \
    amend_error_in_article 110 'al 2' 'alinéa 2' | \
    amend_error_in_article 110 000Fg '000 FG' | \
    # Article 111
    amend_error_in_article 111 ' www.*13\/13' ''
}

function amend_errors_in_headers {
  sed -E 's/- -/-/' | \
    sed -E 's/^(Chapitre 2 -.*)Etablissements/\1établissements/'
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
    add_newlines_between_titles_and_chapters_and_articles | \
    amend_errors_in_articles | \
    amend_errors_in_headers
}
