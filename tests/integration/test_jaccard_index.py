import os
import subprocess

import eia.environment as environment
import eia.tests.utilities as utilities


def test_jaccard_index_full_text_preserve_provision_delimiters():
    '''
    State A legislation word set:
        ((1), (2), (3), a, above, achieve, all, and, be, benefits, bodies,
        cannot, citizens, conservation, country's, creating, defense, due,
        entire, environment, environmental, feasible, for, general, have,
        having, healthy, hence, i, implement, in, interests, is, it, its,
        legislation, live, make, management, merely, national, natural,
        necessary, objectives, obligations, of, out, participate, population,
        preservation, principles, program, protection, published, purpose,
        rational, relation, resources, respect, respectively, responsibility,
        right, set, specialized, state, structures, sustainable, the, this,
        title, to, underestimated, use, utilitarian, values, wellbeing, whose)
    State A legislation word set size: 77

    State B legislation word set:
        ((1), (2), (3), a, aimed, an, and, applies, are, as, aspects,
        associations, at, atmosphere, b, common, communities, conservation,
        constitutes, content, cultural, decentralized, defense, defines,
        develops, end, ensuring, environment, environmental, establishes, for,
        framework, general, geosphere, government, grassroots, heritage, human,
        hydrosphere, i, implementation, in, include, intangible, integral,
        interest, is, it, its, law, legal, life, management, nation, national,
        of, offers, or, part, particular, plans, policy, president, programs,
        protection, provisions, rational, resources, responsibility, social,
        state, strategies, sustainable, tangible, target, territorial, the,
        their, these, they, this, title, to, together, universal, use, well,
        which, with)
    State B legislation word set size: 89

    State C legislation word set:
        ((1), (2), (3), according, action, administration, against, all, and,
        associations, better, bodies, brings, citizen, collaboration,
        collectivities, compliance, concerned, conditions, coordination,
        decentralized, degradation, enhance, environment, environmental,
        essential, establish, every, fight, for, forms, framework, fundamental,
        i, implementation, improve, in, individually, institutions, is, it,
        kinds, law, laws, living, local, managed, natural, necessary, of, or,
        order, organizations, pollution, population, prevent, principles,
        protect, protected, purpose, regulations, resources, responsible,
        safeguard, sets, state, sustainably, territorial, the, this, title, to,
        together, traditional, up, which, with, within, work)
    State C legislation word set size: 79

    Intersection word set sizes:
        State A and State B: 30
        State A and State C: 25
        State B and State C: 28

    Union word set sizes:
        State A and State B: 136
        State A and State C: 131
        State B and State C: 140

    Jaccard index = size of intersection / size of union

    Expected similarity matrix:
                    [ State A State B State C ]
        [ State A ] [  1.000   0.221   0.191  ]
        [ State B ] [  0.221   1.000   0.200  ]
        [ State C ] [  0.191   0.200   1.000  ]
    '''

    test_directory_path = utilities.create_test_directory('jaccard_index_full_text')

    file_content_by_relative_path = {
        os.path.join('legislation', 'state_a_english.txt'): utilities.STATE_A_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_b_english.txt'): utilities.STATE_B_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_c_english.txt'): utilities.STATE_C_LEGISLATION_TEXT,
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    algorithm = 'jaccard_index'
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
        [1.0, 0.221, 0.191],
        [0.221, 1.0, 0.2],
        [0.191, 0.2, 1.0],
    ]

    assert expected_similarity_matrix_labels == actual_similarity_matrix_labels

    utilities.compare_expected_and_actual_similarity_matrices(
        expected_similarity_matrix, actual_similarity_matrix)


