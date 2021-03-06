# Hugo AWS Deployer

This Dockerfile brings hugo and the AWS CLI with it to deploy a hugo
powered static site to AWS.

## How to use

A sample `Makefile` using this container would look like this:

```
.PHONY: clean up compile deploy

up:
	sam deploy -t template.yml \
        --stack-name ${STACK_NAME} \
        --capabilities=CAPABILITY_IAM \
        --parameter-overrides \
        'ParameterKey=HostedZone,ParameterValue=${HOSTED_ZONE} \
        ParameterKey=Domain,ParameterValue=${SITE_NAME}.${HOSTED_ZONE} \
        ParameterKey=SERVICETOKEN,ParameterValue=${VALIDATOR_ARN}'


clean:
	rm -rf ./public ./resources

compile:
	hugo --minify --gc

deploy: compile
	aws s3 sync ./public s3://${S3_BUCKET}
	aws cloudfront create-invalidation --distribution-id ${CLOUDFRONT_DISTRIBUTION} --paths "/*"
```

The deployment in an automatted pipeline would just run a `make deploy`.

## How to configure

The following minimum configuration settings are required:

```
AWS_REGION
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
S3_BUCKET
CLOUDFRONT_DISTRIBUTION
```

The AWS keys need to point to a user with the following permissions:

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucket",
                "s3:DeleteObject",
                "cloudfront:CreateInvalidation"
            ],
            "Resource": [
                "arn:aws:s3:::${S3_BUCKET}/*",
                "arn:aws:s3:::${S3_BUCKET}",
                "arn:aws:cloudfront::680260899871:distribution/${CLOUDFRONT_DISTRIBUTION}"
            ]
        }
    ]
}
```