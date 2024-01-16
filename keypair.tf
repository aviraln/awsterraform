resource "aws_key_pair" "tf_keypair" {
  key_name   = "tf-key"
  public_key = file("${path.module}/id_rsa.pub")
}

output "key_value_file" {
  value = file("${path.module}/id_rsa.pub")

}