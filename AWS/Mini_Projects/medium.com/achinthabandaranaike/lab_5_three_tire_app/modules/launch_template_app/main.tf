resource "aws_launch_template" "app_lt" {
  name_prefix = "app_lt_config"
  image_id = var.ami
  instance_type = var.instance_type
  key_name = var.key_pair_name
  security_group_names = [ var.app_sg_id ]

  user_data = <<-EOF
    #!/bin/bash

    # Update the system
    sudo yum -y update

    # Install Apache web server
    sudo yum -y install httpd

    # Start Apache web server
    sudo systemctl start httpd.service

    # Enable Apache to start at boot
    sudo systemctl enable httpd.service

    # Create index.html file with your custom HTML
    sudo echo 'This is from app server' > /var/www/html/index.html

    EOF

lifecycle {
  prevent_destroy = true
  ignore_changes = [ "all" ]
}
}