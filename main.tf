terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.7.0"
    }
  }
}

variable "zone_id" {
  type = string
}

variable "clerk_id" {
  type = string
}

resource "aws_route53_record" "clerk-accounts" {
  zone_id = var.zone_id
  name    = "accounts"
  type    = "CNAME"
  ttl     = "300"
  records = ["accounts.clerk.services"]
}

resource "aws_route53_record" "clerk-fe" {
  zone_id = var.zone_id
  name    = "clerk"
  type    = "CNAME"
  ttl     = "300"
  records = ["frontend-api.clerk.services"]
}

resource "aws_route53_record" "clerk-fe-api" {
  zone_id = var.zone_id
  name    = "clerk.api"
  type    = "CNAME"
  ttl     = "300"
  records = ["frontend-api.clerk.services"]
}

resource "aws_route53_record" "clerk-s1" {
  zone_id = var.zone_id
  name    = "s1._domainkey"
  type    = "CNAME"
  ttl     = "300"
  records = ["dkim1.${var.clerk_id}.clerk.services"]
}

resource "aws_route53_record" "clerk-s2" {
  zone_id = var.zone_id
  name    = "s2._domainkey"
  type    = "CNAME"
  ttl     = "300"
  records = ["dkim2.${var.clerk_id}.clerk.services"]
}

resource "aws_route53_record" "clerk-mail" {
  zone_id = var.zone_id
  name    = "mail"
  type    = "CNAME"
  ttl     = "300"
  records = ["mail.${var.clerk_id}.clerk.services"]
}