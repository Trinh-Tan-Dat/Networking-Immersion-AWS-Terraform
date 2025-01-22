module "simple_bucket" {
  # source = "terraform-aws-modules/s3-bucket/aws"
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket.git?ref=5b71671533487eec264152701a8e1d11a3113ea9"
  bucket = "my-s3-bucket-blabla"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}