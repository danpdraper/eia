import os
import subprocess

import eia.environment as environment
import eia.tests.utilities as utilities


def test_term_frequency_full_text_preserve_provision_delimiters():
    '''
    The values in column 'Term' in the following table represent the complete
    set of words in STATE_A_LEGISLATION_TEXT, STATE_B_LEGISLATION_TEXT and
    STATE_C_LEGISLATION_TEXT. The values in columns 'State A Count', 'State B
    Count' and 'State C Count' represent the number of occurrences of the values
    in column 'Term' in STATE_A_LEGISLATION_TEXT, STATE_B_LEGISLATION_TEXT and
    STATE_C_LEGISLATION_TEXT respectively.

    Term            State A Count  State B Count  State C Count
    (1)                   1              1              1
    (2)                   1              1              1
    (3)                   1              1              1
    a                     2              1              0
    above                 1              0              0
    according             0              0              1
    achieve               1              0              0
    action                0              0              1
    administration        0              0              1
    against               0              0              2
    aimed                 0              1              0
    all                   1              0              1
    an                    0              1              0
    and                   6              5              7
    applies               0              1              0
    are                   0              1              0
    as                    0              2              0
    aspects               0              1              0
    associations          0              1              1
    at                    0              1              0
    atmosphere            0              1              0
    b                     0              3              0
    be                    1              0              0
    benefits              1              0              0
    better                0              0              1
    bodies                1              0              1
    brings                0              0              1
    cannot                1              0              0
    citizen               0              0              1
    citizens              1              0              0
    collaboration         0              0              1
    collectivities        0              0              1
    common                0              1              0
    communities           0              2              0
    compliance            0              0              1
    concerned             0              0              1
    conditions            0              0              1
    conservation          1              1              0
    constitutes           0              1              0
    content               0              1              0
    coordination          0              0              1
    country's             1              0              0
    creating              1              0              0
    cultural              0              1              0
    decentralized         0              1              1
    defense               1              1              0
    defines               0              1              0
    degradation           0              0              2
    develops              0              1              0
    due                   1              0              0
    end                   0              1              0
    enhance               0              0              2
    ensuring              0              1              0
    entire                1              0              0
    environment           2              1              2
    environmental         1              4              1
    essential             0              0              1
    establish             0              0              1
    establishes           0              1              0
    every                 0              0              1
    feasible              1              0              0
    fight                 0              0              1
    for                   2              1              2
    forms                 0              0              1
    framework             0              1              1
    fundamental           0              0              1
    general               1              3              0
    geosphere             0              1              0
    government            0              2              0
    grassroots            0              1              0
    have                  1              0              0
    having                1              0              0
    healthy               1              0              0
    hence                 1              0              0
    heritage              0              2              0
    human                 0              1              0
    hydrosphere           0              1              0
    i                     1              1              1
    implement             1              0              0
    implementation        0              1              1
    improve               0              0              1
    in                    3              3              3
    include               0              1              0
    individually          0              0              1
    institutions          0              0              1
    intangible            0              1              0
    integral              0              1              0
    interest              0              1              0
    interests             1              0              0
    is                    2              2              3
    it                    3              3              1
    its                   1              2              0
    kinds                 0              0              1
    law                   0              1              2
    laws                  0              0              1
    legal                 0              1              0
    legislation           1              0              0
    life                  0              1              0
    live                  1              0              0
    living                0              0              1
    local                 0              0              1
    make                  1              0              0
    managed               0              0              1
    management            1              2              0
    merely                1              0              0
    nation                0              1              0
    national              1              2              0
    natural               2              0              1
    necessary             1              0              1
    objectives            1              0              0
    obligations           1              0              0
    of                    7              7              7
    offers                0              1              0
    or                    0              1              3
    order                 0              0              1
    organizations         0              0              1
    out                   1              0              0
    part                  0              1              0
    participate           1              0              0
    particular            0              1              0
    plans                 0              1              0
    policy                0              1              0
    pollution             0              0              1
    population            1              0              1
    preservation          1              0              0
    president             0              1              0
    prevent               0              0              1
    principles            2              0              2
    program               1              0              0
    programs              0              1              0
    protect               0              0              1
    protected             0              0              1
    protection            1              1              0
    provisions            0              1              0
    published             1              0              0
    purpose               1              0              1
    rational              2              1              0
    regulations           0              0              1
    relation              1              0              0
    resources             2              2              1
    respect               1              0              0
    respectively          1              0              0
    responsible           0              0              1
    responsibility        1              1              0
    right                 1              0              0
    safeguard             0              0              1
    set                   1              0              0
    sets                  0              0              1
    social                0              1              0
    specialized           1              0              0
    state                 1              3              1
    strategies            0              1              0
    structures            1              0              0
    sustainable           1              1              0
    sustainably           0              0              1
    tangible              0              1              0
    target                0              1              0
    territorial           0              1              1
    the                   15             15             13
    their                 0              1              0
    these                 0              1              0
    they                  0              1              0
    this                  1              2              2
    title                 1              1              1
    to                    8              2              7
    together              0              1              1
    traditional           0              0              1
    underestimated        1              0              0
    universal             0              1              0
    up                    0              0              1
    use                   3              1              0
    utilitarian           1              0              0
    values                1              0              0
    well                  0              1              0
    wellbeing             1              0              0
    which                 0              1              1
    whose                 1              0              0
    with                  0              1              2
    within                0              0              1
    work                  0              0              1

    Column 'State A Count', column 'State B Count' and column 'State C Count'
    each represents a 180 x 1 term frequency vector. The similarity of any of
    the pairs of STATE_A_LEGISLATION_TEXT, STATE_B_LEGISLATION_TEXT and
    STATE_C_LEGISLATION_TEXT can be calculated by taking the cosine of the angle
    between the corresponding term frequency vectors.

    cosine(theta) = (TF1•TF2)/(|TF1||TF2|)

    where TF1•TF2 is the dot product of TF1 and TF2, or sum([i * j for i in TF1,
    j in TF2]), and |TFn| is the Euclidean length of TFn, or sqrt(sum([i ^ 2 for
    i in TFn])).

    Dot products:
        State A, State A: 495
        State A, State B: 385
        State A, State C: 390
        State B, State B: 473
        State B, State C: 347
        State C, State C: 442

    Euclidean lengths:
        State A: 22.249
        State B: 21.749
        State C: 21.024

    Expected similiarity matrix:
                [ State A  State B  State C ]
    [ State A ] [  1.000    0.796    0.834  ]
    [ State B ] [  0.796    1.000    0.759  ]
    [ State C ] [  0.834    0.759    1.000  ]
    '''

    test_directory_path = utilities.create_test_directory('term_frequency_full_text')

    file_content_by_relative_path = {
        os.path.join('legislation', 'state_a_english.txt'): utilities.STATE_A_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_b_english.txt'): utilities.STATE_B_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_c_english.txt'): utilities.STATE_C_LEGISLATION_TEXT,
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    algorithm = 'term_frequency'
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
        [1.0, 0.796, 0.834],
        [0.796, 1.0, 0.759],
        [0.834, 0.759, 1.0],
    ]

    assert expected_similarity_matrix_labels == actual_similarity_matrix_labels

    utilities.compare_expected_and_actual_similarity_matrices(
        expected_similarity_matrix, actual_similarity_matrix)


