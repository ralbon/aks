# Terraform AKS Loreal

This project allows you to manage creation, modification or destruction of AKS Cluster in Azure using Terraform.

# Prerequisites

## Tools: 
- terraform

## Resources: 
- Azure Subscription
- Azure Resource group
- Azure Service Principal with Owner scope in resource group 

# Infrasrtucture creation

Copy prepare.TEMPLATE.sh and fill out informations

```
$ cp prepare.TEMPLATE.sh prepare.sh
$ vi prepare.sh
```

Load requested variables
```
$ source prepare.sh
```

Create infrastructure
```
$ cd terraform
$ terraform init
$ terraform plan -var-files variables.tfvars
$ terraform apply -var-files variables.tfvars
```

# Connect to AKS

Go to azure poartal and select bastion vm -> Connect -> via Bastion host. Enter login and password used during infrastructure creation.
Once you are connected to bastion. 
```
$ az login
$ az account set --subscription 93f7670e-adf8-489e-99af-225c8c725860
$ az aks get-credentials --resource-group we-frri-rg-dev-devops --name infra-dev
```

