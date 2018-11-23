#### Example Description:

This project is an attempt to completely implement a Fargate cluster from nothing.
There are two prerequisites:
1. The *ARN* of an existing *AWS Certificate Manager* certificate
2. A registered domain served by *AWS Route53* and the associated *Hosted Zone ID*

#### Example Stucture:

```
├── clean.sh                      # Clean the cruft for a fresh build
├── deployment
│   ├── build.sh                  # CodePipeline worker
│   ├── buildspec.yml             # CodePipeline description file
│   ├── code_pipeline
│   │   ├── config.ini            # CloudFormation parameters for a CodePipeline
│   │   └── template.yml          # CloudFormation template for a CodePipeline
│   ├── template.yml              # CloudFormation template for Fargate cluster
│   ├── config                    # CloudFormation parameters for Fargate cluster
│   │   └── prod.ini
│   ├── requirements.txt          # List of required Python modules/tools
│   └── verify_unique_version.py  # Python script to verify a new vertion
├── docker-image
│   ├── app
│   │   └── example.ini           # uWsgi config file for the example application
│   ├── Dockerfile                # Definition file for the example Docker image
│   ├── nginx.conf                # nginx config file for the example application
│   └── run_example_app.sh        # [CMD] script for the Docker image
├── example
│   ├── __init__.py
│   └── service
│       ├── example.py            # The Flask application to be deployed in Fargate
│       └── __init__.py
├── iam
│   ├── deploy
│   │   ├── config.ini            # CloudFormation parameters for deploy IAM role
│   │   └── template.yml          # CloudFormation template for deploy IAM role
│   └── project
│       ├── config.ini            # CloudFormation parameters for Fargate app IAM role
│       └── template.yml          # CloudFormation template for Fargate app IAM role
├── README.md
├── setup.cfg                     # Example Python wheel configuration
├── setup.py                      # Example Python wheel setup module
└── vpc
    ├── config.ini                # CloudFormation parameters for a VPC to hold the app
    └── template.yml              # CloudFormation template for a VPC to hold the app
```
