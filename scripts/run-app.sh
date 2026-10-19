#!/bin/bash
# EC2(train-app)에서 실행: Parameter Store의 /train/* 값을 환경변수로 넣고 JAR를 띄운다.
set -euo pipefail

JAR=${1:-$HOME/app.jar}
p() { aws ssm get-parameter --name "$1" --with-decryption --query Parameter.Value --output text; }

export SPRING_DATASOURCE_URL=$(p /train/db/url)
export SPRING_DATASOURCE_USERNAME=$(p /train/db/username)
export SPRING_DATASOURCE_PASSWORD=$(p /train/db/password)
export KAKAO_API_KEY=$(p /train/kakao/api-key)
export JWT_SECRET_KEY=$(p /train/jwt/secret-key)
export FOOD_API_SERVICE_KEY=$(p /train/food-api/service-key)
export OPENAI_API_KEY=$(p /train/openai/api-key)
export S3_BUCKET=$(p /train/s3/bucket)

nohup java -jar "$JAR" > "$HOME/app.log" 2>&1 &
echo "started pid $!  (log: $HOME/app.log)"
