resource "aws_dx_gateway" "resource" {
  name            = var.name
  amazon_side_asn = var.amazon_side_asn
  tags            = var.tags
}

output "id" {
  description = "The ID of the Direct Connect gateway."
  value       = aws_dx_gateway.resource.id
}

output "arn" {
  description = "The ARN of the Direct Connect gateway."
  value       = aws_dx_gateway.resource.arn
}

output "owner_account_id" {
  description = "The AWS account ID that owns this Direct Connect gateway — pass to a cross-account terraform-aws-direct-connect-gateway-association-proposal's dx_gateway_owner_account_id."
  value       = aws_dx_gateway.resource.owner_account_id
}
