output "demo_kms_arn" {
  value       = aws_kms_key.demo_kms.arn
  description = "The ARN of the KMS key used for CloudWatch Logs encryption."
}