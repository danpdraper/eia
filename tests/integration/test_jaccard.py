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

    State A and State B intersection word set:
        ((1), (2), (3), a, and, conservation, defense, environment,
        environmental, for, general, i, in, is, it, its, management, national,
        of, protection, rational, resources, responsibility, state, sustainable,
        the, this, title, to, use)
    State A and State B intersection word set size: 30

    State A and State B union word set:
        ((1), (2), (3), a, above, achieve, aimed, all, an, and, applies, are,
        as, aspects, associations, at, atmosphere, b, be, benefits, bodies,
        cannot, citizens, common, communities, conservation, constitutes,
        content, country's, creating, cultural, decentralized, defense, defines,
        develops, due, end, ensuring, entire, environment, environmental,
        establishes, feasible, for, framework, general, geosphere, government,
        grassroots, have, having, healthy, hence, heritage, human, hydrosphere,
        i, implement, implementation, in, include, intangible, integral,
        interest, interests, is, it, its, law, legal, legislation, life, live,
        make, management, merely, nation, national, natural, necessary,
        objectives, obligations, of, offers, or, out, part, participate,
        particular, plans, policy, population, preservation, president,
        principles, program, programs, protection, provisions, published,
        purpose, rational, relation, resources, respect, respectively,
        responsibility, right, set, social, specialized, state, strategies,
        structures, sustainable, tangible, target, territorial, the, their,
        these, they, this, title, to, together, underestimated, universal, use,
        utilitarian, values, well, wellbeing, which, whose, with)
    State A and State B union word set size: 136

    State A and State C intersection word set:
        ((1), (2), (3), all, and, bodies, environment, environmental, for, i,
        in, is, it, natural, necessary, of, population, principles, purpose,
        resources, state, the, this, title, to)
    State A and State C intersection word set size: 25

    State A and State C union word set:
        ((1), (2), (3), a, above, according, achieve, action, administration,
        against, all, and, associations, be, benefits, better, bodies, brings,
        cannot, citizen, citizens, collaboration, collectivities, compliance,
        concerned, conditions, conservation, coordination, country's, creating,
        decentralized, defense, degradation, due, enhance, entire, environment,
        environmental, essential, establish, every, feasible, fight, for, forms,
        framework, fundamental, general, have, having, healthy, hence, i,
        implement, implementation, improve, in, individually, institutions,
        interests, is, it, its, kinds, law, laws, legislation, live, living,
        local, make, managed, management, merely, national, natural, necessary,
        objectives, obligations, of, or, order, organizations, out, participate,
        pollution, population, preservation, prevent, principles, program,
        protect, protected, protection, published, purpose, rational,
        regulations, relation, resources, respect, respectively, responsibility,
        responsible, right, safeguard, set, sets, specialized, state,
        structures, sustainable, sustainably, territorial, the, this, title, to,
        together, traditional, underestimated, up, use, utilitarian, values,
        wellbeing, which, whose, with, within, work)
    State A and State C union word set size: 131

    State B and State C intersection word set:
        ((1), (2), (3), and, associations, decentralized, environment,
        environmental, for, framework, i, implementation, in, is, it, law, of,
        or, resources, state, territorial, the, this, title, to, together,
        which, with)
    State B and State C intersection word set size: 28

    State B and State C union word set:
        ((1), (2), (3), a, according, action, administration, against, aimed,
        all, an, and, applies, are, as, aspects, associations, at, atmosphere,
        b, better, bodies, brings, citizen, collaboration, collectivities,
        common, communities, compliance, concerned, conditions, conservation,
        constitutes, content, coordination, cultural, decentralized, defense,
        defines, degradation, develops, end, enhance, ensuring, environment,
        environmental, essential, establish, establishes, every, fight, for,
        forms, framework, fundamental, general, geosphere, government,
        grassroots, heritage, human, hydrosphere, i, implementation, improve,
        in, include, individually, institutions, intangible, integral, interest,
        is, it, its, kinds, law, laws, legal, life, living, local, managed,
        management, nation, national, natural, necessary, of, offers, or, order,
        organizations, part, particular, plans, policy, pollution, population,
        president, prevent, principles, programs, protect, protected,
        protection, provisions, purpose, rational, regulations, resources,
        responsibility, responsible, safeguard, sets, social, state, strategies,
        sustainable, sustainably, tangible, target, territorial, the, their,
        these, they, this, title, to, together, traditional, universal, up, use,
        well, which, with, within, work)
    State B and State C union word set size: 140

    Jaccard Index = Size of Intersection / Size of Union
    Jaccard Index(State A, State B) = 30 / 136 ~= 0.221
    Jaccard Index(State A, State C) = 25 / 131 ~= 0.191
    Jaccard Index(State B, State C) = 28 / 140 = 0.2

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
        with open(output_file_path, 'r') as file_object:
            for line in file_object:
                line_components = line.rstrip('\n').split(',')
                actual_similarity_matrix_labels.append(line_components[0])
                actual_similarity_matrix.append(
                    list(map(lambda line_component: float(line_component), line_components[1:])))
    finally:
        utilities.delete_test_directory(test_directory_path)

    expected_similarity_matrix_labels = ['State A', 'State B', 'State C']
    expected_similarity_matrix = [
        [1.0, 0.221, 0.191],
        [0.221, 1.0, 0.2],
        [0.191, 0.2, 1.0],
    ]

    assert expected_similarity_matrix_labels == actual_similarity_matrix_labels

    assert len(expected_similarity_matrix) == len(actual_similarity_matrix)
    epsilon = 0.0005
    for row_index in range(len(expected_similarity_matrix)):
        expected_row = expected_similarity_matrix[row_index]
        actual_row = actual_similarity_matrix[row_index]
        assert len(expected_row) == len(actual_row)
        for column_index in range(len(expected_row)):
            assert abs(expected_row[column_index] - actual_row[column_index]) < epsilon
