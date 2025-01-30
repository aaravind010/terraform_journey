resource "aws_s3_bucket" "sam_s3_2" {
  bucket = "terra-s3-aravind010-11"
}

resource "aws_s3_bucket_public_access_block" "public_block" {
  bucket = aws_s3_bucket.sam_s3_2.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "web_site_2" {
  bucket = aws_s3_bucket.sam_s3_2.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "s3_object_upload" {
  bucket       = aws_s3_bucket.sam_s3_2.id
  for_each     = fileset("html/", "*")
  key          = each.value
  source       = "html/${each.value}"
  etag         = filemd5("html/${each.value}")
  content_type = "text/html"
}


resource "aws_s3_bucket_policy" "aws_s3_bucket_policy_2" {
  bucket = aws_s3_bucket.sam_s3_2.id
  policy = <<EOF
  {
  "Id": "Policy1738210474712",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1738210472312",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::terra-s3-aravind010-11/*",
      "Principal": "*"
    }
  ]
}
EOF
}
