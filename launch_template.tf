# Elasticsearch data_hot Launch Template
resource "aws_launch_template" "ElasticsearchDataHotLC" {
    name = "ElasticsearchDataHotLC"

    description = "Elasticsearch Amazon Linux Data Hot Launch Template"
    image_id = var.elasticsearch_client_amazon_ami_id
    instance_type = var.client_instance_type
    key_name = var.aws_key_name
    vpc_security_group_ids = [aws_security_group.elasticsearch-sg.id]
    user_data = base64encode(<<-EOF
        #!/bin/bash
        mkdir /var/lib/elasticsearch
        yum install -y amazon-efs-utils
        mount -t efs ${aws_efs_file_system.elasticsearch.id}:/ /var/lib/elasticsearch
        echo "${aws_efs_file_system.elasticsearch.id}:/ /var/lib/elasticsearch efs defaults,_netdev 0 0" >> /etc/fstab
        docker run -d --name elasticsearch-data-hot-$HOSTNAME -p 9200:9200 -p 9300:9300 -e "ELASTIC_PASSWORD=${var.password}" -e "node.name=data-hot-$HOSTNAME" -e "network.publish_host=$HOSTNAME" mamos88/elasticsearch-data-hot-v3
        EOF
     )
}

# Elasticsearch data_warm Launch Template
resource "aws_launch_template" "ElasticsearchDataWarmLC" {
    name = "ElasticsearchDataWarmLC"

    description = "Elasticsearch Amazon Linux Data Warm Launch Template"
    image_id = var.elasticsearch_client_amazon_ami_id
    instance_type = var.client_instance_type
    key_name = var.aws_key_name
    vpc_security_group_ids = [aws_security_group.elasticsearch-sg.id]
    user_data = base64encode(<<-EOF
        #!/bin/bash
        mkdir /var/lib/elasticsearch
        yum install -y amazon-efs-utils
        mount -t efs ${aws_efs_file_system.elasticsearch.id}:/ /var/lib/elasticsearch
        echo "${aws_efs_file_system.elasticsearch.id}:/ /var/lib/elasticsearch efs defaults,_netdev 0 0" >> /etc/fstab
        docker run -d --name elasticsearch-data-warm-$HOSTNAME -p 9200:9200 -p 9300:9300 -e "ELASTIC_PASSWORD=${var.password}" -e "node.name=data-warm-$HOSTNAME" -e "network.publish_host=$HOSTNAME" mamos88/elasticsearch-data-warm-v3
        EOF
     )
}
# Elasticsearch data_cold Launch Template
resource "aws_launch_template" "ElasticsearchDataColdLC" {
    name = "ElasticsearchDataColdLC"

    description = "Elasticsearch Amazon Linux Data Cold Launch Template"
    image_id = var.elasticsearch_client_amazon_ami_id
    instance_type = var.client_instance_type
    key_name = var.aws_key_name
    vpc_security_group_ids = [aws_security_group.elasticsearch-sg.id]
    user_data = base64encode(<<-EOF
        #!/bin/bash
        mkdir /var/lib/elasticsearch
        yum install -y amazon-efs-utils
        mount -t efs ${aws_efs_file_system.elasticsearch.id}:/ /var/lib/elasticsearch
        echo "${aws_efs_file_system.elasticsearch.id}:/ /var/lib/elasticsearch efs defaults,_netdev 0 0" >> /etc/fstab
        docker run -d --name elasticsearch-data-cold-$HOSTNAME -p 9200:9200 -p 9300:9300 -e "ELASTIC_PASSWORD=${var.password}" -e "node.name=data-cold-$HOSTNAME" -e "network.publish_host=$HOSTNAME" mamos88/elasticsearch-data-cold-v3
        EOF
     )
}

# Elasticsearch data_content Launch Template
resource "aws_launch_template" "ElasticsearchDataContentLC" {
    name = "ElasticsearchDataContentLC"

    description = "Elasticsearch Amazon Linux Data Content Launch Template"
    image_id = var.elasticsearch_client_amazon_ami_id
    instance_type = var.client_instance_type
    key_name = var.aws_key_name
    vpc_security_group_ids = [aws_security_group.elasticsearch-sg.id]
    user_data = base64encode(<<-EOF
        #!/bin/bash
        mkdir /var/lib/elasticsearch
        yum install -y amazon-efs-utils
        mount -t efs ${aws_efs_file_system.elasticsearch.id}:/ /var/lib/elasticsearch
        echo "${aws_efs_file_system.elasticsearch.id}:/ /var/lib/elasticsearch efs defaults,_netdev 0 0" >> /etc/fstab
        docker run -d --name elasticsearch-data-content-$HOSTNAME -p 9200:9200 -p 9300:9300 -e "ELASTIC_PASSWORD=${var.password}" -e "node.name=data-content-$HOSTNAME" -e "network.publish_host=$HOSTNAME" mamos88/elasticsearch-data-content-v3
        EOF
     )
}

# Kibana Launch Template
resource "aws_launch_template" "KibanaLC" {
    name = "KibanaLC"

    description = "Kibana Amazon Linux Launch Template"
    image_id = var.elasticsearch_client_amazon_ami_id
    instance_type = var.client_instance_type
    key_name = var.aws_key_name
    vpc_security_group_ids = [aws_security_group.elasticsearch-sg.id]
    user_data = base64encode(<<-EOF
        #!/bin/bash
        mkdir /var/lib/elasticsearch
        yum install -y amazon-efs-utils
        mount -t efs ${aws_efs_file_system.elasticsearch.id}:/ /var/lib/elasticsearch
        echo "${aws_efs_file_system.elasticsearch.id}:/ /var/lib/elasticsearch efs defaults,_netdev 0 0" >> /etc/fstab
        docker run -d --name kibana-$HOSTNAME -p 5601:5601 mamos88/kibana-v2
        EOF
     )
}

# Logstash Launch Template
resource "aws_launch_template" "LogstashLC" {
    name = "LogstashLC"

    description = "Logstash Amazon Linux Launch Template"
    image_id = var.elasticsearch_client_amazon_ami_id
    instance_type = var.client_instance_type
    key_name = var.aws_key_name
    vpc_security_group_ids = [aws_security_group.elasticsearch-sg.id]
    user_data = base64encode(<<-EOF
        #!/bin/bash
        mkdir /var/lib/elasticsearch
        yum install -y amazon-efs-utils
        mount -t efs ${aws_efs_file_system.elasticsearch.id}:/ /var/lib/elasticsearch
        echo "${aws_efs_file_system.elasticsearch.id}:/ /var/lib/elasticsearch efs defaults,_netdev 0 0" >> /etc/fstab
        mkdir -p /tmp/testlogs
        docker run -d --name -v /tmp/testlogs:/tmp/testlogs logstash-$HOSTNAME mamos88/logstash-v3
        EOF
     )
}