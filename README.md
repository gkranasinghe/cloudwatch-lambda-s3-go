## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.cloudwatch_export](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_role.cloudwatch_export](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.cloudwatch_export](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_lambda_function.cloudwatch_export](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.events](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [archive_file.lambda_my_function](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_iam_policy_document.cloudwatch_export_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudwatch_export_inline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_exporter_version"></a> [exporter\_version](#input\_exporter\_version) | Version of the cloudwatch-exporter to deploy. Defaults to the latest version available | `string` | `"0.0.2"` | no |
| <a name="input_log_group"></a> [log\_group](#input\_log\_group) | Name of Cloudwatch Log Group to export to S3 | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | short description of the logs you're exporting | `string` | `"cloudwatch-export"` | no |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | bucket logs will be put into | `any` | n/a | yes |
| <a name="input_s3_prefix"></a> [s3\_prefix](#input\_s3\_prefix) | prefix for your logs | `string` | `"cloudwatch-export"` | no |
| <a name="input_schedule"></a> [schedule](#input\_schedule) | CloudWatch schedule for export | `string` | `"cron(15 12 * * ? *)"` | no |

## Outputs

No outputs.