def test_jaccard_index_full_text_do_not_preserve_provision_delimiters():
    '''
    State A legislation word set:
        (a, above, achieve, all, and, be, benefits, bodies, cannot, citizens,
        conservation, country's, creating, defense, due, entire, environment,
        environmental, feasible, for, general, have, having, healthy, hence, i,
        implement, in, interests, is, it, its, legislation, live, make,
        management, merely, national, natural, necessary, objectives,
        obligations, of, out, participate, population, preservation, principles,
        program, protection, published, purpose, rational, relation, resources,
        respect, respectively, responsibility, right, set, specialized, state,
        structures, sustainable, the, this, title, to, underestimated, use,
        utilitarian, values, wellbeing, whose)
    State A legislation word set size: 74

    State B legislation word set:
        (a, aimed, an, and, applies, are, as, aspects, associations, at,
        atmosphere, b, common, communities, conservation, constitutes, content,
        cultural, decentralized, defense, defines, develops, end, ensuring,
        environment, environmental, establishes, for, framework, general,
        geosphere, government, grassroots, heritage, human, hydrosphere, i,
        implementation, in, include, intangible, integral, interest, is, it,
        its, law, legal, life, management, nation, national, of, offers, or,
        part, particular, plans, policy, president, programs, protection,
        provisions, rational, resources, responsibility, social, state,
        strategies, sustainable, tangible, target, territorial, the, their,
        these, they, this, title, to, together, universal, use, well, which,
        with)
    State B legislation word set size: 86

    State C legislation word set:
        (according, action, administration, against, all, and, associations,
        better, bodies, brings, citizen, collaboration, collectivities,
        compliance, concerned, conditions, coordination, decentralized,
        degradation, enhance, environment, environmental, essential, establish,
        every, fight, for, forms, framework, fundamental, i, implementation,
        improve, in, individually, institutions, is, it, kinds, law, laws,
        living, local, managed, natural, necessary, of, or, order,
        organizations, pollution, population, prevent, principles, protect,
        protected, purpose, regulations, resources, responsible, safeguard,
        sets, state, sustainably, territorial, the, this, title, to, together,
        traditional, up, which, with, within, work)
    State C legislation word set size: 76

    Intersection word set sizes:
        State A and State B: 27
        State A and State C: 22
        State B and State C: 25

    Union word set sizes:
        State A and State B: 133
        State A and State C: 128
        State B and State C: 137

    Jaccard index = size of intersection / size of union

    Expected similarity matrix:
                    [ State A State B State C ]
        [ State A ] [  1.000   0.203   0.172  ]
        [ State B ] [  0.203   1.000   0.182  ]
        [ State C ] [  0.172   0.182   1.000  ]
    '''

    test_directory_path = utilities.create_test_directory('jaccard_index_full_text')

    file_content_by_relative_path = {
        os.path.join('legislation', 'state_a_english.txt'): utilities.STATE_A_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_b_english.txt'): utilities.STATE_B_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_c_english.txt'): utilities.STATE_C_LEGISLATION_TEXT,
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    algorithm = 'jaccard_index'
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
        [1.0, 0.203, 0.172],
        [0.203, 1.0, 0.182],
        [0.172, 0.182, 1.0],
    ]

    assert expected_similarity_matrix_labels == actual_similarity_matrix_labels

    utilities.compare_expected_and_actual_similarity_matrices(
        expected_similarity_matrix, actual_similarity_matrix)


