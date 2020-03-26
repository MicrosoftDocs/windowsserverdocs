---
title: Configure Datacenter Firewall Access Control Lists (ACLs)
description: You can apply specific ACLs to network interfaces.  If ACLs are also set on the virtual subnet to which the network interface is connected, both ACLs are applied, but the network interface ACLs are prioritized above the virtual subnet ACLs.
manager: dougkim
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-sdn
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 25f18927-a63e-44f3-b02a-81ed51933187
ms.author: lizross
author: eross-msft
ms.date: 08/23/2018
---
# Configure datacenter firewall Access Control Lists (ACLs)

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

Once you've created an ACL and assigned it to a virtual subnet, you might want to override that default ACL on the virtual subnet with a specific ACL for an individual network interface.  In this case, you apply specific ACLs directly to network interfaces attached to VLANs, instead of the virtual network. If you have ACLs set on the virtual subnet connected to the network interface, both ACLs are applied and prioritizes the network interface ACLs above the virtual subnet ACLs.

>[!IMPORTANT]
>If you have not created an ACL and assigned it to a virtual network, see [Use Access Control Lists (ACLs) to Manage Datacenter Network Traffic Flow](Use-Access-Control-Lists--ACLs--to-Manage-Datacenter-Network-Traffic-Flow.md) to  create an ACL and assign it to a virtual subnet.  

In this topic, we show you how to add an ACL to a network interface. We also show you how to remove an ACL from a network interface using Windows PowerShell and the Network Controller REST API.

- [Example: Add an ACL to a network interface](#example-add-an-acl-to-a-network-interface)
- [Example: Remove an ACL from a network interface by using Windows Powershell and the Network Controller REST API](#example-remove-an-acl-from-a-network-interface-by-using-windows-powershell-and-the-network-controller-rest-api)


## Example: Add an ACL to a network interface
In this example, we demonstrates how to add an ACL to a virtual network. 

>[!TIP]
>It is also possible to add an ACL at the same time that you create the network interface.

1. Get or create the network interface to which you will add the ACL.
 
   ```PowerShell
   $nic = get-networkcontrollernetworkinterface -ConnectionUri $uri -ResourceId "MyVM_Ethernet1"
   ```
 
2. Get or create the ACL you will add to the network interface.
 
   ```PowerShell
   $acl = get-networkcontrolleraccesscontrollist -ConnectionUri $uri -resourceid "AllowAllACL"
   ```
 
3. Assign the ACL to the AccessControlList property of the network interface
 
   ```PowerShell
    $nic.properties.ipconfigurations[0].properties.AccessControlList = $acl
   ```
 
4. Add the network interface in Network Controller
 
   ```
   new-networkcontrollernetworkinterface -ConnectionUri $uri -Properties $nic.properties -ResourceId $nic.resourceid
   ```
 
## Example: Remove an ACL from a network interface by using Windows Powershell and the Network Controller REST API
In this example, we show you how to remove an ACL. Removing an ACL applies the default set of rules to the network interface. The default set of rules allows all outbound traffic but blocks all inbound traffic.

>[!NOTE]
>If you want to allow all inbound traffic, you must follow the previous [example](#example-add-an-acl-to-a-network-interface) to add an ACL that allows all inbound and all outbound traffic.


1. Get the network interface from which you will remove the ACL.<br>
   ```PowerShell
   $nic = get-networkcontrollernetworkinterface -ConnectionUri $uri -ResourceId "MyVM_Ethernet1"
   ```
 
2. Assign $NULL to the AccessControlList property of the ipConfiguration.<br>
   ```PowerShell
   $nic.properties.ipconfigurations[0].properties.AccessControlList = $null
   ```
 
3. Add the network interface object in Network Controller.<br>
   ```PowerShell
   new-networkcontrollernetworkinterface -ConnectionUri $uri -Properties $nic.properties -ResourceId $nic.resourceid
   ```
