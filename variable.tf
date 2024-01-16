variable "region" {
  type = string
}
variable "accesskey" {
  type = string
}
variable "secretkey" {
  type = string
}
variable "ports" {
  type = list(number)
}
variable "image_id" {
  type = string
}
variable "instance_type" {
  type = string
}
