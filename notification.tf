# ---------------------------------
# Optional ASG action notifications
# ---------------------------------
resource "aws_autoscaling_notification" "notification" {
  count = "${var.notifications ? 1 : 0}"

  group_names = [
    "${aws_autoscaling_group.bastion.name}",
  ]

  notifications = [
    #
    # All four alarms that are available currently
    #
    "autoscaling:EC2_INSTANCE_LAUNCH",

    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = "${var.alarm_topic_arn}"
}
