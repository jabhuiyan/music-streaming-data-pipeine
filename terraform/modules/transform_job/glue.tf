# For the `"aws_glue_catalog_database" "transform_db"` resource, set the name to `var.catalog_database`
resource "aws_glue_catalog_database" "transform_db" {
  name        = None.None
  description = "Glue Catalog database for transformations"
}


# For the resource `"aws_glue_job" "json_transformation_job"` add the script location and parameters to the `default_arguments` configuration
resource "aws_glue_job" "json_transformation_job" {
  name         = "${var.project}-json-transform-job"
  role_arn     = var.glue_role_arn
  glue_version = "4.0"
  command {
    name            = "glueetl"
    # Use the scripts_bucket variable and `de-c4w4a1-transform-json-job.py` as the object key
    script_location = "s3://${None.None}/None"
    python_version  = 3
  }

  default_arguments = {
    "--enable-job-insights"     = "true"
    "--job-language"            = "python"
    # Set `"--catalog_database"` to `aws_glue_catalog_database.transform_db.name`
    "--catalog_database"        = None.None.None
    # Set "--ingest_date" to the server's current date in Pacific Time (UTC-7), in "yyyy-mm-dd" format.
    # (replace the placeholder `<PACIFIC-TIME-CURRENT-DATE>`)
    "--ingest_date"             = "<PACIFIC-TIME-CURRENT-DATE>"
    # Review the users source path
    "--users_source_path"       = "s3://${var.data_lake_bucket}/landing_zone/api/users/"
    # Review the sessions source path
    "--sessions_source_path"    = "s3://${var.data_lake_bucket}/landing_zone/api/sessions/"
    # Review the target bucket path
    "--target_bucket_path"      = "${var.data_lake_bucket}"
    # Set `"--users_table"` to `var.users_table`
    "--users_table"             = None.None
    # Set `"--sessions_table"` to `var.sessions_table`
    "--sessions_table"          = None.None
    # Set `"--datalake-formats"` to `"iceberg"`
    "--datalake-formats"        = "None"
    "--enable-glue-datacatalog" = true

  }

  timeout = 5

  number_of_workers = 2
  worker_type       = "G.1X"
}

# Add the script location and review the default arguments configuration in the `"aws_glue_job" "json_transformation_job"` resource
resource "aws_glue_job" "songs_transformation_job" {
  name         = "${var.project}-songs-transform-job"
  role_arn     = var.glue_role_arn
  glue_version = "4.0"

  command {
    name            = "glueetl"
    # Use the scripts_bucket variable and `de-c4w4a1-transform-songs-job.py` as the object key
    script_location = "s3://${None.None}/None"
    python_version  = 3
  }

  default_arguments = {
    "--enable-job-insights"     = "true"
    "--job-language"            = "python"
    "--catalog_database"        = aws_glue_catalog_database.transform_db.name
    # Set "--ingest_date" to the server's current date in Pacific Time (UTC-7), in "yyyy-mm-dd" format.
    # (replace the placeholder `<PACIFIC-TIME-CURRENT-DATE>`)
    "--ingest_date"             = "<PACIFIC-TIME-CURRENT-DATE>"
    "--source_bucket_path"      = "${var.data_lake_bucket}"
    "--target_bucket_path"      = "${var.data_lake_bucket}"
    "--songs_table"             = var.songs_table
    "--datalake-formats"        = "iceberg"
    "--enable-glue-datacatalog" = true

  }

  timeout = 5

  number_of_workers = 2
  worker_type       = "G.1X"
}
