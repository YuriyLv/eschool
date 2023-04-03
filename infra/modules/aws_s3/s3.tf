#____________________________________________S3
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.state_bucket
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Name = "${var.environment_name} State bucket"
  }
}

#____________________________________________Versioning
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = var.state_bucket
  versioning_configuration {
    status = "Enabled"
  }
}

#____________________________________________Encripting
resource "aws_s3_bucket_server_side_encryption_configuration" "state_bucket" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

#____________________________________________Privacy
resource "aws_s3_bucket_acl" "state_bucket_acl" {
  bucket = aws_s3_bucket.terraform_state.id
  acl    = "private"
}

#____________________________________________Lock public access
resource "aws_s3_bucket_public_access_block" "state_bucket" {
  bucket                   = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
