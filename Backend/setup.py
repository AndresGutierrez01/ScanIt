from setuptools import setup, find_packages

setup(
    name='ScanIt',
    version='0.0.1',
    long_description=__doc__,
    packages=find_packages(),
    zip_safe=False,
    install_requires=['Flask']
)