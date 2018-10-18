import logging
from datetime import datetime

logging_level = logging.INFO
logging.basicConfig(
    level=logging_level,
    format='[%(levelname)s] %(asctime)s (%(module)s) %(message)s',
    datefmt='%Y/%m/%d-%H:%M:%S'
)

logging.info('logging initialized')
__title__ = 'mantis2'
__version__ = '0.5.0'
__author__ = 'Mantis Team'
__license__ = 'Proprietary, (c) DuPont Pioneer'
__copyright__ = '(c) {}'.format(datetime.now().year)
__url__ = 'ssh://git@bitbucket.phibred.com:7999/pimg/mantis.git'
__description__ = """
Mauris nec consequat urna, vel maximus erat. Nullam nulla diam,
tincidunt in consectetur eget, sagittis a sapien. Nulla consequat
venenatis ipsum, vel lacinia magna eleifend a. Phasellus at
elementum tellus. Vestibulum sapien nisi, viverra non enim sed,
lobortis hendrerit lacus. Nullam porttitor faucibus vehicula.
Quisque euismod sem felis, id malesuada tortor feugiat id. Sed
dictum ligula massa, ac mollis nulla malesuada quis. Vivamus in
metus ante.
"""
