# terraform-aws-direct-connect-gateway

Terraform module for a Direct Connect gateway — a regionless aggregation
point that a Direct Connect connection's virtual interfaces attach to,
which can in turn associate with a VPC's virtual private gateway or a
Transit Gateway in any region.

## Cost

A Direct Connect gateway has no charge of its own — Direct Connect's
per-port-hour and per-GB data transfer charges originate from the
physical connection and its virtual interfaces, not from the gateway
itself. See AWS's
[Direct Connect pricing](https://aws.amazon.com/directconnect/pricing/)
page for current rates on the pieces that do bill.

## Design

This module creates only the gateway — a global resource that exists
on its own, with nothing to attach until a virtual interface (on a
real Direct Connect connection) and an association exist. Pair with
[`terraform-aws-direct-connect-gateway-association`](https://github.com/kn47ytv9mv/terraform-aws-direct-connect-gateway-association)
to attach a VPC's virtual private gateway or a Transit Gateway, and
(for a cross-account association) with
[`terraform-aws-direct-connect-gateway-association-proposal`](https://github.com/kn47ytv9mv/terraform-aws-direct-connect-gateway-association-proposal).

Unlike almost everything else this gateway eventually connects to,
creating and associating the gateway itself needs no physical Direct
Connect connection to exist first — it is a pure AWS-side construct,
fully usable (and testable) on its own before any real circuit is
ordered.

**`amazon_side_asn` cannot match the ASN of anything it later
associates with.** Confirmed against real AWS: associating a gateway
with a Transit Gateway that shares its `amazon_side_asn` fails with
`DirectConnectClientException: Direct Connect Gateway and Transit
Gateway cannot have the same ASN`. A Transit Gateway's own
`amazon_side_asn` defaults to `64512` if left unset, so pick a
different private ASN here (or set the Transit Gateway's explicitly)
rather than leaving both at their defaults.

## Usage

```hcl
module "gateway" {
  source = "kn47ytv9mv/direct-connect-gateway/aws"

  name            = "example-dxgw"
  amazon_side_asn = "64513"
}
```

Or directly from this repository:

```hcl
module "gateway" {
  source = "github.com/kn47ytv9mv/terraform-aws-direct-connect-gateway"

  name            = "example-dxgw"
  amazon_side_asn = "64513"
}
```

## Requirements

| Name | Version |
|---|---|
| terraform | >= 1.0 |
| aws | ~> 6.61 |

## Providers

| Name | Version |
|---|---|
| aws | ~> 6.61 |

## Inputs

| Name | Description | Default | Required |
|---|---|---|---|
| name | Name of the Direct Connect gateway. | `null` | no |
| amazon_side_asn | Private ASN for the Amazon side of BGP sessions (64512-65534 or 4200000000-4294967294). Cannot be changed once set. | `null` | no |
| tags | A map of tags to assign to the Direct Connect gateway. | `null` | no |

## Outputs

| Name | Description |
|---|---|
| id | The ID of the Direct Connect gateway. |
| arn | The ARN of the Direct Connect gateway. |
| owner_account_id | The AWS account ID that owns this Direct Connect gateway — pass to a cross-account terraform-aws-direct-connect-gateway-association-proposal's dx_gateway_owner_account_id. |

## License

MIT — see [LICENSE.md](LICENSE.md).
