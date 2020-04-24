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

variable "vpc_name" {
    type = string
}

variable "vpc_regions" {
    type = list(string)
}

variable "subnet_number" {
    type = number
}

variable "service_projects" {
    type = set(string)
}