resource "aws_security_group" "rabbit" {
  name        = "${var.vpc_id}-rabbitmq"
  description = "Managed by Terraform"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = var.private_subnets_cidr_blocks
  }

  ingress {
    from_port = 5671
    to_port   = 5671
    protocol  = "tcp"

    cidr_blocks = var.private_subnets_cidr_blocks
  }
}

resource "aws_mq_broker" "rabbit" {
  broker_name = var.name

  engine_type        = "RabbitMQ"
  engine_version     = "3.9.16"
  host_instance_type = "mq.t3.micro"
  subnet_ids         = var.subnet_ids
  security_groups    = [ aws_security_group.rabbit.id ]

  dynamic user {
    for_each = var.users
    content {
      username = user.value.username
      password = user.value.password
    }
  }

  apply_immediately = var.apply_immediately

  tags = var.tags
}