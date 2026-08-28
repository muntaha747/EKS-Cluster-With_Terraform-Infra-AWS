terraform {
  backend "s3" {
    bucket       = "muntaha-tf-modules-state-file"
    key          = "EKS-Project/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}

resource "aws_s3_bucket" "muntaha-tf-modules-state-file" {
  bucket = "muntaha-tf-modules-state-file"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.muntaha-tf-modules-state-file.id
  versioning_configuration {
    status = "Enabled"
  }
}

