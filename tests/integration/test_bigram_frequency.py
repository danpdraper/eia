import json
import os
import subprocess

import eia.environment as environment
import eia.tests.utilities as utilities


def test_bigram_frequency_full_text_preserve_provision_delimiters():
    '''
    The values in the column 'Bigram' in the following table represent the
    complete set of bigrams in STATE_A_LEGISLATION_TEXT,
    STATE_B_LEGISLATION_TEXT and STATE_C_LEGISLATION_TEXT. The values in
    columns 'State A', 'State B' and 'State C' represent the number of
    occurrences of the values in column 'Bigram' in STATE_A_LEGISLATION_TEXT,
    STATE_B_LEGISLATION_TEXT and STATE_C_LEGISLATION_TEXT respectively.

    Bigram                   State A   State B   State C
    (1) all                     1         0         0
    (1) the                     0         0         1
    (1) this                    0         1         0
    (2) every                   0         0         1
    (2) it                      1         0         0
    (2) the                     0         1         0
    (3) it                      1         0         0
    (3) the                     0         1         1
    a common                    0         1         0
    a healthy                   1         0         0
    a national                  1         0         0
    above creating              1         0         0
    according to                0         0         1
    achieve the                 1         0         0
    action to                   0         0         1
    administration sets         0         0         1
    against all                 0         0         1
    against forms               0         0         1
    aimed at                    0         1         0
    all citizens                1         0         0
    all kinds                   0         0         1
    an integral                 0         1         0
    and conservation            1         0         0
    and cultural                0         1         0
    and enhance                 0         0         2
    and environmental           0         1         0
    and having                  1         0         0
    and improve                 0         0         1
    and intangible              0         1         0
    and protected               0         0         1
    and regulations             0         0         1
    and specialized             1         0         0
    and sustainable             1         1         0
    and the                     1         1         1
    and to                      1         0         1
    applies it                  0         1         0
    are of                      0         1         0
    as the                      0         1         0
    as well                     0         1         0
    aspects they                0         1         0
    associations is             0         0         1
    associations to             0         1         0
    at ensuring                 0         1         0
    atmosphere their            0         1         0
    b (2)                       0         1         0
    b defines                   0         1         0
    b it                        0         1         0
    be underestimated           1         0         0
    benefits of                 1         0         0
    better coordination         0         0         1
    bodies for                  1         0         0
    bodies necessary            0         0         1
    brings together             0         0         1
    cannot be                   1         0         0
    citizen individually        0         0         1
    citizens have               1         0         0
    collaboration with          0         0         1
    collectivities and          0         0         1
    common heritage             0         1         0
    communities and             0         1         0
    communities grassroots      0         1         0
    compliance with             0         0         1
    concerned for               0         0         1
    conditions of               0         0         1
    conservation and            0         1         0
    conservation of             1         0         0
    constitutes a               0         1         0
    content as                  0         1         0
    coordination of             0         0         1
    country's natural           1         0         0
    creating the                1         0         0
    cultural aspects            0         1         0
    decentralized territorial   0         1         1
    defense and                 1         0         0
    defense associations        0         1         0
    defines the                 0         1         0
    degradation in              0         0         2
    develops national           0         1         0
    due to                      1         0         0
    end the                     0         1         0
    enhance natural             0         0         1
    enhance the                 0         0         1
    ensuring the                0         1         0
    entire population           1         0         0
    environment and             2         0         0
    environment constitutes     0         1         0
    environment is              0         0         1
    environmental defense       0         1         0
    environmental degradation   0         0         1
    environmental management    1         1         0
    environmental policy        0         1         0
    environmental resources     0         1         0
    essential principles        0         0         1
    establish the               0         0         1
    establishes the             0         1         0
    every citizen               0         0         1
    fight against               0         0         1
    for better                  0         0         1
    for environmental           0         1         0
    for the                     1         0         1
    for this                    1         0         0
    forms of                    0         0         1
    framework for               0         1         0
    framework of                0         0         1
    fundamental principles      0         0         1
    general interest            0         1         0
    general legal               0         1         0
    general principles          1         0         0
    general provisions          0         1         0
    geosphere hydrosphere       0         1         0
    government develops         0         1         0
    government which            0         1         0
    grassroots communities      0         1         0
    have the                    1         0         0
    having legislation          1         0         0
    healthy environment         1         0         0
    hence the                   1         0         0
    heritage its                0         1         0
    heritage of                 0         1         0
    human life                  0         1         0
    hydrosphere atmosphere      0         1         0
    i fundamental               0         0         1
    i general                   1         1         0
    implement a                 1         0         0
    implementation is           0         1         0
    implementation of           0         0         1
    improve the                 0         0         1
    in a                        1         0         0
    in collaboration            0         0         1
    in compliance               0         0         1
    in its                      1         0         0
    in order                    0         0         1
    in particular               0         1         0
    in relation                 1         0         0
    in state                    0         2         0
    include (3)                 0         1         0
    individually or             0         0         1
    institutions or             0         0         1
    intangible content          0         1         0
    integral part               0         1         0
    interest these              0         1         0
    interests (3)               1         0         0
    is an                       0         1         0
    is due                      1         0         0
    is responsible              0         0         1
    is sustainably              0         0         1
    is the                      1         1         0
    is to                       0         0         1
    it brings                   0         0         1
    it feasible                 1         0         0
    it is                       2         1         0
    it offers                   0         1         0
    it together                 0         1         0
    its defense                 1         0         0
    its implementation          0         1         0
    its protection              0         1         0
    kinds of                    0         0         1
    law establishes             0         1         0
    law is                      0         0         1
    law it                      0         0         1
    laws and                    0         0         1
    legal framework             0         1         0
    legislation published       1         0         0
    life are                    0         1         0
    live in                     1         0         0
    living conditions           0         0         1
    local institutions          0         0         1
    make it                     1         0         0
    managed and                 0         0         1
    management in               0         1         0
    management of               0         1         0
    management program          1         0         0
    merely utilitarian          1         0         0
    nation in                   0         1         0
    national environmental      1         1         0
    national strategies         0         1         0
    natural resources           2         0         1
    necessary for               0         0         1
    necessary structures        1         0         0
    objectives set              1         0         0
    obligations to              1         0         0
    of action                   0         0         1
    of degradation              0         0         1
    of environmental            0         1         0
    of general                  0         1         0
    of natural                  1         0         0
    of pollution                0         0         1
    of state                    0         1         0
    of the                      6         4         1
    of this                     0         0         2
    of traditional              0         0         1
    offers to                   0         1         0
    or associations             0         0         1
    or environmental            0         0         1
    or programs                 0         1         0
    or within                   0         0         1
    order to                    0         0         1
    organizations concerned     0         0         1
    out above                   1         0         0
    part of                     0         1         0
    participate in              1         0         0
    particular the              0         1         0
    plans or                    0         1         0
    policy its                  0         1         0
    pollution or                0         0         1
    population (2)              0         0         1
    population the              1         0         0
    preservation and            1         0         0
    president of                0         1         0
    prevent and                 0         0         1
    principles (1)              1         0         1
    principles according        0         0         1
    principles of               1         0         0
    program to                  1         0         0
    programs aimed              0         1         0
    protect and                 0         0         1
    protected against           0         0         1
    protection and              0         1         0
    protection preservation     1         0         0
    provisions (1)              0         1         0
    published to                1         0         0
    purpose and                 1         0         0
    purpose of                  0         0         1
    rational management         0         1         0
    rational use                2         0         0
    regulations (3)             0         0         1
    relation to                 1         0         0
    resources and               0         0         1
    resources hence             1         0         0
    resources it                0         1         0
    resources whose             1         0         0
    respect for                 1         0         0
    respectively (2)            1         0         0
    responsibility of           1         1         0
    responsible in              0         0         1
    right to                    1         0         0
    safeguard and               0         0         1
    set out                     1         0         0
    sets up                     0         0         1
    social and                  0         1         0
    specialized bodies          1         0         0
    state b                     0         3         0
    state to                    1         0         1
    strategies plans            0         1         0
    structures and              1         0         0
    sustainable use             1         1         0
    sustainably managed         0         0         1
    tangible and                0         1         0
    target in                   0         1         0
    territorial collectivities  0         0         1
    territorial communities     0         1         0
    the administration          0         0         1
    the benefits                1         0         0
    the bodies                  0         0         1
    the conservation            0         1         0
    the country's               1         0         0
    the decentralized           0         1         1
    the entire                  1         0         0
    the environment             1         1         2
    the essential               0         0         1
    the framework               0         0         1
    the general                 0         1         0
    the geosphere               0         1         0
    the government              0         2         0
    the implementation          0         0         1
    the living                  0         0         1
    the nation                  0         1         0
    the national                0         1         0
    the necessary               1         0         0
    the objectives              1         0         0
    the obligations             1         0         0
    the organizations           0         0         1
    the population              0         0         1
    the president               0         1         0
    the principles              1         0         0
    the protection              1         0         0
    the purpose                 0         0         1
    the rational                2         1         0
    the resources               0         1         0
    the responsibility          1         1         0
    the right                   1         0         0
    the social                  0         1         0
    the state                   1         0         1
    the universal               0         1         0
    the wellbeing               1         0         0
    their tangible              0         1         0
    these target                0         1         0
    they include                0         1         0
    this end                    0         1         0
    this law                    0         1         2
    this purpose                1         0         0
    title i                     1         1         1
    to achieve                  1         0         0
    to establish                0         0         1
    to fight                    0         0         1
    to human                    0         1         0
    to implement                1         0         0
    to live                     1         0         0
    to make                     1         0         0
    to merely                   1         0         0
    to participate              1         0         0
    to prevent                  0         0         1
    to protect                  0         0         1
    to respect                  1         0         0
    to safeguard                0         0         1
    to the                      1         0         0
    to this                     0         1         0
    to which                    0         0         1
    to work                     0         0         1
    together the                0         0         1
    together with               0         1         0
    traditional local           0         0         1
    underestimated in           1         0         0
    universal heritage          0         1         0
    up the                      0         0         1
    use of                      2         1         0
    use respectively            1         0         0
    utilitarian interests       1         0         0
    values cannot               1         0         0
    well as                     0         1         0
    wellbeing of                1         0         0
    which applies               0         1         0
    which the                   0         0         1
    whose values                1         0         0
    with laws                   0         0         1
    with the                    0         1         1
    within the                  0         0         1
    work to                     0         0         1

    Column 'State A', column 'State B' and column 'State C' each represents a
    328 x 1 bigram frequency vector. The similarity of any of the pairs of
    STATE_A_LEGISLATION_TEXT, STATE_B_LEGISLATION_TEXT and
    STATE_C_LEGISLATION_TEXT can be calculated by taking the cosine of the angle
    between the corresponding bigram frequency vectors.

    cosine(theta) = (BF1•BF2)/(|BF1||BF2|)

    where BF1•BF2 is the dot product of BF1 and BF2, or sum([i * j for i in BF1,
    j in BF2]), and |BFn| is the Euclidean length of BFn, or sqrt(sum([i ^ 2 for
    i in BFn])).

    Dot products:
        State A, State A: 164
        State A, State B: 41
        State A, State C: 17
        State B, State B: 158
        State B, State C: 14
        State C, State C: 133

    Euclidean lengths:
        State A: 12.806
        State B: 12.570
        State C: 11.533

    Expected similiarity matrix:
                [ State A  State B  State C ]
    [ State A ] [  1.000    0.255    0.115  ]
    [ State B ] [  0.255    1.000    0.097  ]
    [ State C ] [  0.115    0.097    1.000  ]
    '''

    test_directory_path = utilities.create_test_directory('bigram_frequency_full_text')

    file_content_by_relative_path = {
        os.path.join('legislation', 'state_a_english.txt'): utilities.STATE_A_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_b_english.txt'): utilities.STATE_B_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_c_english.txt'): utilities.STATE_C_LEGISLATION_TEXT,
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    algorithm = 'bigram_frequency'
    scope = 'full_text'
    output_directory_path = os.path.join(test_directory_path, 'output')
    legislation_directory_path = os.path.join(test_directory_path, 'legislation')

    actual_similarity_matrix_labels = []
    actual_similarity_matrix = []

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        os.makedirs(output_directory_path)
        subprocess.run(
            [
                script_file_path,
                '--legislation_directory_path',
                legislation_directory_path,
                '--debug',
                'matrix_and_plot',
                algorithm,
                scope,
                'english',
                output_directory_path,
            ],
            check=True)
        utilities.populate_actual_similarity_matrix_and_labels(
            output_directory_path, algorithm, scope,
            actual_similarity_matrix_labels, actual_similarity_matrix)
        utilities.assert_plot_file_exists(output_directory_path, algorithm, scope)
    finally:
        utilities.delete_test_directory(test_directory_path)

    expected_similarity_matrix_labels = ['State A', 'State B', 'State C']
    expected_similarity_matrix = [
        [1.0, 0.255, 0.115],
        [0.255, 1.0, 0.097],
        [0.115, 0.097, 1.0],
    ]

    utilities.compare_expected_and_actual_similarity_matrix_labels(
        expected_similarity_matrix_labels, actual_similarity_matrix_labels)

    utilities.compare_expected_and_actual_similarity_matrices(
        expected_similarity_matrix, actual_similarity_matrix,
        expected_similarity_matrix_labels, actual_similarity_matrix_labels)


