# aws-clerk

Creates the AWS resources necessary to integrate your AWS website with [Clerk](https://clerk.dev).

## Features

- Adds DNS records to AWS to integrate with Clerk

## Usage

```hcl
data "aws_route53_zone" "website" {
  name = "example.com."
}

provider "aws" {
  region = "us-east-1"
}

module "aws_clerk" {
  source  = "dvargas92495/clerk/aws"
  zone_id = data.aws_route53_zone.website.zone_id
  clerk_id = "From /dns page"
}
```

## Inputs
- `zone_id` - The AWS Route53 Hosted Zone to add the Clerk DNS configuration to.
- `clerk_id` - This value could be found on your Clerk DNS page and is the 12-digit randomized alpha-numeric path in the mail and clk records. 

## Output

There are no exposed outputs
