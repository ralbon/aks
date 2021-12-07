# Terraform AKS Loreal

This project allows you to manage creattion, modification or destruction of AKS Cluster in Azure using Terraform.


# Prerequisites

## Tools: 
- 

## Resources prequisites creation 

### How to connect to azure-cli ?

connect with az cli to azure tenant with high level credentials
```
$ az login
The default web browser has been opened at https://login.microsoftonline.com/common/oauth2/authorize. Please continue the login in the web browser. If no web browser is available or if the web browser fails to open, use device code flow with `az login --use-device-code`.
You have logged in. Now let us find all the subscriptions to which you have access...
[
  {
    "cloudName": "AzureCloud",
(...)
    "user": {
      "name": "romain.albon@rd.loreal.com",
      "type": "user"
    }
  }
]
```
### How to get my subscription and tenant id ?

get info on azure account
// NOTE id will be used as ___AZURE_IAAS_SUBSCRIPTION_ID___
// NOTE tenantId will be used as ___AZURE_IAAS_TENANT_ID___
```
$ az account show
{
(...)
  "id": "48904eaf-8188-4125-a03f-7697093e3555",
(...)
  "tenantId": "63a61767-c168-4acf-a75d-31b204590b8c",
(...)
}
```
### How to create a resource group ?

// create a resource group
// replace ___RG___
```
$ az group create \
  --location eastus2 \
  --name ___RG___
{
(...)
    "provisioningState": "Succeeded"
(...)
}
```

### How to create service principals and assign resource group scoped ?

// create a service principal for terraform tool and generate a password as credentials
// replace ___AZURE_IAAS_SUBSCRIPTION_ID___ with azure subscription id (see above "how to get subscription id")
// replace ___RG___
// NOTE you should store appID and password in a secret place that will used later
// appID of sa-terraform will be used later as ___SP_TERRAFORM_CLIENT_ID___
// password of sa-terraform  will be used later as ___SP_TERRAFORM_CLIENT_SECRET___
```
$ az ad sp create-for-rbac --name sa-terraform  --role Contributor --scopes /subscriptions/___AZURE_IAAS_SUBSCRIPTION_ID___
The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli
'name' property in the output is deprecated and will be removed in the future. Use 'appId' instead.
{
  "appId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxx",
  "displayName": "sa-terraform",
  "name": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxx",
  "password": "xxxxxxXXXXxxXXXxxXXXXxxXXXXxXX",
  "tenant": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxx"
}
```

# Inrfrasrtucture creation

// copy prepare.TEMPLATE.sh and fill out inyesformations
$ source prepare.sh
$ terraform init
$ terraform plan -var-files variables.tfvars
$ terraform apply -var-files variables.tfvars