def test_bigram_frequency_full_text_do_not_preserve_provision_delimiters():
    '''
    The values in the column 'Bigram' in the following table represent the
    complete set of bigrams in STATE_A_LEGISLATION_TEXT,
    STATE_B_LEGISLATION_TEXT and STATE_C_LEGISLATION_TEXT, excluding the
    provision delimiters, i.e. (1), (2) and (3). The values in columns 'State
    A', 'State B' and 'State C' represent the number of occurrences of the
    values in column 'Bigram' in STATE_A_LEGISLATION_TEXT,
    STATE_B_LEGISLATION_TEXT and STATE_C_LEGISLATION_TEXT respectively.

    Bigram                   State A   State B   State C
    a common                    0         1         0
    a healthy                   1         0         0
    a national                  1         0         0
    above creating              1         0         0
    according to                0         0         1
    achieve the                 1         0         0
    action to                   0         0         1
    administration sets         0         0         1
    against all                 0         0         1
    against forms               0         0         1
    aimed at                    0         1         0
    all citizens                1         0         0
    all kinds                   0         0         1
    an integral                 0         1         0
    and conservation            1         0         0
    and cultural                0         1         0
    and enhance                 0         0         2
    and environmental           0         1         0
    and having                  1         0         0
    and improve                 0         0         1
    and intangible              0         1         0
    and protected               0         0         1
    and regulations             0         0         1
    and specialized             1         0         0
    and sustainable             1         1         0
    and the                     1         1         1
    and to                      1         0         1
    applies it                  0         1         0
    are of                      0         1         0
    as the                      0         1         0
    as well                     0         1         0
    aspects they                0         1         0
    associations is             0         0         1
    associations to             0         1         0
    at ensuring                 0         1         0
    atmosphere their            0         1         0
    b defines                   0         1         0
    b it                        0         1         0
    be underestimated           1         0         0
    benefits of                 1         0         0
    better coordination         0         0         1
    bodies for                  1         0         0
    bodies necessary            0         0         1
    brings together             0         0         1
    cannot be                   1         0         0
    citizen individually        0         0         1
    citizens have               1         0         0
    collaboration with          0         0         1
    collectivities and          0         0         1
    common heritage             0         1         0
    communities and             0         1         0
    communities grassroots      0         1         0
    compliance with             0         0         1
    concerned for               0         0         1
    conditions of               0         0         1
    conservation and            0         1         0
    conservation of             1         0         0
    constitutes a               0         1         0
    content as                  0         1         0
    coordination of             0         0         1
    country's natural           1         0         0
    creating the                1         0         0
    cultural aspects            0         1         0
    decentralized territorial   0         1         1
    defense and                 1         0         0
    defense associations        0         1         0
    defines the                 0         1         0
    degradation in              0         0         2
    develops national           0         1         0
    due to                      1         0         0
    end the                     0         1         0
    enhance natural             0         0         1
    enhance the                 0         0         1
    ensuring the                0         1         0
    entire population           1         0         0
    environment and             2         0         0
    environment constitutes     0         1         0
    environment is              0         0         1
    environmental defense       0         1         0
    environmental degradation   0         0         1
    environmental management    1         1         0
    environmental policy        0         1         0
    environmental resources     0         1         0
    essential principles        0         0         1
    establish the               0         0         1
    establishes the             0         1         0
    every citizen               0         0         1
    fight against               0         0         1
    for better                  0         0         1
    for environmental           0         1         0
    for the                     1         0         1
    for this                    1         0         0
    forms of                    0         0         1
    framework for               0         1         0
    framework of                0         0         1
    fundamental principles      0         0         1
    general interest            0         1         0
    general legal               0         1         0
    general principles          1         0         0
    general provisions          0         1         0
    geosphere hydrosphere       0         1         0
    government develops         0         1         0
    government which            0         1         0
    grassroots communities      0         1         0
    have the                    1         0         0
    having legislation          1         0         0
    healthy environment         1         0         0
    hence the                   1         0         0
    heritage its                0         1         0
    heritage of                 0         1         0
    human life                  0         1         0
    hydrosphere atmosphere      0         1         0
    i fundamental               0         0         1
    i general                   1         1         0
    implement a                 1         0         0
    implementation is           0         1         0
    implementation of           0         0         1
    improve the                 0         0         1
    in a                        1         0         0
    in collaboration            0         0         1
    in compliance               0         0         1
    in its                      1         0         0
    in order                    0         0         1
    in particular               0         1         0
    in relation                 1         0         0
    in state                    0         2         0
    individually or             0         0         1
    institutions or             0         0         1
    intangible content          0         1         0
    integral part               0         1         0
    interest these              0         1         0
    is an                       0         1         0
    is due                      1         0         0
    is responsible              0         0         1
    is sustainably              0         0         1
    is the                      1         1         0
    is to                       0         0         1
    it brings                   0         0         1
    it feasible                 1         0         0
    it is                       2         1         0
    it offers                   0         1         0
    it together                 0         1         0
    its defense                 1         0         0
    its implementation          0         1         0
    its protection              0         1         0
    kinds of                    0         0         1
    law establishes             0         1         0
    law is                      0         0         1
    law it                      0         0         1
    laws and                    0         0         1
    legal framework             0         1         0
    legislation published       1         0         0
    life are                    0         1         0
    live in                     1         0         0
    living conditions           0         0         1
    local institutions          0         0         1
    make it                     1         0         0
    managed and                 0         0         1
    management in               0         1         0
    management of               0         1         0
    management program          1         0         0
    merely utilitarian          1         0         0
    nation in                   0         1         0
    national environmental      1         1         0
    national strategies         0         1         0
    natural resources           2         0         1
    necessary for               0         0         1
    necessary structures        1         0         0
    objectives set              1         0         0
    obligations to              1         0         0
    of action                   0         0         1
    of degradation              0         0         1
    of environmental            0         1         0
    of general                  0         1         0
    of natural                  1         0         0
    of pollution                0         0         1
    of state                    0         1         0
    of the                      6         4         1
    of this                     0         0         2
    of traditional              0         0         1
    offers to                   0         1         0
    or associations             0         0         1
    or environmental            0         0         1
    or programs                 0         1         0
    or within                   0         0         1
    order to                    0         0         1
    organizations concerned     0         0         1
    out above                   1         0         0
    part of                     0         1         0
    participate in              1         0         0
    particular the              0         1         0
    plans or                    0         1         0
    policy its                  0         1         0
    pollution or                0         0         1
    population the              1         0         0
    preservation and            1         0         0
    president of                0         1         0
    prevent and                 0         0         1
    principles according        0         0         1
    principles of               1         0         0
    program to                  1         0         0
    programs aimed              0         1         0
    protect and                 0         0         1
    protected against           0         0         1
    protection and              0         1         0
    protection preservation     1         0         0
    published to                1         0         0
    purpose and                 1         0         0
    purpose of                  0         0         1
    rational management         0         1         0
    rational use                2         0         0
    relation to                 1         0         0
    resources and               0         0         1
    resources hence             1         0         0
    resources it                0         1         0
    resources whose             1         0         0
    respect for                 1         0         0
    responsibility of           1         1         0
    responsible in              0         0         1
    right to                    1         0         0
    safeguard and               0         0         1
    set out                     1         0         0
    sets up                     0         0         1
    social and                  0         1         0
    specialized bodies          1         0         0
    state b                     0         3         0
    state to                    1         0         1
    strategies plans            0         1         0
    structures and              1         0         0
    sustainable use             1         1         0
    sustainably managed         0         0         1
    tangible and                0         1         0
    target in                   0         1         0
    territorial collectivities  0         0         1
    territorial communities     0         1         0
    the administration          0         0         1
    the benefits                1         0         0
    the bodies                  0         0         1
    the conservation            0         1         0
    the country's               1         0         0
    the decentralized           0         1         1
    the entire                  1         0         0
    the environment             1         1         2
    the essential               0         0         1
    the framework               0         0         1
    the general                 0         1         0
    the geosphere               0         1         0
    the government              0         2         0
    the implementation          0         0         1
    the living                  0         0         1
    the nation                  0         1         0
    the national                0         1         0
    the necessary               1         0         0
    the objectives              1         0         0
    the obligations             1         0         0
    the organizations           0         0         1
    the population              0         0         1
    the president               0         1         0
    the principles              1         0         0
    the protection              1         0         0
    the purpose                 0         0         1
    the rational                2         1         0
    the resources               0         1         0
    the responsibility          1         1         0
    the right                   1         0         0
    the social                  0         1         0
    the state                   1         0         1
    the universal               0         1         0
    the wellbeing               1         0         0
    their tangible              0         1         0
    these target                0         1         0
    they include                0         1         0
    this end                    0         1         0
    this law                    0         1         2
    this purpose                1         0         0
    title i                     1         1         1
    to achieve                  1         0         0
    to establish                0         0         1
    to fight                    0         0         1
    to human                    0         1         0
    to implement                1         0         0
    to live                     1         0         0
    to make                     1         0         0
    to merely                   1         0         0
    to participate              1         0         0
    to prevent                  0         0         1
    to protect                  0         0         1
    to respect                  1         0         0
    to safeguard                0         0         1
    to the                      1         0         0
    to this                     0         1         0
    to which                    0         0         1
    to work                     0         0         1
    together the                0         0         1
    together with               0         1         0
    traditional local           0         0         1
    underestimated in           1         0         0
    universal heritage          0         1         0
    up the                      0         0         1
    use of                      2         1         0
    use respectively            1         0         0
    utilitarian interests       1         0         0
    values cannot               1         0         0
    well as                     0         1         0
    wellbeing of                1         0         0
    which applies               0         1         0
    which the                   0         0         1
    whose values                1         0         0
    with laws                   0         0         1
    with the                    0         1         1
    within the                  0         0         1
    work to                     0         0         1

    Column 'State A', column 'State B' and column 'State C' each represents a
    321 x 1 bigram frequency vector. The similarity of any of the pairs of
    STATE_A_LEGISLATION_TEXT, STATE_B_LEGISLATION_TEXT and
    STATE_C_LEGISLATION_TEXT can be calculated by taking the cosine of the angle
    between the corresponding bigram frequency vectors.

    cosine(theta) = (BF1•BF2)/(|BF1||BF2|)

    where BF1•BF2 is the dot product of BF1 and BF2, or sum([i * j for i in BF1,
    j in BF2]), and |BFn| is the Euclidean length of BFn, or sqrt(sum([i ^ 2 for
    i in BFn])).

    Dot products:
        State A, State A: 161
        State A, State B: 41
        State A, State C: 16
        State B, State B: 155
        State B, State C: 13
        State C, State C: 130

    Euclidean lengths:
        State A: 12.689
        State B: 12.450
        State C: 11.402

    Expected similiarity matrix:
                [ State A  State B  State C ]
    [ State A ] [  1.000    0.260    0.111  ]
    [ State B ] [  0.260    1.000    0.092  ]
    [ State C ] [  0.111    0.092    1.000  ]
    '''

    test_directory_path = utilities.create_test_directory('bigram_frequency_full_text')

    file_content_by_relative_path = {
        os.path.join('legislation', 'state_a_english.txt'): utilities.STATE_A_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_b_english.txt'): utilities.STATE_B_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_c_english.txt'): utilities.STATE_C_LEGISLATION_TEXT,
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    algorithm = 'bigram_frequency'
    scope = 'full_text'
    output_directory_path = os.path.join(test_directory_path, 'output')
    legislation_directory_path = os.path.join(test_directory_path, 'legislation')

    actual_similarity_matrix_labels = []
    actual_similarity_matrix = []

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        os.makedirs(output_directory_path)
        subprocess.run(
            [
                script_file_path,
                '--legislation_directory_path',
                legislation_directory_path,
                '--debug',
                'matrix_and_plot',
                algorithm,
                scope,
                'english',
                output_directory_path,
                '--do_not_preserve_provision_delimiters',
            ],
            check=True)
        utilities.populate_actual_similarity_matrix_and_labels(
            output_directory_path, algorithm, scope,
            actual_similarity_matrix_labels, actual_similarity_matrix)
        utilities.assert_plot_file_exists(output_directory_path, algorithm, scope)
    finally:
        utilities.delete_test_directory(test_directory_path)

    expected_similarity_matrix_labels = ['State A', 'State B', 'State C']
    expected_similarity_matrix = [
        [1.0, 0.260, 0.111],
        [0.260, 1.0, 0.092],
        [0.111, 0.092, 1.0],
    ]

    utilities.compare_expected_and_actual_similarity_matrix_labels(
        expected_similarity_matrix_labels, actual_similarity_matrix_labels)

    utilities.compare_expected_and_actual_similarity_matrices(
        expected_similarity_matrix, actual_similarity_matrix,
        expected_similarity_matrix_labels, actual_similarity_matrix_labels)


