resource "aws_instance" "terraform_server" {
  ami                    = var.image_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.tf_keypair.key_name
  vpc_security_group_ids = ["${aws_security_group.tf_sg.id}"]
  tags = {
    Name : "tf instance"
  }
  # user_data = "${file("nginx.sh")}"
  user_data = file("${path.module}/nginx.sh")
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/id_rsa")
    host        = self.public_ip
  }
  provisioner "file" {
    source      = "readme.md"      // terraform machine
    destination = "/tmp/readme.md" // remote machine
  }
  provisioner "file" {
    content     = "This is content from content provisioner" // terraform machine
    destination = "/tmp/readme1.md"                          // remote machine
  }
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > /tmp/mupublicip.txt"

  }
  provisioner "local-exec" {
    on_failure = continue // in case of provisioner fail the terraform apply will not fail
    when = destroy
    command = "echo 'at destroy'"

  }
  provisioner "local-exec" {
    command = "echo 'at start'"

  }
  provisioner "remote-exec" {
    inline = [ 
        "ifconfig > /tmp/ifconfig.output",
        "echo 'Hello Aviral' > /tmp/test.txt"
     ]
  }
  provisioner "remote-exec" {
    script = "./testscript.sh"
  }
  

}





output "nignx_sh_file" {
  value = file("${path.module}/nginx.sh")
}




