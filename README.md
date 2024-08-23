This is a [No-Code ready Module](https://developer.hashicorp.com/terraform/cloud-docs/no-code-provisioning/module-design) that creates the following AWS resources:
* a Lambda function
* an S3 bucket to store the function code, with placeholder code
* an API gateawy
* an IAM role for the function
* a CloudWatch log group

And the following GitHub resources
* a GitHub repo based off of [this template repository](https://github.com/nphilbrook/lambda-function-template)
* 2 [GitHub Actions variables](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/store-information-in-variables) to reference the S3 Bucket and the Lambda function itself

That GitHub repo has configuration for an Action that will update the Lambda with new code, using the S3 bucket

This No-code module includes no provider credentials (AWS or Github).

Assumptions/requirements:
* AWS credentials must be provided to the workspace provisioned by this module (ideally in a HCP Terraform Variable Set). I recommend [Workload Identity](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/dynamic-provider-credentials/aws-configuration))
* GitHub credentiials must also be made available to the workspace, a `GITHUB_TOKEN` environment variable in a Variable Set works.
* The templated Github Actions YAML in the above repository has a hardcoded AWS account ID - which must be the same as the account used by this module. This should also be abstracted away and set in an additional github_actions_variable resource.
