import logging
import os
import subprocess

import eia.environment as environment
import eia.tests.utilities as utilities


LOGGER = logging.getLogger(__name__)


STATE_A_LEGISLATION_TEXT = (
    "TITLE I - GENERAL PRINCIPLES"
    "\n\n"
    "(1) All citizens have the right to live in a healthy environment and to "
    "the benefits of the rational use of the country's natural resources, "
    "hence the obligations to participate in its defense and sustainable use, "
    "respectively."
    "\n\n"
    "(2) It is due to respect for the principles of the well-being of the "
    "entire population, the protection, preservation and conservation of the "
    "environment and the rational use of natural resources, whose values "
    "cannot be underestimated in relation to merely utilitarian interests."
    "\n\n"
    "(3) It is the responsibility of the State to implement a National "
    "Environmental Management Program to achieve the objectives set out above, "
    "creating the necessary structures and specialized bodies for this purpose "
    "and having legislation published to make it feasible."
)


STATE_B_LEGISLATION_TEXT = (
    "TITLE I - GENERAL PROVISIONS"
    "\n\n"
    "(1) This law establishes the general legal framework for environmental "
    "management in State B."
    "\n\n"
    "(2) The environment constitutes a common heritage of the nation in State "
    "B. It is an integral part of the universal heritage. Its protection and "
    "the rational management of the resources it offers to human life are of "
    "general interest. These target in particular the geosphere, hydrosphere, "
    "atmosphere, their tangible and intangible content, as well as the social "
    "and cultural aspects they include."
    "\n\n"
    "(3) The President of State B defines the national environmental policy. "
    "Its implementation is the responsibility of the Government, which applies "
    "it, together with the decentralized territorial communities, grassroots "
    "communities and environmental defense associations. To this end, the "
    "Government develops national strategies, plans or programs aimed at "
    "ensuring the conservation and sustainable use of environmental resources."
)


STATE_C_LEGISLATION_TEXT = (
    "TITLE I - FUNDAMENTAL PRINCIPLES"
    "\n\n"
    "(1) The purpose of this law is to establish the essential principles "
    "according to which the environment is sustainably managed and protected "
    "against forms of degradation, in order to safeguard and enhance natural "
    "resources and improve the living conditions of the population."
    "\n\n"
    "(2) Every citizen, individually or within the framework of traditional "
    "local institutions or associations, is responsible, in collaboration with "
    "the decentralized territorial collectivities and the State, to work, to "
    "prevent and to fight against all kinds of pollution or environmental "
    "degradation in compliance with laws and regulations."
    "\n\n"
    "(3) The administration sets up the bodies necessary for the "
    "implementation of this law. It brings together the organizations "
    "concerned for better coordination of action to protect and enhance the "
    "environment."
)


EPSILON = 0.0005


def populate_actual_similarity_matrix_and_labels(
        output_file_path, actual_similarity_matrix_labels,
        actual_similarity_matrix):
    with open(output_file_path, 'r') as file_object:
        for line in file_object:
            line_components = line.rstrip('\n').split(',')
            actual_similarity_matrix_labels.append(line_components[0])
            actual_similarity_matrix.append(
                list(map(lambda line_component: float(line_component), line_components[1:])))


def compare_expected_and_actual_similarity_matrices(
        expected_similarity_matrix, actual_similarity_matrix):
    assert len(expected_similarity_matrix) == len(actual_similarity_matrix)
    for row_index in range(len(expected_similarity_matrix)):
        expected_row = expected_similarity_matrix[row_index]
        actual_row = actual_similarity_matrix[row_index]
        assert len(expected_row) == len(actual_row)
        for column_index in range(len(expected_row)):
            LOGGER.info(
                "Comparing matrix elements at row index {} and column index "
                "{}. Expected element value: {}, actual element value: "
                "{}.".format(
                    row_index, column_index, expected_row[column_index],
                    actual_row[column_index]))
            assert round(abs(expected_row[column_index] - actual_row[column_index]), 4) <= EPSILON


def test_jaccard_similarity_full_text():
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

    test_directory_path = utilities.create_test_directory('jaccard_similarity_full_text')

    file_content_by_relative_path = {
        os.path.join('legislation', 'state_a_english.txt'): STATE_A_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_b_english.txt'): STATE_B_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_c_english.txt'): STATE_C_LEGISLATION_TEXT,
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity',
        'calculate_similarity.py')
    output_file_path = os.path.join(test_directory_path, 'similarity.txt')

    actual_similarity_matrix_labels = []
    actual_similarity_matrix = []

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        subprocess.run(
            [
                script_file_path,
                'jaccard_index',
                'full_text',
                'english',
                '--legislation_directory_path',
                test_directory_path,
                '--output_file_path',
                output_file_path,
                '--debug',
            ],
            check=True)
        populate_actual_similarity_matrix_and_labels(
            output_file_path, actual_similarity_matrix_labels,
            actual_similarity_matrix)
    finally:
        utilities.delete_test_directory(test_directory_path)

    expected_similarity_matrix_labels = ['State A', 'State B', 'State C']
    expected_similarity_matrix = [
        [1.0, 0.221, 0.191],
        [0.221, 1.0, 0.2],
        [0.191, 0.2, 1.0],
    ]

    assert expected_similarity_matrix_labels == actual_similarity_matrix_labels

    compare_expected_and_actual_similarity_matrices(
        expected_similarity_matrix, actual_similarity_matrix)


def test_jaccard_similarity_provisions():
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

    test_directory_path = utilities.create_test_directory('jaccard_similarity_full_text')

    file_content_by_relative_path = {
        os.path.join('legislation', 'state_a_english.txt'): STATE_A_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_b_english.txt'): STATE_B_LEGISLATION_TEXT,
        os.path.join('legislation', 'state_c_english.txt'): STATE_C_LEGISLATION_TEXT,
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity',
        'calculate_similarity.py')
    output_file_path = os.path.join(test_directory_path, 'similarity.txt')

    actual_similarity_matrix_labels = []
    actual_similarity_matrix = []

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        subprocess.run(
            [
                script_file_path,
                'jaccard_index',
                'provision',
                'english',
                '--legislation_directory_path',
                test_directory_path,
                '--output_file_path',
                output_file_path,
                '--debug',
            ],
            check=True)
        populate_actual_similarity_matrix_and_labels(
            output_file_path, actual_similarity_matrix_labels,
            actual_similarity_matrix)
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

    compare_expected_and_actual_similarity_matrices(
        expected_similarity_matrix, actual_similarity_matrix)