def test_bigram_frequency_full_text_list_of_states_to_include():
    '''
    The values in column 'Bigram' in the following table represent the complete
    set of bigrams in STATE_A_LEGISLATION_TEXT and STATE_C_LEGISLATION_TEXT. The
    values in columns 'State A' and 'State C' represent the number of
    occurrences of the values in column 'Bigram' in STATE_A_LEGISLATION_TEXT and
    STATE_C_LEGISLATION_TEXT respectively.

    Bigram                   State A   State C
    (1) all                     1         0
    (1) the                     0         1
    (2) every                   0         1
    (2) it                      1         0
    (3) it                      1         0
    (3) the                     0         1
    a healthy                   1         0
    a national                  1         0
    above creating              1         0
    according to                0         1
    achieve the                 1         0
    action to                   0         1
    administration sets         0         1
    against all                 0         1
    against forms               0         1
    all citizens                1         0
    all kinds                   0         1
    and conservation            1         0
    and enhance                 0         2
    and having                  1         0
    and improve                 0         1
    and protected               0         1
    and regulations             0         1
    and specialized             1         0
    and sustainable             1         0
    and the                     1         1
    and to                      1         1
    associations is             0         1
    be underestimated           1         0
    benefits of                 1         0
    better coordination         0         1
    bodies for                  1         0
    bodies necessary            0         1
    brings together             0         1
    cannot be                   1         0
    citizen individually        0         1
    citizens have               1         0
    collaboration with          0         1
    collectivities and          0         1
    compliance with             0         1
    concerned for               0         1
    conditions of               0         1
    conservation of             1         0
    coordination of             0         1
    country's natural           1         0
    creating the                1         0
    decentralized territorial   0         1
    defense and                 1         0
    degradation in              0         2
    due to                      1         0
    enhance natural             0         1
    enhance the                 0         1
    entire population           1         0
    environment and             2         0
    environment is              0         1
    environmental degradation   0         1
    environmental management    1         0
    essential principles        0         1
    establish the               0         1
    every citizen               0         1
    fight against               0         1
    for better                  0         1
    for the                     1         1
    for this                    1         0
    forms of                    0         1
    framework of                0         1
    fundamental principles      0         1
    general principles          1         0
    have the                    1         0
    having legislation          1         0
    healthy environment         1         0
    hence the                   1         0
    i fundamental               0         1
    i general                   1         0
    implement a                 1         0
    implementation of           0         1
    improve the                 0         1
    in a                        1         0
    in collaboration            0         1
    in compliance               0         1
    in its                      1         0
    in order                    0         1
    in relation                 1         0
    individually or             0         1
    institutions or             0         1
    interests (3)               1         0
    is due                      1         0
    is responsible              0         1
    is sustainably              0         1
    is the                      1         0
    is to                       0         1
    it brings                   0         1
    it feasible                 1         0
    it is                       2         0
    its defense                 1         0
    kinds of                    0         1
    law is                      0         1
    law it                      0         1
    laws and                    0         1
    legislation published       1         0
    live in                     1         0
    living conditions           0         1
    local institutions          0         1
    make it                     1         0
    managed and                 0         1
    management program          1         0
    merely utilitarian          1         0
    national environmental      1         0
    natural resources           2         1
    necessary for               0         1
    necessary structures        1         0
    objectives set              1         0
    obligations to              1         0
    of action                   0         1
    of degradation              0         1
    of natural                  1         0
    of pollution                0         1
    of the                      6         1
    of this                     0         2
    of traditional              0         1
    or associations             0         1
    or environmental            0         1
    or within                   0         1
    order to                    0         1
    organizations concerned     0         1
    out above                   1         0
    participate in              1         0
    pollution or                0         1
    population (2)              0         1
    population the              1         0
    preservation and            1         0
    prevent and                 0         1
    principles (1)              1         1
    principles according        0         1
    principles of               1         0
    program to                  1         0
    protect and                 0         1
    protected against           0         1
    protection preservation     1         0
    published to                1         0
    purpose and                 1         0
    purpose of                  0         1
    rational use                2         0
    regulations (3)             0         1
    relation to                 1         0
    resources and               0         1
    resources hence             1         0
    resources whose             1         0
    respect for                 1         0
    respectively (2)            1         0
    responsibility of           1         0
    responsible in              0         1
    right to                    1         0
    safeguard and               0         1
    set out                     1         0
    sets up                     0         1
    specialized bodies          1         0
    state to                    1         1
    structures and              1         0
    sustainable use             1         0
    sustainably managed         0         1
    territorial collectivities  0         1
    the administration          0         1
    the benefits                1         0
    the bodies                  0         1
    the country's               1         0
    the decentralized           0         1
    the entire                  1         0
    the environment             1         2
    the essential               0         1
    the framework               0         1
    the implementation          0         1
    the living                  0         1
    the necessary               1         0
    the objectives              1         0
    the obligations             1         0
    the organizations           0         1
    the population              0         1
    the principles              1         0
    the protection              1         0
    the purpose                 0         1
    the rational                2         0
    the responsibility          1         0
    the right                   1         0
    the state                   1         1
    the wellbeing               1         0
    this law                    0         2
    this purpose                1         0
    title i                     1         1
    to achieve                  1         0
    to establish                0         1
    to fight                    0         1
    to implement                1         0
    to live                     1         0
    to make                     1         0
    to merely                   1         0
    to participate              1         0
    to prevent                  0         1
    to protect                  0         1
    to respect                  1         0
    to safeguard                0         1
    to the                      1         0
    to which                    0         1
    to work                     0         1
    together the                0         1
    traditional local           0         1
    underestimated in           1         0
    up the                      0         1
    use of                      2         0
    use respectively            1         0
    utilitarian interests       1         0
    values cannot               1         0
    wellbeing of                1         0
    which the                   0         1
    whose values                1         0
    with laws                   0         1
    with the                    0         1
    within the                  0         1
    work to                     0         1

    Column 'State A' and column 'State C' each represents a 219 x 1 bigram
    frequency vector. The similarity of STATE_A_LEGISLATION_TEXT and
    STATE_C_LEGISLATION_TEXT can be calculated by taking the cosine of the angle
    between the corresponding bigram frequency vectors.

    cosine(theta) = (BF1•BF2)/(|BF1||BF2|)

    where BF1•BF2 is the dot product of BF1 and BF2, or sum([i * j for i in BF1,
    j in BF2]), and |BFn| is the Euclidean length of BFn, or sqrt(sum([i ^ 2 for
    i in BFn])).

    Dot products:
        State A, State A: 164
        State A, State C: 17
        State C, State C: 133

    Euclidean lengths:
        State A: 12.806
        State C: 11.533

    Expected similiarity matrix:
                [ State A  State C ]
    [ State A ] [  1.000    0.115  ]
    [ State C ] [  0.115    1.000  ]
    '''

    test_directory_path = utilities.create_test_directory('bigram_frequency_full_text')

    file_content_by_relative_path = {
        os.path.join('legislation', 'state_a_english.txt'): utilities.STATE_A_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_b_english.txt'): utilities.STATE_B_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_c_english.txt'): utilities.STATE_C_LEGISLATION_TEXT,
    }

    states_to_include_file_path = os.path.join(test_directory_path, 'states_to_include.txt')
    with open(states_to_include_file_path, 'w') as file_object:
        json.dump(
            {
                'State A': {},
                # Omit State B
                'State C': {},
            },
            file_object)

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    algorithm = 'bigram_frequency'
    scope = 'full_text'
    output_directory_path = os.path.join(test_directory_path, 'output')
    legislation_directory_path = os.path.join(test_directory_path, 'legislation')

    actual_similarity_matrix_labels = []
    actual_similarity_matrix = []

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        os.makedirs(output_directory_path)
        subprocess.run(
            [
                script_file_path,
                '--legislation_directory_path',
                legislation_directory_path,
                '--debug',
                'matrix_and_plot',
                algorithm,
                scope,
                'english',
                output_directory_path,
                '--states_to_include_file_path',
                states_to_include_file_path,
            ],
            check=True)
        utilities.populate_actual_similarity_matrix_and_labels(
            output_directory_path, algorithm, scope,
            actual_similarity_matrix_labels, actual_similarity_matrix)
        utilities.assert_plot_file_exists(output_directory_path, algorithm, scope)
    finally:
        utilities.delete_test_directory(test_directory_path)

    expected_similarity_matrix_labels = ['State A', 'State C']
    expected_similarity_matrix = [
        [1.0, 0.115],
        [0.115, 1.0],
    ]

    utilities.compare_expected_and_actual_similarity_matrix_labels(
        expected_similarity_matrix_labels, actual_similarity_matrix_labels)

    utilities.compare_expected_and_actual_similarity_matrices(
        expected_similarity_matrix, actual_similarity_matrix,
        expected_similarity_matrix_labels, actual_similarity_matrix_labels)


