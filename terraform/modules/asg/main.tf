
# create an auto scaling group
resource "aws_autoscaling_group" "asg-main" {
  name_prefix         = "asg-${terraform.workspace}-"
  vpc_zone_identifier = var.vpc2_private_subnets

  min_size         = 2
  max_size         = 4
  desired_capacity = 2

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }

  health_check_grace_period = 100

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_template" "launch_template" {
  name                   = "shemer-template-${terraform.workspace}"
  instance_type          = var.instance_type
  image_id               = var.ami
  key_name               = var.key
  vpc_security_group_ids = [var.private_vpc2_sg_id]
  user_data              = filebase64("/mnt/c/Users/sheme/Desktop/Terraform task 3/terraform/modules/asg/user_data.sh")

  credit_specification {
    cpu_credits = "standard"
  }

  iam_instance_profile {
    arn = aws_iam_instance_profile.ec2-instance_profile.arn
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name   = "launch-instance-${terraform.workspace}"
      Source = "Autoscaling"
    }
  }

}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecsEc2ExecutionRole" {
  name               = "terraform-task-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ecsEc2ExecutionRole_policy" {
  role       = aws_iam_role.ecsEc2ExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ec2-instance_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ecsEc2ExecutionRole.name
}
