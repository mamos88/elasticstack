resource "aws_instance" "elasticsearch-server-node" {
  depends_on = [ aws_efs_file_system.elasticsearch, aws_efs_mount_target.elasticsearch_mount_target ]
  count                       = var.elasticsearch_server_count
  ami                         = var.elasticsearch_server_ami_id
  instance_type               = var.elasticsearch_server_instance_type
  key_name                    = var.aws_key_name
  subnet_id                   = aws_subnet.elasticsearch-lab-pub[count.index].id
  vpc_security_group_ids      = [aws_security_group.elasticsearch-sg.id]
  associate_public_ip_address = true
  user_data                   = base64encode(<<-EOF
        #!/bin/bash
        echo "Mounting EFS file system"
        mkdir /var/lib/elasticsearch
        yum install -y amazon-efs-utils
        mount -t efs ${aws_efs_file_system.elasticsearch.id}:/ /var/lib/elasticsearch
        echo "${aws_efs_file_system.elasticsearch.id}:/ /var/lib/elasticsearch efs defaults,_netdev 0 0" >> /etc/fstab
        EOF
     )
  private_ip                  = "10.0.${count.index}.100"

  tags = {
    Terraform     = "true"
    Name          = "elasticsearch-server-${count.index + 1}"
    ManagedBy     = "Terraform"
  }
}