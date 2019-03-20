variable "alarm_topic_arn" {
  description = "Topic ARN to send ASG event notifcations to"
  default     = ""
}

variable "notifications" {
  description = "Enable / Disable ASG Event notifications"
  default     = "false"
}

variable "hosted_zone_id" {
  description = "Variable for Hosted zone id, eg Z2XXOVXYYGMD12"
}

variable "health_check_grace_period" {
  description = "Health check Grace period for ASG"
  default     = "120"
}

variable "health_check_type" {
  default = "EC2"
}

variable "hostname" {
  default = "bastion"
}

variable "dns_domain_name" {
  description = "DNS domain name the host will be part of. eg dev.domain.io"
}

variable "ebs_optimized" {
  description = "Sets ebs optimised for ec2 instance if required"
  default     = "false"
}

variable "environment" {
  description = "The environment the Bastion will be part of, eg, DEV, UAT or PROD"
}

variable "key_name" {
  description = "Initial Key used to build the host"
}

variable "enable_monitoring" {
  description = "Enables / disables detailed monitoring"
  default     = "false"
}

variable "instance_type" {
  description = "ec2 instance type"
  default     = "t3.micro"
}

variable "image_id" {
  description = "AMI to use"
}

variable "volume_type" {
  description = "ec2 volume type"
  default     = "gp2"
}

variable "orchestration" {
  description = "Link to orchestration used for the build, eg link to git repository"
}

variable "max_size" {
  description = "ASG maximum size"
  default     = "1"
}

variable "min_size" {
  description = "ASG minimum size"
  default     = "1"
}

variable "desired_capacity" {
  description = "ASG desired size"
  default     = "1"
}

variable "volume_size" {
  description = "ec2 Volume size"
  default     = "30"
}

variable "security_groups" {
  description = "Security Group to associate with the lanuch config and ec2 instance"
}

variable "vpc_zone_identifier" {
  description = "A list of subnet IDs to launch resources in"
}

variable "aws_ssm_iam_arn" {
  default = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

variable "vol2_availability_zone" {}

variable "vol2_size" {
  default = "100"
}
