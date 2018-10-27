from setuptools import setup, find_packages
setup(
    name="example",
    version="0.1.6",
    packages=find_packages(),
    description='Python Example Module',
    author='chuck.muckamuck@gmail.com',
    url='www.github.com',
    install_requires=[
        'Flask>=1.0'
    ]
)
