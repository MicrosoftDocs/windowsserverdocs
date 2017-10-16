---
title: Connect Containers to a Virtual Network
description: This topic is part of the Software Defined Networking guide on how to Manage Tenant Workloads and Virtual Networks in Windows Server 2016.
manager: ravirao
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-sdn
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f7af1eb6-d035-4f74-a25b-d4b7e4ea9329
ms.author: jamesmci 
author: jmesser81
---

# Connect container endpoints to a tenant virtual network

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic shows you how to connect container endpoints to an existing tenant virtual network created through the Microsoft Software Defined Networking (SDN) stack. We will use the *l2bridge* (and optionally *l2tunnel*) network driver available with the Windows libnetwork plugin for Docker to create a container network on the container host (tenant) virtual machine.

As documented in the [Container Networking](https://msdn.microsoft.com/en-us/virtualization/windowscontainers/management/container_networking) topic on MSDN, multiple network drivers are available through Docker on Windows. The drivers most suitable for SDN are *l2bridge* and *l2tunnel*. For both drivers, each container endpoint is in the same virtual subnet as the container host (tenant) virtual machine. The IP addresses for container endpoints are assigned dynamically by the Host Networking Service (HNS) through the private cloud plugin. The container endpoints have unique IP addresses but share the same MAC address of the container host (tenant) virtual machine due to Layer-2 address translation. Network policy (for example: ACLs, encapsulation, and QoS) for these container endpoints are enforced in the physical Hyper-V host as received by the Network Controller and defined in upper-layer management systems. There is a slight difference between the *l2bridge* and *l2tunnel* drivers which is explained below.

- **L2 Bridge** - container endpoints that reside on the same container host virtual machine and are in the same subnet have all network traffic bridged within the Hyper-V virtual switch. Container endpoints which reside on different container host VMs or which are in different subnets have their traffic forwarded to the physical Hyper-V host. Since network traffic between containers on the same host and in the same subnet do not flow to the physical host, no network policy is enforced. Policy is only applied for cross-host or cross-subnet container network traffic.  
 
- **L2 Tunnel** - *all* network traffic between two container endpoints is forwarded to the physical Hyper-V host regardless of host or subnet. Network policy is enforced for both cross-subnet and cross-host network traffic.   

>[!NOTE]
>These networking modes do not work for connecting windows container endpoints to a tenant virtual network in Azure public cloud

## Prerequistes
 * An SDN infrastructure with the Network Controller has been deployed
 * A tenant virtual network has been created
 * A tenant virtual machine has been deployed with the Windows Container feature enabled, Docker installed, and Hyper-V feature enabled

>[!Note]
>[Nested virtualization](https://msdn.microsoft.com/en-us/virtualization/hyperv_on_windows/user_guide/nesting) and exposing virtualization extensions is not required unless using Hyper-V Containers
>The HyperV feature is required to install several binaries for l2bridge and l2tunnel networks

```powershell
# To install HyperV feature without checks for nested virtualization
dism /Online /Enable-Feature /FeatureName:Microsoft-Hyper-V /All 
```

 

## Workflow

1. [Add multiple IP configurations to an existing VM NIC resource through Network Controller](#Add) (Hyper-V Host)
2. [Enable the network proxy on the host to allocate CA IP Addresses for container endpoints](#Enable) (Hyper-V Host) 
3. [Install the private cloud plug-in to assign CA IP addresses to container endpoints](#Install) (Container Host VM) 
4. [Create an *l2bridge* or *l2tunnel* network using docker](#Create)  (Container Host VM) 
 
>[!NOTE]
>Multiple IP configurations is not supported on VM NIC resources created through System Center Virtual Machine Manager. It is recommended for these deployments types that you create the VM NIC resource out of band using Network Controller PowerShell.

### <a name="Add"></a>1. Add Multiple IP Configurations

For this example, we assume that the VM NIC of the tenant virtual machine already has one IP configuration with IP address of 192.168.1.9 and is attached to a VNet Resource ID of 'VNet1' and VM Subnet Resource of 'Subnet1' in the 192.168.1.0/24 IP subnet. We will add 10 IP addresses for containers from 192.168.1.101 - 192.168.1.110.

```powershell
Import-Module NetworkController

# Specify Network Controller REST IP or FQDN
$uri = "<NC REST IP or FQDN>"
$vnetResourceId = "VNet1"
$vsubnetResourceId = "Subnet1"

$vmnic= Get-NetworkControllerNetworkInterface -ConnectionUri $uri | where {$_.properties.IpConfigurations.Properties.PrivateIPAddress -eq "192.168.1.9" }
$vmsubnet = Get-NetworkControllerVirtualSubnet -VirtualNetworkId $vnetResourceId -ResourceId $vsubnetResourceId -ConnectionUri $uri

# For this demo, we will assume an ACL has already been defined; any ACL can be applied here
$allowallacl = Get-NetworkControllerAccessControlList -ConnectionUri $uri -ResourceId "AllowAll"


foreach ($i in 1..10)
{
    $newipconfig = new-object Microsoft.Windows.NetworkController.NetworkInterfaceIpConfiguration
    $props = new-object Microsoft.Windows.NetworkController.NetworkInterfaceIpConfigurationProperties

    $resourceid = "IP_192_168_1_1"
    if ($i -eq 10) 
    {
        $resourceid += "10"
        $ipstr = "192.168.1.110"
    }
    else
    {
        $resourceid += "0$i"
        $ipstr = "192.168.1.10$i"
    }
    
    $newipconfig.ResourceId = $resourceid
    $props.PrivateIPAddress = $ipstr    
    
    $props.PrivateIPAllocationMethod = "Static"
    $props.Subnet = new-object Microsoft.Windows.NetworkController.Subnet
    $props.Subnet.ResourceRef = $vmsubnet.ResourceRef
    $props.AccessControlList = new-object Microsoft.Windows.NetworkController.AccessControlList
    $props.AccessControlList.ResourceRef = $allowallacl.ResourceRef

    $newipconfig.Properties = $props
    $vmnic.Properties.IpConfigurations += $newipconfig
}

New-NetworkControllerNetworkInterface -ResourceId $vmnic.ResourceId -Properties $vmnic.Properties -ConnectionUri $uri
```

### <a name="Enable"></a>2. Enable the Network Proxy

[ConfigureMCNP.ps1](https://github.com/Microsoft/SDN/blob/master/Containers/ConfigureMCNP.ps1>)

Run this script on the **Hyper-V Host** which is hosting the container host (tenant) virtual machine to enable the network proxy to allocate multiple IP addresses for the container host virtual machine.

```powershell
PS C:\> ConfigureMCNP.ps1
```

### <a name="Install"></a>3. Install Private Cloud plug-in

[InstallPrivateCloudPlugin.ps1](https://github.com/Microsoft/SDN/blob/master/Containers/InstallPrivateCloudPlugin.ps1)

Run this script inside the **container host (tenant) virtual machine** to allow the Host Networking Service (HNS) to communicate with the network proxy on the Hyper-V Host.

```powershell
PS C:\> InstallPrivateCloudPlugin.ps1
```

### <a name="Create"></a>4. Create an *l2bridge* Container Network

On the **container host (tenant) virtual machine** use the `docker network create` command to create an l2bridge network

```powershell
# Create the container network
C:\> docker network create -d l2bridge --subnet="192.168.1.0/24" --gateway="192.168.1.1" MyContainerOverlayNetwork

# Attach a container to the MyContainerOverlayNetwork 
C:\> docker run -it --network=MyContainerOverlayNetwork <image> <cmd>
```

>[!NOTE]
>Static IP assignment is not supported with *l2bridge* or *l2tunnel* container networks when used with the Microsoft SDN Stack.

## More information
For more infortation about deploying an SDN infrastructure, see [Deploy a Software Defined Network Infrastructure](https://technet.microsoft.com/en-us/windows-server-docs/networking/sdn/deploy/deploy-a-software-defined-network-infrastructure).