def test_term_frequency_full_text_do_not_preserve_provision_delimiters():
    '''
    The values in column 'Term' in the following table represent the complete
    set of words in STATE_A_LEGISLATION_TEXT, STATE_B_LEGISLATION_TEXT and
    STATE_C_LEGISLATION_TEXT, excluding the provision delimiters, i.e. (1), (2)
    and (3). The values in columns 'State A Count', 'State B Count' and 'State C
    Count' represent the number of occurrences of the values in column 'Term' in
    STATE_A_LEGISLATION_TEXT, STATE_B_LEGISLATION_TEXT and
    STATE_C_LEGISLATION_TEXT respectively.

    Term            State A Count  State B Count  State C Count
    a                     2              1              0
    above                 1              0              0
    according             0              0              1
    achieve               1              0              0
    action                0              0              1
    administration        0              0              1
    against               0              0              2
    aimed                 0              1              0
    all                   1              0              1
    an                    0              1              0
    and                   6              5              7
    applies               0              1              0
    are                   0              1              0
    as                    0              2              0
    aspects               0              1              0
    associations          0              1              1
    at                    0              1              0
    atmosphere            0              1              0
    b                     0              3              0
    be                    1              0              0
    benefits              1              0              0
    better                0              0              1
    bodies                1              0              1
    brings                0              0              1
    cannot                1              0              0
    citizen               0              0              1
    citizens              1              0              0
    collaboration         0              0              1
    collectivities        0              0              1
    common                0              1              0
    communities           0              2              0
    compliance            0              0              1
    concerned             0              0              1
    conditions            0              0              1
    conservation          1              1              0
    constitutes           0              1              0
    content               0              1              0
    coordination          0              0              1
    country's             1              0              0
    creating              1              0              0
    cultural              0              1              0
    decentralized         0              1              1
    defense               1              1              0
    defines               0              1              0
    degradation           0              0              2
    develops              0              1              0
    due                   1              0              0
    end                   0              1              0
    enhance               0              0              2
    ensuring              0              1              0
    entire                1              0              0
    environment           2              1              2
    environmental         1              4              1
    essential             0              0              1
    establish             0              0              1
    establishes           0              1              0
    every                 0              0              1
    feasible              1              0              0
    fight                 0              0              1
    for                   2              1              2
    forms                 0              0              1
    framework             0              1              1
    fundamental           0              0              1
    general               1              3              0
    geosphere             0              1              0
    government            0              2              0
    grassroots            0              1              0
    have                  1              0              0
    having                1              0              0
    healthy               1              0              0
    hence                 1              0              0
    heritage              0              2              0
    human                 0              1              0
    hydrosphere           0              1              0
    i                     1              1              1
    implement             1              0              0
    implementation        0              1              1
    improve               0              0              1
    in                    3              3              3
    include               0              1              0
    individually          0              0              1
    institutions          0              0              1
    intangible            0              1              0
    integral              0              1              0
    interest              0              1              0
    interests             1              0              0
    is                    2              2              3
    it                    3              3              1
    its                   1              2              0
    kinds                 0              0              1
    law                   0              1              2
    laws                  0              0              1
    legal                 0              1              0
    legislation           1              0              0
    life                  0              1              0
    live                  1              0              0
    living                0              0              1
    local                 0              0              1
    make                  1              0              0
    managed               0              0              1
    management            1              2              0
    merely                1              0              0
    nation                0              1              0
    national              1              2              0
    natural               2              0              1
    necessary             1              0              1
    objectives            1              0              0
    obligations           1              0              0
    of                    7              7              7
    offers                0              1              0
    or                    0              1              3
    order                 0              0              1
    organizations         0              0              1
    out                   1              0              0
    part                  0              1              0
    participate           1              0              0
    particular            0              1              0
    plans                 0              1              0
    policy                0              1              0
    pollution             0              0              1
    population            1              0              1
    preservation          1              0              0
    president             0              1              0
    prevent               0              0              1
    principles            2              0              2
    program               1              0              0
    programs              0              1              0
    protect               0              0              1
    protected             0              0              1
    protection            1              1              0
    provisions            0              1              0
    published             1              0              0
    purpose               1              0              1
    rational              2              1              0
    regulations           0              0              1
    relation              1              0              0
    resources             2              2              1
    respect               1              0              0
    respectively          1              0              0
    responsible           0              0              1
    responsibility        1              1              0
    right                 1              0              0
    safeguard             0              0              1
    set                   1              0              0
    sets                  0              0              1
    social                0              1              0
    specialized           1              0              0
    state                 1              3              1
    strategies            0              1              0
    structures            1              0              0
    sustainable           1              1              0
    sustainably           0              0              1
    tangible              0              1              0
    target                0              1              0
    territorial           0              1              1
    the                   15             15             13
    their                 0              1              0
    these                 0              1              0
    they                  0              1              0
    this                  1              2              2
    title                 1              1              1
    to                    8              2              7
    together              0              1              1
    traditional           0              0              1
    underestimated        1              0              0
    universal             0              1              0
    up                    0              0              1
    use                   3              1              0
    utilitarian           1              0              0
    values                1              0              0
    well                  0              1              0
    wellbeing             1              0              0
    which                 0              1              1
    whose                 1              0              0
    with                  0              1              2
    within                0              0              1
    work                  0              0              1

    Column 'State A Count', column 'State B Count' and column 'State C Count'
    each represents a 177 x 1 term frequency vector. The similarity of any of
    the pairs of STATE_A_LEGISLATION_TEXT, STATE_B_LEGISLATION_TEXT and
    STATE_C_LEGISLATION_TEXT can be calculated by taking the cosine of the angle
    between the corresponding term frequency vectors.

    cosine(theta) = (TF1•TF2)/(|TF1||TF2|)

    where TF1•TF2 is the dot product of TF1 and TF2, or sum([i * j for i in TF1,
    j in TF2]), and |TFn| is the Euclidean length of TFn, or sqrt(sum([i ^ 2 for
    i in TFn])).

    Dot products:
        State A, State A: 492
        State A, State B: 382
        State A, State C: 387
        State B, State B: 470
        State B, State C: 344
        State C, State C: 439

    Euclidean lengths:
        State A: 22.181
        State B: 21.679
        State C: 20.952

    Expected similiarity matrix:
                [ State A  State B  State C ]
    [ State A ] [  1.000    0.794    0.833  ]
    [ State B ] [  0.794    1.000    0.757  ]
    [ State C ] [  0.833    0.757    1.000  ]
    '''

    test_directory_path = utilities.create_test_directory('term_frequency_full_text')

    file_content_by_relative_path = {
        os.path.join('legislation', 'state_a_english.txt'): utilities.STATE_A_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_b_english.txt'): utilities.STATE_B_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_c_english.txt'): utilities.STATE_C_LEGISLATION_TEXT,
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    algorithm = 'term_frequency'
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
        [1.0, 0.794, 0.833],
        [0.794, 1.0, 0.757],
        [0.833, 0.757, 1.0],
    ]

    assert expected_similarity_matrix_labels == actual_similarity_matrix_labels

    utilities.compare_expected_and_actual_similarity_matrices(
        expected_similarity_matrix, actual_similarity_matrix)


