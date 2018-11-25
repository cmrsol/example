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
stackility delete -s example-cluster --region us-east-1
stackility delete -s example-role --region us-east-1
stackility delete -s example-deploy-role --region us-east-1
stackility delete -s example-application-vpc --region us-east-1
