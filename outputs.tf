output "aws_region" {
  description = "AWS Region"
  value       = var.aws_region
}

output "aws_role" {
  description = "AWS Role to Assume"
  value       = aws_iam_role.ci_deploy.arn
}
