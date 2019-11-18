variable "private-k8s_count" {
  default = 1
}

/* Web Servers */
resource "aws_instance" "private-k8s" {
  count                  = "${var.private-k8s_count}"
  ami                    = "${var.ami}"
  instance_type          = "t2.micro"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.k8s-101digital.id}"]
  subnet_id              = "${aws_subnet.private-101digital-us-east-1a.id}"
  root_block_device = {
    volume_size     = "20"
    volume_type     = "gp2"
  }
  tags = {
    Name    = "worker${count.index + 1}.k8s.use1.101digital"
    Cluster = "101digital_use1_private-k8s"
  }
  provisioner "local-exec" {
    command = <<EOD
cat <<EOF >> aws_hosts
[workers]
${aws_instance.private-k8s.private_ip}
EOF
EOD
}

}