def test_term_frequency_full_text_list_of_states_to_include():
    '''
    The values in column 'Term' in the following table represent the complete
    set of words in STATE_A_LEGISLATION_TEXT and STATE_C_LEGISLATION_TEXT. The
    values in column 'State A Count' and 'State C Count' represent the number of
    occurrences of the values in column 'Term' in STATE_A_LEGISLATION_TEXT and
    STATE_C_LEGISLATION_TEXT respectively.

    Term            State A Count  State C Count
    (1)                   1              1
    (2)                   1              1
    (3)                   1              1
    a                     2              0
    above                 1              0
    according             0              1
    achieve               1              0
    action                0              1
    administration        0              1
    against               0              2
    all                   1              1
    and                   6              7
    associations          0              1
    be                    1              0
    benefits              1              0
    better                0              1
    bodies                1              1
    brings                0              1
    cannot                1              0
    citizen               0              1
    citizens              1              0
    collaboration         0              1
    collectivities        0              1
    compliance            0              1
    concerned             0              1
    conditions            0              1
    conservation          1              0
    coordination          0              1
    country's             1              0
    creating              1              0
    decentralized         0              1
    defense               1              0
    degradation           0              2
    due                   1              0
    enhance               0              2
    entire                1              0
    environment           2              2
    environmental         1              1
    essential             0              1
    establish             0              1
    every                 0              1
    feasible              1              0
    fight                 0              1
    for                   2              2
    forms                 0              1
    framework             0              1
    fundamental           0              1
    general               1              0
    have                  1              0
    having                1              0
    healthy               1              0
    hence                 1              0
    i                     1              1
    implement             1              0
    implementation        0              1
    improve               0              1
    in                    3              3
    individually          0              1
    institutions          0              1
    interests             1              0
    is                    2              3
    it                    3              1
    its                   1              0
    kinds                 0              1
    law                   0              2
    laws                  0              1
    legislation           1              0
    live                  1              0
    living                0              1
    local                 0              1
    make                  1              0
    managed               0              1
    management            1              0
    merely                1              0
    national              1              0
    natural               2              1
    necessary             1              1
    objectives            1              0
    obligations           1              0
    of                    7              7
    or                    0              3
    order                 0              1
    organizations         0              1
    out                   1              0
    participate           1              0
    pollution             0              1
    population            1              1
    preservation          1              0
    prevent               0              1
    principles            2              2
    program               1              0
    protect               0              1
    protected             0              1
    protection            1              0
    published             1              0
    purpose               1              1
    rational              2              0
    regulations           0              1
    relation              1              0
    resources             2              1
    respect               1              0
    respectively          1              0
    responsible           0              1
    responsibility        1              0
    right                 1              0
    safeguard             0              1
    set                   1              0
    sets                  0              1
    specialized           1              0
    state                 1              1
    structures            1              0
    sustainable           1              0
    sustainably           0              1
    territorial           0              1
    the                   15             13
    this                  1              2
    title                 1              1
    to                    8              7
    together              0              1
    traditional           0              1
    underestimated        1              0
    up                    0              1
    use                   3              0
    utilitarian           1              0
    values                1              0
    wellbeing             1              0
    which                 0              1
    whose                 1              0
    with                  0              2
    within                0              1
    work                  0              1

    Column 'State A Count' and column 'State C Count' each represents a 131 x 1
    term frequency vector. The similarity of STATE_A_LEGISLATION_TEXT and
    STATE_C_LEGISLATION_TEXT can be calculated by taking the cosine of the angle
    between the corresponding term frequency vectors.

    cosine(theta) = (TF1•TF2)/(|TF1||TF2|)

    where TF1•TF2 is the dot product of TF1 and TF2, or sum([i * j for i in TF1,
    j in TF2]), and |TFn| is the Euclidean length of TFn, or sqrt(sum([i ^ 2 for
    i in TFn])).

    Dot products:
        State A, State A: 495
        State A, State C: 390
        State C, State C: 442

    Euclidean lengths:
        State A: 22.249
        State C: 21.024

    Expected similiarity matrix:
                [ State A  State C ]
    [ State A ] [  1.000    0.834  ]
    [ State C ] [  0.834    1.000  ]
    '''

    test_directory_path = utilities.create_test_directory('term_frequency_full_text')

    file_content_by_relative_path = {
        os.path.join('legislation', 'state_a_english.txt'): utilities.STATE_A_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_b_english.txt'): utilities.STATE_B_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_c_english.txt'): utilities.STATE_C_LEGISLATION_TEXT,
    }

    states_to_include_file_path = os.path.join(test_directory_path, 'states_to_include.txt')
    with open(states_to_include_file_path, 'w') as file_object:
        file_object.write('state_a\n')
        # Omit State B
        file_object.write('state_c\n')

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    algorithm = 'term_frequency'
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
        [1.0, 0.834],
        [0.834, 1.0],
    ]

    assert expected_similarity_matrix_labels == actual_similarity_matrix_labels

    utilities.compare_expected_and_actual_similarity_matrices(
        expected_similarity_matrix, actual_similarity_matrix)


