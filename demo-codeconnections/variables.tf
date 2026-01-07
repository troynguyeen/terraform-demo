variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}

variable "name" {
  description = "The name of the CodeConnections connection"
  type        = string
  default     = "demo-github-connection"
}

variable "provider" {
  description = "The provider type for the CodeConnections connection"
  type        = string
  default     = "GitHub"
}