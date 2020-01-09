output "load_balancer" {
  description = "The ID and ARN of the load balancer we created."
  value       = aws_lb.application
}
