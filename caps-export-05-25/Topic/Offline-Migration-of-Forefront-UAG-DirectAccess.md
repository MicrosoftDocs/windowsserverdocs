---
title: Offline Migration of Forefront UAG DirectAccess
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4bdce03e-a8d3-4c40-8461-6de800d23acb
author: vhorne
---
# Offline Migration of Forefront UAG DirectAccess
This topic describes how to perform an offline migration of Forefront UAG DirectAccess to DirectAccess in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)]. In an offline migration the Forefront UAG server is shut down before the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Remote Access server is activated. This enables use of existing IP addresses, certificates and FQDNs. However, it creates server downtime, requires all clients to migrate to the new server at once, and is difficult to roll back.  
  
The offline migration consists of the following steps:  
  
-   Step 1: Install the Remote Access role on the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] computer.  
  
-   Step 2: Configure server IP addresses.  
  
-   Step 3: Obtain a server certificate for IP\-HTTPS connections.  
  
-   Step 4: Prepare GPOs in relevant domains for the Remote Access server, DirectAccess clients, and the application server if required. DirectAccess administrators should have the correct permissions \(edit settings, delete, modify security\) to modify the GPOs.  
  
-   Step 5: Configure DirectAccess.  
  
For a complete walkthrough, see [Offline Migration Steps](../Topic/Offline-Migration-Steps.md).  
  
The following graphic illustrates the offline side\-by\-side migration process.  
  
![](../Image/RAUAGMigration1.png)  
  
