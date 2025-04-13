resource "aws_instance" "web" {
  ami           = "ami-0f58b397bc5c1f2e8" # Amazon Linux 2 AMI (for ap-south-1)
  instance_type = "t2.micro"
  key_name      = "terraform-key"  # Replace with your actual key name
  subnet_id     = data.aws_subnet.default.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # User data to install Apache and serve a "Hello, World!" page
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello, World!</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "Terraform-Web-Server"
  }
}