def test_term_frequency_provisions():
    '''
    The values in column 'Term' in the following table represent the complete
    set of words in STATE_A_LEGISLATION_TEXT, STATE_B_LEGISLATION_TEXT and
    STATE_C_LEGISLATION_TEXT. The values in columns 'A_1', 'A_2', 'A_3', 'B_1',
    'B_2', 'B_3', 'C_1', 'C_2' and 'C_3' represent the number of occurrences of
    the values in column 'Term' in STATE_A_LEGISLATION_TEXT provision 1,
    STATE_A_LEGISLATION_TEXT provision 2, STATE_A_LEGISLATION_TEXT provision 3,
    STATE_B_LEGISLATION_TEXT provision 1, STATE_B_LEGISLATION_TEXT provision 2,
    STATE_B_LEGISLATION_TEXT provision 3, STATE_C_LEGISLATION_TEXT provision 1,
    STATE_C_LEGISLATION_TEXT provision 2 and STATE_C_LEGISLATION_TEXT provision
    3 respectively.

    Term           A_1  A_2  A_3  B_1  B_2  B_3  C_1  C_2  C_3
    a               1    0    1    0    1    0    0    0    0
    above           0    0    1    0    0    0    0    0    0
    according       0    0    0    0    0    0    1    0    0
    achieve         0    0    1    0    0    0    0    0    0
    action          0    0    0    0    0    0    0    0    1
    administration  0    0    0    0    0    0    0    0    1
    against         0    0    0    0    0    0    1    1    0
    aimed           0    0    0    0    0    1    0    0    0
    all             1    0    0    0    0    0    0    1    0
    an              0    0    0    0    1    0    0    0    0
    and             2    2    2    0    3    2    3    3    1
    applies         0    0    0    0    0    1    0    0    0
    are             0    0    0    0    1    0    0    0    0
    as              0    0    0    0    2    0    0    0    0
    aspects         0    0    0    0    1    0    0    0    0
    associations    0    0    0    0    0    1    0    1    0
    at              0    0    0    0    0    1    0    0    0
    atmosphere      0    0    0    0    1    0    0    0    0
    b               0    0    0    1    1    1    0    0    0
    be              0    1    0    0    0    0    0    0    0
    benefits        1    0    0    0    0    0    0    0    0
    better          0    0    0    0    0    0    0    0    1
    bodies          0    0    1    0    0    0    0    0    1
    brings          0    0    0    0    0    0    0    0    1
    cannot          0    1    0    0    0    0    0    0    0
    citizen         0    0    0    0    0    0    0    1    0
    citizens        1    0    0    0    0    0    0    0    0
    collaboration   0    0    0    0    0    0    0    1    0
    collectivities  0    0    0    0    0    0    0    1    0
    common          0    0    0    0    1    0    0    0    0
    communities     0    0    0    0    0    2    0    0    0
    compliance      0    0    0    0    0    0    0    1    0
    concerned       0    0    0    0    0    0    0    0    1
    conditions      0    0    0    0    0    0    1    0    0
    conservation    0    1    0    0    0    1    0    0    0
    constitutes     0    0    0    0    1    0    0    0    0
    content         0    0    0    0    1    0    0    0    0
    coordination    0    0    0    0    0    0    0    0    1
    country's       1    0    0    0    0    0    0    0    0
    creating        0    0    1    0    0    0    0    0    0
    cultural        0    0    0    0    1    0    0    0    0
    decentralized   0    0    0    0    0    1    0    1    0
    defense         1    0    0    0    0    1    0    0    0
    defines         0    0    0    0    0    1    0    0    0
    degradation     0    0    0    0    0    0    1    1    0
    develops        0    0    0    0    0    1    0    0    0
    due             0    1    0    0    0    0    0    0    0
    end             0    0    0    0    0    1    0    0    0
    enhance         0    0    0    0    0    0    1    0    1
    ensuring        0    0    0    0    0    1    0    0    0
    entire          0    1    0    0    0    0    0    0    0
    environment     1    1    0    0    1    0    1    0    1
    environmental   0    0    1    1    0    3    0    1    0
    essential       0    0    0    0    0    0    1    0    0
    establish       0    0    0    0    0    0    1    0    0
    establishes     0    0    0    1    0    0    0    0    0
    every           0    0    0    0    0    0    0    1    0
    feasible        0    0    1    0    0    0    0    0    0
    fight           0    0    0    0    0    0    0    1    0
    for             0    1    1    1    0    0    0    0    2
    forms           0    0    0    0    0    0    1    0    0
    framework       0    0    0    1    0    0    0    1    0
    general         0    0    0    1    1    0    0    0    0
    geosphere       0    0    0    0    1    0    0    0    0
    government      0    0    0    0    0    2    0    0    0
    grassroots      0    0    0    0    0    1    0    0    0
    have            1    0    0    0    0    0    0    0    0
    having          0    0    1    0    0    0    0    0    0
    healthy         1    0    0    0    0    0    0    0    0
    hence           1    0    0    0    0    0    0    0    0
    heritage        0    0    0    0    2    0    0    0    0
    human           0    0    0    0    1    0    0    0    0
    hydrosphere     0    0    0    0    1    0    0    0    0
    implement       0    0    1    0    0    0    0    0    0
    implementation  0    0    0    0    0    1    0    0    1
    improve         0    0    0    0    0    0    1    0    0
    in              2    1    0    1    2    0    1    2    0
    include         0    0    0    0    1    0    0    0    0
    individually    0    0    0    0    0    0    0    1    0
    institutions    0    0    0    0    0    0    0    1    0
    intangible      0    0    0    0    1    0    0    0    0
    integral        0    0    0    0    1    0    0    0    0
    interest        0    0    0    0    1    0    0    0    0
    interests       0    1    0    0    0    0    0    0    0
    is              0    1    1    0    1    1    2    1    0
    it              0    1    2    0    2    1    0    0    1
    its             1    0    0    0    1    1    0    0    0
    kinds           0    0    0    0    0    0    0    1    0
    law             0    0    0    1    0    0    1    0    1
    laws            0    0    0    0    0    0    0    1    0
    legal           0    0    0    1    0    0    0    0    0
    legislation     0    0    1    0    0    0    0    0    0
    life            0    0    0    0    1    0    0    0    0
    live            1    0    0    0    0    0    0    0    0
    living          0    0    0    0    0    0    1    0    0
    local           0    0    0    0    0    0    0    1    0
    make            0    0    1    0    0    0    0    0    0
    managed         0    0    0    0    0    0    1    0    0
    management      0    0    1    1    1    0    0    0    0
    merely          0    1    0    0    0    0    0    0    0
    nation          0    0    0    0    1    0    0    0    0
    national        0    0    1    0    0    2    0    0    0
    natural         1    1    0    0    0    0    1    0    0
    necessary       0    0    1    0    0    0    0    0    1
    objectives      0    0    1    0    0    0    0    0    0
    obligations     1    0    0    0    0    0    0    0    0
    of              2    4    1    0    4    3    3    2    2
    offers          0    0    0    0    1    0    0    0    0
    or              0    0    0    0    0    1    0    3    0
    order           0    0    0    0    0    0    1    0    0
    organizations   0    0    0    0    0    0    0    0    1
    out             0    0    1    0    0    0    0    0    0
    part            0    0    0    0    1    0    0    0    0
    participate     1    0    0    0    0    0    0    0    0
    particular      0    0    0    0    1    0    0    0    0
    plans           0    0    0    0    0    1    0    0    0
    policy          0    0    0    0    0    1    0    0    0
    pollution       0    0    0    0    0    0    0    1    0
    population      0    1    0    0    0    0    1    0    0
    preservation    0    1    0    0    0    0    0    0    0
    president       0    0    0    0    0    1    0    0    0
    prevent         0    0    0    0    0    0    0    1    0
    principles      0    1    0    0    0    0    1    0    0
    program         0    0    1    0    0    0    0    0    0
    programs        0    0    0    0    0    1    0    0    0
    protect         0    0    0    0    0    0    0    0    1
    protected       0    0    0    0    0    0    1    0    0
    protection      0    1    0    0    1    0    0    0    0
    published       0    0    1    0    0    0    0    0    0
    purpose         0    0    1    0    0    0    1    0    0
    rational        1    1    0    0    1    0    0    0    0
    regulations     0    0    0    0    0    0    0    1    0
    relation        0    1    0    0    0    0    0    0    0
    resources       1    1    0    0    1    1    1    0    0
    respect         0    1    0    0    0    0    0    0    0
    respectively    1    0    0    0    0    0    0    0    0
    responsibility  0    0    1    0    0    1    0    0    0
    responsible     0    0    0    0    0    0    0    1    0
    right           1    0    0    0    0    0    0    0    0
    safeguard       0    0    0    0    0    0    1    0    0
    set             0    0    1    0    0    0    0    0    0
    sets            0    0    0    0    0    0    0    0    1
    social          0    0    0    0    1    0    0    0    0
    specialized     0    0    1    0    0    0    0    0    0
    state           0    0    1    1    1    1    0    1    0
    strategies      0    0    0    0    0    1    0    0    0
    structures      0    0    1    0    0    0    0    0    0
    sustainable     1    0    0    0    0    1    0    0    0
    sustainably     0    0    0    0    0    0    1    0    0
    tangible        0    0    0    0    1    0    0    0    0
    target          0    0    0    0    1    0    0    0    0
    territorial     0    0    0    0    0    1    0    1    0
    the             5    6    4    1    7    7    5    3    5
    their           0    0    0    0    1    0    0    0    0
    these           0    0    0    0    1    0    0    0    0
    they            0    0    0    0    1    0    0    0    0
    this            0    0    1    1    0    1    1    0    1
    to              3    2    3    0    1    1    3    3    1
    together        0    0    0    0    0    1    0    0    1
    traditional     0    0    0    0    0    0    0    1    0
    underestimated  0    1    0    0    0    0    0    0    0
    universal       0    0    0    0    1    0    0    0    0
    up              0    0    0    0    0    0    0    0    1
    use             2    1    0    0    0    1    0    0    0
    utilitarian     0    1    0    0    0    0    0    0    0
    values          0    1    0    0    0    0    0    0    0
    well            0    0    0    0    1    0    0    0    0
    wellbeing       0    1    0    0    0    0    0    0    0
    which           0    0    0    0    0    1    1    0    0
    whose           0    1    0    0    0    0    0    0    0
    with            0    0    0    0    0    1    0    2    0
    within          0    0    0    0    0    0    0    1    0
    work            0    0    0    0    0    0    0    1    0

    Column 'A_1', column 'A_2', column 'A_3', column 'B_1', column 'B_2', column
    'B_3', column 'C_1', column 'C_2' and column 'C_3' each represents a 173 x 1
    term frequency vector. The similarity of any of the pairs of provisions in
    STATE_A_LEGISLATION_TEXT, STATE_B_LEGISLATION_TEXT and
    STATE_C_LEGISLATION_TEXT can be calculated by taking the cosine of the angle
    between the corresponding term frequency vectors.

    cosine(theta) = (TF1•TF2)/(|TF1||TF2|)

    where TF1•TF2 is the dot product of TF1 and TF2, or sum([i * j for i in TF1,
    j in TF2]), and |TFn| is the Euclidean length of TFn, or sqrt(sum([i ^ 2 for
    i in TFn])).

    Dot products:
        State A 1, State A 1: 70
        State A 1, State A 2: 56
        State A 1, State A 3: 36
        State A 1, State B 1: 7
        State A 1, State B 2: 61
        State A 1, State B 3: 54
        State A 1, State C 1: 51
        State A 1, State C 2: 39
        State A 1, State C 3: 35
        State A 2, State A 2: 87
        State A 2, State A 3: 42
        State A 2, State B 1: 8
        State A 2, State B 2: 75
        State A 2, State B 3: 65
        State A 2, State C 1: 62
        State A 2, State C 2: 41
        State A 2, State C 3: 46
        State A 3, State A 3: 87
        State A 3, State B 1: 9
        State A 3, State B 2: 49
        State A 3, State B 3: 49
        State A 3, State C 1: 42
        State A 3, State C 2: 32
        State A 3, State C 3: 34
        State B 1, State B 1: 13
        State B 1, State B 2: 13
        State B 1, State B 3: 13
        State B 1, State C 1: 8
        State B 1, State C 2: 8
        State B 1, State C 3: 9
        State B 2, State B 2: 130
        State B 2, State B 3: 75
        State B 2, State C 1: 65
        State B 2, State C 2: 47
        State B 2, State C 3: 50
        State B 3, State B 3: 117
        State B 3, State C 1: 58
        State B 3, State C 2: 49
        State B 3, State C 3: 48
        State C 1, State C 1: 81
        State C 1, State C 2: 45
        State C 1, State C 3: 41
        State C 2, State C 2: 76
        State C 2, State C 3: 25
        State C 3, State C 3: 54

    Euclidean lengths:
        State A 1: 8.367
        State A 2: 9.327
        State A 3: 7.810
        State B 1: 3.606
        State B 2: 11.402
        State B 3: 10.817
        State C 1: 9.000
        State C 2: 8.718
        State C 3: 7.348

    Expected similiarity matrix:
            [  A_1    A_2    A_3    B_1    B_2    B_3    C_1    C_2    C_3  ]
    [ A_1 ] [ 1.000  0.718  0.551  0.232  0.639  0.597  0.677  0.535  0.569 ]
    [ A_2 ] [ 0.718  1.000  0.577  0.238  0.705  0.644  0.739  0.504  0.671 ]
    [ A_3 ] [ 0.551  0.577  1.000  0.320  0.550  0.580  0.598  0.470  0.592 ]
    [ B_1 ] [ 0.232  0.238  0.320  1.000  0.316  0.333  0.247  0.255  0.340 ]
    [ B_2 ] [ 0.639  0.705  0.550  0.316  1.000  0.608  0.633  0.473  0.597 ]
    [ B_3 ] [ 0.597  0.644  0.580  0.333  0.608  1.000  0.596  0.520  0.604 ]
    [ C_1 ] [ 0.677  0.739  0.598  0.247  0.633  0.596  1.000  0.574  0.620 ]
    [ C_2 ] [ 0.535  0.504  0.470  0.255  0.473  0.520  0.574  1.000  0.390 ]
    [ C_3 ] [ 0.569  0.671  0.592  0.340  0.597  0.604  0.620  0.390  1.000 ]
    '''

    test_directory_path = utilities.create_test_directory('term_frequency_provisions')

    file_content_by_relative_path = {
        os.path.join('legislation', 'state_a_english.txt'): utilities.STATE_A_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_b_english.txt'): utilities.STATE_B_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_c_english.txt'): utilities.STATE_C_LEGISLATION_TEXT,
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    algorithm = 'term_frequency'
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
        [1.0, 0.718, 0.551, 0.232, 0.639, 0.597, 0.677, 0.535, 0.569],
        [0.718, 1.0, 0.577, 0.238, 0.705, 0.644, 0.739, 0.504, 0.671],
        [0.551, 0.577, 1.0, 0.320, 0.550, 0.580, 0.598, 0.470, 0.592],
        [0.232, 0.238, 0.320, 1.0, 0.316, 0.333, 0.247, 0.255, 0.340],
        [0.639, 0.705, 0.550, 0.316, 1.0, 0.608, 0.633, 0.473, 0.597],
        [0.597, 0.644, 0.580, 0.333, 0.608, 1.0, 0.596, 0.520, 0.604],
        [0.677, 0.739, 0.598, 0.247, 0.633, 0.596, 1.0, 0.574, 0.620],
        [0.535, 0.504, 0.470, 0.255, 0.473, 0.520, 0.574, 1.0, 0.390],
        [0.569, 0.671, 0.592, 0.340, 0.597, 0.604, 0.620, 0.390, 1.0],
    ]

    assert expected_similarity_matrix_labels == actual_similarity_matrix_labels

    utilities.compare_expected_and_actual_similarity_matrices(
        expected_similarity_matrix, actual_similarity_matrix)


