---
title: Side-by-Side Migration of Forefront UAG DirectAccess
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 90244f22-eda5-4892-a57f-0cbc7b134128
---
# Side-by-Side Migration of Forefront UAG DirectAccess
This topic describes how to perform a side\-by\-side migration of Forefront UAG DirectAccess to DirectAccess in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)]. A side\-by\-side migration keeps the Forefront UAG DirectAccess server running while you deploy [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DirectAccess. After the deployment is complete, DirectAccess clients access internal resources via the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Remote Access server, and the Forefront UAG server is removed from service.  
  
The side\-by\-side migration consists of the following steps:  
  
-   Step 1: Forefront UAG DirectAccess configuration settings are exported. If Forefront UAG is deployed in an array, this should be performed on the array manager server.  
  
-   Step 2: Note the names of Group Policy Objects \(GPOs\) used for Forefront UAG DirectAccess, including the server GPO, client GPOs, and application server GPOs if relevant.  
  
-   Step 3: Set up the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] computer as a Remote Access server, by installing the Remote Access role.*<Step name>*  
  
-   Step 4: Configure infrastructure settings for the Remote Access server, including IP addresses, DNS settings, certificates, client security groups, and GPOs.  
  
For a complete walkthrough, see [Side-by-Side Migration Steps](../Topic/Side-by-Side-Migration-Steps.md).  
  
The following graphic illustrates the side\-by\-side migration process.  
  
![](../Image/RAUAGMigration2.png)  
  
