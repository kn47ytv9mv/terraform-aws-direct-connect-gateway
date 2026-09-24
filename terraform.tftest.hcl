mock_provider "aws" {
}

run "name_and_asn_pass_through" {
  command = plan

  variables {
    name            = "example-dxgw"
    amazon_side_asn = "64512"
  }

  assert {
    condition     = aws_dx_gateway.resource.name == "example-dxgw"
    error_message = "name should pass through unchanged."
  }

  assert {
    condition     = aws_dx_gateway.resource.amazon_side_asn == "64512"
    error_message = "amazon_side_asn should pass through unchanged."
  }
}

run "tags_pass_through" {
  command = plan

  variables {
    name            = "example-dxgw"
    amazon_side_asn = "64512"
    tags = {
      Name = "example-dxgw"
    }
  }

  assert {
    condition     = aws_dx_gateway.resource.tags.Name == "example-dxgw"
    error_message = "tags should pass through unchanged."
  }
}

run "readme_default_example" {
  command = plan

  variables {
    name            = "example-dxgw"
    amazon_side_asn = "64513"
  }
}
