---
title: Deploy BranchCache Hosted Cache Mode
description: This guide provides instructions on deploying BranchCache in hosted cache mode on computers running Windows Server 2016 and Windows 10
manager: brianlic
ms.prod: windows-server-threshold
ms.technology: networking-bc
ms.topic: article
ms.assetid: 4235231c-4732-4ea9-9330-2a8c8a616d39
ms.author: pashort
author: shortpatti
---
# Deploy BranchCache Hosted Cache Mode

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The Windows Server 2016 Core Network Guide provides instructions for planning and deploying the core components required for a fully functioning network and a new Active Directory&reg; domain in a new forest.

This guide explains how to build on the core network by providing instructions for deploying BranchCache in hosted cache mode in one or more branch offices with a Read\-Only Domain Controller where client computers are running Windows&reg; 10, Windows 8.1, or Windows 8, and are joined to the domain.

>[!IMPORTANT]
>Do not use this guide if you are planning to deploy or have already deployed a BranchCache hosted cache server that is running Windows Server 2008 R2. This guide provides instructions for deploying hosted cache mode with a hosted cache server that is running Windows Server&reg; 2016, Windows Server 2012 R2, or Windows Server 2012.

This guide contains the following sections.

- [Prerequisites for using this guide](#bkmk_pre)

- [About this guide](#bkmk_about)

- [What this guide does not provide](#bkmk_not)

- [Technology overviews](#bkmk_tech)

- [BranchCache Hosted Cache Mode Deployment Overview](2-Bc-Hcm-Deploy-Overview.md)

- [BranchCache Hosted Cache Mode Deployment Planning](3-Bc-Hcm-Plan.md)

- [BranchCache Hosted Cache Mode Deployment](4-Bc-Hcm-Deployment.md)

- [Additional Resources](11-Bc-Hcm-additional-resources.md)

## <a name="bkmk_pre"></a>Prerequisites for using this guide

This is a companion guide to the Windows Server 2016 Core Network Guide. To deploy BranchCache in hosted cache mode with this guide, you must first do the following.

- Deploy a core network in your main office by using the Core Network Guide, or already have the technologies provided in the Core Network Guide installed and functioning correctly on your network. These technologies include TCP\/IP v4, DHCP, Active Directory Domain Services \(AD DS\), and DNS.

    > [!NOTE]
    > The Windows Server 2016 [Core Network Guide](https://technet.microsoft.com/windows-server-docs/networking/core-network-guide/core-network-guide) is available in the Windows Server 2016 Technical Library.  

- Deploy BranchCache content servers that are running Windows Server 2016, Windows Server 2012 R2, or Windows Server 2012 in your main office or in a cloud data center. For information on how to deploy BranchCache content servers, see [Additional Resources](11-Bc-Hcm-additional-resources.md).

- Establish wide area network \(WAN\) connections between your branch office, your main office and, if appropriate, your Cloud resources, by using a virtual private network \(VPN\), DirectAccess, or other connection method.

- Deploy client computers in your branch office that are running one of the following operating systems, which provide BranchCache with support for Background Intelligent Transfer Service (BITS), Hyper Text Transfer Protocol (HTTP), and Server Message Block (SMB).
	- Windows 10 Enterprise
	- Windows 10 Education
	- Windows 8.1 Enterprise
	- Windows 8 Enterprise

> [!NOTE]
> In the following operating systems, BranchCache does not support HTTP and SMB functionality, but does support BranchCache BITS functionality.
>     - Windows 10 Pro, BITS support only
>     - Windows 8.1 Pro, BITS support only
>     - Windows 8 Pro, BITS support only

## <a name="bkmk_about"></a>About this guide

This guide is designed for network and system administrators who have followed the instructions in the Windows Server 2016 Core Network Guide or Windows Server 2012 Core Network Guide to deploy a core network, or for those who have previously deployed the technologies included in the Core Network Guide, including Active Directory Domain Services \(AD DS\), Domain Name Service \(DNS\), Dynamic Host Configuration Protocol \(DHCP\), and TCP\/IP v4.

It is recommended that you review the design and deployment guides for each of the technologies that are used in this deployment scenario. These guides can help you determine whether this deployment scenario provides the services and configuration that you need for your organization's network.

## <a name="bkmk_not"></a>What this guide does not provide

This guide does not provide conceptual information about BranchCache, including information about BranchCache modes and capabilities.  

This guide does not provide information about how to deploy WAN connections or other technologies in your branch office, such as DHCP, a RODC, or a VPN server.

In addition, this guide does not provide guidance on the hardware you should use when you deploy a hosted cache server. It is possible to run other services and applications on your hosted cache server, however you must make the determination, based on workload, hardware capabilities, and branch office size, whether to install BranchCache hosted cache server on a particular computer, and how much disk space to allocate for the cache.  
This guide does not provide instructions for configuring computers that are running Windows 7. If you have client computers that are running Windows 7 in your branch offices, you must configure them using procedures that are different than those provided in this guide for client computers that are running Windows 10, Windows 8.1, and Windows 8.
  
In addition, if you have computers running Windows 7, you must configure your hosted cache server with a server certificate that is issued by a certification authority that client computers trust. \(If all of your client computers are running Windows 10, Windows 8.1, or Windows 8, you do not need to configure the hosted cache server with a server certificate.\) 
> [!IMPORTANT]
> If your hosted cache servers are running Windows Server 2008 R2, use the Windows Server 2008 R2 [BranchCache Deployment Guide](https://technet.microsoft.com/library/ee649232(v=ws.10).aspx) instead of this guide to deploy BranchCache in hosted cache mode. Apply the Group Policy settings that are described in that guide to all BranchCache clients that are running versions of Windows from Windows 7 to Windows 10. Computers that are running Windows Server 2008 R2 cannot be configured by using the steps in this guide.

## <a name="bkmk_tech"></a>Technology overviews

For this companion guide, BranchCache is the only technology that you need to install and configure. You must run Windows PowerShell BranchCache commands on your content servers, such as Web and file servers, however you do not need to change or reconfigure the content servers in any other way. In addition, you must configure client computers by using Group Policy on your domain controllers that are running AD DS on Windows Server 2016, Windows Server 2012 R2, or Windows Server 2012.

### BranchCache

BranchCache is a wide area network (WAN) bandwidth optimization technology that is included in some editions of the Windows Server 2016 and Windows 10 operating systems, as well as in some editions of Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8, Windows Server 2008 R2, and Windows 7.

To optimize WAN bandwidth when users access content on remote servers, BranchCache downloads client-requested content from your main office or hosted cloud content servers and caches the content at branch office locations, allowing other client computers at branch offices to access the same content locally rather than over the WAN.

When you deploy BranchCache in hosted cache mode, you must configure client computers in the branch office as hosted cache mode clients, and then you must deploy a hosted cache server in the branch office. This guide demonstrates how to deploy your hosted cache server with prehashed and preloaded content from your Web and file server\-based content servers.

### Group Policy

Group Policy in Windows Server 2016, Windows Server 2012 R2, and Windows Server 2012 is an infrastructure used to deliver and apply one or more desired configurations or policy settings to a set of targeted users and computers within an Active Directory environment. 

This infrastructure consists of a Group Policy engine and multiple client\-side extensions \(CSEs\) that are responsible for reading policy settings on target client computers.

Group Policy is used in this scenario to configure domain member client computers with BranchCache hosted cache mode.

To continue with this guide, see [BranchCache Hosted Cache Mode Deployment Overview](2-Bc-Hcm-Deploy-Overview.md).
