function capitalize_title_chapter_and_section_literals {
  sed -E 's/TíTULO/TÍTULO/g' | \
    sed -E 's/CAPíTULO/CAPÍTULO/g' | \
    sed -E 's/SECCiÓN/SECCIÓN/g'
}

function capitalize_headers {
  local stdin="$(</dev/stdin)"

  if [ "$#" -ne 1 ] ; then
    echo_usage_error "$*" '<language>'
    return 1
  fi
  local language="$1"

  local header_regular_expression
  header_regular_expression="$(get_header_regular_expression $language)"
  local return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  echo "$stdin" | sed -E "s/^(${header_regular_expression}).*$/\U&/"
}

function remove_all_text_before_first_title_header {
  sed -n '/^TÍTULO PRELIMINAR/,$p'
}

function remove_trailing_bullet_points {
  sed -E 's/ •$//'
}

function remove_periods_from_headers {
  local stdin="$(</dev/stdin)"

  if [ "$#" -ne 1 ] ; then
    echo_usage_error "$*" '<language>'
    return 1
  fi
  local language="$1"

  local header_regular_expression
  header_regular_expression="$(get_header_regular_expression $language)"
  local return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  local ordinal_regular_expression
  ordinal_regular_expression="$(get_ordinal_regular_expression $language)"
  return_code="$?"
  if [ "$return_code" -ne 0 ] ; then return "$return_code" ; fi

  local regular_expression="^(${header_regular_expression}) "
  regular_expression+="(${ordinal_regular_expression})([^.]+)\."

  echo "$stdin" | sed -E "s/${regular_expression}/\1 \2\3/"
}

