# ---------------------------------------
# s3 Bucket
# ---------------------------------------

resource "aws_s3_bucket" "bastiondata" {
  bucket_prefix = "${var.environment}-bastion-"
  acl           = "private"
  versioning {
    enabled = "true"
  }


  tags = {
    Environment   = "${var.environment}"
    orchestration = "${var.orchestration}"
    purpose       = "${var.environment}-bastion-data"
  }
}
