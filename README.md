###
terraform workspace switches between different states, because the state for environments like Dev and Prod should be separated.
###
terraform fmt ensures uniform coding style, as different people may have different coding styles when writing Terraform.
###
terraform import allows you to import existing resources that were manually created in the cloud into Terraform.
###
terraform validate checks for syntax errors.
###
terraform plan lets you see what changes Terraform will make before actually executing them.
###
terraform apply creates or modifies the cloud infrastructure.

### How to use this Terraform

# Authenticate using the Azure CLI
az login
az account set --subscription "subscription-id"


# OR


# Create a Service Principal
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"


# terraform plan
terraform plan -var-file="secrets.tfvars"


# terraform apply
terraform apply -var-file="secrets.tfvars"


# terraform apply auto-approve
terraform apply -var-file="secrets.tfvars" -auto-approve


# terraform destroy
terraform destroy -var-file="secrets.tfvars"


# terraform destroy auto-approve
terraform destroy -var-file="secrets.tfvars" -auto-approve