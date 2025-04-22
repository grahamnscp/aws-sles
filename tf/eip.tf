# elastic ips

# Associate Elastic IPs to Instances
resource "aws_eip" "sles-eip" {
  count = "${var.node_count_sles}"
  instance = "${element(aws_instance.sles.*.id, count.index)}"

  tags = {
    Name = "${var.prefix}_sles${count.index + 1}"
  }
  depends_on = [aws_instance.sles]
}

resource "aws_eip" "slm-eip" {
  count = "${var.node_count_slm}"
  instance = "${element(aws_instance.slm.*.id, count.index)}"

  tags = {
    Name = "${var.prefix}_slm${count.index + 1}"
  }
  depends_on = [aws_instance.slm]
}
