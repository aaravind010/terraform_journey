resource "aws_s3_bucket" "terra_s3" {
  bucket = "terra-s3-aravind010"

}

resource "aws_s3_bucket_website_configuration" "blog" {
  bucket = aws_s3_bucket.terra_s3.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "Public_access_block" {
  bucket                  = aws_s3_bucket.terra_s3.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_object" "objecct" {
  bucket       = aws_s3_bucket.terra_s3.id
  for_each     = fileset("html/", "*")
  key          = each.value
  source       = "html/${each.value}"
  etag         = filemd5("html/${each.value}")
  content_type = "text/html"
}

