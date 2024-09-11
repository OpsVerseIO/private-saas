# GCP Private SaaS Template
A template for creating GKE cluster as part of Private SaaS deployment.

## Getting Started

### Prerequisites
Download the latest terraform binary from https://www.terraform.io/downloads and install.
Create a GCS bucket in the same GCP project to store the Terraform state file and update its name in the `backend.tf` file.

> [!IMPORTANT]
> **Note**: The terraform version should be `1.3.x` or higher.


### Steps to create the cluster

**Step 1:** Identify the GCP account/project where the cluster has to be created and run the following commands:

```bash
gcloud auth login --no-launch-browser
```

The command will spit out a URL. Copy the URL and paste it in the browser.
Login using appropriate credentials. After the login is successful, a `authorization-code` is displayed in the console.
Copy the `authorization-code` and paste in the terminal where the `gcloud auth login` command was executed.

**Step 2:** Navigate to `gcp > opsverse-gke > vars.tfvars` file and set `gcp_project_id` to your GCP account/project id where the cluster has to be created.

> [!NOTE]
> This template offers 3 Public Subnets and 3 Private Subnets by default. This can be changed as per the requirements.

> [!TIP]
> This Terraform template uses `us-east4 (Virginia)` region by default. `us-east4` has 3 availability zones. This can be changes as per the region requirements. Please note to change the availability zones and node type as per the selected region. This can be found in `gcp > opsverse-gke > vars.tfvars > node_locations` and `gcp > opsverse-gke > vars.tfvars > node_type` respectively. Please refer [this](https://cloud.google.com/compute/docs/regions-zones) document to find the appropriate availability zones and node type.

> [!CAUTION]
> Please ensure to use the correct `gcp_project_id` as this will be used to create the cluster.

**Step 3:** Navigate to `opsverse-gke` directory and execute the following command:
```bash
terraform init
```
**Step 3:** Update all the variables that are required to create the cluster to a file called `vars.tfvars` file based on your environment.

**Step 4:** Create an execution plan which lets you preview the changes that Terraform plans to make to your infrastructure. Execute the following command to prepare the plan and write to a file:
```bash
terraform plan -var-file=vars.tfvars -out gke-plan.tfplan
```

The above command prepares the execution plan by reading the variables/config from `vars.tfvars`` file and writes the plan to the given path (_in this case it writes the plan to main.tfplan file_). This can be used as input to the apply command.


**Step 5:** Provision the GKE cluster. Execute the following command:
```bash
terraform apply "gke-plan.tfplan"
```
The above command executes the prepared plan which actually creates the cluster in GKE.

Your GKE cluster should be ready to use!