def test_jaccard_index_full_text_list_of_states_to_include():
    '''
    State A legislation word set:
        ((1), (2), (3), a, above, achieve, all, and, be, benefits, bodies,
        cannot, citizens, conservation, country's, creating, defense, due,
        entire, environment, environmental, feasible, for, general, have,
        having, healthy, hence, i, implement, in, interests, is, it, its,
        legislation, live, make, management, merely, national, natural,
        necessary, objectives, obligations, of, out, participate, population,
        preservation, principles, program, protection, published, purpose,
        rational, relation, resources, respect, respectively, responsibility,
        right, set, specialized, state, structures, sustainable, the, this,
        title, to, underestimated, use, utilitarian, values, wellbeing, whose)
    State A legislation word set size: 77

    State C legislation word set:
        ((1), (2), (3), according, action, administration, against, all, and,
        associations, better, bodies, brings, citizen, collaboration,
        collectivities, compliance, concerned, conditions, coordination,
        decentralized, degradation, enhance, environment, environmental,
        essential, establish, every, fight, for, forms, framework, fundamental,
        i, implementation, improve, in, individually, institutions, is, it,
        kinds, law, laws, living, local, managed, natural, necessary, of, or,
        order, organizations, pollution, population, prevent, principles,
        protect, protected, purpose, regulations, resources, responsible,
        safeguard, sets, state, sustainably, territorial, the, this, title, to,
        together, traditional, up, which, with, within, work)
    State C legislation word set size: 79

    Intersection word set sizes:
        State A and State C: 25

    Union word set sizes:
        State A and State C: 131

    Jaccard index = size of intersection / size of union

    Expected similarity matrix:
                    [ State A State C ]
        [ State A ] [  1.000   0.191  ]
        [ State C ] [  0.191   1.000  ]
    '''

    test_directory_path = utilities.create_test_directory('jaccard_index_full_text')

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
    algorithm = 'jaccard_index'
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
        [1.0, 0.191],
        [0.191, 1.0],
    ]

    assert expected_similarity_matrix_labels == actual_similarity_matrix_labels

    utilities.compare_expected_and_actual_similarity_matrices(
        expected_similarity_matrix, actual_similarity_matrix)


