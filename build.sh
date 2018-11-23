#!/bin/bash
set -e

# Be in control of our location
cd $(dirname ${0})

# Make a temporrart virtualenv
food=$(date +%s)
virtualenv /tmp/${food}
. /tmp/${food}/bin/activate
pip install -Ur deployment/requirements.txt

# Build the stacks
(cd vpc; stackility upsert -i config.ini)
(cd iam/deploy; stackility upsert -i config.ini)
(cd iam/project; stackility upsert -i config.ini)
(cd deployment; stackility upsert -i config/prod.ini)
