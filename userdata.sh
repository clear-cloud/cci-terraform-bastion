#!/bin/sh
#
# Install AWSCLI
#
yum install awscli -y
#
# Setup DNS record update
#
PUBLICIP=$(curl -s 'http://169.254.169.254/latest/meta-data/public-ipv4')
cat << EOF > /root/dns_update.json
{"Comment": "Bastion DNS record update","Changes":[{"Action":"UPSERT","ResourceRecordSet":{"Name":"${hostname}.${dns_domain_name}","Type":"A","TTL":300,"ResourceRecords":[{"Value":"$PUBLICIP"}]}}]}
EOF
#
# Update DNS record
#
aws route53 change-resource-record-sets --hosted-zone-id ${hosted_zone_id} --change-batch file:///root/dns_update.json
#
# Set hostname
#
hostname ${hostname}.${dns_domain_name}
hostnamectl set-hostname ${hostname}.${dns_domain_name}
#
# Update host
#
yum update -y
#
# Setup SSM Agent
#
yum install amazon-ssm-agent python-deltarpm -y
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent
echo "systemctl start amazon-ssm-agent" >> /etc/rc.local
#
# Setup data volume
#
/usr/sbin/mkfs.ext4 /dev/xvdf
/usr/bin/mkdir /xvdf
/usr/bin/mount /dev/xvdf /xvdf
/usr/bin/echo "/dev/xvdf /xvdf ext4 defaults 0 0" >> /etc/fstab
