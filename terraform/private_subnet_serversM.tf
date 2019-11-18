variable "private-k8s2_count" {
  default = 1
}

/* Web Servers */
resource "aws_instance" "private-k8s2" {
  count                  = "${var.private-k8s2_count}"
  ami                    = "${var.ami}"
  instance_type          = "t2.medium"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.k8s-101digital.id}"]
  subnet_id              = "${aws_subnet.private-101digital-us-east-1a.id}"
  root_block_device = {
    volume_size     = "20"
    volume_type     = "gp2"
  }
  tags = {
    Name    = "master${count.index + 1}.k8s.use1.101digital"
    Cluster = "101digital_use1_private-k8s2"
  }
  provisioner "local-exec" {
    command = <<EOD
cat <<EOF >> aws_hosts
[master]
${aws_instance.private-k8s2.private_ip}
EOF
EOD
}

}