def test_bigram_frequency_provisions():
    '''
    The values in the column 'Bigram' in the following table represent the
    complete set of bigrams in STATE_A_LEGISLATION_TEXT,
    STATE_B_LEGISLATION_TEXT and STATE_C_LEGISLATION_TEXT. The values in columns
    'A_1', 'A_2', 'A_3', 'B_1', 'B_2', 'B_3', 'C_1', 'C_2' and 'C_3' represent
    the number of occurrences of the values in columns 'Bigram' in
    STATE_A_LEGISLATION_TEXT provision 1, STATE_A_LEGISLATION_TEXT provision 2,
    STATE_A_LEGISLATION_TEXT provision 3, STATE_B_LEGISLATION_TEXT provision 1,
    STATE_B_LEGISLATION_TEXT provision 2, STATE_B_LEGISLATION_TEXT provision 3,
    STATE_C_LEGISLATION_TEXT provision 1, STATE_C_LEGISLATION_TEXT provision 2
    and STATE_C_LEGISLATION_TEXT provision 3 respectively.

    Bigram                     A_1  A_2  A_3  B_1  B_2  B_3  C_1  C_2  C_3
    a common                    0    0    0    0    1    0    0    0    0
    a healthy                   1    0    0    0    0    0    0    0    0
    a national                  0    0    1    0    0    0    0    0    0
    above creating              0    0    1    0    0    0    0    0    0
    according to                0    0    0    0    0    0    1    0    0
    achieve the                 0    0    1    0    0    0    0    0    0
    action to                   0    0    0    0    0    0    0    0    1
    administration sets         0    0    0    0    0    0    0    0    1
    against all                 0    0    0    0    0    0    0    1    0
    against forms               0    0    0    0    0    0    1    0    0
    aimed at                    0    0    0    0    0    1    0    0    0
    all citizens                1    0    0    0    0    0    0    0    0
    all kinds                   0    0    0    0    0    0    0    1    0
    an integral                 0    0    0    0    1    0    0    0    0
    and conservation            0    1    0    0    0    0    0    0    0
    and cultural                0    0    0    0    1    0    0    0    0
    and enhance                 0    0    0    0    0    0    1    0    1
    and environmental           0    0    0    0    0    1    0    0    0
    and having                  0    0    1    0    0    0    0    0    0
    and improve                 0    0    0    0    0    0    1    0    0
    and intangible              0    0    0    0    1    0    0    0    0
    and protected               0    0    0    0    0    0    1    0    0
    and regulations             0    0    0    0    0    0    0    1    0
    and specialized             0    0    1    0    0    0    0    0    0
    and sustainable             1    0    0    0    0    1    0    0    0
    and the                     0    1    0    0    1    0    0    1    0
    and to                      1    0    0    0    0    0    0    1    0
    applies it                  0    0    0    0    0    1    0    0    0
    are of                      0    0    0    0    1    0    0    0    0
    as the                      0    0    0    0    1    0    0    0    0
    as well                     0    0    0    0    1    0    0    0    0
    aspects they                0    0    0    0    1    0    0    0    0
    associations is             0    0    0    0    0    0    0    1    0
    associations to             0    0    0    0    0    1    0    0    0
    at ensuring                 0    0    0    0    0    1    0    0    0
    atmosphere their            0    0    0    0    1    0    0    0    0
    b defines                   0    0    0    0    0    1    0    0    0
    b it                        0    0    0    0    1    0    0    0    0
    be underestimated           0    1    0    0    0    0    0    0    0
    benefits of                 1    0    0    0    0    0    0    0    0
    better coordination         0    0    0    0    0    0    0    0    1
    bodies for                  0    0    1    0    0    0    0    0    0
    bodies necessary            0    0    0    0    0    0    0    0    1
    brings together             0    0    0    0    0    0    0    0    1
    cannot be                   0    1    0    0    0    0    0    0    0
    citizen individually        0    0    0    0    0    0    0    1    0
    citizens have               1    0    0    0    0    0    0    0    0
    collaboration with          0    0    0    0    0    0    0    1    0
    collectivities and          0    0    0    0    0    0    0    1    0
    common heritage             0    0    0    0    1    0    0    0    0
    communities and             0    0    0    0    0    1    0    0    0
    communities grassroots      0    0    0    0    0    1    0    0    0
    compliance with             0    0    0    0    0    0    0    1    0
    concerned for               0    0    0    0    0    0    0    0    1
    conditions of               0    0    0    0    0    0    1    0    0
    conservation and            0    0    0    0    0    1    0    0    0
    conservation of             0    1    0    0    0    0    0    0    0
    constitutes a               0    0    0    0    1    0    0    0    0
    content as                  0    0    0    0    1    0    0    0    0
    coordination of             0    0    0    0    0    0    0    0    1
    country's natural           1    0    0    0    0    0    0    0    0
    creating the                0    0    1    0    0    0    0    0    0
    cultural aspects            0    0    0    0    1    0    0    0    0
    decentralized territorial   0    0    0    0    0    1    0    1    0
    defense and                 1    0    0    0    0    0    0    0    0
    defense associations        0    0    0    0    0    1    0    0    0
    defines the                 0    0    0    0    0    1    0    0    0
    degradation in              0    0    0    0    0    0    1    1    0
    develops national           0    0    0    0    0    1    0    0    0
    due to                      0    1    0    0    0    0    0    0    0
    end the                     0    0    0    0    0    1    0    0    0
    enhance natural             0    0    0    0    0    0    1    0    0
    enhance the                 0    0    0    0    0    0    0    0    1
    ensuring the                0    0    0    0    0    1    0    0    0
    entire population           0    1    0    0    0    0    0    0    0
    environment and             1    1    0    0    0    0    0    0    0
    environment constitutes     0    0    0    0    1    0    0    0    0
    environment is              0    0    0    0    0    0    1    0    0
    environmental defense       0    0    0    0    0    1    0    0    0
    environmental degradation   0    0    0    0    0    0    0    1    0
    environmental management    0    0    1    1    0    0    0    0    0
    environmental policy        0    0    0    0    0    1    0    0    0
    environmental resources     0    0    0    0    0    1    0    0    0
    essential principles        0    0    0    0    0    0    1    0    0
    establish the               0    0    0    0    0    0    1    0    0
    establishes the             0    0    0    1    0    0    0    0    0
    every citizen               0    0    0    0    0    0    0    1    0
    fight against               0    0    0    0    0    0    0    1    0
    for better                  0    0    0    0    0    0    0    0    1
    for environmental           0    0    0    1    0    0    0    0    0
    for the                     0    1    0    0    0    0    0    0    1
    for this                    0    0    1    0    0    0    0    0    0
    forms of                    0    0    0    0    0    0    1    0    0
    framework for               0    0    0    1    0    0    0    0    0
    framework of                0    0    0    0    0    0    0    1    0
    general interest            0    0    0    0    1    0    0    0    0
    general legal               0    0    0    1    0    0    0    0    0
    geosphere hydrosphere       0    0    0    0    1    0    0    0    0
    government develops         0    0    0    0    0    1    0    0    0
    government which            0    0    0    0    0    1    0    0    0
    grassroots communities      0    0    0    0    0    1    0    0    0
    have the                    1    0    0    0    0    0    0    0    0
    having legislation          0    0    1    0    0    0    0    0    0
    healthy environment         1    0    0    0    0    0    0    0    0
    hence the                   1    0    0    0    0    0    0    0    0
    heritage its                0    0    0    0    1    0    0    0    0
    heritage of                 0    0    0    0    1    0    0    0    0
    human life                  0    0    0    0    1    0    0    0    0
    hydrosphere atmosphere      0    0    0    0    1    0    0    0    0
    implement a                 0    0    1    0    0    0    0    0    0
    implementation is           0    0    0    0    0    1    0    0    0
    implementation of           0    0    0    0    0    0    0    0    1
    improve the                 0    0    0    0    0    0    1    0    0
    in a                        1    0    0    0    0    0    0    0    0
    in collaboration            0    0    0    0    0    0    0    1    0
    in compliance               0    0    0    0    0    0    0    1    0
    in its                      1    0    0    0    0    0    0    0    0
    in order                    0    0    0    0    0    0    1    0    0
    in particular               0    0    0    0    1    0    0    0    0
    in relation                 0    1    0    0    0    0    0    0    0
    in state                    0    0    0    1    1    0    0    0    0
    individually or             0    0    0    0    0    0    0    1    0
    institutions or             0    0    0    0    0    0    0    1    0
    intangible content          0    0    0    0    1    0    0    0    0
    integral part               0    0    0    0    1    0    0    0    0
    interest these              0    0    0    0    1    0    0    0    0
    is an                       0    0    0    0    1    0    0    0    0
    is due                      0    1    0    0    0    0    0    0    0
    is responsible              0    0    0    0    0    0    0    1    0
    is sustainably              0    0    0    0    0    0    1    0    0
    is the                      0    0    1    0    0    1    0    0    0
    is to                       0    0    0    0    0    0    1    0    0
    it brings                   0    0    0    0    0    0    0    0    1
    it feasible                 0    0    1    0    0    0    0    0    0
    it is                       0    1    1    0    1    0    0    0    0
    it offers                   0    0    0    0    1    0    0    0    0
    it together                 0    0    0    0    0    1    0    0    0
    its defense                 1    0    0    0    0    0    0    0    0
    its implementation          0    0    0    0    0    1    0    0    0
    its protection              0    0    0    0    1    0    0    0    0
    kinds of                    0    0    0    0    0    0    0    1    0
    law establishes             0    0    0    1    0    0    0    0    0
    law is                      0    0    0    0    0    0    1    0    0
    law it                      0    0    0    0    0    0    0    0    1
    laws and                    0    0    0    0    0    0    0    1    0
    legal framework             0    0    0    1    0    0    0    0    0
    legislation published       0    0    1    0    0    0    0    0    0
    life are                    0    0    0    0    1    0    0    0    0
    live in                     1    0    0    0    0    0    0    0    0
    living conditions           0    0    0    0    0    0    1    0    0
    local institutions          0    0    0    0    0    0    0    1    0
    make it                     0    0    1    0    0    0    0    0    0
    managed and                 0    0    0    0    0    0    1    0    0
    management in               0    0    0    1    0    0    0    0    0
    management of               0    0    0    0    1    0    0    0    0
    management program          0    0    1    0    0    0    0    0    0
    merely utilitarian          0    1    0    0    0    0    0    0    0
    nation in                   0    0    0    0    1    0    0    0    0
    national environmental      0    0    1    0    0    1    0    0    0
    national strategies         0    0    0    0    0    1    0    0    0
    natural resources           1    1    0    0    0    0    1    0    0
    necessary for               0    0    0    0    0    0    0    0    1
    necessary structures        0    0    1    0    0    0    0    0    0
    objectives set              0    0    1    0    0    0    0    0    0
    obligations to              1    0    0    0    0    0    0    0    0
    of action                   0    0    0    0    0    0    0    0    1
    of degradation              0    0    0    0    0    0    1    0    0
    of environmental            0    0    0    0    0    1    0    0    0
    of general                  0    0    0    0    1    0    0    0    0
    of natural                  0    1    0    0    0    0    0    0    0
    of pollution                0    0    0    0    0    0    0    1    0
    of state                    0    0    0    0    0    1    0    0    0
    of the                      2    3    1    0    3    1    1    0    0
    of this                     0    0    0    0    0    0    1    0    1
    of traditional              0    0    0    0    0    0    0    1    0
    offers to                   0    0    0    0    1    0    0    0    0
    or associations             0    0    0    0    0    0    0    1    0
    or environmental            0    0    0    0    0    0    0    1    0
    or programs                 0    0    0    0    0    1    0    0    0
    or within                   0    0    0    0    0    0    0    1    0
    order to                    0    0    0    0    0    0    1    0    0
    organizations concerned     0    0    0    0    0    0    0    0    1
    out above                   0    0    1    0    0    0    0    0    0
    part of                     0    0    0    0    1    0    0    0    0
    participate in              1    0    0    0    0    0    0    0    0
    particular the              0    0    0    0    1    0    0    0    0
    plans or                    0    0    0    0    0    1    0    0    0
    policy its                  0    0    0    0    0    1    0    0    0
    pollution or                0    0    0    0    0    0    0    1    0
    population the              0    1    0    0    0    0    0    0    0
    preservation and            0    1    0    0    0    0    0    0    0
    president of                0    0    0    0    0    1    0    0    0
    prevent and                 0    0    0    0    0    0    0    1    0
    principles according        0    0    0    0    0    0    1    0    0
    principles of               0    1    0    0    0    0    0    0    0
    program to                  0    0    1    0    0    0    0    0    0
    programs aimed              0    0    0    0    0    1    0    0    0
    protect and                 0    0    0    0    0    0    0    0    1
    protected against           0    0    0    0    0    0    1    0    0
    protection and              0    0    0    0    1    0    0    0    0
    protection preservation     0    1    0    0    0    0    0    0    0
    published to                0    0    1    0    0    0    0    0    0
    purpose and                 0    0    1    0    0    0    0    0    0
    purpose of                  0    0    0    0    0    0    1    0    0
    rational management         0    0    0    0    1    0    0    0    0
    rational use                1    1    0    0    0    0    0    0    0
    relation to                 0    1    0    0    0    0    0    0    0
    resources and               0    0    0    0    0    0    1    0    0
    resources hence             1    0    0    0    0    0    0    0    0
    resources it                0    0    0    0    1    0    0    0    0
    resources whose             0    1    0    0    0    0    0    0    0
    respect for                 0    1    0    0    0    0    0    0    0
    responsibility of           0    0    1    0    0    1    0    0    0
    responsible in              0    0    0    0    0    0    0    1    0
    right to                    1    0    0    0    0    0    0    0    0
    safeguard and               0    0    0    0    0    0    1    0    0
    set out                     0    0    1    0    0    0    0    0    0
    sets up                     0    0    0    0    0    0    0    0    1
    social and                  0    0    0    0    1    0    0    0    0
    specialized bodies          0    0    1    0    0    0    0    0    0
    state b                     0    0    0    1    1    1    0    0    0
    state to                    0    0    1    0    0    0    0    1    0
    strategies plans            0    0    0    0    0    1    0    0    0
    structures and              0    0    1    0    0    0    0    0    0
    sustainable use             1    0    0    0    0    1    0    0    0
    sustainably managed         0    0    0    0    0    0    1    0    0
    tangible and                0    0    0    0    1    0    0    0    0
    target in                   0    0    0    0    1    0    0    0    0
    territorial collectivities  0    0    0    0    0    0    0    1    0
    territorial communities     0    0    0    0    0    1    0    0    0
    the administration          0    0    0    0    0    0    0    0    1
    the benefits                1    0    0    0    0    0    0    0    0
    the bodies                  0    0    0    0    0    0    0    0    1
    the conservation            0    0    0    0    0    1    0    0    0
    the country's               1    0    0    0    0    0    0    0    0
    the decentralized           0    0    0    0    0    1    0    1    0
    the entire                  0    1    0    0    0    0    0    0    0
    the environment             0    1    0    0    1    0    1    0    1
    the essential               0    0    0    0    0    0    1    0    0
    the framework               0    0    0    0    0    0    0    1    0
    the general                 0    0    0    1    0    0    0    0    0
    the geosphere               0    0    0    0    1    0    0    0    0
    the government              0    0    0    0    0    2    0    0    0
    the implementation          0    0    0    0    0    0    0    0    1
    the living                  0    0    0    0    0    0    1    0    0
    the nation                  0    0    0    0    1    0    0    0    0
    the national                0    0    0    0    0    1    0    0    0
    the necessary               0    0    1    0    0    0    0    0    0
    the objectives              0    0    1    0    0    0    0    0    0
    the obligations             1    0    0    0    0    0    0    0    0
    the organizations           0    0    0    0    0    0    0    0    1
    the population              0    0    0    0    0    0    1    0    0
    the president               0    0    0    0    0    1    0    0    0
    the principles              0    1    0    0    0    0    0    0    0
    the protection              0    1    0    0    0    0    0    0    0
    the purpose                 0    0    0    0    0    0    1    0    0
    the rational                1    1    0    0    1    0    0    0    0
    the resources               0    0    0    0    1    0    0    0    0
    the responsibility          0    0    1    0    0    1    0    0    0
    the right                   1    0    0    0    0    0    0    0    0
    the social                  0    0    0    0    1    0    0    0    0
    the state                   0    0    1    0    0    0    0    1    0
    the universal               0    0    0    0    1    0    0    0    0
    the wellbeing               0    1    0    0    0    0    0    0    0
    their tangible              0    0    0    0    1    0    0    0    0
    these target                0    0    0    0    1    0    0    0    0
    they include                0    0    0    0    1    0    0    0    0
    this end                    0    0    0    0    0    1    0    0    0
    this law                    0    0    0    1    0    0    1    0    1
    this purpose                0    0    1    0    0    0    0    0    0
    to achieve                  0    0    1    0    0    0    0    0    0
    to establish                0    0    0    0    0    0    1    0    0
    to fight                    0    0    0    0    0    0    0    1    0
    to human                    0    0    0    0    1    0    0    0    0
    to implement                0    0    1    0    0    0    0    0    0
    to live                     1    0    0    0    0    0    0    0    0
    to make                     0    0    1    0    0    0    0    0    0
    to merely                   0    1    0    0    0    0    0    0    0
    to participate              1    0    0    0    0    0    0    0    0
    to prevent                  0    0    0    0    0    0    0    1    0
    to protect                  0    0    0    0    0    0    0    0    1
    to respect                  0    1    0    0    0    0    0    0    0
    to safeguard                0    0    0    0    0    0    1    0    0
    to the                      1    0    0    0    0    0    0    0    0
    to this                     0    0    0    0    0    1    0    0    0
    to which                    0    0    0    0    0    0    1    0    0
    to work                     0    0    0    0    0    0    0    1    0
    together the                0    0    0    0    0    0    0    0    1
    together with               0    0    0    0    0    1    0    0    0
    traditional local           0    0    0    0    0    0    0    1    0
    underestimated in           0    1    0    0    0    0    0    0    0
    universal heritage          0    0    0    0    1    0    0    0    0
    up the                      0    0    0    0    0    0    0    0    1
    use of                      1    1    0    0    0    1    0    0    0
    use respectively            1    0    0    0    0    0    0    0    0
    utilitarian interests       0    1    0    0    0    0    0    0    0
    values cannot               0    1    0    0    0    0    0    0    0
    well as                     0    0    0    0    1    0    0    0    0
    wellbeing of                0    1    0    0    0    0    0    0    0
    which applies               0    0    0    0    0    1    0    0    0
    which the                   0    0    0    0    0    0    1    0    0
    whose values                0    1    0    0    0    0    0    0    0
    with laws                   0    0    0    0    0    0    0    1    0
    with the                    0    0    0    0    0    1    0    1    0
    within the                  0    0    0    0    0    0    0    1    0
    work to                     0    0    0    0    0    0    0    1    0

    Column 'A_1', column 'A_2', column 'A_3', column 'B_1', column 'B_2', column
    'B_3', column 'C_1', column 'C_2' and column 'C_3' each represents a 306 x 1
    bigram frequency vector. The similarity of any of the pairs of provisions in
    STATE_A_LEGISLATION_TEXT, STATE_B_LEGISLATION_TEXT and
    STATE_C_LEGISLATION_TEXT can be calculated by taking the cosine of the angle
    between the corresponding bigram frequency vectors.

    cosine(theta) = (BF1•BF2)/(|BF1||BF2|)

    where BF1•BF2 is the dot product of BF1 and BF2, or sum([i * j for i in BF1,
    j in BF2]), and |BFn| is the Euclidean length of BFn, or sqrt(sum([i ^ 2 for
    i in BFn])).

    Dot products:
        State A 1, State A 1: 37
        State A 1, State A 2: 11
        State A 1, State A 3: 2
        State A 1, State B 1: 0
        State A 1, State B 2: 7
        State A 1, State B 3: 5
        State A 1, State C 1: 3
        State A 1, State C 2: 1
        State A 1, State C 3: 0
        State A 2, State A 2: 46
        State A 2, State A 3: 4
        State A 2, State B 1: 0
        State A 2, State B 2: 13
        State A 2, State B 3: 4
        State A 2, State C 1: 5
        State A 2, State C 2: 1
        State A 2, State C 3: 2
        State A 3, State A 3: 38
        State A 3, State B 1: 1
        State A 3, State B 2: 4
        State A 3, State B 3: 5
        State A 3, State C 1: 1
        State A 3, State C 2: 2
        State A 3, State C 3: 0
        State B 1, State B 1: 12
        State B 1, State B 2: 2
        State B 1, State B 3: 1
        State B 1, State C 1: 1
        State B 1, State C 2: 0
        State B 1, State C 3: 1
        State B 2, State B 2: 67
        State B 2, State B 3: 4
        State B 2, State C 1: 4
        State B 2, State C 2: 1
        State B 2, State C 3: 1
        State B 3, State B 3: 56
        State B 3, State C 1: 1
        State B 3, State C 2: 3
        State B 3, State C 3: 0
        State C 1, State C 1: 40
        State C 1, State C 2: 1
        State C 1, State C 3: 4
        State C 2, State C 2: 45
        State C 2, State C 3: 0
        State C 3, State C 3: 29

    Euclidean lengths:
        State A 1: 6.083
        State A 2: 6.782
        State A 3: 6.164
        State B 1: 3.464
        State B 2: 8.185
        State B 3: 7.483
        State C 1: 6.325
        State C 2: 6.708
        State C 3: 5.385

    Expected similiarity matrix:
            [  A_1    A_2    A_3    B_1    B_2    B_3    C_1    C_2    C_3  ]
    [ A_1 ] [ 1.000  0.267  0.053  0.000  0.141  0.110  0.078  0.025  0.000 ]
    [ A_2 ] [ 0.267  1.000  0.096  0.000  0.234  0.079  0.117  0.022  0.055 ]
    [ A_3 ] [ 0.053  0.096  1.000  0.047  0.079  0.108  0.026  0.048  0.000 ]
    [ B_1 ] [ 0.000  0.000  0.047  1.000  0.071  0.039  0.046  0.000  0.054 ]
    [ B_2 ] [ 0.141  0.234  0.079  0.071  1.000  0.065  0.077  0.018  0.023 ]
    [ B_3 ] [ 0.110  0.079  0.108  0.039  0.065  1.000  0.021  0.060  0.000 ]
    [ C_1 ] [ 0.078  0.117  0.026  0.046  0.077  0.021  1.000  0.024  0.117 ]
    [ C_2 ] [ 0.025  0.022  0.048  0.000  0.018  0.060  0.024  1.000  0.000 ]
    [ C_3 ] [ 0.000  0.055  0.000  0.054  0.023  0.000  0.117  0.000  1.000 ]
    '''

    test_directory_path = utilities.create_test_directory('bigram_frequency_provisions')

    file_content_by_relative_path = {
        os.path.join('legislation', 'state_a_english.txt'): utilities.STATE_A_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_b_english.txt'): utilities.STATE_B_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_c_english.txt'): utilities.STATE_C_LEGISLATION_TEXT,
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    algorithm = 'bigram_frequency'
    scope = 'provision'
    output_directory_path = os.path.join(test_directory_path, 'output')
    legislation_directory_path = os.path.join(test_directory_path, 'legislation')

    actual_similarity_matrix_labels = []
    actual_similarity_matrix = []

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        os.makedirs(output_directory_path)
        subprocess.run(
            [
                script_file_path,
                '--legislation_directory_path',
                legislation_directory_path,
                '--debug',
                'matrix_and_plot',
                algorithm,
                scope,
                'english',
                output_directory_path,
            ],
            check=True)
        utilities.populate_actual_similarity_matrix_and_labels(
            output_directory_path, algorithm, scope,
            actual_similarity_matrix_labels, actual_similarity_matrix)
        utilities.assert_plot_file_exists(output_directory_path, algorithm, scope)
    finally:
        utilities.delete_test_directory(test_directory_path)

    expected_similarity_matrix_labels = [
        'State A 1',
        'State A 2',
        'State A 3',
        'State B 1',
        'State B 2',
        'State B 3',
        'State C 1',
        'State C 2',
        'State C 3',
    ]
    expected_similarity_matrix = [
        [1.0, 0.267, 0.053, 0.0, 0.141, 0.110, 0.078, 0.025, 0.0],
        [0.267, 1.0, 0.096, 0.0, 0.234, 0.079, 0.117, 0.022, 0.055],
        [0.053, 0.096, 1.0, 0.047, 0.079, 0.108, 0.026, 0.048, 0.0],
        [0.0, 0.0, 0.047, 1.0, 0.071, 0.039, 0.046, 0.0, 0.054],
        [0.141, 0.234, 0.079, 0.071, 1.0, 0.065, 0.077, 0.018, 0.023],
        [0.110, 0.079, 0.108, 0.039, 0.065, 1.0, 0.021, 0.060, 0.0],
        [0.078, 0.117, 0.026, 0.046, 0.077, 0.021, 1.0, 0.024, 0.117],
        [0.025, 0.022, 0.048, 0.0, 0.018, 0.060, 0.024, 1.0, 0.0],
        [0.0, 0.055, 0.0, 0.054, 0.023, 0.0, 0.117, 0.0, 1.0],
    ]

    utilities.compare_expected_and_actual_similarity_matrix_labels(
        expected_similarity_matrix_labels, actual_similarity_matrix_labels)

    utilities.compare_expected_and_actual_similarity_matrices(
        expected_similarity_matrix, actual_similarity_matrix,
        expected_similarity_matrix_labels, actual_similarity_matrix_labels)


