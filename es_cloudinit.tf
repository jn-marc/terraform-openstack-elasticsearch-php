data "template_file" "es" {
  template = <<EOF
#!/bin/bash
yum -y install epel-release
yum install -y gcc openssl-devel python-pip python-virtualenv jq java-1.8.0-openjdk

rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch



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


yum -y install elasticsearch
cat > /etc/yum.repos.d/elasticsearch.repo <<REPO
[elasticsearch-6.x]
name=Elasticsearch repository for 6.x packages
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
REPO
yum -y install elasticsearch
/bin/systemctl daemon-reload
/bin/systemctl enable elasticsearch.service


cat > /etc/elasticsearch/elasticsearch.yml <<ES_CONF
cluster.name: "my_cluster"
path.data: /var/lib/elasticsearch
path.logs: /var/log/elasticsearch
network.host: 0.0.0.0
discovery.zen.hosts_provider: file
ES_CONF

source /root/os_credentials
openstack server list --name demo_es -f value -c Networks | cut -d= -f2 > /etc/elasticsearch/unicast_hosts.txt

/bin/systemctl restart elasticsearch.service
EOF

  vars {
    openstack_username = "${var.openstack_username}"
    openstack_password = "${var.openstack_password}"
    openstack_project  = "${var.openstack_project}"
    openstack_auth_url = "${var.openstack_auth_url}"
  }
}

data "template_cloudinit_config" "es" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.es.rendered}"
  }
}
