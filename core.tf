resource "azurerm_resource_group" "core" {
    name                                = "core99"
    location                            = "${var.loc}"
    tags                                = "${var.tags}"
}

resource "azurerm_public_ip" "vpnGatewayPublicIp" {
    name                                = "vpnGatewayPublicIp"
    public_ip_address_allocation        = "dynamic"
    resource_group_name                 = "${azurerm_resource_group.core.name}"
    location                            = "${azurerm_resource_group.core.location}"
    tags                                = "${azurerm_resource_group.core.tags}"
}

resource "azurerm_virtual_network" "core" {
    name                                = "core"
    address_space                       = ["10.0.0.0/16"]
    dns_servers                         = ["1.1.1.1","1.0.0.1"]
    resource_group_name                 = "${azurerm_resource_group.core.name}"
    location                            = "${azurerm_resource_group.core.location}"
    tags                                = "${azurerm_resource_group.core.tags}"
}

resource "azurerm_subnet" "GatewaySubnet" {
    name                                = "GatewaySubnet"
    address_prefix                      = "10.0.0.0/24"
    resource_group_name                 = "${azurerm_resource_group.core.name}"
    virtual_network_name                = "${azurerm_virtual_network.core.name}"
}

resource "azurerm_subnet" "training" {
    name                                = "training"
    address_prefix                      = "10.0.1.0/24"
    resource_group_name                 = "${azurerm_resource_group.core.name}"
    virtual_network_name                = "${azurerm_virtual_network.core.name}"
}

resource "azurerm_subnet" "dev" {
    name                                = "dev"
    address_prefix                      = "10.0.2.0/24"
    resource_group_name                 = "${azurerm_resource_group.core.name}"
    virtual_network_name                = "${azurerm_virtual_network.core.name}"
}

# resource "azurerm_virtual_network_gateway" "vpnGatway" {
#     name                                = "vpnGatway"
#     resource_group_name                 = "${azurerm_resource_group.core.name}"
#     location                            = "${azurerm_resource_group.core.location}"
#     tags                                = "${azurerm_resource_group.core.tags}"
#     type                                = "vpn"
#     vpn_type                            = "RouteBased"
#     enable_bgp                          = true
#     sku                                 = "basic"
#     ip_configuration {
#         name                            = "vpnGwConfig1"
#         private_ip_address_allocation   = "Dynamic"
#         public_ip_address_id            = "${azurerm_public_ip.vpnGatewayPublicIp.id}"
#         subnet_id                       = "${azurerm_subnet.GatewaySubnet.id}"
#     }
# }