def test_bigram_frequency_provisions_list_of_states_to_include():
    '''
    The values in column 'Bigram' in the following table represent the complete
    set of bigrams in provisions 1 and 3 of STATE_A_LEGISLATION_TEXT and
    provision 2 of STATE_C_LEGISLATION_TEXT. The values in columns 'A_1', 'A_3'
    and 'C_2' represent the number of occurences of the values of column
    'Bigram' in STATE_A_LEGISLATION_TEXT provision 1, STATE_A_LEGISLATION_TEXT
    provision 3 and STATE_C_LEGISLATION_TEXT provision 2 respectively.

    Bigram                     A_1  A_3  C_2
    a healthy                   1    0    0
    a national                  0    1    0
    above creating              0    1    0
    achieve the                 0    1    0
    against all                 0    0    1
    all citizens                1    0    0
    all kinds                   0    0    1
    and having                  0    1    0
    and regulations             0    0    1
    and specialized             0    1    0
    and sustainable             1    0    0
    and the                     0    0    1
    and to                      1    0    1
    associations is             0    0    1
    benefits of                 1    0    0
    bodies for                  0    1    0
    citizen individually        0    0    1
    citizens have               1    0    0
    collaboration with          0    0    1
    collectivities and          0    0    1
    compliance with             0    0    1
    country's natural           1    0    0
    creating the                0    1    0
    decentralized territorial   0    0    1
    defense and                 1    0    0
    degradation in              0    0    1
    environment and             1    0    0
    environmental degradation   0    0    1
    environmental management    0    1    0
    every citizen               0    0    1
    fight against               0    0    1
    for this                    0    1    0
    framework of                0    0    1
    have the                    1    0    0
    having legislation          0    1    0
    healthy environment         1    0    0
    hence the                   1    0    0
    implement a                 0    1    0
    in a                        1    0    0
    in collaboration            0    0    1
    in compliance               0    0    1
    in its                      1    0    0
    individually or             0    0    1
    institutions or             0    0    1
    is responsible              0    0    1
    is the                      0    1    0
    it feasible                 0    1    0
    it is                       0    1    0
    its defense                 1    0    0
    kinds of                    0    0    1
    laws and                    0    0    1
    legislation published       0    1    0
    live in                     1    0    0
    local institutions          0    0    1
    make it                     0    1    0
    management program          0    1    0
    national environmental      0    1    0
    natural resources           1    0    0
    necessary structures        0    1    0
    objectives set              0    1    0
    obligations to              1    0    0
    of pollution                0    0    1
    of the                      2    1    0
    of traditional              0    0    1
    or associations             0    0    1
    or environmental            0    0    1
    or within                   0    0    1
    out above                   0    1    0
    participate in              1    0    0
    pollution or                0    0    1
    prevent and                 0    0    1
    program to                  0    1    0
    published to                0    1    0
    purpose and                 0    1    0
    rational use                1    0    0
    resources hence             1    0    0
    responsibility of           0    1    0
    responsible in              0    0    1
    right to                    1    0    0
    set out                     0    1    0
    specialized bodies          0    1    0
    state to                    0    1    1
    structures and              0    1    0
    sustainable use             1    0    0
    territorial collectivities  0    0    1
    the benefits                1    0    0
    the country's               1    0    0
    the decentralized           0    0    1
    the framework               0    0    1
    the necessary               0    1    0
    the objectives              0    1    0
    the obligations             1    0    0
    the rational                1    0    0
    the responsibility          0    1    0
    the right                   1    0    0
    the state                   0    1    1
    this purpose                0    1    0
    to achieve                  0    1    0
    to fight                    0    0    1
    to implement                0    1    0
    to live                     1    0    0
    to make                     0    1    0
    to participate              1    0    0
    to prevent                  0    0    1
    to the                      1    0    0
    to work                     0    0    1
    traditional local           0    0    1
    use of                      1    0    0
    use respectively            1    0    0
    with laws                   0    0    1
    with the                    0    0    1
    within the                  0    0    1
    work to                     0    0    1

    Column 'A_1', column 'A_3' and column 'C_2' each represents a 113 x 1 bigram
    frequency vector. The similarity of the pair STATE_A_LEGISLATION_TEXT
    provision 1 and STATE_C_LEGISLATION_TEXT provision 2, or the pair
    STATE_A_LEGISLATION_TEXT provision 3 and STATE_C_LEGISLATION_TEXT provision
    2 can be calculated by taking the cosine of the angle between the
    corresponding bigram frequency vectors.

    cosine(theta) = (BF1•BF2)/(|BF1||BF2|)

    where BF1•BF2 is the dot product of BF1 and BF2, or sum([i * j for i in BF1,
    j in BF2]), and |BFn| is the Euclidean length of BFn, or sqrt(sum([i ^ 2 for
    i in BFn])).

    Dot products:
        State A 1, State A 1: 37
        State A 1, State A 3: 2
        State A 1, State C 2: 1
        State A 3, State A 3: 38
        State A 3, State C 2: 2
        State C 2, State C 2: 45

    Euclidean lengths:
        State A 1: 6.083
        State A 3: 6.164
        State C 2: 6.708

    Expected similiarity matrix:
            [  A_1    A_3    C_2  ]
    [ A_1 ] [ 1.000  0.053  0.025 ]
    [ A_3 ] [ 0.053  1.000  0.048 ]
    [ C_2 ] [ 0.025  0.048  1.000 ]
    '''

    test_directory_path = utilities.create_test_directory('bigram_frequency_provisions')

    file_content_by_relative_path = {
        os.path.join('legislation', 'state_a_english.txt'): utilities.STATE_A_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_b_english.txt'): utilities.STATE_B_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_c_english.txt'): utilities.STATE_C_LEGISLATION_TEXT,
    }

    states_to_include_file_path = os.path.join(test_directory_path, 'states_to_include.txt')
    with open(states_to_include_file_path, 'w') as file_object:
        json.dump(
            {
                'State A': {
                    'Provisions': ['1', '3'],
                },
                # Omit State B
                'State C': {
                    'Provisions': ['2'],
                },
            },
            file_object)

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    algorithm = 'bigram_frequency'
    scope = 'provision'
    output_directory_path = os.path.join(test_directory_path, 'output')
    legislation_directory_path = os.path.join(test_directory_path, 'legislation')

    actual_similarity_matrix_labels = []
    actual_similarity_matrix = []

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        os.makedirs(output_directory_path)
        subprocess.run(
            [
                script_file_path,
                '--legislation_directory_path',
                legislation_directory_path,
                '--debug',
                'matrix_and_plot',
                algorithm,
                scope,
                'english',
                output_directory_path,
                '--states_to_include_file_path',
                states_to_include_file_path,
            ],
            check=True)
        utilities.populate_actual_similarity_matrix_and_labels(
            output_directory_path, algorithm, scope,
            actual_similarity_matrix_labels, actual_similarity_matrix)
        utilities.assert_plot_file_exists(output_directory_path, algorithm, scope)
    finally:
        utilities.delete_test_directory(test_directory_path)

    expected_similarity_matrix_labels = [
        'State A 1',
        'State A 3',
        'State C 2',
    ]
    expected_similarity_matrix = [
        [1.0, 0.053, 0.025],
        [0.053, 1.0, 0.048],
        [0.025, 0.048, 1.0],
    ]

    utilities.compare_expected_and_actual_similarity_matrix_labels(
        expected_similarity_matrix_labels, actual_similarity_matrix_labels)

    utilities.compare_expected_and_actual_similarity_matrices(
        expected_similarity_matrix, actual_similarity_matrix,
        expected_similarity_matrix_labels, actual_similarity_matrix_labels)


