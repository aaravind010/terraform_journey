# CREATE IAM USER
resource "aws_iam_user" "akan" {
  name = "akan"

  tags = {
    Name = "AKAN"
    ROLE = "Devploper"
  }
}

# CREATE ACCESS ANCD SECRET KEY FOR THE USER
resource "aws_iam_access_key" "akan_access_key" {
  user = aws_iam_user.akan.name
}

output "iam_access_key_id" {
  value     = aws_iam_access_key.akan_access_key.id
  sensitive = true
}

output "iam_secret_key" {
  value     = aws_iam_access_key.akan_access_key.secret
  sensitive = true
}

locals {
  akan_keys_csv = "access_key,secret_key\n${aws_iam_access_key.akan_access_key.id},${aws_iam_access_key.akan_access_key.secret}"
}

resource "local_file" "akan_keys" {
  filename = "akan_keys.csv"
  content  = local.akan_keys_csv
}

resource "aws_iam_group" "devops" {
  name = "devops"
}

resource "aws_iam_group_membership" "devops" {
  name  = aws_iam_group.devops.name
  users = [aws_iam_user.akan.name]
  group = aws_iam_group.devops.name
}

data "aws_iam_policy" "rdsfull" {
  arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

data "aws_iam_policy_document" "ec2_custom" {
  statement {
    actions = [
      "ec2:StartInstances",
      "ec2:StopInstances"
    ]
    resources = [
      "arn:aws:ec2:*:*:instance/*"
    ]
  }
}

resource "aws_iam_policy" "ec2_instance" {
  name   = "ec2-instance-actions"
  policy = data.aws_iam_policy_document.ec2_custom.json
}

resource "aws_iam_group_policy_attachment" "rdsfull-akan" {
  policy_arn = data.aws_iam_policy.rdsfull.arn
  group      = aws_iam_group.devops.name
}

resource "aws_iam_group_policy_attachment" "ec2_custom-akan" {
  policy_arn = aws_iam_policy.ec2_instance.arn
  group      = aws_iam_group.devops.name
}

resource "aws_iam_role" "CWA-role" {
  name = "terra-cwa-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cwa-role-attach" {
  role       = aws_iam_role.CWA-role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}