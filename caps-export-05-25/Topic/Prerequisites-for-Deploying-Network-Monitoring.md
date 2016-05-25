---
title: Prerequisites for Deploying Network Monitoring
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: 072582ad-bb44-4c5f-b7ba-2560f8f9963b
author: vhorne
---
# Prerequisites for Deploying Network Monitoring
You can use this topic to learn how to prepare your network for the deployment of the Network Controller Network Monitoring feature.  
  
> [!NOTE]  
> In addition to this topic, the following Network Monitoring documentation is available.  
>   
> -   [Network Monitoring](../Topic/Network-Monitoring.md)  
> -   [Deploy Network Monitoring using Windows PowerShell](../Topic/Deploy-Network-Monitoring-using-Windows-PowerShell.md)  
  
Before you deploy Network Monitoring, you must complete the following steps.  
  
-   Deploy Network Controller in your datacenter. For more information, see one or more of the following topics.  
  
    -   [Deploy Network Controller using Windows PowerShell](../Topic/Deploy-Network-Controller-using-Windows-PowerShell.md)  
  
    -   [Deploy Software Defined Networks using scripts](../Topic/Deploy-Software-Defined-Networks-using-scripts.md)  
  
    -   [Deploy Software Defined Networks using Virtual Machine Manager](../Topic/Deploy-Software-Defined-Networks-using-Virtual-Machine-Manager.md)  
  
-   Decide which computers that are running [!INCLUDE[winthreshold_server_1](../Token/winthreshold_server_1_md.md)] you plan on using as Canary Agents. Network Monitoring requires at least two Canary Agents per logical network per rack.  
  
-   On all devices involved in Network Monitoring communications, including computers configured with Network Controller or as Canary Agents, configure the firewall to allow inbound and outbound Network Performance and Diagnostic Service \(NPDS\) traffic on port 8084.  
  
-   Determine how you are planning to use Network Monitoring: with System Center Operations Manager, or by using REST APIs or Windows PowerShell. If you are planning on using System Center Operations Manager, complete the following steps.  
  
    -   Deploy System Center Operations Manager in your datacenter.  
  
    -   On the computer that is running System Center Operations Manager, install the Network Controller Network Monitoring management pack.  
  
