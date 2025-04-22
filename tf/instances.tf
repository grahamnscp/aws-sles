# Instances:

resource "aws_instance" "sles" {

  instance_type = "${var.aws_instance_type_sles}"
  ami           = "${var.aws_ami_sles}"
  key_name      = "${var.aws_key_name}"

  root_block_device {
    volume_size = "${var.volume_size_root_sles}"
    volume_type = "gp2"
    delete_on_termination = true
  }

  iam_instance_profile = "${aws_iam_instance_profile.suse_instance_profile.id}"

  vpc_security_group_ids = ["${aws_security_group.dc-instance-sg.id}"]
  subnet_id = "${aws_subnet.dc-subnet1.id}"

  user_data = "${file("userdata-sles.sh")}"

  count = "${var.node_count_sles}"

  tags = {
    Name = "${var.prefix}-sles${count.index + 1}"
  }
}

resource "aws_instance" "slm" {

  instance_type = "${var.aws_instance_type_sles}"
  ami           = "${var.aws_ami_slm}"
  key_name      = "${var.aws_key_name}"

  root_block_device {
    volume_size = "${var.volume_size_root_sles}"
    volume_type = "gp2"
    delete_on_termination = true
  }

  iam_instance_profile = "${aws_iam_instance_profile.suse_instance_profile.id}"

  vpc_security_group_ids = ["${aws_security_group.dc-instance-sg.id}"]
  subnet_id = "${aws_subnet.dc-subnet1.id}"

  user_data = "${file("userdata-slm.sh")}"

  count = "${var.node_count_slm}"

  tags = {
    Name = "${var.prefix}-slm${count.index + 1}"
  }
}
