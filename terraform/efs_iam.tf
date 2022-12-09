
resource "aws_iam_policy" "efs-policy" {
  name        = "efs-policy"
  path        = "/"
  description = "Policy for efs provisioning"

  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "elasticfilesystem:DescribeAccessPoints",
        "elasticfilesystem:DescribeFileSystems",
        "elasticfilesystem:DescribeMountTargets",
        "ec2:DescribeAvailabilityZones"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "elasticfilesystem:CreateAccessPoint"
      ],
      "Resource": "*",
      "Condition": {
        "StringLike": {
          "aws:RequestTag/efs.csi.aws.com/cluster": "true"
        }
      }
    },
    {
      "Effect": "Allow",
      "Action": "elasticfilesystem:DeleteAccessPoint",
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "aws:ResourceTag/efs.csi.aws.com/cluster": "true"
        }
      }
    }
  ]
})
}

resource "aws_iam_role" "efs-role" {
  name = "${var.project}-efs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Federated = aws_iam_openid_connect_provider.eks-oidc.arn
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEFSPolicy" {
  policy_arn = aws_iam_policy.efs-policy.arn
  role       = aws_iam_role.efs-role.name
}

resource "aws_security_group" "efs-sg" {
  name        = "${var.project}-efs-sg"
  description = "Cluster communication with efs"
  vpc_id      = aws_vpc.vpc-dev.id
  ingress {
    from_port = 2049
    protocol  = "tcp"
    to_port   = 2049
    cidr_blocks = [aws_vpc.vpc-dev.cidr_block]
  }
  tags = var.tags
}