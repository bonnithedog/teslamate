# terraformdemo
Getting Started with Terraform on Azure: Modules

This environment creates modules for resources groupes.
Can be used to demonstrate the need to have Demo, Test, Stage, Prod environment.
Variables needs to be set in terraform.tfvars.

This setup was created intended to be used in Terraform cloud.

Variables set in Terraform cloud
https://www.terraform.io/docs/cloud/index.html

Environment variables can be set not mandatory.
envset
location

Azure ARM identification mandatory

ARM_CLIENT_ID  
ARM_SUBSCRIPTION_ID  
ARM_TENANT_ID  
ARM_CLIENT_SECRET  

```bash
/terraformdemo
├── README.md
├── main.tf
├── modules
│   └── rg
│       ├── main.tf
│       └── variables.tf
├── provider.tf
└── variable.tf
```
