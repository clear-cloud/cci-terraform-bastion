# ---------------------------------------
# Launch Config
# ---------------------------------------
resource "aws_launch_configuration" "bastion" {
  depends_on           = ["aws_eip.bastion"]
  name_prefix          = "terraform-bastion-lc-"
  image_id             = "${var.image_id}"
  instance_type        = "${var.instance_type}"
  key_name             = "${var.key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.bastion_instance_profile.name}"
  security_groups      = ["${var.security_groups}"]
  enable_monitoring    = "${var.enable_monitoring}"
  user_data            = "${data.template_file.user_data.rendered}"

  # Setup root block device
  root_block_device {
    volume_size = "${var.volume_size}"
    volume_type = "${var.volume_type}"
  }

  # Create before destroy
  lifecycle {
    ignore_changes = ["ebs_optimized", "user_data", "ephemeral_block_device"]
    create_before_destroy = true
  }

}

# ---------------------------------------
# Render Bastion userdata bootstrap file
# ---------------------------------------
data "template_file" "user_data" {
  depends_on = ["aws_eip.bastion"]
  template   = "${file("${path.module}/${var.platform}/userdata")}"

  vars {
    hostname                    = "${var.hostname}"
    dns_domain_name             = "${var.dns_domain_name}"
    hosted_zone_id              = "${var.hosted_zone_id}"
    supplementary_user_data_pre = "${var.supplementary_user_data_pre}"
    supplementary_user_data     = "${var.supplementary_user_data}"
    data_volume_mount_point     = "${var.data_volume_mount_point}"
    region                      = "${var.region}"
    ComputerName                = "${var.ComputerName}"                # Windows userdata
    userName                    = "${var.userName}"                    # Windows userdata
    eip_assoc_id                = "${aws_eip.bastion.id}"              # Windows userdata 
  }
}
