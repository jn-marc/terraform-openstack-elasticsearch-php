data "template_file" "install_front" {
  template = <<EOF
#!/bin/bash
set -x
yum -y install epel-release
yum -y install https://rhel7.iuscommunity.org/ius-release.rpm
yum install -y gcc openssl-devel python-pip python-virtualenv jq git
yum -y install mod_php71u httpd24u php71u-cli php71u-common php71u-json unzip


cd /tmp
virtualenv openstack
source openstack/bin/activate
pip install python-openstackclient

cat > /root/os_credentials <<OS_CREDENTIALS
export OS_AUTH_URL=$${openstack_auth_url}
export OS_PROJECT_NAME="$${openstack_project}"
export OS_USER_DOMAIN_NAME="Default"
export OS_USERNAME="$${openstack_username}"
export OS_PASSWORD=$${openstack_password}
export OS_REGION_NAME="regionOne"
export OS_IDENTITY_API_VERSION=3
OS_CREDENTIALS
chmod 600 /root/os_credentials


[ -d /var/www/html ] && rm -rf /var/www/html
git clone https://github.com/jn-marc/demo-php-elasticsearch.git /var/www/html

cd /var/www/html
export COMPOSER_HOME=/var/www/html
curl -s http://getcomposer.org/installer | /bin/php

/bin/php composer.phar install --no-dev

source /root/os_credentials
echo "<?php \$hosts = [" > es_hosts.php
openstack server list --name demo_es -f value -c Networks | awk -F'=' '{print "\""$2"\","}' >> es_hosts.php
echo "]; ?>" >> es_hosts.php

# SELinux : Allow httpd to connect to port 9200
semanage port -a -p tcp -t http_port_t 9200

systemctl enable httpd
systemctl start httpd

EOF

  vars {
    openstack_username = "${var.openstack_username}"
    openstack_password = "${var.openstack_password}"
    openstack_project  = "${var.openstack_project}"
    openstack_auth_url = "${var.openstack_auth_url}"
  }
}

data "template_cloudinit_config" "front" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.install_front.rendered}"
  }
}
