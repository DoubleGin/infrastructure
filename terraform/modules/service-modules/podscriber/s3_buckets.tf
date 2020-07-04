resource "aws_s3_bucket" "excerpts" {
  bucket = "oddmark-excerpts-${var.environment}"
  acl    = "private"

  tags = {
    Environment = var.environment
  }
}

resource "aws_s3_bucket" "transcripts" {
  bucket = "oddmark-transcripts-${var.environment}"
  acl    = "private"

  tags = {
    Environment = var.environment
  }
}
