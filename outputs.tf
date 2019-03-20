#
# Define outputs
#

output "asg_id" {
  description = "Auto Scaling Group id"
  value       = "${aws_autoscaling_group.bastion.id}"
}
