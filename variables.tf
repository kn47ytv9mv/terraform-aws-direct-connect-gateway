variable "name" {
  default     = null
  description = "Name of the Direct Connect gateway."
}

variable "amazon_side_asn" {
  default     = null
  description = "Private ASN for the Amazon side of BGP sessions (64512-65534 or 4200000000-4294967294). Cannot be changed once set."
}

variable "tags" {
  default     = null
  description = "A map of tags to assign to the Direct Connect gateway."
}
