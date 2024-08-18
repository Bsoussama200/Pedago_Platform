provider "aws" {
  region = "eu-west-3"
  alias  = "certificates"
}

provider "aws" {
  region = "eu-west-3"
  alias  = "dns"
}

module "cert" {
  source = "github.com/azavea/terraform-aws-acm-certificate"

  providers = {
    aws.acm_account     = aws.certificates
    aws.route53_account = aws.dns
  }

  domain_name                       = var.domain
  subject_alternative_names         = ["*.${var.domain}"]
  hosted_zone_id                    = var.hosted_zone_id
  validation_record_ttl             = "60"
  allow_validation_record_overwrite = true
}

# module "cert" {
#   source                            = "terraform-aws-modules/acm/aws"
#   version                           = "5.0.0"
#   domain_name                       = var.domain
#   subject_alternative_names         = ["*.${var.domain}"]
#   create_route53_records            = true
#   wait_for_validation               = true
#   validate_certificate              = true
#   validation_method                 = "DNS"
#   zone_id                           = var.hosted_zone_id
# }