def test_jaccard_index_provisions():
    '''
    State A legislation provision 1 word set:
        (a, all, and, benefits, citizens, country's, defense, environment, have,
        healthy, hence, in, its, live, natural, obligations, of, participate,
        rational, resources, respectively, right, sustainable, the, to, use)
    State A legislation provision 1 word set size: 26

    State A legislation provision 2 word set:
        (and, be, cannot, conservation, due, entire, environment, for, in,
        interests, is, it, merely, natural, of, population, preservation,
        principles, protection, rational, relation, resources, respect, the, to,
        underestimated, use, utilitarian, values, wellbeing, whose)
    State A legislation provision 2 word set size: 31

    State A legislation provision 3 word set:
        (a, above, achieve, and, bodies, creating, environmental, feasible, for,
        having, implement, is, it, legislation, make, management, national,
        necessary, objectives, of, out, program, published, purpose,
        responsibility, set, specialized, state, structures, the, this, to)
    State A legislation provision 3 word set size: 32

    State B legislation provision 1 word set:
        (b, environmental, establishes, for, framework, general, in, law, legal,
        management, state, the, this)
    State B legislation provision 1 word set size: 13

    State B legislation provision 2 word set:
        (a, an, and, are, as, aspects, atmosphere, b, common, constitutes,
        content, cultural, environment, general, geosphere, heritage, human,
        hydrosphere, in, include, intangible, integral, interest, is, it, its,
        life, management, nation, of, offers, part, particular, protection,
        rational, resources, social, state, tangible, target, the, their, these,
        they, to, universal, well)
    State B legislation provision 2 word set size: 47

    State B legislation provision 3 word set:
        (aimed, and, applies, associations, at, b, communities, conservation,
        decentralized, defense, defines, develops, end, ensuring, environmental,
        government, grassroots, implementation, is, it, its, national, of, or,
        plans, policy, president, programs, resources, responsibility, state,
        strategies, sustainable, territorial, the, this, to, together, use,
        which, with)
    State B legislation provision 3 word set size: 41

    State C legislation provision 1 word set:
        (according, against, and, conditions, degradation, enhance, environment,
        essential, establish, forms, improve, in, is, law, living, managed,
        natural, of, order, population, principles, protected, purpose,
        resources, safeguard, sustainably, the, this, to, which)
    State C legislation provision 1 word set size: 30

    State C legislation provision 2 word set:
        (against, all, and, associations, citizen, collaboration,
        collectivities, compliance, decentralized, degradation, environmental,
        every, fight, framework, in, individually, institutions, is, kinds,
        laws, local, of, or, pollution, prevent, regulations, responsible,
        state, territorial, the, to, traditional, with, within, work)
    State C legislation provision 2 word set size: 35

    State C legislation provision 3 word set:
        (action, administration, and, better, bodies, brings, concerned,
        coordination, enhance, environment, for, implementation, it, law,
        necessary, of, organizations, protect, sets, the, this, to, together,
        up)
    State C legislation provision 3 word set size: 24

    Intersection word set sizes:
        State A provision 1 and State A provision 2: 10
        State A provision 1 and State A provision 3: 5
        State A provision 1 and State B provision 1: 2
        State A provision 1 and State B provision 2: 10
        State A provision 1 and State B provision 3: 9
        State A provision 1 and State C provision 1: 8
        State A provision 1 and State C provision 2: 6
        State A provision 1 and State C provision 3: 5
        State A provision 2 and State A provision 3: 7
        State A provision 2 and State B provision 1: 3
        State A provision 2 and State B provision 2: 11
        State A provision 2 and State B provision 3: 9
        State A provision 2 and State C provision 1: 11
        State A provision 2 and State C provision 2: 6
        State A provision 2 and State C provision 3: 7
        State A provision 3 and State B provision 1: 6
        State A provision 3 and State B provision 2: 9
        State A provision 3 and State B provision 3: 11
        State A provision 3 and State C provision 1: 7
        State A provision 3 and State C provision 2: 7
        State A provision 3 and State C provision 3: 9
        State B provision 1 and State B provision 2: 6
        State B provision 1 and State B provision 3: 5
        State B provision 1 and State C provision 1: 4
        State B provision 1 and State C provision 2: 5
        State B provision 1 and State C provision 3: 4
        State B provision 2 and State B provision 3: 10
        State B provision 2 and State C provision 1: 8
        State B provision 2 and State C provision 2: 7
        State B provision 2 and State C provision 3: 6
        State B provision 3 and State C provision 1: 8
        State B provision 3 and State C provision 2: 12
        State B provision 3 and State C provision 3: 8
        State C provision 1 and State C provision 2: 8
        State C provision 1 and State C provision 3: 8
        State C provision 2 and State C provision 3: 4

    Union word set sizes:
        State A provision 1 and State A provision 2: 47
        State A provision 1 and State A provision 3: 53
        State A provision 1 and State B provision 1: 37
        State A provision 1 and State B provision 2: 63
        State A provision 1 and State B provision 3: 58
        State A provision 1 and State C provision 1: 48
        State A provision 1 and State C provision 2: 55
        State A provision 1 and State C provision 3: 45
        State A provision 2 and State A provision 3: 56
        State A provision 2 and State B provision 1: 41
        State A provision 2 and State B provision 2: 67
        State A provision 2 and State B provision 3: 63
        State A provision 2 and State C provision 1: 50
        State A provision 2 and State C provision 2: 60
        State A provision 2 and State C provision 3: 48
        State A provision 3 and State B provision 1: 39
        State A provision 3 and State B provision 2: 70
        State A provision 3 and State B provision 3: 62
        State A provision 3 and State C provision 1: 55
        State A provision 3 and State C provision 2: 60
        State A provision 3 and State C provision 3: 47
        State B provision 1 and State B provision 2: 54
        State B provision 1 and State B provision 3: 49
        State B provision 1 and State C provision 1: 39
        State B provision 1 and State C provision 2: 43
        State B provision 1 and State C provision 3: 33
        State B provision 2 and State B provision 3: 78
        State B provision 2 and State C provision 1: 69
        State B provision 2 and State C provision 2: 75
        State B provision 2 and State C provision 3: 65
        State B provision 3 and State C provision 1: 63
        State B provision 3 and State C provision 2: 64
        State B provision 3 and State C provision 3: 57
        State C provision 1 and State C provision 2: 57
        State C provision 1 and State C provision 3: 46
        State C provision 2 and State C provision 3: 55

    Jaccard index = size of intersection / size of union

    Expected similarity matrix:
                [  A_1   A_2   A_3   B_1   B_2   B_3   C_1   C_2   C_3  ]
        [ A_1 ] [ 1.000 0.213 0.094 0.054 0.159 0.155 0.167 0.109 0.111 ]
        [ A_2 ] [ 0.213 1.000 0.125 0.073 0.164 0.143 0.220 0.100 0.146 ]
        [ A_3 ] [ 0.094 0.125 1.000 0.154 0.123 0.177 0.140 0.117 0.188 ]
        [ B_1 ] [ 0.054 0.073 0.154 1.000 0.111 0.102 0.103 0.116 0.121 ]
        [ B_2 ] [ 0.159 0.164 0.123 0.111 1.000 0.128 0.116 0.093 0.092 ]
        [ B_3 ] [ 0.155 0.143 0.177 0.102 0.128 1.000 0.127 0.188 0.140 ]
        [ C_1 ] [ 0.167 0.220 0.140 0.103 0.116 0.127 1.000 0.140 0.174 ]
        [ C_2 ] [ 0.109 0.100 0.117 0.116 0.093 0.188 0.140 1.000 0.073 ]
        [ C_3 ] [ 0.111 0.146 0.188 0.121 0.092 0.140 0.174 0.073 1.000 ]
    '''

    test_directory_path = utilities.create_test_directory('jaccard_index_provisions')

    file_content_by_relative_path = {
        os.path.join('legislation', 'state_a_english.txt'): utilities.STATE_A_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_b_english.txt'): utilities.STATE_B_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_c_english.txt'): utilities.STATE_C_LEGISLATION_TEXT,
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    algorithm = 'jaccard_index'
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
        [1.0, 0.213, 0.094, 0.054, 0.159, 0.155, 0.167, 0.109, 0.111],
        [0.213, 1.0, 0.125, 0.073, 0.164, 0.143, 0.220, 0.1, 0.146],
        [0.094, 0.125, 1.0, 0.154, 0.129, 0.177, 0.127, 0.117, 0.191],
        [0.054, 0.073, 0.154, 1.0, 0.111, 0.102, 0.103, 0.116, 0.121],
        [0.159, 0.164, 0.129, 0.111, 1.0, 0.128, 0.116, 0.093, 0.092],
        [0.155, 0.143, 0.177, 0.102, 0.128, 1.0, 0.127, 0.188, 0.140],
        [0.167, 0.220, 0.127, 0.103, 0.116, 0.127, 1.0, 0.140, 0.174],
        [0.109, 0.1, 0.117, 0.116, 0.093, 0.188, 0.140, 1.0, 0.073],
        [0.111, 0.146, 0.191, 0.121, 0.092, 0.140, 0.174, 0.073, 1.0],
    ]

    assert expected_similarity_matrix_labels == actual_similarity_matrix_labels

    utilities.compare_expected_and_actual_similarity_matrices(
        expected_similarity_matrix, actual_similarity_matrix)


