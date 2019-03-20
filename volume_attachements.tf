#---------------------------------------------------------------
# ec2 attachments
#---------------------------------------------------------------

resource "aws_volume_attachment" "attach_vol2" {
  device_name = "/dev/xvdd"
  volume_id   = "${aws_ebs_volume.vol2.id}"
  instance_id = "${aws_instance.ec2.id}"
}
