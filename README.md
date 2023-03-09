# AKS

This project allows you to deploy an AKS Cluster in Azure using Terraform.

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
$ terraform plan -var-files dev.tfvars
$ terraform apply -var-files dev.tfvars
```

# Connect to AKS

Go to azure poartal and select bastion vm -> Connect -> via Bastion host. Enter login and password used during infrastructure creation.
Once you are connected to bastion. 
```
$ az login
$ az account set --subscription XXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
$ az aks get-credentials --resource-group rg-aks --name infra-dev
```

