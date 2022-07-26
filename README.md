# Terraform AmazonMQ module
RabbitMQ implementation for AmazonMQ

This module will create a **RabbitMQ** broker in a `mq.t3.micro` instance (included in the Free Tier).

## Usage

Set the `users` variable value as a list of objects (username, password) and add the following snippet on your `main.tf` file:

```tf
module "rabbit" {
  source = "./mq"
  name   = "awesome-mq-broker"

  # Only one user is allowed for engine RabbitMQ
  users = var.users

  # Override this values with your own resources attributes
  vpc_id                      = "vpc_id"
  subnet_ids                  = [ "private_subnet_id" ]
  private_subnets_cidr_blocks = [ "172.31.0.0/20", "172.31.16.0/20", "172.31.32.0/20" ]

  tags = {
    Owner       = "some-owner"
    Environment = "staging"
  }
}
```

Also a *Security Group* will be created with the following ingresses allowed only for the private subnets CIDR blocks:

- HTTPS 443 for the Management console
- AMQPS 5671

All outgoing traffic is allowed.