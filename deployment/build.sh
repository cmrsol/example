#!/bin/bash
set -e
set -x

if [ -z "${region}" ]; then
    region=us-east-1
fi

version=$(python -c "import ${module_name}; print(${module_name}.__version__)" 2>/dev/null)

if [ "${mode}" == "build_wheel" ]; then
    echo "Building the wheel"
    python code_pipeline/verify_unique_version.py ${image_name} ${version}
    python code_pipeline/dot_pypirc.py > /root/.pypirc
    python setup.py sdist bdist_wheel
    twine upload -r local dist/*
elif [ "${mode}" == "build_image" ]; then
    echo Logging in to Amazon ECR in region=${region}
    $(aws ecr get-login --no-include-email --region ${region})

    echo "Building the docker image"
    (cd runner-image; docker build -t ${image_name} --build-arg VERSION=${version} .)

    echo "Publising the docker image"
    docker tag ${image_name} ${account_id}.dkr.ecr.${region}.amazonaws.com/${image_name}:latest
    docker push ${account_id}.dkr.ecr.${region}.amazonaws.com/${image_name}:latest

    docker tag ${image_name} ${account_id}.dkr.ecr.${region}.amazonaws.com/${image_name}:${version}
    docker push ${account_id}.dkr.ecr.${region}.amazonaws.com/${image_name}:${version}
elif [ "${mode}" == "deploy_fargate" ]; then
    echo Deploying Fargate Cluster
    cd code_pipeline
    $(iam_role_assumer assume -r ${build_role} --region ${region})
    stackility upsert -i config/${target_env}.ini
else
    echo "Build mode not set"
    exit 1
fi
