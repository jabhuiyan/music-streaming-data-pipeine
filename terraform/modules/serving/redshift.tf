# Complete the parameters for the resource `"redshift_schema" "serving_schema"`
resource "redshift_schema" "serving_schema" {
  # Set the schema name to `"deftunes_serving"`
  name  = "None"
  # Set the owner to `var.redshift_user`
  owner = None.None
  quota = 50
}

# External schema using AWS Glue Data Catalog
# Complete the parameters for the `"redshift_schema" "transform_external_from_glue_data_catalog"` resource
resource "redshift_schema" "transform_external_from_glue_data_catalog" {
  # Set the name to `"deftunes_transform"`
  name  = "None"
  # The owner will be the same as for the previous schema `var.redshift_user`
  owner = None.None
  external_schema {
    # Set the database name to `var.catalog_database`
    database_name = None.None
    data_catalog_source {
      # Set `iam_role_arns` to a list with the following element `data.aws_iam_role.redshift_spectrum_role.arn`
      iam_role_arns = [
        None.None.None.None
      ]
      create_external_database_if_not_exists = true
    }
  }
}
