# OCI_VCN_Deploy
In this we are going to deploy Oracle cloud Infra VCN using Terraform.We have three file : Variable.tf : Stands for initializing variable terraform.tfvars : Here we are declaring variable values main.tf : Here we are calling provider : OCI  : adding all data details Resource which includes VCN , Internet gateway, Route Table , subnet and Security list.
Steps of execution: 
niks@niks-mac OCVS_VCN_deploy % terraform -version
Terraform v1.3.1
on darwin_arm64
+ provider registry.terraform.io/hashicorp/oci v4.96.0

Your version of Terraform is out of date! The latest version
is 1.3.2. You can update by downloading from https://www.terraform.io/downloads.html
niks@niks-mac OCVS_VCN_deploy % terraform init

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/oci from the dependency lock file
- Using previously-installed hashicorp/oci v4.96.0

╷
│ Warning: Additional provider information from registry
│ 
│ The remote registry returned warnings for registry.terraform.io/hashicorp/oci:
│ - For users on Terraform 0.13 or greater, this provider has moved to oracle/oci. Please update your source in required_providers.
╵

Terraform has been successfully initialized!
niks@niks-mac OCVS_VCN_deploy % terraform plan -out ocivcn.tfplan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:Plan: 5 to add, 0 to change, 0 to destroy.

────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Saved the plan to: ocivcn.tfplan

To perform exactly these actions, run the following command to apply:
    terraform apply "ocivcn.tfplan"
    
niks@niks-mac OCVS_VCN_deploy % terraform apply "ocivcn.tfplan"
oci_core_virtual_network.terraform-vcn: Creating...
Apply complete! Resources: 5 added, 0 changed, 0 destroyed.
