provider "aws" {
  region = "us-east-1"
}
locals {
  user_data = <<-EOT
    #!/bin/bash
    sudo yum install -y httpd
    sudo systemctl start httpd
    sudo systemctl enable httpd
    TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
    AZ=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/availability-zone)
    if [ -z "$AZ" ]; then
        echo "Cann't get Availability Zone!" | sudo tee /var/www/html/index.html
    else
        echo "Availability Zone: $AZ" | sudo tee /var/www/html/index.html
    fi
  EOT
}
module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"

  # Autoscaling group
  name = "example-asg"
  min_size                  = 1
  max_size                  = 2
  desired_capacity          = 2
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  # vpc_zone_identifier       = ["subnet-1235678", "subnet-87654321"]
  vpc_zone_identifier = var.vpcB_public_subnets
  security_groups = [var.security_groupB_id]
 

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      checkpoint_delay       = 600
      checkpoint_percentages = [35, 70, 100]
      instance_warmup        = 300
      min_healthy_percentage = 50
      max_healthy_percentage = 100
    }
    triggers = ["tag"]
  }

  # Launch template
  launch_template_name        = "example-asg"
  launch_template_description = "Launch template example"
  update_default_version      = true
  
  image_id          = "ami-01816d07b1128cd2d"
  instance_type     = "t2.micro"
  ebs_optimized     = true
  enable_monitoring = true
  key_name = "trinhdat"
  user_data         = base64encode(local.user_data)

  capacity_reservation_specification = {
    capacity_reservation_preference = "open"
  }

  network_interfaces = [
    {
      delete_on_termination = true
      description           = "eth0"
      device_index          = 0
      security_groups       = [var.security_groupB_id]
      associate_public_ip_address = true
    }

  ]

  tags = {
    Environment = "dev"
    Project     = "megasecret"
  }
}