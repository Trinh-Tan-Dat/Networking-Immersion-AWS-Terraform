data "aws_instances" "asg_instances" {
  filter {
    name   = "tag:Environment"
    values = ["dev"]
  }
}

output "instance_ids" {
  value = data.aws_instances.asg_instances.ids
}
