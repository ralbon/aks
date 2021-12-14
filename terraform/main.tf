resource "azurerm_kubernetes_cluster" "k8s" {
  name                = local.name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix          = local.name
  kubernetes_version  = var.aks_kubernetes_version
  private_cluster_enabled = true

  default_node_pool {
    name                 = "agentpool"
    node_count           = var.aks_agent_count
    vm_size              = var.aks_agent_vm_size
    vnet_subnet_id       = azurerm_subnet.subnet.id
    type                 = "VirtualMachineScaleSets"
    orchestrator_version = var.aks_kubernetes_version
  }

  identity {
    type = "SystemAssigned"
  }
  
  maintenance_window {
    allowed {
      day= "Tuesday"
      hours = ["11","12","13","14"]     
    }
  }


# addon_profile {}}

  network_profile {
    load_balancer_sku = "standard"
    network_plugin = "kubenet"
    network_policy = "calico"
    service_cidr = "172.16.0.0/16"
    dns_service_ip = "172.16.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
  }

  role_based_access_control {
    enabled = var.aks_kubernetes_cluster_rbac_enabled

  #  azure_active_directory {
  #    managed                = true
  #    admin_group_object_ids = [var.aks_admins_group_object_id]
  # }
  }

  tags = local.tags
}