function amend_errors_in_articles {
  # Article 1
  amend_error_in_article 1 'lograr:el' 'lograr el' | \
    amend_error_in_article 1 'Pais\.' 'País.' | \
    # Article 3
    amend_error_in_article 3 td9as todas | \
    # Article 4
    amend_error_in_article 4 Leyes 'Ley es' | \
    amend_error_in_article 4 periodlcidad periodicidad | \
    # Article 5
    amend_error_in_article 5 Intervención intervención | \
    # Article 7
    amend_error_in_article 7 'o com pensar' 'o compensar' | \
    # Article 9
    amend_error_in_article 9 ~reventivas preventivas | \
    amend_error_in_article 9 "impacto 'negativo" 'impacto negativo' | \
    amend_error_in_article 9 '\[•\] \[b\]' '[b]' | \
    amend_error_in_article 9 'subsidiar\/edad' subsidiariedad | \
    amend_error_in_article 9 'generala especial' 'general o especial' | \
    amend_error_in_article 9 'eí lugar' 'el lugar' | \
    amend_error_in_article 9 'Impacto negativo' 'impacto negativo' | \
    # Article 10
    amend_error_in_article 10 'Acuerdo voluntarío' 'Acuerdo voluntario' | \
    amend_error_in_article 10 'medioambiental mente' medioambientalmente | \
    amend_error_in_article 10 'I \[2\]' '[2]' | \
    amend_error_in_article 10 'ía seguridad' 'la seguridad' | \
    amend_error_in_article 10 descrípción descripción | \
    amend_error_in_article 10 agrlcola agrícola | \
    amend_error_in_article 10 descornposición descomposición | \
    amend_error_in_article 10 Géstión Gestión | \
    amend_error_in_article 10 'garantl<;e' garantice | \
    amend_error_in_article 10 apropíados apropiados | \
    amend_error_in_article 10 'degradaci¡in' degradación | \
    amend_error_in_article 10 poblacíón población | \
    amend_error_in_article 10 disferentes diferentes | \
    amend_error_in_article 10 yaguas 'y aguas' | \
    amend_error_in_article 10 'Valor timite' 'Valor límite' | \
    amend_error_in_article 10 "el hombre', la fauna" 'el hombre, la fauna' | \
    amend_error_in_article 10 'Area protegida' 'Área protegida' | \
    amend_error_in_article 10 laalteración 'la alteración' | \
    amend_error_in_article 10 'y fares· tal' 'y forestal' | \
    amend_error_in_article 10 'del lugar\. ! \.' 'del lugar.' | \
    amend_error_in_article 10 'medio amblente' 'medio ambiente' | \
    amend_error_in_article 10 '\[•\] \[37\]' '[37]' | \
    amend_error_in_article 10 'rnoda!idades' modalidades | \
    amend_error_in_article 10 'por, \[a\]' 'por: [a]' | \
    amend_error_in_article 10 'pero sanas' personas | \
    amend_error_in_article 10 'vegetalo los ecosistemas' 'vegetal o los ecosistemas' | \
    amend_error_in_article 10 ', el bienes- \[41\]' ', el [41].' | \
    amend_error_in_article 10 'las duíces' 'las dulces' | \
    amend_error_in_article 10 "\. , '\. \[50\]" '. [50]' | \
    amend_error_in_article 10 caracterlsticas características | \
    amend_error_in_article 10 'medioambien- \. tales' medioambientales | \
    amend_error_in_article 10 '\. " \[52\]' '. [52]' | \
    amend_error_in_article 10 'Impida su renovación' 'impida su renovación' | \
    amend_error_in_article 10 re~idente residente | \
    amend_error_in_article 10 SÓlidos sólidos | \
    amend_error_in_article 10 'recuperación yeliminación' 'recuperación y eliminación' | \
    amend_error_in_article 10 "mismos\. \[•\] '\." 'mismos.' | \
    amend_error_in_article 10 'contenidos\. \.' 'contenidos.' | \
    # Article 11
    amend_error_in_article 11 'titularidao u r2;;::-:-lell jwídico' 'titularidad o régimen jurídico' | \
    amend_error_in_article 11 'renovables \. \[•\]' 'renovables.' | \
    amend_error_in_article 11 formatión formación | \
    amend_error_in_article 11 'y cientificos' 'y científicos' | \
    # Article 13
    amend_error_in_article 13 'articulo 11' 'artículo 11' | \
    amend_error_in_article 13 '\[e\] Señalar' '[c] Señalar' | \
    amend_error_in_article 13 'caracteristicas IIsicas' 'características físicas' | \
    amend_error_in_article 13 '\[e\] Determinación' '[c] Determinación' | \
    amend_error_in_article 13 reglmenes regímenes | \
    amend_error_in_article 13 aplicárseres aplicárseles | \
    amend_error_in_article 13 "articulo'\." 'artículo.' | \
    amend_error_in_article 13 'apartado 3 \[e\]' 'apartado [3][e]' | \
    amend_error_in_article 13 ' \[•\] Artículo 14' '\n\n(14)' | \
    # Article 14
    amend_error_in_article 14 '¡efiere el articulo' 'refiere el artículo' | \
    amend_error_in_article 14 "con9'lituyendo" constituyendo | \
    amend_error_in_article 14 limite límite | \
    amend_error_in_article 14 fisica física | \
    amend_error_in_article 14 IIsica física | \
    amend_error_in_article 14 temtorial territorial | \
    amend_error_in_article 14 '\. \[•\]' '.' | \
    amend_error_in_article 14 'panes o programas' 'planes o programas' | \
    # Article 15
    amend_error_in_article 15 articulo artículo | \
    # Article 16
    amend_error_in_article 16 IIsica física | \
    amend_error_in_article 16 Imposible imposible | \
    amend_error_in_article 16 'Jos Recursos' 'los Recursos' | \
    amend_error_in_article 16 fisica física | \
    # Article 18
    amend_error_in_article 18 'entorno\. \.' 'entorno.' | \
    amend_error_in_article 18 "'ograr" lograr | \
    # Article 19
    amend_error_in_article 19 'espacros marltimos' 'espacios marítimos' | \
    # Article 21
    amend_error_in_article 21 '\[e\] Monumentos' '[c] Monumentos' | \
    amend_error_in_article 21 Paísajes Paisajes | \
    # Article 22
    amend_error_in_article 22 tíora flora | \
    amend_error_in_article 22 justifícado justificado | \
    # Article 23
    amend_error_in_article 23 impotencia importancia | \
    amend_error_in_article 23 'recursos\.Ísatvo' 'recursos, salvo' | \
    amend_error_in_article 23 Mmisterio Ministerio | \
    # Article 25
    amend_error_in_article 25 torrnaciones formaciones | \
    # Article 27
    amend_error_in_article 27 Cuandoproceda 'Cuando proceda' | \
    amend_error_in_article 27 '\[l\] ZONA RESTRINGIDA\.-' '[I] ZONA RESTRINGIDA.' | \
    amend_error_in_article 27 '\[11\] ZONA ABIERTA\.-' '[II] ZONA ABIERTA.' | \
    amend_error_in_article 27 '\[111\] ZONA TRADICIONAL\.-' '[III] ZONA TRADICIONAL.' | \
    amend_error_in_article 27 'ZONA ESPECIAL\.-' 'ZONA ESPECIAL.' | \
    amend_error_in_article 27 Amortiguamíento Amortiguamiento | \
    # Article 28
    amend_error_in_article 28 deterrninaciones determinaciones | \
    amend_error_in_article 28 'jos órganos' 'los órganos' | \
    amend_error_in_article 28 "\. , '\." '.' | \
    # Article 29
    amend_error_in_article 29 '\. ,' '.' | \
    # Article 31
    amend_error_in_article 31 'yen particular' 'y en particular' | \
    amend_error_in_article 31 'protegido\. \[e\] Informar' 'protegido. [c] Informar' | \
    amend_error_in_article 31 'gestión, \[e\]' 'gestión [e]' | \
    # Article 32
    amend_error_in_article 32 'estado\. o cuando' 'estado, o cuando' | \
    amend_error_in_article 32 'Naturales\. de' 'Naturales, de' | \
    amend_error_in_article 32 'articulo 13-4 ' 'artículo 13[4]' | \
    amend_error_in_article 32 ', al La' ': [a] La' | \
    amend_error_in_article 32 'tutor\. con' 'tutor, con' | \
    amend_error_in_article 32 'estado, \[1\]' 'estado. [1]' | \
    amend_error_in_article 32 'Zona\.' 'Zona,' | \
    amend_error_in_article 32 'articulo 16' 'artículo 16' | \
    amend_error_in_article 32 'este Capitulo' 'este Capítulo' | \
    # Article 33
    amend_error_in_article 33 '\[y\] en su caso' 'y, en su caso' | \
    amend_error_in_article 33 "cuencas\. \[•\] '\." 'cuencas.' | \
    # Article 34
    amend_error_in_article 34 categorlas categorías | \
    amend_error_in_article 34 'articulo 37' 'artículo 37' | \
    amend_error_in_article 34 Silvestres silvestres | \
    amend_error_in_article 34 artícu1037 'artículo 37' | \
    amend_error_in_article 34 categorlas categorías | \
    amend_error_in_article 34 '\. lB Artículo 35' '.\n\n(35)' | \
    # Article 35
    amend_error_in_article 35 preservacion preservación | \
    amend_error_in_article 35 '\[e\] Conceder' '[c] Conceder' | \
    # Article 36
    amend_error_in_article 36 'artículo 34-4' 'artículo 34[4]' | \
    amend_error_in_article 36 'ía legislación' 'la legislación' | \
    amend_error_in_article 36 estabecido establecido | \
    amend_error_in_article 36 'artículos 35-4' 'artículos 35[4]' | \
    amend_error_in_article 36 'protegidas\. \[e\]' 'protegidas. [c]' | \
    amend_error_in_article 36 autorizacíón autorización | \
    amend_error_in_article 36 '\[e\] Las' '[c] Las' | \
    amend_error_in_article 36 "y'lugar" 'y lugar' | \
    amend_error_in_article 36 'apartado 2 anterior' 'apartado [2] anterior' | \
    amend_error_in_article 36 'inmediata "de la' 'inmediata de la' | \
    # Article 37
    amend_error_in_article 37 'la siguientes' 'las siguientes' | \
    amend_error_in_article 37 '\[e\] Vulnerables' '[c] Vulnerables' | \
    amend_error_in_article 37 'nesgo de pasar' 'riesgo de pasar' | \
    amend_error_in_article 37 'sin eslar' 'sin estar' | \
    amend_error_in_article 37 cientifico científico | \
    # Article 38
    amend_error_in_article 38 Ambienle Ambiente | \
    amend_error_in_article 38 anteríor anterior | \
    # Article 39
    amend_error_in_article 39 calegorías categorías | \
    amend_error_in_article 39 'peligro de exlínción' 'peligro de extinción' | \
    amend_error_in_article 39 'al Tratándose' '[a] Tratándose' | \
    amend_error_in_article 39 autorízada autorizada | \
    amend_error_in_article 39 'asi como' 'así como' | \
    amend_error_in_article 39 '\[e\] En' '[c] En' | \
    amend_error_in_article 39 reglamentaríamente reglamentariamente | \
    amend_error_in_article 39 categoria categoría | \
    amend_error_in_article 39 exígirá exigirá | \
    amend_error_in_article 39 hábilat hábitat | \
    amend_error_in_article 39 "Hábitat\. '\." 'Hábitat.' | \
    amend_error_in_article 39 proteccíón protección | \
    amend_error_in_article 39 'medidas, necesarias' 'medidas necesarias' | \
    # Article 40
    amend_error_in_article 40 contínental continental | \
    amend_error_in_article 40 "las'aguas donde" 'las aguas donde' | \
    amend_error_in_article 40 acuicola acuícola | \
    amend_error_in_article 40 'terrenos acolados' 'terrenos acotados' | \
    # Article 41
    amend_error_in_article 41 'al Salvo' '[a] Salvo' | \
    amend_error_in_article 41 'venenoso trampas' 'venenos o trampas' | \
    amend_error_in_article 41 'b \) Queda' '[b] Queda' | \
    amend_error_in_article 41 '\[e\] Solo' '[c] Solo' | \
    amend_error_in_article 41 'generala prohibiciones' 'general o prohibiciones' | \
    amend_error_in_article 41 'el Queda' '[e] Queda' | \
    # Article 42
    amend_error_in_article 42 'aptitud, \.\. y' 'aptitud, y' | \
    amend_error_in_article 42 "que , reglamentarramente se determine\. '\." 'que reglamentariamente se determine.' | \
    amend_error_in_article 42 Estadistica Estadístico | \
    amend_error_in_article 42 áctualizada actualizada | \
    amend_error_in_article 42 piscicolas piscícolas | \
    amend_error_in_article 42 'se crearan' 'se crearán' | \
    # Article 43
    amend_error_in_article 43 'al El' '[a] El' | \
    amend_error_in_article 43 'internacionales\. \[e\]' 'internacionales. [c]' | \
    amend_error_in_article 43 'Título\. o\)' 'Título. [d]' | \
    amend_error_in_article 43 Oceanografia Oceanografía | \
    # Article 44
    amend_error_in_article 44 '^\(44\) Las' '(44) [1] Las' | \
    amend_error_in_article 44 'aquell~¡;' aquellos | \
    amend_error_in_article 44 "responsabilidades\. '" 'responsabilidades.' | \
    # Article 45
    amend_error_in_article 45 'Primera\.-' 'Primera.' | \
    amend_error_in_article 45 quimicos químicos | \
    amend_error_in_article 45 'Segunda\.-' 'Segunda.' | \
    amend_error_in_article 45 'Tercera\.-' 'Tercera.' | \
    amend_error_in_article 45 'Cuarta\.-' 'Cuarta.' | \
    amend_error_in_article 45 'Quinta\.-' 'Quinta.' | \
    amend_error_in_article 45 armonia armonía | \
    amend_error_in_article 45 'Sexta\.-' 'Sexta.' | \
    amend_error_in_article 45 'asi como' 'así como' | \
    amend_error_in_article 45 'Séptima\.-' 'Séptima.' | \
    amend_error_in_article 45 'extinción O vulnerables' 'extinción o vulnerables' | \
    amend_error_in_article 45 'reposo, campo' 'reposo, campeo' | \
    amend_error_in_article 45 'octave\.\.' 'Octava.' | \
    amend_error_in_article 45 'asi como' 'así como' | \
    amend_error_in_article 45 'Novena\.-' 'Novena.' | \
    amend_error_in_article 45 'reposo, campo' 'reposo, campeo' | \
    amend_error_in_article 45 'Décima\.-' 'Décima.' | \
    amend_error_in_article 45 'Undécima\.-' 'Undécima.' | \
    amend_error_in_article 45 'Duodécima\.-' 'Duodécima.' | \
    amend_error_in_article 45 'Decimotercera\.-' 'Decimotercera.' | \
    # Article 46
    amend_error_in_article 46 'asi como' 'así como' | \
    amend_error_in_article 46 articulo artículo | \
    amend_error_in_article 46 "el'~mbito" 'el ámbito' | \
    amend_error_in_article 46 istposición imposición | \
    amend_error_in_article 46 'Generala el' 'General o el' | \
    amend_error_in_article 46 'la via' 'la vía' | \
    amend_error_in_article 46 'apartado 1' 'apartado [1]' | \
    # Article 50 
    amend_error_in_article 50 'al Descripción' '[a] Descripción' | \
    amend_error_in_article 50 'e\) Evaluación' '[c] Evaluación' | \
    amend_error_in_article 50 histórico-artistico histórico-artístico | \
    amend_error_in_article 50 'el Resumen' '[e] Resumen' | \
    amend_error_in_article 50 'inforrnes y rualquiera' 'informes y cualquiera' | \
    amend_error_in_article 50 resultW resultar | \
    amend_error_in_article 50 reatización realización | \
    amend_error_in_article 50 'o,.",c:a' estudio | \
    amend_error_in_article 50 '\. \.' '.' | \
    # Article 51
    amend_error_in_article 51 'con\. éste' 'con éste' | \
    # Article 54
    amend_error_in_article 54 'articulo 49' 'artículo 49' | \
    amend_error_in_article 54 '\. I I I I I I I I I I I I I \[•\] Artículo 55' '.\n\n(55)' | \
    # Article 55
    amend_error_in_article 55 'información\.de' 'información de' | \
    # Article 56
    amend_error_in_article 56 'con ías' 'con las' | \
    amend_error_in_article 56 industríal industrial | \
    # Article 57
    amend_error_in_article 57 'siguientes, \[a\]' 'siguientes: [a]' | \
    amend_error_in_article 57 trasgresión transgresión | \
    # Article 58
    amend_error_in_article 58 artterior anterior | \
    amend_error_in_article 58 '\. \[•\]' '.' | \
    # Article 59
    amend_error_in_article 59 'articulo 50' 'artículo 50' | \
    # Article 60
    amend_error_in_article 60 Titulo Título | \
    amend_error_in_article 60 juridico jurídico | \
    amend_error_in_article 60 energla energía | \
    # Article 62
    amend_error_in_article 62 importádoras importadoras | \
    # Article 63
    amend_error_in_article 63 'articulo 67' 'artículo 67' | \
    amend_error_in_article 63 yeliminación 'y eliminación' | \
    amend_error_in_article 63 mlnimo mínimo | \
    # Article 66
    amend_error_in_article 66 tóxícos tóxicos | \
    amend_error_in_article 66 'responsabilidad Civil' 'responsabilidad civil' | \
    amend_error_in_article 66 'y cuantia' 'y cuantía' | \
    # Article 67
    amend_error_in_article 67 regisho registro | \
    amend_error_in_article 67 Pían Plan | \
    # Article 68
    amend_error_in_article 68 y-gestión 'y gestión' | \
    amend_error_in_article 68 Organo Órgano | \
    # Article 69
    amend_error_in_article 69 intormaciones informaciones | \
    amend_error_in_article 69 retiere refiere | \
    amend_error_in_article 69 cítado citado | \
    # Article 70
    amend_error_in_article 70 'suscepti bies' susceptibles | \
    # Article 71
    amend_error_in_article 71 'los articulas' 'los artículos' | \
    # Article 72
    amend_error_in_article 72 Capitulo Capítulo | \
    # Article 73
    amend_error_in_article 73 "\. '\. 11" '.' | \
    # Article 74
    amend_error_in_article 74 tÓXICOS tóxicos | \
    amend_error_in_article 74 'artículo 63\.3' 'artículo 63[3]' | \
    amend_error_in_article 74 flsicas físicas | \
    amend_error_in_article 74 'articulo \[68\] 7\.' 'artículo 68. [7]' | \
    amend_error_in_article 74 'artículo 66\.2' 'artículo 66[2]' | \
    amend_error_in_article 74 '\. 11' '.' | \
    # Article 75
    amend_error_in_article 75 Titulo Título | \
    amend_error_in_article 75 'muy grayes' 'muy graves' | \
    amend_error_in_article 75 defmitivo definitivo | \
    amend_error_in_article 75 'o Cese' '[•] Cese' | \
    amend_error_in_article 75 'o Prohibición' '[•] Prohibición' | \
    amend_error_in_article 75 'o Multa' '[•] Multa' | \
    amend_error_in_article 75 'o Cierre' '[•] Cierre' | \
    amend_error_in_article 75 'o Cese' '[•] Cese' | \
    amend_error_in_article 75 'o Prohibición' '[•] Prohibición' | \
    amend_error_in_article 75 'o Multa' '[•] Multa' | \
    amend_error_in_article 75 'o Cierre' '[•] Cierre' | \
    amend_error_in_article 75 'o Multa' '[•] Multa' | \
    # Article 77
    amend_error_in_article 77 'la r correspondiente' 'la correspondiente' | \
    amend_error_in_article 78 Organo Órgano | \
    amend_error_in_article 77 dificil difícil | \
    amend_error_in_article 77 'o Coste' '[•] Coste' | \
    amend_error_in_article 77 'o Valor' '[•] Valor' | \
    # Article 78
    amend_error_in_article 78 hubíere hubiere | \
    # Article 82
    amend_error_in_article 82 'hídri- \[•\] COS' hídricos | \
    amend_error_in_article 82 'podrás otorgar' 'podrán otorgar' | \
    # Article 84
    amend_error_in_article 84 '\. , ' '.\n\n' | \
    # Article 85
    amend_error_in_article 85 prevencíón prevención | \
    amend_error_in_article 85 hídrícos hídricos | \
    # Article 86
    amend_error_in_article 86 entíende entiende | \
    amend_error_in_article 86 equitibnq equilibrio | \
    # Article 87
    amend_error_in_article 87 'articulo precedente' 'artículo precedente' | \
    amend_error_in_article 87 limites límites | \
    # Article 88
    amend_error_in_article 88 yespecialmente 'y especialmente' | \
    amend_error_in_article 88 perjuício perjuicio | \
    amend_error_in_article 88 'por razo- I' 'por razones de' | \
    amend_error_in_article 88 erniestablecidos 'emisión establecidos' | \
    amend_error_in_article 88 'aplicables\. Cuando' 'aplicables. [5] Cuando' | \
    amend_error_in_article 88 'sera vinculante' 'será vinculante' | \
    # Article 89
    amend_error_in_article 89 'yen los' 'y en los' | \
    amend_error_in_article 89 'Gobierno adoptara' 'Gobierno adoptará' | \
    # Article 90
    amend_error_in_article 90 'asi como' 'así como' | \
    amend_error_in_article 90 emisíones emisiones | \
    amend_error_in_article 90 ínmisión inmisión | \
    # Article 91
    amend_error_in_article 91 perseguírá perseguirá | \
    amend_error_in_article 91 inmisíón inmisión | \
    amend_error_in_article 91 ~ingularizadas singularizadas | \
    amend_error_in_article 91 funcionamíento funcionamiento | \
    amend_error_in_article 91 limites límites | \
    amend_error_in_article 91 especíalmente especialmente | \
    amend_error_in_article 91 'normas mas' 'normas más' | \
    amend_error_in_article 91 'zona\. \[•\] \.' 'zona.' | \
    # Article 92
    amend_error_in_article 92 Mlnisterio Ministerio | \
    amend_error_in_article 92 Provinciaí Provincial | \
    amend_error_in_article 92 'inciso el del articulo 91\.2' 'inciso [e] del artículo 91[2]' | \
    amend_error_in_article 92 'siguientes, \[a\]' 'siguientes: [a]' | \
    amend_error_in_article 92 'articulo 88' 'artículo 88' | \
    # Article 93
    amend_error_in_article 93 'articulo anterior' 'artículo anterior' | \
    amend_error_in_article 93 "asistenciales,'" 'asistenciales,' | \
    # Article 94
    amend_error_in_article 94 exrstentes existentes | \
    # Articles 95 and 96
    amend_error_in_article 95 ': Artículo 96' ':\n\n(96)' | \
    amend_error_in_article 96 contaminacion contaminación | \
    amend_error_in_article 96 'futuro\. Los' 'futuro. [2] Los' | \
    amend_error_in_article 96 'atmosférica\. Las' 'atmosférica. [3] Las' | \
    amend_error_in_article 96 'emisores\. La' 'emisores. [4] La' | \
    amend_error_in_article 96 'pública\. Para' 'pública. [5] Para' | \
    amend_error_in_article 96 ' 1: \[2\] ¡: \[3\] , 1; ~"t- \[4\] \. li I \[5\] í; \[•\] 1 t ~\. ' '' | \
    amend_error_in_article 96 'Subvenciones,' 'Subvenciones:' | \
    amend_error_in_article 96 Pais País | \
    amend_error_in_article 96 'quinquenio, \[a\]' 'quinquenio: [a]' | \
    # Article 97
    amend_error_in_article 97 'yen las disposiciónes' 'y en las disposiciones' | \
    amend_error_in_article 97 'penales, \[a\]' 'penales: [a]' | \
    amend_error_in_article 97 vehiculos vehículos | \
    amend_error_in_article 97 'graves nodebida' 'graves no debida' | \
    # Article 98
    amend_error_in_article 98 'corresponde, \[a\]' 'corresponde: [a]' | \
    amend_error_in_article 98 "montos' recaudados" 'montos recaudados' | \
    amend_error_in_article 98 limites límites | \
    # Article 101
    amend_error_in_article 101 Inundación inundación | \
    amend_error_in_article 101 'asi aprobado' 'así aprobado' | \
    amend_error_in_article 101 Ecuatoríal Ecuatorial | \
    # Article 102
    amend_error_in_article 102 biológícos biológicos | \
    # Article 103
    amend_error_in_article 103 conservacion conservación | \
    amend_error_in_article 103 '\. I \[•\] Artículo 104' '.\n\n(104)' | \
    # Article 104
    amend_error_in_article 104 'Se prohiben' 'Se prohíben' | \
    # Article 105
    amend_error_in_article 105 Guínea Guinea | \
    amend_error_in_article 105 utilízación utilización | \
    amend_error_in_article 105 áctividades actividades | \
    # Article 106
    amend_error_in_article 106 íntencionado intencionado | \
    amend_error_in_article 106 jurisdícción jurisdicción | \
    amend_error_in_article 106 pelígrosas peligrosas | \
    amend_error_in_article 106 contamínación contaminación | \
    # Article 107
    amend_error_in_article 107 GUinea Guinea | \
    amend_error_in_article 107 decíarar declarar | \
    amend_error_in_article 107 'ex~emos' extremos | \
    amend_error_in_article 107 '\. \.' '.' | \
    # Article 108
    amend_error_in_article 108 'a fínes' 'a fines' | \
    amend_error_in_article 108 autorizacíones autorizaciones | \
    amend_error_in_article 108 autorízación autorización | \
    # Article 110
    amend_error_in_article 110 qulmicos químicos | \
    amend_error_in_article 110 qulmicas químicas | \
    # Article 111
    amend_error_in_article 111 investigacion investigación | \
    # Article 112
    amend_error_in_article 112 '\[e\] Gestión' '[c] Gestión' | \
    # Article 115
    amend_error_in_article 115 'bJ Al' '[b] Al' | \
    amend_error_in_article 115 medioambíental medioambiental | \
    amend_error_in_article 115 'Anexo 11 ' 'Anexo II ' | \
    amend_error_in_article 115 '\[e\] Al' '[c] Al' | \
    amend_error_in_article 115 'Anexo 111' 'Anexo III' | \
    # Article 116
    amend_error_in_article 116 'disponibles\. \[e\]' 'disponibles. [c]' | \
    amend_error_in_article 116 'inclv,strial determi.nado' 'industrial determinado' | \
    # Article 117
    amend_error_in_article 117 "del'medio" 'del medio' | \
    amend_error_in_article 117 '\[e\] Las' '[c] Las' | \
    # Article 118
    amend_error_in_article 118 'Anexo 1' 'Anexo I' | \
    # Article 119
    amend_error_in_article 119 '\. I I I I' '.' | \
    amend_error_in_article 119 yemisiones 'y emisiones' | \
    amend_error_in_article 119 '\[e\] Integrar' '[c] Integrar' | \
    amend_error_in_article 119 '\. PROCEDIMIENTO' '.\n\nPROCEDIMIENTO' | \
    # Article 120
    amend_error_in_article 120 'al La' '[a] La' | \
    amend_error_in_article 120 juridico jurídico | \
    amend_error_in_article 120 'cinco dias' 'cinco días' | \
    amend_error_in_article 120 '\[e\] El' '[c] El' | \
    amend_error_in_article 120 '\[e\] Evaluación' '[c] Evaluación' | \
    amend_error_in_article 120 "\. , '\." '.' | \
    # Article 121
    amend_error_in_article 121 '\[l\] La' '[I] La' | \
    amend_error_in_article 121 energia energía | \
    amend_error_in_article 121 '\[11\] Las' '[II] Las' | \
    amend_error_in_article 121 '\[111\] Las' '[III] Las' | \
    amend_error_in_article 121 'materia\. \[e\]' 'materia. [c]' | \
    amend_error_in_article 121 '\. -----\.\.,' '.' | \
    amend_error_in_article 121 'un\.resumen' 'un resumen' | \
    amend_error_in_article 121 'apartado 1' 'apartado [1]' | \
    # Article 122
    amend_error_in_article 122 '\. \[•\] \. \[1\] 2\. \[3\] 4\.' '.' | \
    # Article 123
    amend_error_in_article 123 'La resolución' '[1] La resolución' | \
    amend_error_in_article 123 expedíente expediente | \
    amend_error_in_article 123 'El plazo' '[2] El plazo' | \
    amend_error_in_article 123 ', Pasado' '[3] Pasado' | \
    amend_error_in_article 123 'La autorización' '[4] La autorización' | \
    # Article 124
    amend_error_in_article 124 'contenido minimo' 'contenido mínimo' | \
    amend_error_in_article 124 'apartado 1\.1\)' 'apartado [1][1]' | \
    # Article 125
    amend_error_in_article 125 'La resolución' '[1] La resolución' | \
    # Article 126
    amend_error_in_article 126 'actividades-que' 'actividades que' | \
    amend_error_in_article 126 'Anexo 11' 'Anexo II' | \
    # Article 127
    amend_error_in_article 127 ': , \[a\]' ': [a]' | \
    amend_error_in_article 127 'asi como' 'así como' | \
    # Article 129
    amend_error_in_article 129 '\[1\]-' '[1]' | \
    amend_error_in_article 129 'al Proyecto' '[a] Proyecto' | \
    amend_error_in_article 129 '-con suficiente rnformación' 'con suficiente información' | \
    amend_error_in_article 129 '\[e\] Certificado' '[c] Certificado' | \
    # Article 131
    amend_error_in_article 131 prqtección protección | \
    amend_error_in_article 131 'de controlo de' 'de control o de' | \
    amend_error_in_article 131 'SI es desfavorable' 'si es desfavorable' | \
    amend_error_in_article 131 'de controlo de' 'de control o de' | \
    amend_error_in_article 131 'puede atubuir' 'puede atribuir' | \
    amend_error_in_article 131 'apartado 1' 'apartado [1]' | \
    amend_error_in_article 131 Justifiquen justifiquen | \
    amend_error_in_article 131 medioambientaí medioambiental | \
    amend_error_in_article 131 prevencíón prevención | \
    # Article 132
    amend_error_in_article 132 '\. 11' '.' | \
    # Article 133
    amend_error_in_article 133 juridico jurídico | \
    amend_error_in_article 133 '\. I I \[•\] Artículo 134' '.\n\n(134)' | \
    # Article 134
    amend_error_in_article 134 'controlo de garantia' 'control o de garantía' | \
    amend_error_in_article 134 'AUTORIZACiÓN' 'AUTORIZACIÓN' | \
    amend_error_in_article 134 ', DISPOSICIONES' '.\n\nDISPOSICIONES' | \
    # Article 135
    amend_error_in_article 135 'Administraciones,' 'Administraciones:' | \
    # Article 136
    amend_error_in_article 136 'supuestos, al Si' 'supuestos: [a] Si' | \
    amend_error_in_article 136 conveñíents conveniente | \
    amend_error_in_article 136 '\[e\] Si' '[c] Si' | \
    amend_error_in_article 136 significatIvamente significativamente | \
    amend_error_in_article 136 'el Si' '[e] Si' | \
    # Article 137
    amend_error_in_article 137 limites límites | \
    # Article 138
    amend_error_in_article 138 'anexo \[111\] \[•\] Artículo 139' 'anexo III.\n\n(139)' | \
    # Article 139
    amend_error_in_article 139 '1y 11' 'I y II' | \
    # Article 140
    amend_error_in_article 140 'anexo 111' 'anexo III' | \
    amend_error_in_article 140 'urbanística\. si es' 'urbanística, si es' | \
    amend_error_in_article 140 tipologia tipología | \
    amend_error_in_article 140 ', \[a\]' '[a]' | \
    amend_error_in_article 140 'técnico-o' 'técnico o' | \
    amend_error_in_article 140 establecirniehtos establecimientos | \
    amend_error_in_article 140 'anexo \[111\]' 'anexo III.' | \
    amend_error_in_article 140 "sea preceptiva'" 'sea preceptiva' | \
    amend_error_in_article 140 '\[b\] y \[e\]' '[b] y [c]' | \
    amend_error_in_article 140 'anexo 111' 'anexo III' | \
    amend_error_in_article 140 'anexo 111' 'anexo III' | \
    amend_error_in_article 140 'apartados 1,2 y 4' 'apartados [1],[2] y [4]' | \
    amend_error_in_article 140 'apartado 1' 'apartado [1]' | \
    # Article 141
    amend_error_in_article 141 'deí técnico' 'del técnico' | \
    amend_error_in_article 141 'apartado 1' 'apartado [1]' | \
    # Article 142
    amend_error_in_article 142 'anexo 11 ' 'anexo II ' | \
    amend_error_in_article 142 'anexo 11 ' 'anexo II ' | \
    amend_error_in_article 142 'apartado I' 'apartado [1]' | \
    amend_error_in_article 142 'apartado 2' 'apartado [2]' | \
    amend_error_in_article 142 'anexos I y 11-1' 'anexos I y II-1' | \
    amend_error_in_article 142 'anexo 11-2' 'anexo II-2' | \
    amend_error_in_article 142 '\. B\. ACTIVIDADES' '.\n\nB. ACTIVIDADES' | \
    # Article 143
    amend_error_in_article 143 'anexo 111' 'anexo III' | \
    amend_error_in_article 143 'segun el' 'según el' | \
    amend_error_in_article 143 '\. I I I I I I I I I I I I' '.' | \
    amend_error_in_article 143 '\. C\. RÉGIMEN' '.\n\nC. RÉGIMEN' | \
    # Article 144
    amend_error_in_article 144 'Los titulares' '[1] Los titulares' | \
    # Article 145
    amend_error_in_article 145 '\. D\. RÉGIMEN' '.\n\nD. RÉGIMEN' | \
    # Article 146
    amend_error_in_article 146 'laS,omlslones' 'las omisiones' | \
    amend_error_in_article 146 '\. \.' '.' | \
    amend_error_in_article 146 'articulo siguiente' 'artículo siguiente' | \
    # Article 147
    amend_error_in_article 147 muygraves 'muy graves' | \
    amend_error_in_article 147 siguienles siguientes | \
    amend_error_in_article 147 "determinaciones'de" 'determinaciones de' | \
    amend_error_in_article 147 'anexo \[111\] \[•\] Artículo 148' 'anexo III.\n\n(148)' | \
    # Article 148
    amend_error_in_article 148 'fisicas y Jurídicas' 'físicas y jurídicas' | \
    # Article 149
    amend_error_in_article 149 'apartado 2' 'apartado [2]' | \
    amend_error_in_article 149 'articulo 97' 'artículo 97' | \
    # Article 150
    amend_error_in_article 150 'cuantilt\.' cuantía | \
    # Article 151
    amend_error_in_article 151 ', \[a\] El beneficro' '[a] El beneficio' | \
    # Article 153
    amend_error_in_article 153 'medioambiental·' medioambiental | \
    amend_error_in_article 153 '\. E\. TASAS' '.\n\nE. TASAS' | \
    # Article 154
    amend_error_in_article 154 '\. , r \[•\] \[1\] ¡ \[2\] I \[3\] 4\. \[5\] 6\. \[7\] 8\. , f· ¡ i ' '.\n\n' | \
    # Article 155
    amend_error_in_article 155 OerechoPúblico 'Derecho Público' | \
    amend_error_in_article 155 juridica jurídica | \
    amend_error_in_article 155 reaiizar realizar | \
    # Article 156
    amend_error_in_article 156 '\[•\] \[1\]' '[1]' | \
    amend_error_in_article 156 'r \[2\]' '[2]' | \
    amend_error_in_article 156 ' \[•\] Artículo 157' '.\n\n(157)' | \
    # Article 157
    amend_error_in_article 157 'FONAMA, Fomentar' 'FONAMA: [1] Fomentar' | \
    amend_error_in_article 157 'Ambiente\. Apoyar' 'Ambiente. [2] Apoyar' | \
    amend_error_in_article 157 'voluntario\. Promover' 'voluntario. [3] Promover' | \
    amend_error_in_article 157 'Ambiente\. Potenciar' 'Ambiente. [4] Potenciar' | \
    amend_error_in_article 157 'medioambiental\. En' 'medioambiental. [5] En' | \
    amend_error_in_article 157 'propias\. Apoyar' 'propias. [6] Apoyar' | \
    amend_error_in_article 157 'sostenible\. Apoyar' 'sostenible. [7] Apoyar' | \
    amend_error_in_article 157 'cuando asi lo' 'cuando así lo' | \
    amend_error_in_article 157 'requieran\. Cualesquiera' 'requieran. [8] Cualesquiera' | \
    amend_error_in_article 157 "'atenderá" atenderá | \
    # Article 159
    amend_error_in_article 159 '\. \."' '.' | \
    # Article 160
    amend_error_in_article 160 'los articulas' 'los artículos' | \
    amend_error_in_article 160 'distintas vias' 'distintas vías' | \
    # Article 163
    amend_error_in_article 163 FüNAMA FONAMA | \
    amend_error_in_article 163 '\[l\]' '[1]' | \
    amend_error_in_article 163 FüNAMA FONAMA | \
    amend_error_in_article 163 FüNAMA FONAMA | \
    amend_error_in_article 163 'enlre los' 'entre los' | \
    amend_error_in_article 163 FüNAMA FONAMA | \
    amend_error_in_article 163 FüNAMA FONAMA | \
    amend_error_in_article 163 FüNAMA FONAMA | \
    amend_error_in_article 163 '\. DISPOSICIONES FINALES' '.\n\nDISPOSICIONES FINALES' | \
    amend_error_in_article 163 '\. DISPOSICiÓN DEROGATORIA' '.\n\nDISPOSICIÓN DEROGATORIA' | \
    amend_error_in_article 163 '\. DISPOSICiÓN TRANSITORIA' '.\n\nDISPOSICIÓN TRANSITORIA' | \
    amend_error_in_article 163 '\. DISPOSICIONES ADICIONALES' '.\n\nDISPOSICIONES ADICIONALES'
}