def test_term_frequency_provisions_list_of_states_to_include():
    '''
    The values in column 'Term' in the following table represent the complete
    set of words in STATE_A_LEGISLATION_TEXT and STATE_C_LEGISLATION_TEXT. The
    values in columns 'A_1', 'A_2', 'A_3', 'C_1', 'C_2' and 'C_3' represent the
    number of occurrences of the values of column 'Term' in
    STATE_A_LEGISLATION_TEXT provision 1, STATE_A_LEGISLATION_TEXT provision 2,
    STATE_A_LEGISLATION_TEXT provision 3, STATE_C_LEGISLATION_TEXT provision 1,
    STATE_C_LEGISLATION_TEXT provision 2 and STATE_C_LEGISLATION_TEXT provision
    3 respectively.

    Term           A_1  A_2  A_3  C_1  C_2  C_3
    a               1    0    1    0    0    0
    above           0    0    1    0    0    0
    according       0    0    0    1    0    0
    achieve         0    0    1    0    0    0
    action          0    0    0    0    0    1
    administration  0    0    0    0    0    1
    against         0    0    0    1    1    0
    all             1    0    0    0    1    0
    and             2    2    2    3    3    1
    associations    0    0    0    0    1    0
    be              0    1    0    0    0    0
    benefits        1    0    0    0    0    0
    better          0    0    0    0    0    1
    bodies          0    0    1    0    0    1
    brings          0    0    0    0    0    1
    cannot          0    1    0    0    0    0
    citizen         0    0    0    0    1    0
    citizens        1    0    0    0    0    0
    collaboration   0    0    0    0    1    0
    collectivities  0    0    0    0    1    0
    compliance      0    0    0    0    1    0
    concerned       0    0    0    0    0    1
    conditions      0    0    0    1    0    0
    conservation    0    1    0    0    0    0
    coordination    0    0    0    0    0    1
    country's       1    0    0    0    0    0
    creating        0    0    1    0    0    0
    decentralized   0    0    0    0    1    0
    defense         1    0    0    0    0    0
    degradation     0    0    0    1    1    0
    due             0    1    0    0    0    0
    enhance         0    0    0    1    0    1
    entire          0    1    0    0    0    0
    environment     1    1    0    1    0    1
    environmental   0    0    1    0    1    0
    essential       0    0    0    1    0    0
    establish       0    0    0    1    0    0
    every           0    0    0    0    1    0
    feasible        0    0    1    0    0    0
    fight           0    0    0    0    1    0
    for             0    1    1    0    0    2
    forms           0    0    0    1    0    0
    framework       0    0    0    0    1    0
    have            1    0    0    0    0    0
    having          0    0    1    0    0    0
    healthy         1    0    0    0    0    0
    hence           1    0    0    0    0    0
    implement       0    0    1    0    0    0
    implementation  0    0    0    0    0    1
    improve         0    0    0    1    0    0
    in              2    1    0    1    2    0
    individually    0    0    0    0    1    0
    institutions    0    0    0    0    1    0
    interests       0    1    0    0    0    0
    is              0    1    1    2    1    0
    it              0    1    2    0    0    1
    its             1    0    0    0    0    0
    kinds           0    0    0    0    1    0
    law             0    0    0    1    0    1
    laws            0    0    0    0    1    0
    legislation     0    0    1    0    0    0
    live            1    0    0    0    0    0
    living          0    0    0    1    0    0
    local           0    0    0    0    1    0
    make            0    0    1    0    0    0
    managed         0    0    0    1    0    0
    management      0    0    1    0    0    0
    merely          0    1    0    0    0    0
    national        0    0    1    0    0    0
    natural         1    1    0    1    0    0
    necessary       0    0    1    0    0    1
    objectives      0    0    1    0    0    0
    obligations     1    0    0    0    0    0
    of              2    4    1    3    2    2
    or              0    0    0    0    3    0
    order           0    0    0    1    0    0
    organizations   0    0    0    0    0    1
    out             0    0    1    0    0    0
    participate     1    0    0    0    0    0
    pollution       0    0    0    0    1    0
    population      0    1    0    1    0    0
    preservation    0    1    0    0    0    0
    prevent         0    0    0    0    1    0
    principles      0    1    0    1    0    0
    program         0    0    1    0    0    0
    protect         0    0    0    0    0    1
    protected       0    0    0    1    0    0
    protection      0    1    0    0    0    0
    published       0    0    1    0    0    0
    purpose         0    0    1    1    0    0
    rational        1    1    0    0    0    0
    regulations     0    0    0    0    1    0
    relation        0    1    0    0    0    0
    resources       1    1    0    1    0    0
    respect         0    1    0    0    0    0
    respectively    1    0    0    0    0    0
    responsibility  0    0    1    0    0    0
    responsible     0    0    0    0    1    0
    right           1    0    0    0    0    0
    safeguard       0    0    0    1    0    0
    set             0    0    1    0    0    0
    sets            0    0    0    0    0    1
    specialized     0    0    1    0    0    0
    state           0    0    1    0    1    0
    structures      0    0    1    0    0    0
    sustainable     1    0    0    0    0    0
    sustainably     0    0    0    1    0    0
    territorial     0    0    0    0    1    0
    the             5    6    4    5    3    5
    this            0    0    1    1    0    1
    to              3    2    3    3    3    1
    together        0    0    0    0    0    1
    traditional     0    0    0    0    1    0
    underestimated  0    1    0    0    0    0
    up              0    0    0    0    0    1
    use             2    1    0    0    0    0
    utilitarian     0    1    0    0    0    0
    values          0    1    0    0    0    0
    wellbeing       0    1    0    0    0    0
    which           0    0    0    1    0    0
    whose           0    1    0    0    0    0
    with            0    0    0    0    2    0
    within          0    0    0    0    1    0
    work            0    0    0    0    1    0

    Column 'A_1', column 'A_2', column 'A_3', column 'C_1', column 'C_2' and
    column 'C_3' each represents a 124 x 1 term frequency vector. The similarity
    of any of the pairs of provisions in STATE_A_LEGISLATION_TEXT and
    STATE_C_LEGISLATION_TEXT can be calculated by taking the cosine of the angle
    between the corresponding term frequency vectors.

    cosine(theta) = (TF1•TF2)/(|TF1||TF2|)

    where TF1•TF2 is the dot product of TF1 and TF2, or sum([i * j for i in TF1,
    j in TF2]), and |TFn| is the Euclidean length of TFn, or sqrt(sum([i ^ 2 for
    i in TFn])).

    Dot products:
        State A 1, State A 1: 70
        State A 1, State A 2: 56
        State A 1, State A 3: 36
        State A 1, State C 1: 51
        State A 1, State C 2: 39
        State A 1, State C 3: 35
        State A 2, State A 2: 87
        State A 2, State A 3: 42
        State A 2, State C 1: 62
        State A 2, State C 2: 41
        State A 2, State C 3: 46
        State A 3, State A 3: 87
        State A 3, State C 1: 42
        State A 3, State C 2: 32
        State A 3, State C 3: 34
        State C 1, State C 1: 81
        State C 1, State C 2: 45
        State C 1, State C 3: 41
        State C 2, State C 2: 76
        State C 2, State C 3: 25
        State C 3, State C 3: 54

    Euclidean lengths:
        State A 1: 8.367
        State A 2: 9.327
        State A 3: 7.810
        State C 1: 9.000
        State C 2: 8.718
        State C 3: 7.348

    Expected similiarity matrix:
            [  A_1    A_2    A_3    C_1    C_2    C_3  ]
    [ A_1 ] [ 1.000  0.718  0.551  0.677  0.535  0.569 ]
    [ A_2 ] [ 0.718  1.000  0.577  0.739  0.504  0.671 ]
    [ A_3 ] [ 0.551  0.577  1.000  0.598  0.470  0.592 ]
    [ C_1 ] [ 0.677  0.739  0.598  1.000  0.574  0.620 ]
    [ C_2 ] [ 0.535  0.504  0.470  0.574  1.000  0.390 ]
    [ C_3 ] [ 0.569  0.671  0.592  0.620  0.390  1.000 ]
    '''

    test_directory_path = utilities.create_test_directory('term_frequency_provisions')

    file_content_by_relative_path = {
        os.path.join('legislation', 'state_a_english.txt'): utilities.STATE_A_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_b_english.txt'): utilities.STATE_B_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_c_english.txt'): utilities.STATE_C_LEGISLATION_TEXT,
    }

    states_to_include_file_path = os.path.join(test_directory_path, 'states_to_include.txt')
    with open(states_to_include_file_path, 'w') as file_object:
        file_object.write('state_a\n')
        # Omit State B
        file_object.write('state_c\n')

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    algorithm = 'term_frequency'
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
        'State A 2',
        'State A 3',
        'State C 1',
        'State C 2',
        'State C 3',
    ]
    expected_similarity_matrix = [
        [1.0, 0.718, 0.551, 0.677, 0.535, 0.569],
        [0.718, 1.0, 0.577, 0.739, 0.504, 0.671],
        [0.551, 0.577, 1.0, 0.598, 0.470, 0.592],
        [0.677, 0.739, 0.598, 1.0, 0.574, 0.620],
        [0.535, 0.504, 0.470, 0.574, 1.0, 0.390],
        [0.569, 0.671, 0.592, 0.620, 0.390, 1.0],
    ]

    assert expected_similarity_matrix_labels == actual_similarity_matrix_labels

    utilities.compare_expected_and_actual_similarity_matrices(
        expected_similarity_matrix, actual_similarity_matrix)


def test_term_frequency_output_directory_does_not_exist():
    test_directory_path = utilities.create_test_directory('term_frequency_provisions')

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
                'term_frequency',
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


def test_term_frequency_matrix_only():
    test_directory_path = utilities.create_test_directory('term_frequency_full_text')

    file_content_by_relative_path = {
        os.path.join('legislation', 'state_a_english.txt'): utilities.STATE_A_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_b_english.txt'): utilities.STATE_B_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_c_english.txt'): utilities.STATE_C_LEGISLATION_TEXT,
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    algorithm = 'term_frequency'
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
