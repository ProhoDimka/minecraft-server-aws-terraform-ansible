resource "aws_route53_zone" "main" {
  name = var.account_domain_init_name
  lifecycle {
    prevent_destroy = true
  }
}