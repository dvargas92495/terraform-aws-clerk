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

variable "subdomain" {
  type = string
  default = ""
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
  name    = "clerk.api${length(var.subdomain) > 0 ? ".${var.subdomain}" : ""}"
  type    = "CNAME"
  ttl     = "300"
  records = ["frontend-api.clerk.services"]
}

resource "aws_route53_record" "clerk-dkim1" {
  zone_id = var.zone_id
  name    = "clk._domainkey"
  type    = "CNAME"
  ttl     = "300"
  records = ["dkim1.${var.clerk_id}.clerk.services"]
}

resource "aws_route53_record" "clerk-dkim2" {
  zone_id = var.zone_id
  name    = "clk2._domainkey"
  type    = "CNAME"
  ttl     = "300"
  records = ["dkim2.${var.clerk_id}.clerk.services"]
}

resource "aws_route53_record" "clerk-mail" {
  zone_id = var.zone_id
  name    = "clkmail"
  type    = "CNAME"
  ttl     = "300"
  records = ["mail.${var.clerk_id}.clerk.services"]
}
