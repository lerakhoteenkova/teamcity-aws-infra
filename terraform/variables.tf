variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "AWS vpc cidr"
  type        = string
  default     = "10.0.0.0/16"
}

variable "dns-zone" {
  description = "AWS route53 zone"
  type        = string
  default     = "lkhoteenkova.com"
}

variable "project" {
  default = "tc-infra"
}

variable "subnet_cidr_bits" {
  description = "The number of subnet bits for the CIDR. For example, specifying a value 8 for this parameter will create a CIDR with a mask of /24."
  type        = number
  default     = 8
}

variable "availability_zones_count" {
  description = "The number of AZs."
  type        = number
  default     = 2
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    "Project"     = "tc-infra"
    "Environment" = "dev"
    "Owner"       = "lkhoteenkova"
  }
}