function split_article_96_into_articles_95_and_96 {
  local stdin="$(</dev/stdin)"

  local mislabeled_article_96_text="$(echo "$stdin" | grep -E '^\(95\)' | sed -E 's/^\(95\)//')"

  echo "$stdin" | \
    sed -E "s/^\(96\)(.*)(\[1\] Subvenciones.*$)/(95)\1\n\n(96) [1]${mislabeled_article_96_text} \2/" | \
    sed -E '/^\(95\) Los/,+1d'
}

function add_bis_suffix_to_article_140 {
  sed -E 's/^\(140\) La/(140 bis) La/'
}

function amend_errors_in_headers {
  sed -E 's/^(SECCIÓN PRIMERA.*)~ROTEGIDOS/\1PROTEGIDOS/' | \
    sed -E 's/^(CAPÍTULO CUARTO.*) ,$/\1/' | \
    sed -E 's/^(CAPÍTULO QUINTO) -/\1/' | \
    sed -E "s/^(SECCIÓN SEGUNDA.*)L,\/LCAZA Y L~--'PESCA COI'LJINEN_TAL/\1LA CAZA Y LA PESCA CONTINENTAL/" | \
    sed -E 's/^(CAPÍTULO PRIMERO.*PELIGROSOS)\./\1/' | \
    sed -E 's/^(SECCIÓN TERCERA.*)Q, INFRACCIONES_Y/\1D, INFRACCIONES Y/' | \
    sed -E 's/^(SECCIÓN PRIMERA - RÉGIMEN DE LA AUTORIZACIÓN MEDIOAMBIENTAL) /\1\n\n/' | \
    sed -E 's/^(SECCIÓN SEGUNDA.*)L1CENCIAMEº,OAIVIJLL\.ENTA!" /\1LICENCIA MEDIOAMBIENTAL\n\n/' | \
    sed -E 's/^(SECCIÓN TERCERA - RÉGIMEN DE )CQMUNICACIÓN/\1COMUNICACIÓN/' | \
    sed -E 's/^(CAPÍTULO SEXTO).*L (SISTEMA.*) (A\.)/\1\n\nI. \2\n\n\3/' | \
    sed -E 's/^(TÍTULO QUINTO)\./\1 -/'
}

