resource "aws_elb" "101digital" {
  name = "101digital"
  security_groups = ["${aws_security_group.k8s-101digital.id}"]
  subnets = ["${aws_subnet.public-101digital-us-east-1a.id}","${aws_subnet.public-101digital-us-east-1b.id}"]
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:30000/"
  }
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "30000"
    instance_protocol = "http"
  }
  instances                   = ["${aws_instance.public-k8s.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
}
