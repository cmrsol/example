#!/bin/bash

set +e
acm_arn=$(aws ssm get-parameter --name /example/acmARN --with-decryption --output text --region us-east-1 2>/dev/null | awk '{print $NF}' 2>/dev/null)
zone_id=$(aws ssm get-parameter --name /example/hostedZoneId --with-decryption --output text --region us-east-1 2>/dev/null | awk '{print $NF}' 2>/dev/null)

if [ -z "${acm_arn}" ]; then
    echo -n "Enter ACM certificate ARN: "; read acm_arn
else
    echo -n "Enter ACM certificate ARN (default=${acm_arn}): "; read tmp
    if [ ! -z "${tmp}" ]; then
        acm_arn=${tmp}
    fi
fi

if [ -z "${acm_arn}" ]; then
    echo "You must enter ACM certificate ARN"
    exit 1
fi

if [ -z "${zone_id}" ]; then
    echo -n "Enter Hosted Zone ID: ${zone_id}"; read zone_id
else
    echo -n "Enter Hosted Zone ID (default=${zone_id}): "; read tmp
    if [ ! -z "${tmp}" ]; then
        zone_id=${tmp}
    fi
fi

if [ -z "${zone_id}" ]; then
    echo "You must enter Hosted Zone ID"
    exit 1
fi

echo "Setting ${acm_arn}"
echo "Setting ${zone_id}"
aws ssm put-parameter --name /example/acmARN --value ${acm_arn} --type SecureString --overwrite --region us-east-1
aws ssm put-parameter --name /example/hostedZoneId --value ${zone_id} --type SecureString --overwrite --region us-east-1
set -e
