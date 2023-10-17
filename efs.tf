resource "aws_efs_file_system" "elasticsearch" {
  creation_token = "elasticsearch"

  tags = {
    Name = "elasticsearch-efs"
  }
}

resource "aws_efs_mount_target" "elasticsearch_mount_target" {
  count = var.subnet_count
  file_system_id = aws_efs_file_system.elasticsearch.id
  subnet_id = values(local.subnet_ids)[count.index]
  security_groups = [aws_security_group.elasticsearch-sg.id]
}

output "efs_file_system_id" {
  value = aws_efs_file_system.elasticsearch.id
}