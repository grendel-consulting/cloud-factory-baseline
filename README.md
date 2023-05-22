# Cloud Factory (Global) Baseline

Definitions for use with the Account Factory for Terraform (AFT) framework. Global Customizations are used to customize **all** provisioned accounts with customer defined resources. The resources can be created through Terraform or through Python, leveraging the API helpers. The customization run is parameterized at runtime.

## Usage

### Terraform

You can see AFT-provided Jinja templates for the Terraform backend and providers. These are rendered at the time the Terraform is applied. Further providers can be defined by creating a `providers.tf` file, as needed.

Define your own Terraform resources, placing `.tf` files in the 'terraform' directory or as submodules to it.

### API Helpers

Define any scripts that need to run before/after Terraform using the bash entry points. You can extend these to run Python scripts or to perform other actions, such as leveraging the AWS CLI.

Within the `api_helpers/python` folder is a requirements.txt, where you can specify packages to be installed via PIP.

## Deployment

Deployment must presently be triggered manually - and should be across the whole AWS Organization - through [re-invoking an AWS Step Function](https://docs.aws.amazon.com/controltower/latest/userguide/aft-account-customization-options.html#aft-re-invoke-customizations) in the factory management OU.

## Further Reading

See: [AFT Global Customizations](https://github.com/aws-ia/terraform-aws-control_tower_account_factory/tree/main/sources/aft-customizations-repos/aft-global-customizations)
