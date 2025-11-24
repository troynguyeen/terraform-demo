variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}

variable "my_repos" {
  description = "List of repositories to create. Defaults to NPM with public NPM external connection"
  type = list(object({
    name        = string
    description = string
    external_connections = list(object({
      external_connection_name = string
    }))
    upstreams = optional(list(object({
      upstream_repository_name = string
    })))
  }))
  default = [
    {
      name        = "demo-npm"
      description = "Demo NPM repository"
      external_connections = [{
        external_connection_name = "public:npmjs"
      }]
    },
    {
      name        = "demo-nuget"
      description = "Demo NuGet repository"
      external_connections = [{
        external_connection_name = "public:nuget-org"
      }]
    }
  ]
}