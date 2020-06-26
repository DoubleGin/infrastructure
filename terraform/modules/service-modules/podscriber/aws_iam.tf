resource "aws_iam_user" "podscriber" {
  name = "podscriber"
}

resource "aws_iam_access_key" "podscriber" {
  user = aws_iam_user.podscriber.name
}

data "aws_iam_policy_document" "podscriber" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.podcasts.bucket}",
      "arn:aws:s3:::${aws_s3_bucket.podcasts.bucket}/*",
      "arn:aws:s3:::${aws_s3_bucket.excerpts.bucket}",
      "arn:aws:s3:::${aws_s3_bucket.excerpts.bucket}/*",
      "arn:aws:s3:::${aws_s3_bucket.transcripts.bucket}",
      "arn:aws:s3:::${aws_s3_bucket.transcripts.bucket}/*",
    ]
  }

  statement {
    actions = [
      "transcribe:*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "podscriber" {
  name   = "podscriber"
  path   = "/"
  policy = data.aws_iam_policy_document.podscriber.json
}

resource "aws_iam_user_policy_attachment" "podscriber" {
  user       = aws_iam_user.podscriber.name
  policy_arn = aws_iam_policy.podscriber.arn
}