function format_disposiciones_adicionales {
  local stdin="$(</dev/stdin)"

  local line_prefix='DISPOSICIONES ADICIONALES'

  echo "$stdin" |
    sed -E "s/^(${line_prefix}.*\.) (Décima\.)-/\1\n\2/" | \
    sed -E "s/^(${line_prefix}.*\.) (Novena\.)-/\1\n\2/" | \
    sed -E "s/^(${line_prefix}.*)especificamente/\1específicamente/" | \
    sed -E "s/^(${line_prefix}.*\.) (Octava\.)-/\1\n\2/" | \
    sed -E "s/^(${line_prefix}.*)las cuantias/\1las cuantías/" | \
    sed -E "s/^(${line_prefix}.*\.) (Séptima\.)-/\1\n\2/" | \
    sed -E "s/^(${line_prefix}.*)mlnimas/\1mínimas/" | \
    sed -E "s/^(${line_prefix}.*\.) (Sexta\.)-/\1\n\2/" | \
    sed -E "s/^(${line_prefix}.*)Sin ánimo/\1sin ánimo/" | \
    sed -E "s/^(${line_prefix}.)derechosreales/\1derechos reales/" | \
    sed -E "s/^(${line_prefix}.*\.) (Quinta\.)-/\1\n\2/" | \
    sed -E "s/^(${line_prefix}.*\.) (Cuarta\.)-/\1\n\2/" | \
    sed -E "s/^(${line_prefix}.*\.) (Tercera\.)-/\1\n\2/" | \
    sed -E "s/^(${line_prefix}.*)sea , parte,/\1sea parte,/" | \
    sed -E "s/^(${line_prefix}.*)üNG/\1ONG/" | \
    sed -E "s/^(${line_prefix}.*\.) (Segunda\.)-/\1\n\2/" | \
    sed -E "s/^(${line_prefix}.*estatales )especificas/\1específicas/" | \
    sed -E "s/^(${line_prefix}) •r (Primera\.)-/\1\n\n\2/"
}

