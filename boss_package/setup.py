# -*- coding: utf-8 -*-

# DO NOT EDIT THIS FILE!
# This file has been autogenerated by dephell <3
# https://github.com/dephell/dephell

try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

import os.path

readme = ''
here = os.path.abspath(os.path.dirname(__file__))
readme_path = os.path.join(here, 'README.rst')
if os.path.exists(readme_path):
    with open(readme_path, 'rb') as stream:
        readme = stream.read().decode('utf8')

setup(
    long_description=readme,
    name='boss_package',
    version='0.1.0',
    description='The description of the package',
    python_requires='==3.*,>=3.7.0',
    project_urls={'homepage': 'https://github.com/bossjones/boss_package'},
    author='Jarvis',
    author_email='jarvis@theblacktonystark.com',
    license='MIT',
    keywords='command cli',
    entry_points={'console_scripts': ['boss_package = boss_package=cli:cli']},
    packages=['boss_package'],
    package_data={},
    install_requires=[
        'click==7.*,>=7.0.0', 'pyconfig==3.*,>=3.0.0',
        'requests[security]==2.*,>=2.13.0', 'toml==0.*,>=0.9.0'
    ],
    extras_require={
        'dev': [
            'black==19.*,>=19.3.0; python_version == "3.*" and python_version >= "3.6.0"',
            'pre-commit==1.*,>=1.12.0', 'pytest==4.*,>=4.4.0',
            'pytest-cov==2.*,>=2.6.0', 'pytest-mock==1.*,>=1.7.0',
            'tox==3.*,>=3.5.0'
        ]
    },
)
