resource "aws_s3_bucket" "artifactrepo" {
  bucket = "${var.bucket_name}"
 
}