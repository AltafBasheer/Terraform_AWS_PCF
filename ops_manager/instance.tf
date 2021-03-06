resource "aws_instance" "ops_manager" {
  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.ops_manager_security_group.id}"]
  source_dest_check      = false
  subnet_id              = "${var.subnet_id}"
  iam_instance_profile   = "${var.instance_profile_name}"
  count                  = "${var.count}"

  root_block_device {
    volume_type = "gp2"
    volume_size = 150
  }

  tags = "${merge(var.tags, var.default_tags,
    map("Name", "${var.env_name}-ops-manager")
  )}"
}
