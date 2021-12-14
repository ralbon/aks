
variable "resource_group_name" {
  description = "The resource group name"
  type        = string
}

variable "resource_group_location" {
  description = "The location of resource group"
  type        = string
  default     = "northeurope"
}

variable "vnet_address_space" {
  description = "The CIDR to address space that is used by the virtual network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_address_prefix" {
  description = "The address prefixes to use for the subnet"
  type        = string
  default     = "10.0.0.0/24"
}

variable "project" {
  description = "The name of the project or domain application or product"
  type        = string
}

variable "environment" {
  description = "The name for the environment"
  type        = string
}

variable "aks_kubernetes_version" {
  description = "The version of kubernetes"
  default = "1.21.2"
  type        = string
}

variable "aks_agent_count" {
  description = "The number of node to create at start"
  default = "2"
  type        = number
}

variable "aks_agent_vm_size" {
  description = "The vm size of node"
  default = "Standard_D2_v2"
  type        = string
}

variable "ssh_public_key" {
  description = "The public key allowed for admin username access"
  default     = ""
  type        = string
}

variable "aks_kubernetes_cluster_rbac_enabled" {
  description = "Enable using rabs in Kubernetes"
  default = "true"
  type        = bool
}

variable "bastion_password" {
  description = "Password to connect to bastion as admin"
  type        = string
}
