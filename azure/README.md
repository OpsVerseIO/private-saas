# Azure Private SaaS Template
A template for creating an Azure Kubernetes Service (AKS) cluster as part of Private SaaS deployment.

## Getting Started

### Prerequisites
- Download and install the latest Terraform binary from [Terraform Downloads](https://www.terraform.io/downloads).
- The Azure Resource Group for storing the Terraform state must be created prior to initiating the cluster creation process, and the values in `backend.tf`should be updated accordingly
- A Storage Account and containers should be created in Azure. Also update the relevant values in `backend.tf`.
- Azure CLI installed and configured.


> [!IMPORTANT]
> **Note**: The Terraform version should be `1.3.x` or higher.

### Permissions
Ensure that the service principal or user running this Terraform code has **Owner** permission or at least **Cloud Application Administrator** role.

### Environment Variables
Before proceeding, set the following environment variables with the appropriate values for your Azure setup:
```bash
export ARM_CLIENT_ID="00000000-0000-0000-0000-000000000000"
export ARM_CLIENT_SECRET="12345678-0000-0000-0000-000000000000"
export ARM_TENANT_ID="10000000-0000-0000-0000-000000000000"
export ARM_SUBSCRIPTION_ID="20000000-0000-0000-0000-000000000000"

For more information, refer to the Terraform Azure Provider Documentation.{https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret#creating-a-service-principal}

### Steps to create the cluster
```
> [!NOTE]
> This template offers 2 Public Subnets and 2 Private Subnets by default. This can be changed as per the requirements.

**Step 1:** Navigate to `opsverse-aks` directory and execute the following command:
```bash
terraform init
```
**Step 3:** Update all the variables that are required to create the cluster to a file called `vars.tfvars` file based on your environment.

**Step 4:** Create an execution plan which lets you preview the changes that Terraform plans to make to your infrastructure. Execute the following command to prepare the plan and write to a file:
```bash
terraform plan -var-file=vars.tfvars -out aks-plan.tfplan
```

The above command prepares the execution plan by reading the variables/config from `vars.tfvars`` file and writes the plan to the given path (_in this case it writes the plan to main.tfplan file_). This can be used as input to the apply command.


**Step 5:** Provision the AKS cluster. Execute the following command:
```bash
terraform apply "aks-plan.tfplan"
```
The above command executes the prepared plan which actually creates the cluster in AKS.

Your AKS cluster should be ready to use!