function format_disposicion_transitoria {
  local stdin="$(</dev/stdin)"

  local line_prefix='DISPOSICIÓN TRANSITORIA'

  echo "$stdin" | \
    sed -E "s/^(${line_prefix}.*)anexo 1 /\1anexo I /" | \
    sed -E "s/^(${line_prefix}.*)anexo 11/\1anexo II/" | \
    sed -E "s/^(${line_prefix}.*) \[2004\] 3\./\1 2004. [3]/" | \
    sed -E "s/^(${line_prefix}.*)sustitucián/\1sustitución/" | \
    sed -E "s/^(${line_prefix}) /\1\n\n/"
}

function format_disposicion_derogatoria {
  local stdin="$(</dev/stdin)"

  local line_prefix='DISPOSICIÓN DEROGATORIA'

  echo "$stdin" | \
    sed -E "s/^(${line_prefix}.*)yen especial/\1y en especial/" | \
    sed -E ":start;s/^(${line_prefix}.*)Ley n\"/\1Ley número/;t start" | \
    sed -E "s/^(${line_prefix}.*)\[1\] Ley/\1[I] Ley/" | \
    sed -E "s/^(${line_prefix}.*)\[11\] El/\1[II] El/" | \
    sed -E "s/^(${line_prefix}.*)\[111\] Ley/\1[III] Ley/" | \
    sed -E "s/^(${line_prefix}) \[•\] /\1\n\n/"
}

