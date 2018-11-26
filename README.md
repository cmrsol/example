#### Example Description:

This project is an attempt to completely implement an *AWS Fargate* cluster from nothing in `us-east-1` region
(except the prerequisites noted below).


There are some prerequisites:
1. An installation of `bash` and the `AWS CLI`.
2. A registered domain served by *AWS Route53* and the associated *Hosted Zone ID*
3. The *ARN* of an existing *AWS Certificate Manager* certificate
4. A *AWS S3* bucket for artifacts
5. This repo pushed into a CodeCommit repo called `example`


*Note: you will need to tweak the following INI files for your own situation before running `build-example.sh`:*

* `vpc/config.ini` - configuration for the VPC that will be constucted
* `iam/deploy/config.ini` - configuration for the IAM deploy role
* `iam/project/config.ini` - configuration for the IAM cluster run role
* `deployment/code_pipeline/config.ini` - configuration of the CodePipeline
* `deployment/config/prod.ini` - configuration for the CodePipeline

---

#### Building the Example:

In the root of the project you will find a `build-example.sh` file. When you execute this file
it will ask for the *Hosted Zone ID* and *ACM certificate ARN* and place them into *SSM*. Then
it will do all the needed bits to create deploy the *AWS Fargate* cluster using *CodePipeline*

In broad strokes the `build-example.sh` file will:

* Ask for the ARN of the ACM certificate and the Route53 zone ID
* Create and activate a python virtual environment in `/tmp`
* Install some python tools into the virtual environment, notably [Stackility](https://github.com/muckamuck/stackility).
* Use Stackility / CloudFormation to create a new VPC.
* Use Stackility / CloudFormation to create a deployment IAM role
* Use Stackility / CloudFormation to create an *AWS CodePipeline* for the changes to the cluster.

The stack for the CodePipeline will deploy the example.

---

#### Example Stucture:

```
├── clean.sh                      # Clean the cruft for a fresh build
├── build-example.sh              # Build the example after tweaking the INI files
├── smash-example.sh              # Remove all the resources created by build-example.sh
├── deployment
│   ├── build.sh                  # CodePipeline worker
│   ├── buildspec.yml             # CodePipeline description file
│   ├── code_pipeline
│   │   ├── config.ini            # CloudFormation parameters for a CodePipeline
│   │   └── template.yml          # CloudFormation template for a CodePipeline
│   ├── template.yml              # CloudFormation template for Fargate cluster
│   ├── config
│   │   └── prod.ini              # CloudFormation parameters for Fargate cluster
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
