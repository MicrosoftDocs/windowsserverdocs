---
title: BranchCache Deployment Guide
description: This topic is part of the BranchCache Deployment Guide for Windows Server 2016, which demonstrates how to deploy BranchCache in distributed and hosted cache modes to optimize WAN bandwidth usage in branch offices
manager: brianlic
ms.prod: windows-server
ms.technology: networking-bc
ms.topic: get-started-article
ms.assetid: 3830b356-36d3-44f9-a1d7-990ff3e57403
ms.author: lizross
author: eross-msft
---
# BranchCache Deployment Guide

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this guide to learn how to deploy BranchCache in Windows Server 2016.  
  
In addition to this topic, this guide contains the following sections.  
  
-   [Choosing a BranchCache Design](../../branchcache/plan/Choosing-a-BranchCache-Design.md)  
  
-   [Deploy BranchCache](../../branchcache/deploy/Deploy-BranchCache.md)  
  
## BranchCache Deployment Overview

BranchCache is a wide area network (WAN) bandwidth optimization technology that is included in some editions of Windows Server 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012, Windows Server&reg; 2008 R2, and related Windows client operating systems.  
  
To optimize WAN bandwidth, BranchCache copies content from your main office content servers and caches the content at branch office locations, allowing client computers at branch offices to access the content locally rather than over the WAN.  
  
At branch offices, content is cached either on servers that are running the BranchCache feature of Windows Server 2016,  Windows Server 2012 R2 ,    Windows Server 2012 , or  Windows Server 2008 R2  - or, if there are no servers available in the branch office, content is cached on client computers that are running Windows 10&reg;, Windows&reg; 8.1,  Windows 8, or  Windows 7&reg; .  
  
After a client computer requests and receives content from the main office or cloud datacenter and the content is cached at the branch office, other computers at the same branch office can obtain the content locally rather than contacting the content server over the WAN link.  
  
**Benefits of deploying BranchCache**  
  
BranchCache caches file, web, and application content at branch office locations, allowing client computers to access data using the local area network (LAN) rather than accessing the content over slow WAN connections.  
  
BranchCache reduces both WAN traffic and the time that is required for branch office users to open files on the network.  BranchCache always provides users with the most recent data, and it protects the security of your content by encrypting the caches on the hosted cache server and on client computers.  
  
### What this guide provides  
This deployment guide allows you to deploy BranchCache in the following modes:  
  
-   Distributed cache mode. In this mode, branch office client computers download content from the content servers in the main office or cloud, and then cache the content for other computers in the same branch office. Distributed cache mode does not require a server computer in the branch office.  
  
-   Hosted cache mode. In this mode, branch office client computers download content from the content servers in the main office or cloud, and a hosted cache server retrieves the content from the clients. The hosted cache server then caches the content for other client computers.  
  
This guide also provides instructions on how to deploy three types of content servers. Content servers contain the source content that is downloaded by branch office client computers, and one or more content server is required to deploy BranchCache in either mode. The content server types are:  
  
-   **Web server-based content servers**. These content servers send content to BranchCache client computers using the HTTP and HTTPS protocols. These content servers must be running Windows Server 2016,  Windows Server 2012 R2,  Windows Server 2012, or  Windows Server 2008 R2 versions that support BranchCache and upon which the BranchCache feature is installed.  
  
-   **BITS-based application servers**. These content servers send content to BranchCache client computers using the Background Intelligent Transfer Service (BITS). These content servers must be running Windows Server 2016,  Windows Server 2012 R2,  Windows Server 2012, or  Windows Server 2008 R2 versions that support BranchCache and upon which the BranchCache feature is installed.  
  
-   **File server-based content servers**. These content servers must be running Windows Server 2016,  Windows Server 2012 R2 ,  Windows Server 2012 , or  Windows Server 2008 R2  versions that support BranchCache and upon which the File Services server role is installed. In addition, the **BranchCache for network files** role service of the File Services server role must be installed and configured. These content servers send content to BranchCache client computers using the Server Message Block (SMB) protocol.  
  
For more information, see [Operating system versions for BranchCache](https://technet.microsoft.com/windows-server-docs/networking/branchcache/branchcache#a-namebkmkosaoperating-system-versions-for-branchcache).  
  
### BranchCache deployment requirements

Following are the requirements for deploying BranchCache by using this guide.  
  
-   **File and Web content servers** must be running one of the following operating systems to provide BranchCache functionality: Windows Server 2016,  Windows Server 2012 R2 ,  Windows Server 2012 , or  Windows Server 2008 R2 . Windows 8 and later clients continue to see benefits from BranchCache when accessing content servers that are running  Windows Server 2008 R2 , however they are unable to make use of the new chunking and hashing technologies in Windows Server 2016,  Windows Server 2012 R2,  and  Windows Server 2012.  
  
-   **Client computers** must be running Windows 10, Windows 8.1, or Windows 8 to make use of the most recent deployment model and the chunking and hashing improvements that were introduced with  Windows Server 2012 .  
  
-   **Hosted cache servers** must be running Windows Server 2016,  Windows Server 2012 R2, or  Windows Server 2012 to make use of the deployment improvements and scale features described in this document.  A computer that is running one of these operating systems that is configured as a hosted cache server can continue to serve client computers that are running  Windows 7 , but to do so, it must be equipped with a certificate that is suitable for Transport Layer Security (TLS), as described in the Windows Server 2008 R2 and Windows 7 [BranchCache Deployment Guide](https://technet.microsoft.com/library/ee649232.aspx).  
  
-   **An Active Directory domain** is required to take advantage of Group Policy and hosted cache automatic discovery, but a domain is not required to use BranchCache.  You can configure individual computers by using Windows PowerShell. In addition, it is not required that your domain controllers are running  Windows Server 2012  or later to utilize new BranchCache Group Policy settings; you can import the BranchCache administrative templates onto domain controllers that are running earlier operating systems, or you can author the group policy objects remotely on other computers that are running Windows 10, Windows Server 2016, Windows 8.1, Windows Server 2012 R2, Windows 8, or Windows Server 2012.

-   **Active Directory sites** are used to limit the scope of hosted cache servers that are automatically discovered.  To automatically discover a hosted cache server, both the client and server computers must belong to the same site. BranchCache is designed to have a minimal impact on clients and servers and does not impose additional hardware requirements beyond those needed to run their respective operating systems.  

**BranchCache history and documentation**

BranchCache was first introduced in Windows 7&reg; and Windows Server&reg; 2008 R2, and was improved in Windows Server 2012, Windows 8, and later operating systems.

> [!NOTE]
> If you are deploying BranchCache in operating systems other than Windows Server 2016, the following documentation resources are available.
> 
> - For information about BranchCache in Windows 8, Windows 8.1, Windows Server 2012, and  Windows Server 2012 R2, see [BranchCache Overview](https://technet.microsoft.com/library/hh831696.aspx).  
> - For information about BranchCache in Windows 7 and Windows Server 2008 R2, see  [BranchCache for Windows Server 2008 R2](https://technet.microsoft.com/library/dd996634.aspx).  
  


