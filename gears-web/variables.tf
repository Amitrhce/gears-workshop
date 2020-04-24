#################################
#          PROVIDER             #
#################################

variable "credentials_file" {
    type = string
}

variable "gcp_project" {
    type = string
}

variable "environment" {
    type = string
}

#################################
#          NETWORK              #
#################################

variable "vpc_project" {
    type = string
}

variable "vpc_name" {
    type = string
}

variable "vpc_regions" {
    type = set(string)
}

#################################
#          COMPUTE              #
#################################

variable "caddy_base_image" {
    type = string
}

variable "caddy_min_size" {
    type = number
}

variable "caddy_max_size" {
    type = number
}

variable "domains" {
    type = list(string)
}