#
# Optional EIP 
#
resource "aws_eip" "bastion" {
  count = "${var.eip_static ? 1 : 0}"
  vpc   = true
}
