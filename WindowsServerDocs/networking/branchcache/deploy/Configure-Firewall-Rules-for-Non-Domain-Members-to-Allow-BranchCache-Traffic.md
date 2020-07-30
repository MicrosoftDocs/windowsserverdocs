---
title: Configure Firewall Rules for Non-Domain Members to Allow BranchCache Traffic
description: This topic is part of the BranchCache Deployment Guide for Windows Server 2016, which demonstrates how to deploy BranchCache in distributed and hosted cache modes to optimize WAN bandwidth usage in branch offices
manager: brianlic
ms.prod: windows-server
ms.technology: networking-bc
ms.topic: get-started-article
ms.assetid: da956be0-c92d-46ea-99eb-85e2bd67bf07
ms.author: lizross
author: eross-msft
---
# Configure Firewall Rules for Non-Domain Members to Allow BranchCache Traffic

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use the information in this topic to configure third party firewall products and to manually configure a client computer with firewall rules that allow BranchCache to run in distributed cache mode.  
  
> [!NOTE]  
> -   If you have configured BranchCache client computers using Group Policy, the Group Policy settings override any manual configuration of client computers to which the policies are applied.  
> -   If you have deployed BranchCache with DirectAccess, you can use the settings in this topic to configure IPsec rules to allow BranchCache traffic.  
  
Membership in **Administrators**, or equivalent is the minimum required to make these configuration changes.  
  
## [MS-PCCRD]: Peer Content Caching and Retrieval Discovery Protocol  
Distributed cache clients must allow inbound and outbound MS-PCCRD traffic, which is carried in the Web Services Dynamic Discovery (WS-Discovery) protocol.  
  
Firewall settings must allow multicast traffic in addition to inbound and outbound traffic. You can use the following settings to configure firewall exceptions for distributed cache mode.  
  
IPv4 multicast: 239.255.255.250  
  
IPv6 multicast: FF02::C  
  
Inbound traffic: Local port: 3702, Remote port: ephemeral  
  
Outbound traffic: Local port: ephemeral, Remote port: 3702  
  
Program: %systemroot%\system32\svchost.exe (BranchCache Service [PeerDistSvc])  
  
## [MS-PCCRR]: Peer Content Caching and Retrieval: Retrieval Protocol  
Distributed cache clients must allow inbound and outbound MS-PCCRR traffic, which is carried in the HTTP 1.1 protocol as documented in request for comments (RFC) 2616.  
  
Firewall settings must allow inbound and outbound traffic. You can use the following settings to configure firewall exceptions for distributed cache mode.  
  
Inbound traffic: Local port: 80, Remote port: ephemeral  
  
Outbound traffic: Local port: ephemeral, Remote port: 80  
  


