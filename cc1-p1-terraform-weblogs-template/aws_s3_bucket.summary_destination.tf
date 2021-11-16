# Create a S3 bucket - destination of the data pipeline
resource "aws_s3_bucket" "summary_destination" {
  bucket = "analytics-destination-idir-hamdis"
  acl    = "private"

  tags = {
    Name        = "S3 bucket Idir"
    Environment = "test"
  }
}