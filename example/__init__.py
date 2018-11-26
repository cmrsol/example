import logging
from datetime import datetime

logging_level = logging.INFO
logging.basicConfig(
    level=logging_level,
    format='[%(levelname)s] %(asctime)s (%(module)s) %(message)s',
    datefmt='%Y/%m/%d-%H:%M:%S'
)

logging.info('logging initialized')
__title__ = 'example'
__version__ = '1.0.10'
__author__ = 'Chuck Muckamuck'
__license__ = 'MIT'
__copyright__ = '(c) {}'.format(datetime.now().year)
__url__ = 'https://github.com'
__description__ = """
Mauris nec consequat urna, vel maximus erat. Nullam nulla diam,
tincidunt in consectetur eget, sagittis a sapien. Nulla consequat
elementum tellus. Vestibulum sapien nisi, viverra non enim sed,
lobortis hendrerit lacus. Nullam porttitor faucibus vehicula.
Venenatis ipsum, vel lacinia magna eleifend a. Phasellus at
quisque euismod sem felis, id malesuada tortor feugiat id. Sed
dictum ligula massa, ac mollis nulla malesuada quis. Vivamus in
metus ante.
"""
