# Resume Site - Ralph King Jr

A static HTML/CSS resume site deployed to AWS with CloudFront CDN and automated CI/CD.

**Live Site:** https://kingralphresume.com

## Project Overview

This is a personal resume website showcasing professional experience, skills, and certifications. It's a static site (HTML/CSS) deployed to AWS S3 with CloudFront for global CDN delivery.

## Architecture

### Infrastructure Stack
- **Hosting:** AWS S3 (private bucket with encryption)
- **CDN:** AWS CloudFront with custom domain and SSL/TLS
- **DNS:** Route 53 (managed separately)
- **IaC:** Terraform for infrastructure management
- **CI/CD:** GitHub Actions for automated deployments

### Security Features
✅ Private S3 bucket (no public access)
✅ CloudFront Origin Access Control (OAC) for secure S3 access
✅ S3 server-side encryption (AES256)
✅ HTTPS-only with TLS 1.2 minimum
✅ No hardcoded AWS account IDs (dynamic data sources)
✅ ACM certificate for custom domain SSL

## Project Structure

```
.
├── public/                  # Static site files
│   ├── index.html          # Resume content
│   └── css/styles.css      # Styling
├── infra/                   # Terraform infrastructure
│   ├── main.tf             # AWS resources (S3, CloudFront, OAC)
│   ├── variables.tf        # Terraform variables
│   ├── terraform.tfvars    # Variable values (gitignored)
│   └── .env                # Environment variables (gitignored)
├── scripts/
│   └── deploy.sh           # Deployment script
└── .github/workflows/
    └── deploy.yml          # CI/CD automation
```

## Setup & Deployment

### Prerequisites
- AWS CLI configured with profile: `iamadmin-resume`
- Terraform 1.13+ installed
- AWS resources: ACM certificate, CloudFront cache policy

### Local Setup

1. **Configure environment variables** in `infra/.env`:
   ```bash
   export AWS_PROFILE="iamadmin-resume"
   export TF_VAR_bucket_name="kingralphresume.com"
   export DIST_ID="E3EKVDRWYHFEQW"
   ```

2. **Set Terraform variables** in `infra/terraform.tfvars`:
   ```hcl
   bucket_name         = "kingralphresume.com"
   profile             = "iamadmin-resume"
   aws_region          = "us-east-1"
   acm_certificate_arn = "arn:aws:acm:..."
   cache_policy_id     = "658327ea-f89d-4fab-a63d-7e88639e58f6"
   price_class         = "PriceClass_100"
   aliases             = ["kingralphresume.com", "www.kingralphresume.com"]
   ```

### Manual Deployment

To deploy infrastructure and content changes:
```bash
./scripts/deploy.sh
```

This script:
1. Runs `terraform init` and `terraform apply`
2. Syncs `public/` to S3
3. Invalidates CloudFront cache

### Automated Deployment (GitHub Actions)

**Automatic deployment** on push to `main` branch when `public/` files change:

- ✅ Syncs content to S3
- ✅ Sets cache headers (`max-age=31536000`)
- ✅ Invalidates CloudFront cache
- ⏱️ ~2 minutes deployment time

**Note:** Terraform changes are deployed manually via `deploy.sh` for safety.

## Development Workflow

### Updating Resume Content
1. Edit `public/index.html` or `public/css/styles.css`
2. Commit and push to `main`
3. GitHub Actions automatically deploys
4. Changes live in ~2 minutes

### Updating Infrastructure
1. Edit `infra/main.tf` or other `.tf` files
2. Test locally: `cd infra && terraform plan`
3. Deploy: `./scripts/deploy.sh`
4. Commit and push changes

## Infrastructure Details

### Terraform Resources
- `aws_s3_bucket.site` - Private bucket with encryption
- `aws_s3_bucket_server_side_encryption_configuration.site` - AES256 encryption
- `aws_s3_bucket_website_configuration.site` - Website hosting config
- `aws_s3_bucket_policy.site` - CloudFront OAC access policy
- `aws_cloudfront_origin_access_control.site` - Secure S3 access
- `aws_cloudfront_distribution.cdn` - CDN with custom domain
- `aws_s3_object.index` - Index.html deployment

### AWS Account Configuration
- **Account ID:** Retrieved dynamically via `data.aws_caller_identity.current`
- **Region:** us-east-1
- **Profile:** iamadmin-resume

### State Management
- **Backend:** Local state files (suitable for solo projects)
- **Protected:** `.gitignore` excludes `*.tfstate*` and `*.tfvars`
- **Note:** For team projects, consider S3 remote backend

## Security Considerations

✅ **Private Bucket Architecture:** S3 bucket is private; CloudFront uses OAC to access files
✅ **No Public Policies:** S3 Block Public Access prevents accidental public exposure
✅ **Encryption at Rest:** All S3 objects encrypted with AES256
✅ **HTTPS Only:** CloudFront enforces HTTPS with modern TLS
✅ **No Hardcoded Secrets:** Account IDs and ARNs dynamically referenced
✅ **ACL-Free:** Modern bucket access patterns (no legacy ACLs)

## Technologies Used

- **Frontend:** HTML, CSS, Google Fonts (Roboto Slab)
- **Infrastructure:** Terraform, AWS (S3, CloudFront, ACM)
- **CI/CD:** GitHub Actions, AWS CLI
- **Version Control:** Git, GitHub

## Maintenance

### Cost Optimization
- CloudFront cache reduces S3 requests
- S3 lifecycle policies not needed (content rarely changes)
- Estimated cost: ~$1-2/month (CloudFront + S3)

### Monitoring
- CloudFront metrics in AWS Console
- S3 access logs (optional, not currently enabled)

## License

Copyright (c) 2023-2025 Ralph King Jr. All Rights Reserved.

---

## For AI Assistants (Claude Code Context)

**Project Type:** Static resume site with AWS infrastructure
**Deployment Pattern:** Automated content deployment, manual infrastructure changes
**State:** Local Terraform state (solo developer)
**Security Posture:** Private bucket + OAC + encryption (defense in depth)
**Key Files:** `infra/main.tf`, `public/index.html`, `scripts/deploy.sh`
**Common Tasks:** Update resume → push to main (auto-deploys)
