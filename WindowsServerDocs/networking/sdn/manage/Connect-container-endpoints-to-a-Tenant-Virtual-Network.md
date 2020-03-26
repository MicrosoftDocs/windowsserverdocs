---
title: Connect container endpoints to a tenant virtual network
description: In this topic, we show you how to connect container endpoints to an existing tenant virtual network created through SDN. You use the l2bridge (and optionally l2tunnel) network driver available with the Windows libnetwork plugin for Docker to create a container network on the tenant VM.
manager: ravirao
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-sdn
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f7af1eb6-d035-4f74-a25b-d4b7e4ea9329
ms.author: lizross 
author: jmesser81
ms.date: 08/24/2018
---

# Connect container endpoints to a tenant virtual network

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

In this topic, we show you how to connect container endpoints to an existing tenant virtual network created through SDN. You use the *l2bridge* (and optionally *l2tunnel*) network driver available with the Windows libnetwork plugin for Docker to create a container network on the tenant VM.

In the [Container network drivers](https://docs.microsoft.com/virtualization/windowscontainers/container-networking/network-drivers-topologies) topic, we discussed the multiple network drivers are available through Docker on Windows. For SDN, use the *l2bridge* and *l2tunnel* drivers. For both drivers, each container endpoint is in the same virtual subnet as the container host (tenant) virtual machine. 

The Host Networking Service (HNS), through the private cloud plugin, dynamically assigns the IP addresses for container endpoints. The container endpoints have unique IP addresses but share the same MAC address of the container host (tenant) virtual machine due to Layer-2 address translation. 

Network policy (ACLs, encapsulation, and QoS) for these container endpoints are enforced in the physical Hyper-V host as received by the Network Controller and defined in upper-layer management systems. 

The difference between the *l2bridge* and *l2tunnel* drivers are:


|                                                                                                                                                                                                                                                                            l2bridge                                                                                                                                                                                                                                                                            |                                                                                                 l2tunnel                                                                                                  |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Container endpoints that reside on: <ul><li>The same container host virtual machine and on the same subnet have all network traffic bridged within the Hyper-V virtual switch. </li><li>Different container host VMs or on different subnets have their traffic forwarded to the physical Hyper-V host. </li></ul>Network policy does not get enforced since network traffic between containers on the same host and in the same subnet do not flow to the physical host. Network policy applies only to cross-host or cross-subnet container network traffic. | *ALL* network traffic between two container endpoints is forwarded to the physical Hyper-V host regardless of host or subnet. Network policy applies to both cross-subnet and cross-host network traffic. |

---

>[!NOTE]
>These networking modes do not work for connecting windows container endpoints to a tenant virtual network in Azure public cloud.


## Prerequisites
-  A deployed SDN infrastructure with the Network Controller.
-  A tenant virtual network has been created.
-  A deployed tenant virtual machine with the Windows Container feature enabled, Docker installed, and Hyper-V feature enabled. The Hyper-V feature is required to install several binaries for l2bridge and l2tunnel networks.

   ```powershell
   # To install HyperV feature without checks for nested virtualization
   dism /Online /Enable-Feature /FeatureName:Microsoft-Hyper-V /All 
   ```

>[!Note]
>[Nested virtualization](https://msdn.microsoft.com/virtualization/hyperv_on_windows/user_guide/nesting) and exposing virtualization extensions is not required unless using Hyper-V Containers. 


## Workflow

[1. Add multiple IP configurations to an existing VM NIC resource through Network Controller (Hyper-V Host)](#1-add-multiple-ip-configurations)
[2. Enable the network proxy on the host to allocate CA IP Addresses for container endpoints (Hyper-V Host)](#2-enable-the-network-proxy)
[3. Install the private cloud plug-in to assign CA IP addresses to container endpoints (Container Host VM)](#3-install-the-private-cloud-plug-in)
[4. Create an *l2bridge* or *l2tunnel* network using docker (Container Host VM)](#4-create-an-l2bridge-container-network)

>[!NOTE]
>Multiple IP configurations is not supported on VM NIC resources created through System Center Virtual Machine Manager. It is recommended for these deployments types that you create the VM NIC resource out of band using Network Controller PowerShell.

### 1. Add Multiple IP Configurations
In this step, we assume the VM NIC of the tenant virtual machine has one IP configuration with IP address of 192.168.1.9 and is attached to a VNet Resource ID of 'VNet1' and VM Subnet Resource of 'Subnet1' in the 192.168.1.0/24 IP subnet. We add 10 IP addresses for containers from 192.168.1.101 - 192.168.1.110.

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

### 2. Enable the network proxy
In this step, you enable the network proxy to allocate multiple IP addresses for the container host virtual machine. 

To enable the network proxy, run the [ConfigureMCNP.ps1](https://github.com/Microsoft/SDN/blob/master/Containers/ConfigureMCNP.ps1) script on the **Hyper-V Host** hosting the container host (tenant) virtual machine.

```powershell
PS C:\> ConfigureMCNP.ps1
```

### 3. Install the Private Cloud plug-in
In this step, you install a plug-in to allow the HNS to communicate with the network proxy on the Hyper-V Host.

To install the plug-in, run the [InstallPrivateCloudPlugin.ps1](https://github.com/Microsoft/SDN/blob/master/Containers/InstallPrivateCloudPlugin.ps1) script inside the **container host (tenant) virtual machine**.


```powershell
PS C:\> InstallPrivateCloudPlugin.ps1
```

### 4. Create an *l2bridge* Container Network
In this step, you use the `docker network create` command on the **container host (tenant) virtual machine** to create an l2bridge network. 

```powershell
# Create the container network
C:\> docker network create -d l2bridge --subnet="192.168.1.0/24" --gateway="192.168.1.1" MyContainerOverlayNetwork

# Attach a container to the MyContainerOverlayNetwork 
C:\> docker run -it --network=MyContainerOverlayNetwork <image> <cmd>
```

>[!NOTE]
>Static IP assignment is not supported with *l2bridge* or *l2tunnel* container networks when used with the Microsoft SDN Stack.

## More information
For more details about deploying an SDN infrastructure, see [Deploy a Software Defined Network Infrastructure](https://docs.microsoft.com/windows-server/networking/sdn/deploy/deploy-a-software-defined-network-infrastructure).

