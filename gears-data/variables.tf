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
#            DATA               #
#################################

