# Route53 for instances

resource "aws_route53_record" "sles" {
  zone_id = "${var.route53_zone_id}"
  count = "${var.node_count_sles}"
  name = "${var.prefix}-sles${count.index + 1}.${var.route53_subdomain}.${var.route53_domain}"
  type = "A"
  ttl = "300"
  records = ["${element(aws_eip.sles-eip.*.public_ip, count.index)}"]
}
resource "aws_route53_record" "slm" {
  zone_id = "${var.route53_zone_id}"
  count = "${var.node_count_slm}"
  name = "${var.prefix}-slm${count.index + 1}.${var.route53_subdomain}.${var.route53_domain}"
  type = "A"
  ttl = "300"
  records = ["${element(aws_eip.slm-eip.*.public_ip, count.index)}"]
}

