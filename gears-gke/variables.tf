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
    type = list(string)
}

#################################
#            GKE                #
#################################

variable "pod_range" {
    type = string
}

variable "service_range" {
    type = string
}

variable "gke_min_size" {
    type = number
}

variable "gke_max_size" {
    type = number
}

variable "gke_release_channel" {
    type = string
}