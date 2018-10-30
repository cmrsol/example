from setuptools import setup, find_packages
setup(
    name="example",
    version="1.0.2",
    packages=find_packages(),
    description='Python Example Module',
    author='chuck.muckamuck@gmail.com',
    url='www.github.com',
    install_requires=[
        'Flask>=1.0'
    ]
)