def test_bigram_frequency_output_directory_does_not_exist():
    test_directory_path = utilities.create_test_directory('bigram_frequency_provisions')

    file_content_by_relative_path = {
        os.path.join('legislation', 'state_a_english.txt'): utilities.STATE_A_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_b_english.txt'): utilities.STATE_B_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_c_english.txt'): utilities.STATE_C_LEGISLATION_TEXT,
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    output_directory_path = os.path.join(
        os.path.sep, 'invalid', 'output', 'directory', 'path')
    legislation_directory_path = os.path.join(test_directory_path, 'legislation')

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        completed_process = subprocess.run(
            [
                script_file_path,
                '--legislation_directory_path',
                legislation_directory_path,
                '--debug',
                'matrix_and_plot',
                'bigram_frequency',
                'full_text',
                'english',
                output_directory_path,
            ],
            capture_output=True,
            text=True)
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert 0 != completed_process.returncode
    assert 'ValueError' in completed_process.stderr


def test_bigram_frequency_matrix_only():
    test_directory_path = utilities.create_test_directory('bigram_frequency_full_text')

    file_content_by_relative_path = {
        os.path.join('legislation', 'state_a_english.txt'): utilities.STATE_A_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_b_english.txt'): utilities.STATE_B_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_c_english.txt'): utilities.STATE_C_LEGISLATION_TEXT,
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    algorithm = 'bigram_frequency'
    scope = 'full_text'
    output_directory_path = os.path.join(test_directory_path, 'output')
    legislation_directory_path = os.path.join(test_directory_path, 'legislation')

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        os.makedirs(output_directory_path)
        subprocess.run(
            [
                script_file_path,
                '--legislation_directory_path',
                legislation_directory_path,
                '--debug',
                'matrix_and_plot',
                algorithm,
                scope,
                'english',
                output_directory_path,
                '--matrix_only',
            ],
            check=True)
        utilities.assert_plot_file_does_not_exist(
            output_directory_path, algorithm, scope)
    finally:
        utilities.delete_test_directory(test_directory_path)
