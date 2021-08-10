import os
import setuptools


setuptools.setup(
    data_files=[
        ('configuration', [
            os.path.join('configuration', 'states_to_include.txt'),
        ]),
    ],
    name='EIA',
    packages=['eia'],
    package_dir={'': 'src'},
    scripts=[
        os.path.join('scripts', 'similarity', 'calculate_similarity.py'),
    ])
