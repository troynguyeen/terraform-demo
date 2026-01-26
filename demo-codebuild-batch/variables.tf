variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}

variable "inline_policy_statements" {
  description = "A map of list statements for inline role policy"
  type        = any
  default     = {}
}