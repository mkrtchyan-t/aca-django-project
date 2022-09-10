# Create a Null Resource and Provisioners
resource "null_resource" "copy_ec2_keys" {
  depends_on = [module.ec2_public]
  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type        = "ssh"
    host        = aws_eip.bastion_eip.public_ip
    user        = "ec2-user"
    password    = ""
    private_key = file("private-key/${var.instance_keypair}.pem")
  }

  ## File Provisioner: Copies the django-key-pair.pem file to /tmp/tdjango-key-pair.pem
  provisioner "file" {
    source      = "private-key/${var.instance_keypair}.pem"
    destination = "/tmp/django-key-pair.pem"
  }
  ## Remote Exec Provisioner:Fix the private key permissions on Bastion Host
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/django-key-pair.pem"
    ]
  }


}
