#---------------------------------------------------------------
#  ec2 Volumes
#---------------------------------------------------------------

resource "aws_ebs_volume" "vol2" {
  availability_zone = "${var.vol2_availability_zone}"
  size              = "${var.vol2_size}"
  type              = "gp2"

  tags {
    "Environment"   = "${var.environment}"
    "Orchestration" = "${var.orchestration}"
  }
}