def test_jaccard_index_provisions_list_of_states_to_include():
    '''
    State A legislation provision 1 word set:
        (a, all, and, benefits, citizens, country's, defense, environment, have,
        healthy, hence, in, its, live, natural, obligations, of, participate,
        rational, resources, respectively, right, sustainable, the, to, use)
    State A legislation provision 1 word set size: 26

    State A legislation provision 2 word set:
        (and, be, cannot, conservation, due, entire, environment, for, in,
        interests, is, it, merely, natural, of, population, preservation,
        principles, protection, rational, relation, resources, respect, the, to,
        underestimated, use, utilitarian, values, wellbeing, whose)
    State A legislation provision 2 word set size: 31

    State A legislation provision 3 word set:
        (a, above, achieve, and, bodies, creating, environmental, feasible, for,
        having, implement, is, it, legislation, make, management, national,
        necessary, objectives, of, out, program, published, purpose,
        responsibility, set, specialized, state, structures, the, this, to)
    State A legislation provision 3 word set size: 32

    State C legislation provision 1 word set:
        (according, against, and, conditions, degradation, enhance, environment,
        essential, establish, forms, improve, in, is, law, living, managed,
        natural, of, order, population, principles, protected, purpose,
        resources, safeguard, sustainably, the, this, to, which)
    State C legislation provision 1 word set size: 30

    State C legislation provision 2 word set:
        (against, all, and, associations, citizen, collaboration,
        collectivities, compliance, decentralized, degradation, environmental,
        every, fight, framework, in, individually, institutions, is, kinds,
        laws, local, of, or, pollution, prevent, regulations, responsible,
        state, territorial, the, to, traditional, with, within, work)
    State C legislation provision 2 word set size: 35

    State C legislation provision 3 word set:
        (action, administration, and, better, bodies, brings, concerned,
        coordination, enhance, environment, for, implementation, it, law,
        necessary, of, organizations, protect, sets, the, this, to, together,
        up)
    State C legislation provision 3 word set size: 24

    Intersection word set sizes:
        State A provision 1 and State A provision 2: 10
        State A provision 1 and State A provision 3: 5
        State A provision 1 and State C provision 1: 8
        State A provision 1 and State C provision 2: 6
        State A provision 1 and State C provision 3: 5
        State A provision 2 and State A provision 3: 7
        State A provision 2 and State C provision 1: 11
        State A provision 2 and State C provision 2: 6
        State A provision 2 and State C provision 3: 7
        State A provision 3 and State C provision 1: 7
        State A provision 3 and State C provision 2: 7
        State A provision 3 and State C provision 3: 9
        State C provision 1 and State C provision 2: 8
        State C provision 1 and State C provision 3: 8
        State C provision 2 and State C provision 3: 4

    Union word set sizes:
        State A provision 1 and State A provision 2: 47
        State A provision 1 and State A provision 3: 53
        State A provision 1 and State C provision 1: 48
        State A provision 1 and State C provision 2: 55
        State A provision 1 and State C provision 3: 45
        State A provision 2 and State A provision 3: 56
        State A provision 2 and State C provision 1: 50
        State A provision 2 and State C provision 2: 60
        State A provision 2 and State C provision 3: 48
        State A provision 3 and State C provision 1: 55
        State A provision 3 and State C provision 2: 60
        State A provision 3 and State C provision 3: 47
        State C provision 1 and State C provision 2: 57
        State C provision 1 and State C provision 3: 46
        State C provision 2 and State C provision 3: 55

    Jaccard index = size of intersection / size of union

    Expected similarity matrix:
                [  A_1   A_2   A_3   C_1   C_2   C_3  ]
        [ A_1 ] [ 1.000 0.213 0.094 0.167 0.109 0.111 ]
        [ A_2 ] [ 0.213 1.000 0.125 0.220 0.100 0.146 ]
        [ A_3 ] [ 0.094 0.125 1.000 0.140 0.117 0.188 ]
        [ C_1 ] [ 0.167 0.220 0.140 1.000 0.140 0.174 ]
        [ C_2 ] [ 0.109 0.100 0.117 0.140 1.000 0.073 ]
        [ C_3 ] [ 0.111 0.146 0.188 0.174 0.073 1.000 ]
    '''

    test_directory_path = utilities.create_test_directory('jaccard_index_provisions')

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
    algorithm = 'jaccard_index'
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
        [1.0, 0.213, 0.094, 0.167, 0.109, 0.111],
        [0.213, 1.0, 0.125, 0.220, 0.1, 0.146],
        [0.094, 0.125, 1.0, 0.127, 0.117, 0.191],
        [0.167, 0.220, 0.127, 1.0, 0.140, 0.174],
        [0.109, 0.1, 0.117, 0.140, 1.0, 0.073],
        [0.111, 0.146, 0.191, 0.174, 0.073, 1.0],
    ]

    assert expected_similarity_matrix_labels == actual_similarity_matrix_labels

    utilities.compare_expected_and_actual_similarity_matrices(
        expected_similarity_matrix, actual_similarity_matrix)


def test_jaccard_index_output_directory_does_not_exist():
    test_directory_path = utilities.create_test_directory('jaccard_index_provisions')

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
                'jaccard_index',
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


def test_jaccard_index_matrix_only():
    test_directory_path = utilities.create_test_directory('jaccard_index_full_text')

    file_content_by_relative_path = {
        os.path.join('legislation', 'state_a_english.txt'): utilities.STATE_A_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_b_english.txt'): utilities.STATE_B_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_c_english.txt'): utilities.STATE_C_LEGISLATION_TEXT,
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    algorithm = 'jaccard_index'
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