function format_disposiciones_finales {
  local stdin="$(</dev/stdin)"

  local line_prefix='DISPOSICIONES FINALES'

  echo "$stdin" | \
    sed -E "s/^(${line_prefix}.*) Así lo dispongo.*$/\1/" | \
    sed -E "s/^(${line_prefix}.*)dia 10/\1día 10/" | \
    sed -E "s/^(${line_prefix}.*)Boletin/\1Boletín/" | \
    sed -E "s/^(${line_prefix}.*\.) (Cuarta\.)-/\1\n\2/" | \
    sed -E "s/^(${line_prefix}.*\.) (Tercera\.)-/\1\n\2/" | \
    sed -E "s/^(${line_prefix}.*)\. oodrá llevar/\1, podrá llevar/" | \
    sed -E "s/^(${line_prefix}.*)mndifir-acionas\./\1modificaciones,/" | \
    sed -E "s/^(${line_prefix}.*)rpfllnrlirinnp,/\1refundiciones/" | \
    sed -E "s/^(${line_prefix}.*)v <:;llnrpc;innp, ,-jI\" f r 1 r/\1y supresiones de/" | \
    sed -E "s/^(${line_prefix}.*\.) (Segunda\.)-/\1\n\2/" | \
    sed -E "s/^(${line_prefix}): (Primera\.)-/\1\n\n\2/"
}

function preprocess_state_and_language_input_file {
  if [ "$#" -ne 2 ] ; then
    echo_usage_error "$*" '<input_file_path> <language>'
    return 1
  fi
  local input_file_path="$1"
  local language="$2"

  cat "$input_file_path" | \
    capitalize_title_chapter_and_section_literals | \
    apply_common_transformations_to_stdin "$language" | \
    remove_all_text_before_first_title_header | \
    remove_trailing_bullet_points | \
    amend_errors_in_articles | \
    split_article_96_into_articles_95_and_96 | \
    add_bis_suffix_to_article_140 | \
    capitalize_headers "$language" | \
    remove_periods_from_headers "$language" | \
    amend_errors_in_headers | \
    format_disposiciones_adicionales | \
    format_disposicion_transitoria | \
    format_disposicion_derogatoria | \
    format_disposiciones_finales
}
