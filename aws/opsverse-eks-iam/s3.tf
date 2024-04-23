##############
# Loki storage buckets
##############

module "s3_bucket_opsverse" {
  source = "../modules/s3"

  bucket_name = "opsverse-bucket"
  bucket_tags = {
    Name        = "opsverse-bucket"
    Environment = "production"
  }
}

