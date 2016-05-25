---
title: Core Network Companion Guide: Deploying BranchCache Hosted Cache Mode
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3609cdd8-afc4-482e-9f43-c37535568d11
author: vhorne
---
# Core Network Companion Guide: Deploying BranchCache Hosted Cache Mode
The [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Core Network Guide provides instructions for planning and deploying the core components required for a fully functioning network and a new Active Directory® domain in a new forest.  
  
This guide explains how to build on the core network by providing instructions for deploying BranchCache in hosted cache mode in a branch office with a Read\-Only Domain Controller where client computers are running [!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)] and are joined to the domain.  
  
> [!IMPORTANT]  
> Do not use this guide if you are planning to deploy or have already deployed a BranchCache hosted cache server that is running [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)]. This guide provides instructions for deploying hosted cache mode with a hosted cache server that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
This guide contains the following sections.  
  
-   [Prerequisites for using this guide](#bkmk_pre)  
  
-   [About this guide](#bkmk_about)  
  
-   [What this guide does not provide](#bkmk_not)  
  
-   [Technology overviews](#bkmk_tech)  
  
-   [BranchCache Hosted Cache Mode Deployment Overview](../Topic/BranchCache-Hosted-Cache-Mode-Deployment-Overview.md)  
  
-   [BranchCache Hosted Cache Mode Deployment Planning](../Topic/BranchCache-Hosted-Cache-Mode-Deployment-Planning.md)  
  
-   [BranchCache Hosted Cache Mode Deployment](../Topic/BranchCache-Hosted-Cache-Mode-Deployment.md)  
  
-   [Additional Resources](assetId:///9f69a6e5-d757-4a25-af95-197f5b4896c1)  
  
> [!NOTE]  
> This guide is available at the following locations.  
>   
> -   The [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)][Core Network Companion Guide: Deploying BranchCache Hosted Cache Mode](http://ppstw.com/downloads/en/details.aspx?FamilyID=49b77688-a634-4107-9457-0938c354a09c) in Word format in the Microsoft Download Center.  
> -   The [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)][Core Network Companion Guide: Deploying BranchCache Hosted Cache Mode](http://technet.microsoft.com/library/jj862369.aspx) in HTML format in the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Technical Library.  
  
## <a name="bkmk_pre"></a>Prerequisites for using this guide  
This is a companion guide to the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Core Network Guide. To deploy BranchCache in hosted cache mode with this guide, you must first do the following.  
  
-   Deploy a core network in your main office by using the Core Network Guide, or already have the technologies provided in the Core Network Guide installed and functioning correctly on your network. These technologies include TCP\/IP v4, DHCP, Active Directory Domain Services \(AD DS\), DNS, NPS, and Web Server \(IIS\).  
  
    > [!NOTE]  
    > The [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Core Network Guide is available in the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Technical Library \([http:\/\/technet.microsoft.com\/library\/hh911995.aspx](http://technet.microsoft.com/library/hh911995.aspx)\).  
    >   
    > The Core Network Guide is also available in Word format at the Microsoft Download Center \([http:\/\/go.microsoft.com\/fwlink\/p\/?LinkId\=255199](http://go.microsoft.com/fwlink/p/?LinkId=255199)\).  
  
-   Deploy BranchCache content servers that are running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] in your main office or in a cloud data center. For information on how to deploy BranchCache content servers, see [Additional Resources](assetId:///9f69a6e5-d757-4a25-af95-197f5b4896c1).  
  
-   Establish wide area network \(WAN\) connections between your branch office, your main office and, if appropriate, your Cloud resources, by using a virtual private network \(VPN\), DirectAccess, or other connection method.  
  
-   Deploy client computers in your branch office that are running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
  
## <a name="bkmk_about"></a>About this guide  
This guide is designed for network and system administrators who have followed the instructions in the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Core Network Guide to deploy a core network, or for those who have previously deployed the technologies included in the Core Network Guide, including Active Directory Domain Services \(AD DS\), Domain Name Service \(DNS\), Dynamic Host Configuration Protocol \(DHCP\), TCP\/IP, Web Server \(IIS\), and Network Policy Server \(NPS\).  
  
It is recommended that you review the design and deployment guides for each of the technologies that are used in this deployment scenario. These guides can help you determine whether this deployment scenario provides the services and configuration that you need for your organization's network.  
  
## <a name="bkmk_not"></a>What this guide does not provide  
This guide does not provide conceptual information about BranchCache, including information about BranchCache modes and capabilities.  
  
This guide does not provide information about how to deploy WAN connections or other technologies in your branch office, such as DHCP, a RODC, or a VPN server.  
  
In addition, this guide does not provide guidance on the hardware you should use when you deploy a hosted cache server. It is possible to run other services and applications on your hosted cache server, however you must make the determination, based on workload, hardware capabilities, and branch office size, whether to install BranchCache hosted cache server on a particular computer, and how much disk space to allocate for the cache.  
  
This guide does not provide instructions for configuring computers that are running [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)]. If you have client computers that are running [!INCLUDE[firstref_client_7](../Token/firstref_client_7_md.md)] in your branch offices, you must configure them using procedures that are different than those provided in this guide for client computers that are running [!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)].  
  
In addition, if you have computers running [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], you must configure your hosted cache server with a server certificate that is issued by a certification authority that client computers trust. \(If all of your client computers are running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], you do not need to configure the hosted cache server with a server certificate.\)  
  
> [!IMPORTANT]  
> If your hosted cache servers are running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], use the [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] BranchCache Deployment Guide rather than this guide to deploy BranchCache in hosted cache mode. Apply the Group Policy settings that are described in that guide to both [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] BranchCache clients.  Computers that are running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] cannot be configured by using the steps in this guide. For more information, see the [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)][BranchCache Deployment Guide](http://technet.microsoft.com/library/ee649232(v=ws.10).aspx)  
  
## <a name="bkmk_tech"></a>Technology overviews  
For this companion guide, BranchCache is the only technology that you need to install and configure. You must run Windows PowerShell BranchCache commands on your content servers, such as Web and file servers, however you do not need to change or reconfigure the content servers in any other way. In addition, you must configure client computers by using Group Policy.  
  
### BranchCache  
BranchCache is a wide area network \(WAN\) bandwidth optimization technology that is included in some editions of the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] operating systems, as well as in some editions of [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)] and [!INCLUDE[firstref_client_7](../Token/firstref_client_7_md.md)]. To optimize WAN bandwidth when users access content on remote servers, BranchCache copies content from your main office or hosted cloud content servers and caches the content at branch office locations, allowing client computers at branch offices to access the content locally rather than over the WAN.  
  
When you deploy BranchCache in hosted cache mode, you must configure client computers in the branch office as hosted cache mode clients, and then you must deploy a hosted cache server in the branch office. This guide demonstrates how to deploy your hosted cache server with prehashed and preloaded content from your Web and file server\-based content servers.  
  
### Group Policy  
Group Policy in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] is an infrastructure used to deliver and apply one or more desired configurations or policy settings to a set of targeted users and computers within an Active Directory environment. This infrastructure consists of a Group Policy engine and multiple client\-side extensions \(CSEs\) responsible for reading policy settings on target client computers.  
  
Group Policy is used in this scenario to configure domain member client computers with BranchCache hosted cache mode.  
  
