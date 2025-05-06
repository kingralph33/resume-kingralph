#!/usr/bin/env bash
set -euo pipefail

# load vars
[ -f infra/.env ] && source infra/.env

export BUCKET_NAME="$TF_VAR_bucket_name"
export DIST_ID=$(cd infra && terraform output -raw distribution_id)

# terraform
( cd infra \
  && terraform init -input=false -upgrade \
  && terraform apply -auto-approve )

echo "✅ Terraform applied."

# sync static site
echo "🌐 Syncing public/ to S3://$BUCKET_NAME..."
aws s3 sync public/ s3://"$BUCKET_NAME" \
  --delete \
  --acl public-read \
  --cache-control max-age=31536000,public

# cloudfront invalidation
echo "🚀 Creating CloudFront invalidation..."
aws cloudfront create-invalidation \
  --distribution-id "$DIST_ID" \
  --paths "/*"

echo "🎉 Done! Resume is updated"