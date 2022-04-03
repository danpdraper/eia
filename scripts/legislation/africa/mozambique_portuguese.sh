function remove_all_text_before_first_header {
  sed -n '/^CAPITULO I /,$p'
}

function amend_errors_in_articles {
  sed -E 's/(GERAIS) ARTIGO J/\1\n\n(1)/' | \
    sed -E 's/ A\.RU002\./\n\n(2)/' | \
    sed -E "s/ AR\/\.'fIGQ'3/\n\n(3)/" | \
    sed -E 's/ AR-TJQ\.\.0,4:/\n\n(4)/' | \
    sed -E 's/(AMBIENTAL) ARTIGOS/\1\n\n(5)/' | \
    sed -E 's/ ARTIG0([0-9]+)/\n\n(\1)/g' | \
    sed -E 's/ ARTIU028/\n\n(28)/' | \
    sed -E 's/ Alt110030/\n\n(30)/' | \
    sed -E 's/ ARtlG033/\n\n(33)/' | \
    # Article 1
    amend_error_in_article 1 Defimções Definições | \
    amend_error_in_article 1 Lei 'Lei:' | \
    amend_error_in_article 1 Actzvulade '[1] Actividade' | \
    amend_error_in_article 1 'ê qualquer acçao' 'é qualquer acção' | \
    amend_error_in_article 1 'miciauva p4bbca' 'iniciativa pública' | \
    amend_error_in_article 1 'pnvada relac10nada' 'privada relacionada' | \
    amend_error_in_article 1 'uuhzi,~a9 ou a \[e\]xploraçao' 'utilização ou a exploração' | \
    amend_error_in_article 1 'component\\l~ amb1;ntats' 'componentes ambientais' | \
    amend_error_in_article 1 'a,arIJJ;~Çã1\?\.de t~Rolog1as' 'a aplicação de tecnologias' | \
    amend_error_in_article 1 'process<,>s prQdl\)ttvo~\.' 'processos produtivos,' | \
    amend_error_in_article 1 'pl~AA,\);t:>r9a_i:\{\\\+\\lf~~ !qtos' 'planos, programas, actos' | \
    amend_error_in_article 1 'regulamenw~i1 4!-!Y ~~a- eu' 'regulamentares que afecta ou' | \
    amend_error_in_article 1 'ambiente 2 ' 'ambiente. [2] ' | \
    amend_error_in_article 1 me10 meio | \
    amend_error_in_article 1 'outroS,seres' 'outros seres' | \
    amend_error_in_article 1 's1 e com o própno' 'si e com o próprio' | \
    amend_error_in_article 1 '\\ll~O ~ mclµi' 'meio e inclui:' | \
    amend_error_in_article 1 'água \[b\]' 'água; [b]' | \
    amend_error_in_article 1 ecossistemàS ecossistemas | \
    amend_error_in_article 1 '~lôdi[^e]+' 'biodiversidade ' | \
    amend_error_in_article 1 'es-,\.,\.\.;, 1-\.\. 1<>\.çoes' 'e as relações' | \
    amend_error_in_article 1 'ecológicas \[e\]' 'ecológicas; [c]' | \
    amend_error_in_article 1 'maténa orgâruca e morgãmc,a' 'matéria orgânica e inorgânica;' | \
    amend_error_in_article 1 "s6c1C>-'cultura1s" 'sócio-culturais' | \
    amend_error_in_article 1 'comuntdades 3' 'comunidades. [3]' | \
    amend_error_in_article 1 'Assoclaçoes de DefesafkJ' 'Associações de Defesa do' | \
    amend_error_in_article 1 'Ambiente sao' 'Ambiente são' | \
    amend_error_in_article 1 ',c0Ject1 vas' colectivas | \
    amend_error_in_article 1 ObJeCtO objecto | \
    amend_error_in_article 1 consefvaçao conservação | \
    amend_error_in_article 1 valonzaçao valorização | \
    amend_error_in_article 1 ' Estas assoc1açoes' '. Estas associações' | \
    amend_error_in_article 1 'ambtto mternacwnal' 'âmbito internacional,' | \
    amend_error_in_article 1 'nac10nal reg10nal' 'nacional, regional' | \
    amend_error_in_article 1 'local 4' 'local. [4]' | \
    amend_error_in_article 1 Auditona Auditoria | \
    amend_error_in_article 1 'mstrUmento de gestao' 'instrumento de gestão' | \
    amend_error_in_article 1 'obJ\.ecfiv\.,a' objectiva | \
    amend_error_in_article 1 'orga,nt~o de ~1stema de gestao' 'organização de sistema de gestão' | \
    amend_error_in_article 1 'protecçao do amb;epte S' 'protecção do ambiente. [5]' | \
    amend_error_in_article 1 Avaliaçao Avaliação | \
    amend_error_in_article 1 '10stn1mento de gestao' 'instrumento de gestão' | \
    amend_error_in_article 1 '1denu:ticaçao' identificação | \
    amend_error_in_article 1 análISe análise | \
    amend_error_in_article 1 quantrtaava quantitativa | \
    amend_error_in_article 1 penuc1os0s perniciosos | \
    amend_error_in_article 1 acav1daqe actividade | \
    amend_error_in_article 1 'proposta 6' 'proposta. [6]' | \
    amend_error_in_article 1 Bwdiversufade Biodiversidade | \
    amend_error_in_article 1 varredade variedade | \
    amend_error_in_article 1 vanabibdMdtt variabilidade | \
    amend_error_in_article 1 "-orlge'ÍIS indi:lindo" 'origens incluindo' | \
    amend_error_in_article 1 Qutros outros | \
    amend_error_in_article 1 'terrestres mannhos' 'terrestres, marinhos' | \
    amend_error_in_article 1 aquaucos aquáticos | \
    amend_error_in_article 1 ecológ1cos ecológicos | \
    amend_error_in_article 1 dtvers1dade diversidade | \
    amend_error_in_article 1 espec1es espécies | \
    amend_error_in_article 1 'ecossistemas 7' 'ecossistemas. [7]' | \
    amend_error_in_article 1 'Ambient4~' Ambientais | \
    amend_error_in_article 1 'são,os' 'são os' | \
    amend_error_in_article 1 'amb1en\.~' ambiente | \
    amend_error_in_article 1 'cuJa mteracção penrute' 'cuja interacção permite' | \
    amend_error_in_article 1 'equtlíbno, mclumdo' 'equilíbrio, incluindo' | \
    amend_error_in_article 1 'flor\.a' flora | \
    amend_error_in_article 1 'soc10-econónucas' 'sócio-económicas' | \
    amend_error_in_article 1 sáúde saúde | \
    amend_error_in_article 1 "dé'sigrlados" designados | \
    amend_error_in_article 1 'naturais 8' 'naturais. [8]' | \
    amend_error_in_article 1 "'tiégfada9ão" Degradação | \
    amend_error_in_article 1 ' dó ' ' do ' | \
    amend_error_in_article 1 1nclu1 inclui | \
    amend_error_in_article 1 'deflorestarnentb 9' 'desflorestamento. [9]' | \
    amend_error_in_article 1 Deflorestamento Desflorestamento | \
    amend_error_in_article 1 md1scnmmado indiscriminado | \
    amend_error_in_article 1 'hílitas J tiorêstas' 'matas e florestas' | \
    amend_error_in_article 1 'devida 10' 'devida. [10]' | \
    amend_error_in_article 1 "Desenvol'vimelitb" Desenvolvimento | \
    amend_error_in_article 1 ' muna ' ' numa ' | \
    amend_error_in_article 1 '~mbiental' ambiental | \
    amend_error_in_article 1 'eqmlíbno dQ~mbtente' 'equilíbrio do ambiente' | \
    amend_error_in_article 1 poss1b1hqade possibilidade | \
    amend_error_in_article 1 'necessidades 1 l' 'necessidades. [11]' | \
    amend_error_in_article 1 provoçado provocado | \
    amend_error_in_article 1 'pela ,remoção' 'pela remoção' | \
    amend_error_in_article 1 'utthzação predat6qaque' 'utilização predatória que' | \
    amend_error_in_article 1 chmát1cas climáticas | \
    amend_error_in_article 1 'transfonná-lo' 'transformá-lo' | \
    amend_error_in_article 1 'deserto 12' 'deserto. [12]' | \
    amend_error_in_article 1 'dmâm1co de comumdades' 'dinâmico de comunidades' | \
    amend_error_in_article 1 'ammais·ede microorgamsmos' 'animais e de microorganismos' | \
    amend_error_in_article 1 ' hão ' ' não ' | \
    amend_error_in_article 1 com0 como | \
    amend_error_in_article 1 'funcional 1--3' 'funcional. [13]' | \
    amend_error_in_article 1 'E\+ri"s\.\/ib1' Erosão | \
    amend_error_in_article 1 'b desi,refid1mento1' 'o desprendimento' | \
    amend_error_in_article 1 "'acÇã'i'\.Jnaturitl" 'acção natural' | \
    amend_error_in_article 1 '\[o\]J êas aguas' 'ou das águas' | \
    amend_error_in_article 1 mtenstficado intensificado | \
    amend_error_in_article 1 'rearada de vegetàção 14' 'retirada de vegetação. [14]' | \
    amend_error_in_article 1 ' d9 ' ' do ' | \
    amend_error_in_article 1 'ttcnica-i,a- in~nlJ,tl~ll\/ment~ ll\.S' 'técnica e cientificamente as' | \
    amend_error_in_article 1 act1V1dades actividades | \
    amend_error_in_article 1 '\.d~\$envolv1mento' desenvolvimento | \
    amend_error_in_article 1 'ctmbum~\. 15' 'ambiente. [15]' | \
    amend_error_in_article 1 Amburttal Ambiental | \
    amend_error_in_article 1 'mane\.1O' maneio | \
    amend_error_in_article 1 utJhzação utilização | \
    amend_error_in_article 1 'amb1enta1s, mclumdo' 'ambientais, incluindo' | \
    amend_error_in_article 1 'o 1 seu' 'o seu' | \
    amend_error_in_article 1 'r~c1cl~gem' reciclagem | \
    amend_error_in_article 1 'conservação 16' 'conservação. [16]' | \
    amend_error_in_article 1 'lrrwacto Ainbienial' 'Impacto Ambiental' | \
    amend_error_in_article 1 "t ' \) " '' | \
    amend_error_in_article 1 'oú para p10r' 'ou para pior' | \
    amend_error_in_article 1 'no f t l \. ar' 'no ar,' | \
    amend_error_in_article 1 ' saude das' ' saúde das' | \
    amend_error_in_article 1 acttv1dades actividades | \
    amend_error_in_article 1 'humanas 17' 'humanas. [17]' | \
    amend_error_in_article 1 'Legislo,ção Ambientql' 'Legislação Ambiental' | \
    amend_error_in_article 1 'ambiente 18' 'ambiente. [18]' | \
    amend_error_in_article 1 'compoilente á\\nbiental' 'componente ambiental' | \
    amend_error_in_article 1 'específico 19' 'específico. [19]' | \
    amend_error_in_article 1 Padrdes Padrões | \
    amend_error_in_article 1 ad1111ssíve1s admissíveis | \
    amend_error_in_article 1 prescntos prescritos | \
    amend_error_in_article 1 'detemunado ftm 70' 'determinado fim. [20]' | \
    amend_error_in_article 1 mvest1gação investigação | \
    amend_error_in_article 1 'grµpo-..' 'grupo ' | \
    amend_error_in_article 1 attdoefpec1ahstasde1doneldade 'integrando especialistas de idoneidade ' | \
    amend_error_in_article 1 'ereputação reconheç:uiaa' 'e reputação reconhecidas' | \
    amend_error_in_article 1 'avabar a gravtdade' 'avaliar, a gravidade' | \
    amend_error_in_article 1 'do~ danos cau~adas' 'dos danos causados' | \
    amend_error_in_article 1 "ambiente '21" 'ambiente. [21]' | \
    amend_error_in_article 1 'PfJluiçélq 6' 'Poluição é' | \
    amend_error_in_article 1 'fonna,' 'forma,' | \
    amend_error_in_article 1 'emis~ijo' emissão | \
    amend_error_in_article 1 ' fonnas ' ' formas ' | \
    amend_error_in_article 1 'negativamente.*22' 'negativamente. [22]' | \
    amend_error_in_article 1 Qualuiade Qualidade | \
    amend_error_in_article 1 '~ p equtlíbr10' 'é o equilíbrio' | \
    amend_error_in_article 1 'mclumdo a apequação' 'incluindo a adequação' | \
    amend_error_in_article 1 'seu~' seus | \
    amend_error_in_article 1 dutros outros | \
    amend_error_in_article 1 'vivos 23' 'vivos. [23]' | \
    amend_error_in_article 1 'Res\(duosc Dengos0\!P' 'Resíduos Perigosos' | \
    amend_error_in_article 1 'sãosubstân11.aas.oq-0bJectos' 'são substâncias ou objectos' | \
    amend_error_in_article 1 ehm1nam eliminam | \
    amend_error_in_article 1 'tepl a, intenção de elunmar 91,1' 'tem a intenção de eliminar ou' | \
    amend_error_in_article 1 'obnK~çio' obrigado | \
    amend_error_in_article 1 'l~\\ 1a[^q]+' 'lei a eliminar e ' | \
    amend_error_in_article 1 'cqnt~m' contêm | \
    amend_error_in_article 1 ' nscp ' ' risco ' | \
    amend_error_in_article 1 'mflamáve1s exp\)OSlVO~' 'inflamáveis explosivos' | \
    amend_error_in_article 1 'c9rros1vq,~' corrosivos | \
    amend_error_in_article 1 't9x1cos, 1nfecc10s0s' 'tóxicos, infecciosos' | \
    amend_error_in_article 1 rad1oactivos1 radioactivos | \
    amend_error_in_article 1 'oµ por apri;senJarem \[q\]llllquer' 'ou por apresentarem qualquer' | \
    amend_error_in_article 1 'caracter\{sttq@que' 'característica que' | \
    amend_error_in_article 1 'con~utuq pengo par~ &' 'constitua perigo para a' | \
    amend_error_in_article 1 'saude do' 'saúde do' | \
    amend_error_in_article 1 quahdade qualidade | \
    amend_error_in_article 1 'ambiente 24 ' 'ambiente. [24] ' | \
    amend_error_in_article 1 "sãc;, área~ c:Je pâl'ltano breJo" 'são áreas de pântano, brejo,' | \
    amend_error_in_article 1 art1fic1al artificial | \
    amend_error_in_article 1 'temporária parada' 'temporária, parada' | \
    amend_error_in_article 1 'cirtehté, dóce,L' 'corrente, doce, ' | \
    amend_error_in_article 1 'salôbratní\!sa\}gada' 'salobra ou salgada' | \
    amend_error_in_article 1 foclafndo incluindo | \
    amend_error_in_article 1 'cqJa pi:0fun,,d;dade' 'cuja profundidade' | \
    amend_error_in_article 1 'rêq1Ie1ra ébli.diçõe~' 'requeira condições ' | \
    amend_error_in_article 1 satttràçlãbat1tiáticado 'saturação aquática do' | \
    amend_error_in_article 1 'solo.*$' 'solo.' | \
    # Article 2
    amend_error_in_article 2 'ôhj~~to' Objecto | \
    amend_error_in_article 2 'bbje~to' objecto | \
    amend_error_in_article 2 ',uma' uma | \
    amend_error_in_article 2 'ut1hzação e ,gestã\(!\)\.' 'utilização e gestão' | \
    amend_error_in_article 2 "~!'f,e~tílS J,dQ;,~mbtente" 'correctas do ambiente' | \
    amend_error_in_article 2 'v1~ta à, m,aterif.lhza~ão' 'vista à materialização' | \
    amend_error_in_article 2 "µm sistema çiç ' 1 \. \. e," 'um sistema de' | \
    amend_error_in_article 2 país 'país.' | \
    # Article 3
    amend_error_in_article 3 Âmbkot 'Âmbito)' | \
    amend_error_in_article 3 'aphca-se ,dodas' 'aplica-se a todas' | \
    amend_error_in_article 3 "aêti v1dade~ p'úbhea~" 'actividades públicas' | \
    amend_error_in_article 3 'd1recta oh I indirec\\an;rente' 'directa ou indirectamente' | \
    amend_error_in_article 3 '1nTI&1t' influir | \
    amend_error_in_article 3 'amb1entaJ~' 'ambientais.' | \
    # Article 4
    amend_error_in_article 4 'Principio& fandaíne,ntáis' 'Princípios fundamentais' | \
    amend_error_in_article 4 'baseia•se' 'baseia-se' | \
    amend_error_in_article 4 pnncíp1os princípios | \
    amend_error_in_article 4 'd1re1to de tqdos Qs\.' 'direito de todos os' | \
    amend_error_in_article 4 'equihbrado, propíc1c\{' 'equilibrado, propício ' | \
    amend_error_in_article 4 saude saúde | \
    amend_error_in_article 4 'bem -estar' 'bem-estar' | \
    amend_error_in_article 4 "nõtrieadàmênte '" nomeadamente | \
    amend_error_in_article 4 utihzação utilização | \
    amend_error_in_article 4 'rgestão ràe1onâ1s' 'gestão racionais' | \
    amend_error_in_article 4 "dús c0mpori'entés" 'dos componentes' | \
    amend_error_in_article 4 'I ptomoçM da inelhoiia' 'promoção da melhoria' | \
    amend_error_in_article 4 'v1d11 d~ ~4ãos' 'vida dos cidadãos' | \
    amend_error_in_article 4 b1od1vers1dade biodiversidade | \
    amend_error_in_article 4 'ecossistemas \[b' 'ecossistemas; [b' | \
    amend_error_in_article 4 'va1ottz~ó ais tradlções' 'valorização das tradições' | \
    amend_error_in_article 4 '0omun1dades 1eoail' 'comunidades locais' | \
    amend_error_in_article 4 'tf útl \.oont111buam' 'que contribuam' | \
    amend_error_in_article 4 "consel\"'89ão e presew~ão" 'conservação e preservação' | \
    amend_error_in_article 4 'dt!>s recunoirn•urAü \[e\]' 'dos recursos naturais e ' | \
    amend_error_in_article 4 'ambiente \[e' 'ambiente [c' | \
    amend_error_in_article 4 'precau~ão\. çom ba,se' 'precaução, com base' | \
    amend_error_in_article 4 'q~ Jt g~stão' 'qual a gestão' | \
    amend_error_in_article 4 'estabeJ~1mento <;te\.' 'estabelecimento de' | \
    amend_error_in_article 4 '~i11tçm,s 4~' 'sistemas de' | \
    amend_error_in_article 4 Jes1vos lesivos | \
    amend_error_in_article 4 irreversive1s irreversíveis | \
    amend_error_in_article 4 'ex1stên,c1a' existência | \
    amend_error_in_article 4 '<\.ertez~ cient\(fica so~re' 'certeza científica sobre' | \
    amend_error_in_article 4 ' 7 DE OUTUBRO DE 1997' ';' | \
    amend_error_in_article 4 'compenss 1\)8' 'compensar os' | \
    amend_error_in_article 4 hannoniosas harmoniosas | \
    # Article 6
    amend_error_in_article 6 iunbíental ambiental | \
    amend_error_in_article 6 'b \)émitir' '[b] emitir' | \
    amend_error_in_article 6 rec11rsos recursos | \
    amend_error_in_article 6 '\[e\] pronunciar' '[c] pronunciar' | \
    amend_error_in_article 6 '200·-\(21\) ' '' | \
    amend_error_in_article 6 instituciomus institucionais | \
    # Article 7
    amend_error_in_article 7 '\{Órgãos' '(Órgãos' | \
    amend_error_in_article 7 pennitir permitir | \
    # Article 8
    amend_error_in_article 8 '~ara' para | \
    amend_error_in_article 8 '\{Ullbiente' ambiente | \
    # Article 9
    amend_error_in_article 9 '·' '' | \
    amend_error_in_article 9 ágµa água | \
    amend_error_in_article 9 'limites,legalmente' 'limites, legalmente' | \
    amend_error_in_article 9 ',específica' específica | \
    # Article 10
    amend_error_in_article 10 'amqi~ntal' ambiental | \
    amend_error_in_article 10 '~os recursq\$' 'dos recursos' | \
    amend_error_in_article 10 nonnas normas | \
    # Article 11
    amend_error_in_article 11 Protecçio Protecção | \
    amend_error_in_article 11 '200--\(22\) pennanentes' permanentes | \
    # Article 12
    amend_error_in_article 12 'bioc;liversidade' biodiversidade | \
    amend_error_in_article 12 'pr9tecção esp,<;eia\\' 'protecção especial' | \
    amend_error_in_article 12 'ameaç\.adas' ameaçadas | \
    amend_error_in_article 12 "'·gm:ipo" grupo | \
    amend_error_in_article 12 "'raridade" raridade | \
    # Article 13
    amend_error_in_article 13 'protecção"ambiental' 'protecção ambiental' | \
    amend_error_in_article 13 '\·pr@tecção e pre~ervação' ' protecção e preservação' | \
    amend_error_in_article 13 'manutenç~o' manutenção | \
    amend_error_in_article 13 'ec9l6gico e s6cio-econ6mico' 'ecológico e sócio-económico' | \
    amend_error_in_article 13 naci0nal nacional | \
    amend_error_in_article 13 ainilainternacional 'ainda internacional' | \
    amend_error_in_article 13 'c<5ftsoante os int~resses' 'consoante os interesses' | \
    amend_error_in_article 13 "salv,gµ,ardl'!J'" salvaguardar | \
    amend_error_in_article 13 'iluviais ou marítimas~' 'fluviais ou marítimas e' | \
    amend_error_in_article 13 'zçmas naturais\.' 'zonas naturais ' | \
    amend_error_in_article 13 "'3\. ~s," '[3] As ' | \
    amend_error_in_article 13 "sempte' em consideraçãó'" 'sempre em consideração' | \
    amend_error_in_article 13 mediçlas medidas | \
    amend_error_in_article 13 'nQ \[t\]Úmero' 'no número' | \
    # Article 14
    amend_error_in_article 14 'lnfra•estruturas' 'infra-estruturas' | \
    amend_error_in_article 14 infraestruturas 'infra-estruturas' | \
    amend_error_in_article 14 habitacionaia habitacionais | \
    amend_error_in_article 14 cijmensão dimensão | \
    amend_error_in_article 14 námero número | \
    amend_error_in_article 14 ' oli ' ' ou ' | \
    amend_error_in_article 14 hámidas húmidas | \
    amend_error_in_article 14 ecologicamepte ecologicamente | \
    amend_error_in_article 14 'sensíveis,' 'sensíveis.' | \
    amend_error_in_article 14 ndmero número | \
    amend_error_in_article 14 '\. ~ ' '. É ' | \
    amend_error_in_article 14 'I SÉRIE-NÚMERO 40 ' '-' | \
    # Article 15
    amend_error_in_article 15 'lic·enciamento' licenciamento | \
    amend_error_in_article 15 sejamsusceptíveis 'sejam susceptíveis' | \
    amend_error_in_article 15 'ambiente, ,são' 'ambiente, são' | \
    amend_error_in_article 15 'regulll!Dento' regulamento | \
    amend_error_in_article 15 " ambi'ental'" ' ambiental ' | \
    amend_error_in_article 15 'precede-a' 'precede a' | \
    amend_error_in_article 15 'leg~lmente' legalmente | \
    # Article 16
    amend_error_in_article 16 'ambiental \.a' 'ambiental a' | \
    amend_error_in_article 16 fonnalidades formalidades | \
    # Article 17
    amend_error_in_article 17 's~guinte;' 'seguinte:' | \
    amend_error_in_article 17 pirojecto projecto | \
    amend_error_in_article 17 '\[e\] situação' '[c] situação' | \
    amend_error_in_article 17 's1,1primir' suprimir | \
    amend_error_in_article 17 daactividade 'da actividade' | \
    amend_error_in_article 17 '\/\)' '[f]' | \
    amend_error_in_article 17 'previstc,s' previstos | \
    # Article 18
    amend_error_in_article 18 Auclttorlu Auditorias | \
    amend_error_in_article 18 TodasasacUvidades 'Todas as actividades ' | \
    amend_error_in_article 18 'queàdatadaenu-ada' 'que à data da entrada ' | \
    amend_error_in_article 18 'emvigordestaLei ce' 'em vigor desta Lei se' | \
    amend_error_in_article 18 funçionamonto funcionamento | \
    amend_error_in_article 18 resultarem 'resultar em' | \
    amend_error_in_article 18 '\{>&rao' 'para o ' | \
    amend_error_in_article 18 sãoobjecto 'são objecto' | \
    amend_error_in_article 18 'constat#d9s' constatados | \
    amend_error_in_article 18 ' sfo ' ' são ' | \
    amend_error_in_article 18 ' 7 DE OUTUBRO DE.*$' '' | \
    # Article 19
    amend_error_in_article 19 infonnação informação | \
    # Article 20
    amend_error_in_article 20 'eduçação\/' 'educação)' | \
    amend_error_in_article 20 emcolaboraçãocom 'em colaboração com ' | \
    amend_error_in_article 20 os6rgãosdecomunicação 'os órgãos de comunicação ' | \
    amend_error_in_article 20 'sodal,mecanismos' 'social, mecanismos' | \
    amend_error_in_article 20 ' pàra ' ' para ' | \
    amend_error_in_article 20 'fonnal e infonnal' 'formal e informal' | \
    # Article 21
    amend_error_in_article 21 Justiça justiça | \
    amend_error_in_article 21 violaçãodos 'violação dos' | \
    amend_error_in_article 21 viQlação violação | \
    amend_error_in_article 21 'nºS' números | \
    amend_error_in_article 21 lesadçs lesados | \
    # Article 22
    amend_error_in_article 22 '\}' ')' | \
    amend_error_in_article 22 "Ol'" ou | \
    # Article 23
    amend_error_in_article 23 '\. pamcipação' ' de participação' | \
    amend_error_in_article 23 imittência iminência | \
    amend_error_in_article 23 infonnar informar | \
    amend_error_in_article 23 'agenres adftlinimativos' 'agentes administrativos' | \
    amend_error_in_article 23 'pró,titnos sobm' 'próximos sobre' | \
    # Article 24
    amend_error_in_article 24 'O~pção ele udlbação' 'Obrigação de utilização' | \
    amend_error_in_article 24 '\. T' T | \
    amend_error_in_article 24 '200--\(23\) ' '' | \
    amend_error_in_article 24 putras outras | \
    # Article 25
    amend_error_in_article 25 'do \.ambiente' 'do ambiente' | \
    # Article 26
    amend_error_in_article 26 'ambíenteou' 'ambiente ou' | \
    amend_error_in_article 26 'acti vidades' actividades | \
    amend_error_in_article 26 'ex\.iJam' exijam | \
    # Article 27
    amend_error_in_article 27 atttbientais ambientais | \
    # Article 28
    amend_error_in_article 28 ítsealização fiscalização | \
    amend_error_in_article 28 tennos termos | \
    amend_error_in_article 28 parn para | \
    amend_error_in_article 28 ' ·.*$' '' | \
    # Article 29
    amend_error_in_article 29 'Deverde~' 'Dever de colaboração' | \
    # Article 30
    amend_error_in_article 30 'P..rtkipação ,Ju' 'Participação das' | \
    amend_error_in_article 30 'locaise\.autilizaradequadamenteos' 'locais e a utilizar adequadamente os' | \
    amend_error_in_article 30 '~usconhecimentoserecursos' 'seus conhecimentos e recursos' | \
    amend_error_in_article 30 'humanos.oOovemo.' 'humanos, o Governo, ' | \
    amend_error_in_article 30 emcowdeAtlçãocom 'em coordenação com ' | \
    amend_error_in_article 30 asaatoridades 'as autoridades' | \
    amend_error_in_article 30 ", . '" ', ' | \
    # Article 32
    amend_error_in_article 32 1 '[1]' | \
    # Article 34
    amend_error_in_article 34 'após ,a' 'após a' | \
    amend_error_in_article 34 ' Aprovada.*$' ''
}

function amend_errors_in_headers {
  sed -E 's/CAPITULO/CAPÍTULO/' | \
    sed -E 's/^(CAPÍTULO I - )DISPOSIÇOES/\1DISPOSIÇÕES/' | \
    sed -E 's/^(CAPÍTULO II - ÓRGÃOS )J;\)E/\1DE/' | \
    sed -E 's/^(CAPÍTULO III - POLUIÇÃO )l>O/\1DO/' | \
    sed -E 's/^(CAPÍTULO IV - )MEDID~/\1MEDIDAS/' | \
    sed -E 's/^(CAPÍTULO V - PREVENÇÃO.*)AMBIJJ!NTAIS/\1AMBIENTAIS/'
}

function remove_all_text_after_last_article {
  sed -E '/^\(34\)/,${/^\(34\)/!d}'
}

function move_article_titles_above_articles {
  sed -E 's/^(\([0-9]+\)) \(([^)]+)\)/\2\n\1/'
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
    amend_errors_in_headers | \
    remove_all_text_after_last_article | \
    move_article_titles_above_articles
}
