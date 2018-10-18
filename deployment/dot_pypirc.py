import sys
import boto3


dot_pypirc = '''[distutils]
index-servers = local

[local]
repository: https://artifactory.research.phibred.com/artifactory/api/pypi/pypi-local
username: {}
password: {}'''


try:
    username_key = '/artifactory/mantis/user'
    password_key = '/artifactory/mantis/password'
    ssm_client = boto3.client('ssm')

    response = ssm_client.get_parameter(Name=username_key, WithDecryption=True)
    username = response.get('Parameter', {}).get('Value', None)

    response = ssm_client.get_parameter(Name=password_key, WithDecryption=True)
    password = response.get('Parameter', {}).get('Value', None)

    print(dot_pypirc.format(username, password))
    sys.exit(0)
except Exception as wtf:
    print('dot_pypirc exploded: {}'.format(wtf))
    sys.exit(1)
