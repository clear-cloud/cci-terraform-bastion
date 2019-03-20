# ----------------------------
# Bastion EC2 Instance Profile
# ----------------------------
resource "aws_iam_instance_profile" "bastion_instance_profile" {
  name = "${var.environment}_bastion_instance_profile"
  role = "${aws_iam_role.bastion_role.name}"
}

# ----------------
# Bastion EC2 Role
# ----------------
resource "aws_iam_role" "bastion_role" {
  name = "${var.environment}_bastion_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# ---------------------------------
# Attach Bastion Policy to Role
# ---------------------------------
resource "aws_iam_role_policy_attachment" "bastion_attach_ec2_policy" {
  role       = "${aws_iam_role.bastion_role.name}"
  policy_arn = "${aws_iam_policy.bastion_policy.arn}"
}

# ------------------
# Bastion IAM Policy
# ------------------
resource "aws_iam_policy" "bastion_policy" {
  name        = "${var.environment}_bastion_policy"
  path        = "/"
  description = "${var.environment} Bastion IAM Policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1477071439000",
      "Effect": "Allow",
      "Action": [
        "route53:ChangeResourceRecordSets"
      ],
      "Resource": [
        "arn:aws:route53:::hostedzone/${var.hosted_zone_id}"
      ]
    }
  ]
}
EOF
}

# ---------------------------------
# Attach AWS SSM IAM Policy to Role
# ---------------------------------
resource "aws_iam_role_policy_attachment" "bastion_attach_ssm_policy" {
  role       = "${aws_iam_role.bastion_role.name}"
  policy_arn = "${var.aws_ssm_iam_arn}"
}
