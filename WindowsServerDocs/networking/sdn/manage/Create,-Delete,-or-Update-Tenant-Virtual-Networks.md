---
title: Create, Delete, or Update Tenant Virtual Networks
description: This topic is part of the Software Defined Networking guide on how to Manage Tenant Workloads and Virtual Networks in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-sdn
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6a820826-e829-4ef2-9a20-f74235f8c25b
ms.author: jamesmci
author: jamesmci
---
# Create, Delete, or Update Tenant Virtual Networks

>Applies To: Windows Server 2016

You can use this topic to learn how to create, delete, and update Hyper-V Network Virtualization Virtual Networks after you deploy Software Defined Networking (SDN).  
  
Using Hyper-V Network Virtualization, you can isolate tenant networks so that each tenant network is a completely separate entity with no cross-connection possibility unless you configure public access workloads.  
  
You can create new Virtual Networks for tenants, you can modify existing Virtual Networks, and if a tenant no longer needs certain resources, or if the tenant is no longer your customer, you can delete tenant Virtual Networks.  
  
## Create a new Virtual Network  
  
When you create a Virtual Network for a tenant, it is placed within a unique routing domain on the Hyper-V host.  
  
Following are the steps to create a new Virtual Network.  
  
1. Identify the IP address prefixes from which you want to create the virtual subnets.   
2. Identify the logical provider network upon which the tenant traffic is tunneled.   
3. Create at least one virtual subnet for each IP Prefix that you defined in step 1.   
  
>[!NOTE]  
>Beneath every virtual network there is at least one virtual subnet. Virtual Subnets are defined by an IP Prefix and reference a previously defined Access Control List.  
  
Optionally, after completing these steps, you can also add the previously created access control lists to the virtual subnets, or add gateway connectivity for tenants.    
  
The following table includes example subnet IDs and prefixes for two fictional tenants. The tenant Fabrikam has two virtual subnets, while the Contoso tenant has three virtual subnets.  
  
  
  
Tenant Name  |Virtual Subnet ID  |Virtual Subnet Prefix    
---------|---------|---------  
Fabrikam    |5001         |24.30.1.0/24           
Fabrikam     |5002         | 24.30.2.0/20          
Contoso    |6001         |  24.30.1.0/24         
Contoso    | 6002        |  24.30.2.0/24         
Contoso     | 6003        | 24.30.3.0/24          
  
The following example script uses Windows PowerShell commands exported from the **NetworkController** module to create Contoso's virtual network and one subnet:   
  
```  
import-module networkcontroller  
$URI = "https://ncrest.contoso.local"  
  
#Find the HNV Provider Logical Network  
  
$logicalnetworks = Get-NetworkControllerLogicalNetwork -ConnectionUri $uri  
foreach ($ln in $logicalnetworks) {  
   if ($ln.Properties.NetworkVirtualizationEnabled -eq "True") {  
      $HNVProviderLogicalNetwork = $ln  
   }  
}   
  
#Find the Access Control List to user per virtual subnet  
  
$acllist = Get-NetworkControllerAccessControlList -ConnectionUri $uri -ResourceId "AllowAll"  
  
#Create the Virtual Subnet  
  
$vsubnet = new-object Microsoft.Windows.NetworkController.VirtualSubnet  
$vsubnet.ResourceId = "Contoso_WebTier"  
$vsubnet.Properties = new-object Microsoft.Windows.NetworkController.VirtualSubnetProperties  
$vsubnet.Properties.AccessControlList = $acllist  
$vsubnet.Properties.AddressPrefix = "24.30.1.0/24"  
  
#Create the Virtual Network  
  
$vnetproperties = new-object Microsoft.Windows.NetworkController.VirtualNetworkProperties  
$vnetproperties.AddressSpace = new-object Microsoft.Windows.NetworkController.AddressSpace  
$vnetproperties.AddressSpace.AddressPrefixes = @("24.30.1.0/24")  
$vnetproperties.LogicalNetwork = $HNVProviderLogicalNetwork  
$vnetproperties.Subnets = @($vsubnet)  
New-NetworkControllerVirtualNetwork -ResourceId "Contoso_VNet1" -ConnectionUri $uri -Properties $vnetproperties  
  
  
```  
  
## Modify an existing Virtual Network  
You can use Windows PowerShell to update an existing Virtual subnet or network.   
  
When you run the following example script, the updated resources are simply PUT to Network Controller with the same resource ID. If your tenant Contoso wants to add a new virtual subnet (24.30.2.0/24) to their virtual network, either you or the Contoso Administrator can use the following script.  
  
```  
$acllist = Get-NetworkControllerAccessControlList -ConnectionUri $uri -ResourceId "AllowAll"  
  
$vnet = Get-NetworkControllerVirtualNetwork -ResourceId "Contoso_VNet1" -ConnectionUri $uri  
  
$vnet.properties.AddressSpace.AddressPrefixes += "24.30.2.0/24"  
  
$vsubnet = new-object Microsoft.Windows.NetworkController.VirtualSubnet  
$vsubnet.ResourceId = "Contoso_DBTier"  
$vsubnet.Properties = new-object Microsoft.Windows.NetworkController.VirtualSubnetProperties  
$vsubnet.Properties.AccessControlList = $acllist  
$vsubnet.Properties.AddressPrefix = "24.30.2.0/24"  
  
$vnet.properties.Subnets += $vsubnet  
  
New-NetworkControllerVirtualNetwork -ResourceId "Contoso_VNet1" -ConnectionUri $uri -properties $vnet.properties  
  
```  
  
## Delete a Virtual Network  
  
You can use Windows PowerShell to delete a Virtual Network.  
  
The following Windows PowerShell example deletes a tenant Virtual Network by issuing an HTTP delete to the URI of the Resource ID.  
  
    Remove-NetworkControllerVirtualNetwork -ResourceId "Contoso_Vnet1" -ConnectionUri $uri  


