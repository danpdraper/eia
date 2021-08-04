import setuptools


setuptools.setup(
    name='EIA',
    packages=['eia'],
    package_dir={'': 'src'},
    scripts=['scripts/similarity/calculate_similarity.py'])
