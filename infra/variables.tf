variable "aws_region" {
  type        = string
  description = "AWS region to deploy into"
}

variable "bucket_name" {
  type = string
}

variable "profile" {
  type        = string
  description = "AWS CLI profile."
}

variable "aliases" {
  type        = list(string)
  description = "CloudFront alternate domain names (CNAMEs)"
}

variable "acm_certificate_arn" {
  type        = string
  description = "ARN of ACM certificate for CloudFront"
}

variable "cache_policy_id" {
  type        = string
  description = "CloudFront cache policy ID"
}

variable "price_class" {
  type        = string
  description = "CloudFront price class"
}