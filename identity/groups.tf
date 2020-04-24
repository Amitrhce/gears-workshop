resource "gsuite_group" "developers" {
    email = "developers@${var.domain}"
    name = gsuite_group.developers.email
    description = "Developers"
}