output "endpoints" {
  description = "Broker Endpoints"
  value = aws_mq_broker.rabbit.instances.0.endpoints
}