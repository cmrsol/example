#!/bin/bash
set -e # exit on any error
version=$(python -c "import ${module_name}; print(${module_name}.__version__)" 2>/dev/null)

if [ "${mode}" == "build_wheel" ]; then
    echo "Building the wheel"
    python deployment/verify_unique_version.py ${image_name} ${version}
    python setup.py sdist bdist_wheel
    aws s3 cp dist/example-${version}-py3-none-any.whl s3://${bucket}/artifacts/example/example-${version}-py3-none-any.whl
elif [ "${mode}" == "build_image" ]; then
    echo Logging in to Amazon ECR in region=${region}
    $(aws ecr get-login --no-include-email --region ${region})

    echo "Building the docker image"
    (cd docker-image; docker build -t ${image_name} --build-arg VERSION=${version} --build-arg BUCKET=${bucket} .)

    echo "Publising the docker image"
    docker tag ${image_name} ${account_id}.dkr.ecr.${region}.amazonaws.com/${image_name}:latest
    docker push ${account_id}.dkr.ecr.${region}.amazonaws.com/${image_name}:latest

    docker tag ${image_name} ${account_id}.dkr.ecr.${region}.amazonaws.com/${image_name}:${version}
    docker push ${account_id}.dkr.ecr.${region}.amazonaws.com/${image_name}:${version}
elif [ "${mode}" == "deploy_fargate" ]; then
    echo Deploying Fargate Cluster
    cd deployment
    stackility upsert -i config/prod.ini
    service_name=$(aws ecs list-services --cluster ${cluster_name} --output text --region ${region} | awk -F'/' '{print $2}')
    aws ecs update-service --force-new-deployment --service ${service_name} --cluster ${cluster_name} --region ${region}
else
    echo "Build mode not set"
    exit 1
fi
