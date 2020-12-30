#!/bin/bash

docker run --rm -it \
    --env AWS_REGION=$AWS_REGION 
    --env AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
    --env AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
    --env S3_BUCKET=$AWS_SECRET_ACCESS_KEY
    --env CLOUDFRONT_DISTRIBUTION=$CLOUDFRONT_DISTRIBUTION
    okoeth/hugo-aws-deployer /bin/bash
