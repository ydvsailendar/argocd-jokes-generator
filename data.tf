data "google_client_config" "current" {}

data "aws_route53_zone" "ydvsailendar" {
  name = "ydvsailendar.com."
}
