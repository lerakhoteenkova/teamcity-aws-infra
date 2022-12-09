resource "aws_efs_file_system" "teamcity-data" {
  creation_token = "efs"

  tags = var.tags
}

resource "aws_efs_mount_target" "tc-efs-target" {
  count = var.availability_zones_count
  file_system_id = aws_efs_file_system.teamcity-data.id
  subnet_id      = aws_subnet.private[count.index].id
}

resource "aws_efs_replication_configuration" "efs-rc" {
  source_file_system_id = aws_efs_file_system.teamcity-data.id

  destination {
    region = var.region
  }
}

resource "aws_efs_access_point" "k8s" {
  file_system_id = aws_efs_file_system.teamcity-data.id
}
