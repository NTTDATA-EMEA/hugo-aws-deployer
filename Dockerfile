FROM    alpine:3.12
LABEL   authors="Oliver Koeth <koeth@acm.org>"

ENV     AWS_REGION="set_me_in_cli"
ENV     AWS_ACCESS_KEY_ID="set_me_in_cli"
ENV     AWS_SECRET_ACCESS_KEY="set_me_in_cli"
ENV     S3_BUCKET="set_me_in_cli"
ENV     CLOUDFRONT_DISTRIBUTION="set_me_in_cli"

RUN     apk add groff less build-base python3 py-pip python3-dev git hugo && \
        pip install awscli && \
        pip install aws-sam-cli && \
        rm /var/cache/apk/*
