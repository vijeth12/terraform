resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.sg_id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install apache2 -y
              systemctl start apache2
              systemctl enable apache2
              echo "Hello from Terraform Modules" > /var/www/html/index.html
              EOF

  tags = {
    Name = "terraform-web-server"
  }
}
