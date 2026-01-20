variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}

variable "name" {
  description = "The name of the CodeConnections connection"
  type        = string
  default     = ""
}

variable "provider_type" {
  description = "The provider type for the CodeConnections connection"
  type        = string
  default     = ""
}
