# terraform-aws-gha-deploy

Depends on existing IAM OIDC connection to https://token.actions.githubusercontent.com.

Outputs the Role ARN.

## Example Usage

```yaml
jobs:
  runs-on: ubuntu-latest
  permissions:
    id-token: write
    contents: read
  env:
    TF_IN_AUTOMATION: true
  deploy:
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - uses: hashicorp/setup-terraform@v2
        with:
          cli_config_credentials_token: ${{ secrets.TF_API_TOKEN }}
          terraform_wrapper: false
      - name: Run `terraform init`
        run: terraform init -input=false

      - name: Setup Environment
        id: aws
        run: |
          AWS_REGION="$(terraform output -raw aws_region)"
          AWS_ROLE="$(terraform output -raw ci_aws_role)"
          echo "aws_region=$AWS_REGION" >> $GITHUB_OUTPUT
          echo "aws_role=$AWS_ROLE" >> $GITHUB_OUTPUT

      - uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-region: ${{ steps.aws.outputs.aws_region }}
          role-to-assume: ${{ steps.aws.outputs.aws_role }}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.ci_deploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_openid_connect_provider.github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_openid_connect_provider) | data source |
| [aws_iam_policy_document.odic_trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | n/a | yes |
| <a name="input_default_branch"></a> [default\_branch](#input\_default\_branch) | Default repo branch | `string` | `"master"` | no |
| <a name="input_github_repo"></a> [github\_repo](#input\_github\_repo) | GitHub repository | `string` | n/a | yes |
| <a name="input_policy"></a> [policy](#input\_policy) | AWS IAM Policy document | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The project identifier to use for this website | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region"></a> [aws\_region](#output\_aws\_region) | AWS Region |
| <a name="output_aws_role"></a> [aws\_role](#output\_aws\_role) | AWS Role to Assume |
<!-- END_TF_DOCS -->
