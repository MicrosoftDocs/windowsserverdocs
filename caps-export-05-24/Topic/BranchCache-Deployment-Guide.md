---
title: BranchCache Deployment Guide
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9a8217ed-f85d-4b6b-a339-926e258b713d
---
# BranchCache Deployment Guide
This guide contains the following sections.  
  
-   [Choosing a BranchCache Design_1](../Topic/Choosing-a-BranchCache-Design_1.md)  
  
-   [Deploy BranchCache_1](../Topic/Deploy-BranchCache_1.md)  
  
-   [Additional Resources_10](../Topic/Additional-Resources_10.md)  
  
> [!NOTE]  
> This guide is available at the following locations.  
>   
> -   The [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)][BranchCache Deployment Guide](http://go.microsoft.com/fwlink/p/?LinkId=259572) in Word format in the Microsoft Download Center at http:\/\/go.microsoft.com\/fwlink\/p\/?LinkId\=259572.  
> -   The [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)][BranchCache Deployment Guide](http://go.microsoft.com/fwlink/?LinkId=259777) in HTML format in the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Technical Library at  HYPERLINK "http:\/\/go.microsoft.com\/fwlink\/?LinkId\=259777" http:\/\/go.microsoft.com\/fwlink\/?LinkId\=259777.  
  
BranchCache is a wide area network \(WAN\) bandwidth optimization technology that is included in some editions of the [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] and [!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)] operating systems.  
  
To optimize WAN bandwidth, BranchCache copies content from your main office content servers and caches the content at branch office locations, allowing client computers at branch offices to access the content locally rather than over the WAN.  
  
At branch offices, content is cached either on servers that are running the BranchCache feature of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or, when no server is available in the branch office, on computers running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)]. After a client computer requests and receives content from the main office or cloud data center and the content is cached at the branch office, other computers at the same branch office can obtain the content locally rather than contacting the content server over the WAN link.  
  
**Benefits of deploying BranchCache**  
  
BranchCache caches file, web, and application content at branch office locations, allowing client computers to access data using the local area network \(LAN\) rather than accessing the content over slow WAN connections.  
  
BranchCache reduces both WAN traffic and the time that is required for branch office users to open files on the network.  BranchCache always provides users with the most recent data, and it protects the security of your content by encrypting the caches on the hosted cache server and on client computers.  
  
### What this guide provides  
This deployment guide allows you to deploy BranchCache in the following modes:  
  
-   Distributed cache mode. In this mode, branch office client computers download content from the content servers in the main office and then cache the content for other computers in the same branch office. Distributed cache mode does not require a server computer in the branch office.  
  
-   Hosted cache mode. In this mode, branch office client computers download content from the content servers in the main office, and a hosted cache server retrieves the content from the clients. The hosted cache server then caches the content for other client computers.  
  
This guide also provides instructions on how to deploy three types of content servers. Content servers contain the source content that is downloaded by branch office client computers, and one or more content server is required to deploy BranchCache in either mode. The content server types are:  
  
-   **Web server\-based content servers**. These content servers send content to BranchCache client computers using the HTTP and HTTPS protocols. These content servers must be running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] versions that support BranchCache and upon which the BranchCache feature is installed.  
  
-   **BITS\-based application servers**. These content servers send content to BranchCache client computers using the Background Intelligent Transfer Service \(BITS\). These content servers must be running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] versions that support BranchCache and upon which the BranchCache feature is installed.  
  
-   **File server\-based content servers**. These content servers must be running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] versions that support BranchCache and upon which the File Services server role is installed. In addition, the **BranchCache for network files** role service of the File Services server role must be installed and configured. These content servers send content to BranchCache client computers using the Server Message Block \(SMB\) protocol.  
  
### BranchCache deployment requirements  
Following are the requirements for deploying BranchCache by using this guide.  
  
-   **File and Web content servers** must be running either [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to provide BranchCache functionality. [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] clients continue to see benefits from BranchCache when accessing content servers that are running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], however they are unable to make use of the new chunking and hashing technologies in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   **Client computers** must be running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] to make use of the new deployment model and the chunking and hashing improvements.  
  
-   **Hosted cache servers** must be running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to make use of the deployment improvements and scale features described in this document.  A computer that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] that is configured as a hosted cache server can continue to serve client computers that are running [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], but to do so, it must be equipped with a certificate that is suitable for Transport Layer Security \(TLS\), as described in the [BranchCache Deployment Guide for Windows Server 2008 R2 and Windows 7](http://www.microsoft.com/download/en/details.aspx?displaylang=en&id=19558).  
  
-   **An Active Directory domain** is required to take advantage of Group Policy and hosted cache automatic discovery, but a domain is not required to use BranchCache.  You can configure individual computers by using Windows PowerShell. In addition, it is not required that your domain controllers are running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to utilize new BranchCache Group Policy settings; you can import the BranchCache administrative templates onto domain controllers that are running other operating systems, or you can author the group policy objects remotely on other computers that are running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   **Active Directory sites** are used to limit the scope of hosted cache servers that are automatically discovered.  To automatically discover a hosted cache server, both the client and server computers must belong to the same site. BranchCache is designed to have a minimal impact on clients and servers and does not impose additional hardware requirements beyond those needed to run their respective operating systems.  
  
**BranchCache history and documentation**  
  
BranchCache was first introduced in [!INCLUDE[firstref_client_7](../Token/firstref_client_7_md.md)] and [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)], and is improved in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  For more information about BranchCache in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], including security information and a comprehensive list of new features, see [BranchCache overview](http://technet.microsoft.com/library/hh831696.aspx).  
  
For more information about new BranchCache features, see [What’s New in BranchCache](http://technet.microsoft.com/library/jj127252).  
  
> [!NOTE]  
> For information about BranchCache in [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], see [http:\/\/branchcache.com](http://branchcache.com) and  [BranchCache for Windows Server 2008 R2](http://technet.microsoft.com/library/dd996634(WS.10).aspx).  
  
