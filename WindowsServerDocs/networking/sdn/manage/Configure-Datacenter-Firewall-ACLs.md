---
title: Configure Datacenter Firewall Access Control Lists (ACLs)
description: This topic is part of the Software Defined Networking guide on how to Manage Tenant Workloads and Virtual Networks in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-sdn
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 25f18927-a63e-44f3-b02a-81ed51933187
ms.author: jamesmci
author: jamesmci
---
# Configure Datacenter Firewall Access Control Lists (ACLs)

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

You can apply specific ACLs to network interfaces.  If ACLs are also set on the virtual subnet to which the network interface is connected, both ACLs are applied, but the network interface ACLs are prioritized above the virtual subnet ACLs.

This topic contains the following sections.

- [Example: Add an ACL to a network interface](#bkmk_addacl)
- [Example: Remove an ACL from a network interface by using Windows Powershell and the Network Controller REST API](#bkmk_removeacl)

##<a name="bkmk_addacl"></a>Example: Add an ACL to a network interface

In the topic [Use Access Control Lists (ACLs) to Manage Datacenter Network Traffic Flow](Use-Access-Control-Lists--ACLs--to-Manage-Datacenter-Network-Traffic-Flow.md) you learned how to create an ACL and assign it to a virtual subnet.  In some cases, however, you might want to override that default ACL on the virtaul subnet with a specific ACL for an individual network interface.  You will also need to apply ACLs directly to network interfaces that are attached to VLANs instead of virtual networks.

This example demonstrates how to add an ACL to a virtual network. 

>[!NOTE]
>It is also possible to add an ACL at the same time that you create the network interface.

###Step 1: Get or create the network interface to which you will add the ACL

    $nic = get-networkcontrollernetworkinterface -ConnectionUri $uri -ResourceId "MyVM_Ethernet1"

###Step 2: Get or create the ACL you will add to the network interface
You can use the following example command to get or create the ACL. 

    $acl = get-networkcontrolleraccesscontrollist -ConnectionUri $uri -resourceid "AllowAllACL"

###Step 3: Assign the ACL to the AccessControlList property of the network interface
You can use the following example command to assign the ACL to the AccessControlList property.

    $nic.properties.ipconfigurations[0].properties.AccessControlList = $acl

###Step 4: Add the network interface in Network Controller
You can use the following example command to add the network interface in Network Controller.

    new-networkcontrollernetworkinterface -ConnectionUri $uri -Properties $nic.properties -ResourceId $nic.resourceid


##<a name="bkmk_removeacl"></a>Example: Remove an ACL from a network interface by using Windows Powershell and the Network Controller REST API
You can use this example if you want to remove an ACL. When you remove an ACL, the default set of rules are applied to the network interface.

The default set of rules allows all outbound traffic, but blocks all inbound traffic.

>[!NOTE]
>If you want to allow all inbound traffic, you must follow the previous example to add an ACL that allows all inbound and all outbound traffic.

###Step 1: Get the network interface from which you will remove the ACL
You can use the following example command to retrieve the network interface.

    $nic = get-networkcontrollernetworkinterface -ConnectionUri $uri -ResourceId "MyVM_Ethernet1"

###Step 2: Assign $NULL to the AccessControlList property of the ipConfiguration
You can use the following example command to assign $NULL to the AccessControlList property.

    $nic.properties.ipconfigurations[0].properties.AccessControlList = $null

###Step 3: Add the network interface object in Network Controller
You can use the following example command to add the network interface object in Network Controller,

    new-networkcontrollernetworkinterface -ConnectionUri $uri -Properties $nic.properties -ResourceId $nic.resourceid

