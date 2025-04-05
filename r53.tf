resource "aws_route53_record" "devsecops_ns" {
  zone_id = data.aws_route53_zone.ydvsailendar.zone_id
  name    = "devsecops"
  type    = "NS"
  ttl     = 300
  records = google_dns_managed_zone.devsecops.name_servers
}
