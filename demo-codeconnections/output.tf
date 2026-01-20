output "arn" {
  value       = aws_codeconnections_connection.demo-githubconnection.arn
  description = "The ARN of the CodeConnections connection"
}

output "connection_status" {
  value       = aws_codeconnections_connection.demo-githubconnection.connection_status
  description = "The connection status of the CodeConnections connection"
}
