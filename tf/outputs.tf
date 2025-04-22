# Output Values:

# Domain
output "domainname" {
  value = "${var.route53_subdomain}.${var.route53_domain}"
}

# Instances
# sles
output "sles-instance-private-ips" {
  value = ["${aws_instance.sles.*.private_ip}"]
}
output "sles-instance-public-ips" {
  value = ["${aws_eip.sles-eip.*.public_ip}"]
}
output "sles-instance-names" {
  value = ["${aws_route53_record.sles.*.name}"]
}

# slmicro
output "slm-instance-private-ips" {
  value = ["${aws_instance.slm.*.private_ip}"]
}
output "slm-instance-public-ips" {
  value = ["${aws_eip.slm-eip.*.public_ip}"]
}
output "slm-instance-names" {
  value = ["${aws_route53_record.slm.*.name}"]
}
