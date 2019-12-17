---
title: Install Active Directory Domain Services on an Azure virtual machine
description: How to create a new Active Directory forest on a virtual machine (VM) on an Azure virtual machine.
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 04/11/2019
ms.technology: identity-adds
ms.topic: article
ms.prod: windows-server
---
# Install a new Active Directory forest using Azure CLI

AD DS can run on an Azure virtual machine (VM) in the same way it runs in many on-premises instances. This article walks through deploying a new AD DS Forest, on two new domain controllers, in an Azure availability set using the Azure portal and Azure CLI. Many customers find this guidance helpful when creating a lab or preparing to deploy domain controllers in Azure.

## Components

* A resource group to put everything in.
* An [Azure Virtual Network](https://docs.microsoft.com/azure/virtual-network/virtual-networks-overview.md), subnet, network security group, and rule to allow RDP access to VMs.
* An Azure virtual machine [availability set](https://docs.microsoft.com/azure/virtual-machines/windows/regions-and-availability#availability-sets) to put two Active Directory Domain Services (AD DS) domain controllers in.
* Two Azure virtual machines to run AD DS and DNS.

### Items that are not covered

* [Creating a site-to-site VPN connection](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-howto-site-to-site-resource-manager-portal.md) from an on-premises location
* [Securing network traffic in Azure](https://docs.microsoft.com/azure/security/azure-security-network-security-best-practices.md)
* [Designing the site topology](https://docs.microsoft.com/windows-server/identity/ad-ds/plan/designing-the-site-topology)
* [Planning operations master role placement](https://docs.microsoft.com/windows-server/identity/ad-ds/plan/planning-operations-master-role-placement)
* [Deploying Azure AD Connect to synchronize identities to Azure AD](https://docs.microsoft.com/azure/active-directory/hybrid/how-to-connect-install-express)

## Build the test environment

We use the [Azure portal](https://portal.azure.com) and [Azure CLI](https://docs.microsoft.com/cli/azure/overview?view=azure-cli-latest) for creating the environment.

The Azure CLI is used to create and manage Azure resources from the command line or in scripts. This tutorial details using the Azure CLI to deploy virtual machines running Windows Server 2019. Once deployment is complete, we connect to the servers and install AD DS.

If you don't have an Azure subscription, [create a free account](https://azure.microsoft.com/free) before you begin.

### Using Azure CLI

The following script automates the process of building two Windows Server 2019 VMs, for the purpose of building domain controllers for a new Active Directory Forest in Azure. An administrator can modify the variables below, to suit their needs then complete as one operation. The script creates the necessary resource group, network security group with a traffic rule for Remote Desktop, virtual network and subnet, and availability group. The VMs are each then built with a 20 GB data disk with caching disabled for AD DS to be installed to.

The script below can be run directly from the Azure portal. If you choose to install and use the CLI locally, this quickstart requires that you are running the Azure CLI version 2.0.4 or later. Run `az --version` to find the version. If you need to install or upgrade, see [Install Azure CLI 2.0](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest).

| Variable Name | Purpose |
| :---: | :--- |
| AdminUsername | Username to be configured on each VM as the local administrator. |
| AdminPassword | Cleartext password to be configured on each VM as the local administrator password. |
| ResourceGroupName | Name to be used for resource group. Should not duplicate an existing name. |
| Location | Azure location name that you would like to deploy to. List supported regions for the current subscription using `az account list-locations`. |
| VNetName | Name to assign the Azure virtual network Should not duplicate an existing name. |
| VNetAddress | IP scope to use for Azure networking. Should not duplicate an existing range. |
| SubnetName | Name to assign the IP subnet. Should not duplicate an existing name. |
| SubnetAddress | Subnet address for the domain controllers. Should be a subnet inside of the VNet. |
| AvailabilitySet | Name of the availability set the domain controller VMs will join. |
| VMSize | Standard Azure VM Size available in the location for deployment. |
| DataDiskSize | Size in GB for the data disk where AD DS installs. |
| DomainController1 | Name of first domain controller. |
| DC1IP | IP address for first domain controller. |
| DomainController2 | Name of second domain controller. |
| DC2IP | IP address for second domain controller. |

```azurecli
#Update based on your organizational requirements
Location=westus2
ResourceGroupName=ADonAzureVMs
NetworkSecurityGroup=NSG-DomainControllers
VNetName=VNet-AzureVMsWestUS2
VNetAddress=10.10.0.0/16
SubnetName=Subnet-AzureDCsWestUS2
SubnetAddress=10.10.10.0/24
AvailabilitySet=DomainControllers
VMSize=Standard_DS1_v2
DataDiskSize=20
AdminUsername=azureuser
AdminPassword=ChangeMe123456
DomainController1=AZDC01
DC1IP=10.10.10.11
DomainController2=AZDC02
DC2IP=10.10.10.12

# Create a resource group.
az group create --name $ResourceGroupName \
                --location $Location

# Create a network security group
az network nsg create --name $NetworkSecurityGroup \
                      --resource-group $ResourceGroupName \
                      --location $Location

# Create a network security group rule for port 3389.
az network nsg rule create --name PermitRDP \
                           --nsg-name $NetworkSecurityGroup \
                           --priority 1000 \
                           --resource-group $ResourceGroupName \
                           --access Allow \
                           --source-address-prefixes "*" \
                           --source-port-ranges "*" \
                           --direction Inbound \
                           --destination-port-ranges 3389

# Create a virtual network.
az network vnet create --name $VNetName \
                       --resource-group $ResourceGroupName \
                       --address-prefixes $VNetAddress \
                       --location $Location \

# Create a subnet
az network vnet subnet create --address-prefix $SubnetAddress \
                              --name $SubnetName \
                              --resource-group $ResourceGroupName \
                              --vnet-name $VNetName \
                              --network-security-group $NetworkSecurityGroup

# Create an availability set.
az vm availability-set create --name $AvailabilitySet \
                              --resource-group $ResourceGroupName \
                              --location $Location

# Create two virtual machines.
az vm create \
    --resource-group $ResourceGroupName \
    --availability-set $AvailabilitySet \
    --name $DomainController1 \
    --size $VMSize \
    --image Win2019Datacenter \
    --admin-username $AdminUsername \
    --admin-password $AdminPassword \
    --data-disk-sizes-gb $DataDiskSize \
    --data-disk-caching None \
    --nsg $NetworkSecurityGroup \
    --private-ip-address $DC1IP \
    --no-wait

az vm create \
    --resource-group $ResourceGroupName \
    --availability-set $AvailabilitySet \
    --name $DomainController2 \
    --size $VMSize \
    --image Win2019Datacenter \
    --admin-username $AdminUsername \
    --admin-password $AdminPassword \
    --data-disk-sizes-gb $DataDiskSize \
    --data-disk-caching None \
    --nsg $NetworkSecurityGroup \
    --private-ip-address $DC2IP

```

## DNS and Active Directory

If the Azure virtual machines created as part of this process will be an extension of an existing on-premises Active Directory infrastructure the DNS settings on the virtual network must be changed to include your on-premises DNS servers before deployment. This step is important to allow the newly created Domain Controllers in Azure to resolve on-premises resources and allow for replication to occur. More information about DNS, Azure, and how to configure settings can be found in the section [Name resolution that uses your own DNS server](https://docs.microsoft.com/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances#name-resolution-that-uses-your-own-dns-server).

After promoting the new domain controllers in Azure they will need to be set to the primary and secondary DNS Servers for the virtual network, and any on-premises DNS Servers would be demoted to tertiary and beyond. More information on changing DNS Servers can be found in the article [Create, change, or delete a virtual network](https://docs.microsoft.com/azure/virtual-network/manage-virtual-network#change-dns-servers).

Information about extending an on-premises network to Azure can be found in the article [Creating a site-to-site VPN connection](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-howto-site-to-site-resource-manager-portal
).

## Configure the VMs and install Active Directory Domain Services

After the script completes, browse to the [Azure portal](https://portal.azure.com), then **Virtual machines**.

### Configure the first Domain Controller

Connect to AZDC01 using the credentials you provided in the script.

* Initialize and format the data disk as F:
   * Open the Start menu and browse to **Computer Management**
   * Browse to **Storage** > **Disk Management**
   * Initialize the disk as MBR
   * Create a New Simple Volume and Assign the drive letter F: you can provide a Volume label if you wish
* Install Active Directory Domain Services using Server Manager
* Promote the domain controller as the first in a new forest
   * Leave Domain Name System (DNS) server and Global Catalog (GC) checked on the Domain Controller Options page
   * Specify a Directory Services Restore Mode password based on your organizational requirements
   * Change the paths from C: to point to the F: drive we created when prompted for their location
   * Review the selections made in the wizard and choose **Next**

> [!NOTE]
> The Prerequisites Check will warn you that the physical network adapter does not have static IP address(es) assigned, you can safely ignore this as static IPs are assigned in the Azure virtual network.

* Choose **Install**

When the wizard completes the install process, the VM reboots.

When the VM reboots log back in with the credentials used but this time as a member of the domain you created.

   > [!NOTE]
   > The first logon after promotion to a domain controller may take longer than normal and this is ok. Grab a cup of tea, coffee, water, or other beverage of choice.

Because [Azure virtual networks do not support IPv6](https://docs.microsoft.com/azure/virtual-network/virtual-networks-faq#do-vnets-support-ipv6) you will want to set your VMs to prefer IPv4 over IPv6. Information on how to complete this task can be found in the KB article [Guidance for configuring IPv6 in Windows for advanced users](https://support.microsoft.com/help/929852/guidance-for-configuring-ipv6-in-windows-for-advanced-users).

### Configure the second Domain Controller

Connect to AZDC02 using the credentials you provided in the script.

* Initialize and format the data disk as F:
   * Open the Start menu and browse to **Computer Management**
   * Browse to **Storage** > **Disk Management**
   * Initialize the disk as MBR
   * Create a New Simple Volume and Assign the drive letter F: you can provide a Volume label if you wish
* Install Active Directory Domain Services using Server Manager
* Promote the domain controller
   * Add a domain controller to an existing domain - CONTOSO.com
   * Supply credentials to perform the operation
   * Change the paths from C: to point to the F: drive we created when prompted for their location
   * Ensure Domain Name System (DNS) server and Global Catalog (GC) checked on the Domain Controller Options page
   * Specify a Directory Services Restore Mode password based on your organizational requirements
   * Review the selections made in the wizard and choose **Next**

> [!NOTE]
> The Prerequisites Check will warn you that the physical network adapter does not have static IP address(es) assigned, you can safely ignore this as static IPs are assigned in the Azure virtual network.

* Choose **Install**

When the wizard completes the install process, the VM reboots.

When the VM reboots log back in with the credentials used but this time as a member of the CONTOSO.com domain

Because [Azure virtual networks do not support IPv6](https://docs.microsoft.com/azure/virtual-network/virtual-networks-faq#do-vnets-support-ipv6) you will want to set your VMs to prefer IPv4 over IPv6. Information on how to complete this task can be found in the KB article [Guidance for configuring IPv6 in Windows for advanced users](https://support.microsoft.com/help/929852/guidance-for-configuring-ipv6-in-windows-for-advanced-users).

### Configure DNS

After promoting the new domain controllers in Azure they will need to be set to the primary and secondary DNS Servers for the virtual network and any on-premises DNS Servers would be demoted to tertiary and beyond. More information on changing DNS Servers can be found in the article [Create, change, or delete a virtual network](https://docs.microsoft.com/azure/virtual-network/manage-virtual-network#change-dns-servers).

### Wrap up

At this point, the environment has a pair of domain controllers and we have configured the Azure virtual network so that additional servers may be added to the environment. Post-install tasks for Active Directory Domain Services like configuring sites and services, auditing, backup, and securing the built-in administrator account should be completed at this point.

## Removing the environment

To remove the environment when you have completed testing the resource group we created above can be deleted, this step removes all of the components that are part of that resource group.

### Remove using the Azure portal

From the Azure portal, browse to **Resource groups** and choose the resource group we created in this example ADonAzureVMs, then select **Delete resource group**. The process asks for confirmation before deleting all the resources contained inside of the resource group.

### Remove using the Azure CLI

From Azure CLI run the following command:

```azurecli
az group delete --name ADonAzureVMs
```

## Next steps

* [Safely virtualizing Active Directory Domain Services (AD DS)](../../Introduction-to-Active-Directory-Domain-Services-AD-DS-Virtualization-Level-100.md)
* [Azure AD Connect](https://docs.microsoft.com/azure/active-directory/connect/active-directory-aadconnect-get-started-express)
* [Backup and recovery](https://docs.microsoft.com/azure/virtual-machines/windows/backup-recovery)
* [Site to site VPN connectivity](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-howto-site-to-site-resource-manager-portal)
* [Monitoring](https://docs.microsoft.com/azure/virtual-machines/windows/monitor)
* [Security and policy](https://docs.microsoft.com/azure/virtual-machines/windows/security-policy)
* [Maintenance and updates](https://docs.microsoft.com/azure/virtual-machines/windows/maintenance-and-updates)
