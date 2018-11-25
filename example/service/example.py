'''
The Example service
'''
# pylint: disable=invalid-name
# pylint: disable=superfluous-parens
# pylint: disable=broad-except
# pylint: disable=too-many-nested-blocks

import logging
import os
import time #noqa
from flask import Flask

version = '1.0.4'


def get_fs_freespace(pathname):
    '''
    Find the free space on the given path

    Args:
        pathname - the path on which to find free space

    Returns:
        A number of bytess that are free
    '''
    stat = os.statvfs(pathname)
    return stat.f_bfree*stat.f_bsize


_app = Flask(__name__)


@_app.route("/example/ping")
def ping():
    logging.info('version = {}'.format(version))
    return 'example::pong'


@_app.route("/example/status")
def status():
    '''
    Determine the status of the service

    Args:
        None

    Returns:
        A Flask repsonse dictionary
    '''
    try:
        df = get_fs_freespace('/')
        logging.info('disk free = {} bytes'.format(df))
    except Exception as status_problems:
        logging.error(status_problems)
        df = -1

    body = STATUS_HTML.format(df, version)
    return body, 200, {'Content-Type': 'text/html; charset=utf-8'}


STATUS_HTML = '''<html>
  <head>
    <title>Example Status</title>
  </head>
  <body>
    <strong>Example Status:</strong><br>
    <br>
    Bytes free on /: {}
    <br><br>
    <i>version: {}</i>
  </body>
</html>'''
