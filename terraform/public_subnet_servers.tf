variable "public-k8s_count" {
  default = 1
}

/* Web Servers */
resource "aws_instance" "public-k8s" {
  count                  = "${var.public-k8s_count}"
  ami                    = "${var.ami}"
  instance_type          = "t2.micro"
/*  associate_public_ip_address = true */
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.k8s-101digital.id}"]
  subnet_id              = "${aws_subnet.public-101digital-us-east-1a.id}"
  root_block_device = {
    volume_size     = "20"
    volume_type     = "gp2"
  }
  tags = {
    Name    = "worker${count.index + 2}.k8s.use1.101digital"
    Cluster = "101digital_use1_public-k8s"
  }
  provisioner "local-exec" {
    command = <<EOD
cat <<EOF >> aws_hosts
[workers]
${aws_instance.public-k8s.private_ip}
EOF
EOD
}
#  provisioner "local-exec" {
#    command = "aws ec2 wait instance-status-ok --instance-ids ${aws_instance.public-k8s.id}  && ansible-playbook -i aws_hosts kube-dependencies.yml && ansible-playbook -i aws_hosts master.yml && ansible-playbook -i aws_hosts workers.yml"
#
#}

}

