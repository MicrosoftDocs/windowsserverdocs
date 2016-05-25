---
title: Design a WSUS Storage Strategy
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3e47f0a7-b25d-4b84-a6be-0c96b505af9d
author: britw
---
# Design a WSUS Storage Strategy
[!INCLUDE[wsus_firstref_30SP2](../Token/wsus_firstref_30SP2_md.md)] 3.0 SP2 uses two types of storage systems: a database to store WSUS configuration and update metadata, and an optional local file system to store update files. Before you install WSUS, you should decide how you want to implement storage.  
  
Updates are composed of two parts: metadata that describes the update and the files that are required to install the update. Update metadata is typically much smaller than the actual update, and it is stored in the WSUS database. Update files are stored either on a local WSUS server or on a Microsoft Update Web server.  
  
In a deployment of multiple WSUS servers, each WSUS server can configure its own storage options.  
  
In this topic:  
  
-   [WSUS database](../Topic/Design-a-WSUS-Storage-Strategy.md#wsusdb)  
  
-   [WSUS update storage](../Topic/Design-a-WSUS-Storage-Strategy.md#updatestorage)  
  
## <a name="wsusdb"></a>WSUS database  
WSUS 3.0 SP2 requires a database for each WSUS server. WSUS supports the use of a database that resides on a different computer than the WSUS server, with some restrictions. For a list of supported databases and remote database limitations, see [WSUS database requirements](assetId:///e8f62aba-4c8d-410e-9012-e3c9680a929b#WSUSdb).  
  
The WSUS database stores the following information:  
  
-   WSUS server configuration information  
  
-   Metadata that describes each update  
  
-   Information about client computers, updates, and interactions  
  
If you install multiple WSUS servers, you must maintain a separate database for each WSUS server, whether it is an autonomous or a replica server. \(For more information about WSUS server types, see [Design the WSUS Server Layout](../Topic/Design-the-WSUS-Server-Layout.md).\) You cannot store multiple WSUS databases on a single instance of SQL Server, except in Network Load Balancing \(NLB\) clusters that use SQL Server failover. For more about this configuration, see [Configure WSUS for Network Load Balancing](../Topic/Configure-WSUS-for-Network-Load-Balancing.md).  
  
SQL Server, SQL Server Express, and [!INCLUDE[nextref_wyukon](../Token/nextref_wyukon_md.md)] provide the same performance characteristics for a single server configuration, where the database and the WSUS service are located on the same computer. A single server configuration can support several thousand WSUS client computers.  
  
> [!CAUTION]  
> Do not attempt to manage WSUS by accessing the database directly. Directly manipulating the database can cause database corruption. The corruption might not be immediately obvious, but it can prevent upgrades to the next version of the product.  
>   
> You can manage WSUS by using the WSUS console or WSUS application programming interfaces \(APIs\). For more information about how to use WSUS APIs, see the [Windows Server Update Services Software Development Kit](http://go.microsoft.com/fwlink/?LinkID=203519).  
  
### WSUS with Windows Internal Database  
By default, the installation wizard creates and uses a Windows Internal Database that is named **SUSDB.mdf**. This database is located in the *<installdrive>***\\WSUS\\UpdateServicesDbFiles** folder, where *<installdrive>* is the local drive on which the WSUS server software is installed. [!INCLUDE[nextref_wyukon](../Token/nextref_wyukon_md.md)] is included with WSUS 3.0 SP2.  
  
WSUS supports Windows authentication only for the database. You cannot use SQL Server authentication with WSUS. If you use [!INCLUDE[nextref_wyukon](../Token/nextref_wyukon_md.md)] for the WSUS database, WSUS Setup creates an instance of SQL Server that is named *server*\\MICROSOFT\#\#SSEE, where *server* is the name of the computer. With either database option, WSUS Setup creates a database named SUSDB. The name of this database is not configurable.  
  
We recommend that you use [!INCLUDE[nextref_wyukon](../Token/nextref_wyukon_md.md)] in the following cases:  
  
-   The organization has not already purchased and does not require a SQL Server product for any other application.  
  
-   The organization does not require an NLB WSUS solution.  
  
-   You intend to deploy multiple WSUS servers \(for example, in branch offices\). In this case, you should consider using [!INCLUDE[nextref_wyukon](../Token/nextref_wyukon_md.md)] on the secondary servers, even if you will use SQL Server for the root WSUS server. Because each WSUS server requires a separate instance of SQL Server, you will quickly experience database performance issues if only one SQL Server handles multiple WSUS servers.  
  
[!INCLUDE[nextref_wyukon](../Token/nextref_wyukon_md.md)] does not provide a user interface or any database management tools. If you select this database for WSUS, you must use external tools to manage the database. You can back up and restore the [!INCLUDE[nextref_wyukon](../Token/nextref_wyukon_md.md)] database by using Windows Server Backup. For more information, see [Backup and Restore WSUS Data](../Topic/Backup-and-Restore-WSUS-Data.md) and [Backing Up Your Server](http://go.microsoft.com/fwlink/?LinkID=203517). You can reindex the [!INCLUDE[nextref_wyukon](../Token/nextref_wyukon_md.md)] database by using a published script.  
  
For more information about reindexing the [!INCLUDE[nextref_wyukon](../Token/nextref_wyukon_md.md)] database, see [Reindex the WSUS Database](../Topic/Reindex-the-WSUS-Database.md).  
  
### WSUS with SQL Server  
We recommend that you use SQL Server with WSUS in the following cases:  
  
-   You require an NLB WSUS solution.  
  
-   You already have at least one instance of SQL Server installed.  
  
You cannot run the SQL Server service under a local non\-system account or by using SQL Server authentication. WSUS supports Windows authentication only.  
  
## <a name="updatestorage"></a>WSUS update storage  
You can store update files on the local WSUS server, or you can leave approved updates on the Microsoft Update Web servers. In the first case, client computers will download approved updates from the local WSUS server. In the latter case, client computers will download approved updates directly from Microsoft Update. The option that makes the most sense for your organization will depend on network bandwidth to the Internet, network bandwidth on the intranet, and local storage availability.  
  
You can select a different update storage solution for each WSUS server that you deploy.  
  
### Local WSUS server storage  
Local storage of update files is the default option when you install and configure WSUS. This option can save bandwidth on the corporate connection to the Internet because client computers download updates directly from the local WSUS server.  
  
This option requires that the server have sufficient disk space to store all needed updates. At a minimum, WSUS requires 20 GB to store updates locally; however, we recommend 30 GB based on tested variables. For more information about storage capacity requirements and planning, see [WSUS Server minimum hardware requirements](assetId:///e8f62aba-4c8d-410e-9012-e3c9680a929b#hw) and [Determine Capacity Requirements](../Topic/Determine-Capacity-Requirements.md).  
  
### Remote storage on Microsoft Update servers  
You can store updates remotely on Microsoft Update servers. This option is useful if most client computers connect to the WSUS server over a slow WAN connection, but they connect to the Internet over a high\-bandwidth connection.  
  
In this case, the root WSUS server synchronizes with Microsoft Update and receives the update metadata. After you approve the updates, the client computers download the approved updates from Microsoft Update servers.  
  
The following drawing shows a WSUS configuration in which updates are stored on Microsoft Update. In this case, branch offices retrieve approved updates directly from Microsoft Update servers. This saves disk space and network bandwidth in the organization. This storage option can offer faster downloads for geographically distributed client computers.  
  
![](../Image/sus2_dpl_003c.gif)  
  
## <a name="bestpr"></a>WSUS storage planning best practices  
The following practices can help you conserve resources on your WSUS server:  
  
1.  Make sure that your WSUS server is configured to download only approved updates. When the server synchronizes updates, it downloads only the update metadata and will download the update files only after the update has been approved.  
  
2.  If a WSUS server serves only a few client computers, or if most of the client computers are roaming with Internet access, consider hosting update files on Microsoft Update instead of on the local WSUS server.  
  
3.  Approve only the updates that are actually needed by the client computers and limit the product updates to the products that are actually installed.  
  
4.  Synchronize only the update languages that are needed. If you must synchronize multiple languages and you store updates locally, you can estimate the required disk space by multiplying the recommended space times the number of update languages.  
  
5.  Enable WSUS to automatically decline expired updates. If for some reason you do not want to automatically decline expired updates, you should schedule a task to manually decline expired updates regularly.  
  
6.  Do not use express installation files unless you must minimize downloads between the WSUS server and its client computers. Express installation files typically reduce downloads from WSUS servers to client computers by a factor of two, but they increases downloads from Microsoft Update \(or an upstream server\) by a factor of four. You should evaluate which criteria are more important to your network: local network bandwidth, or server disk space and Internet bandwidth. For more information, see [Express installation files](../Topic/Design-for-Optimized-Performance.md#express).  
  
## See Also  
[Design the WSUS Server Layout](../Topic/Design-the-WSUS-Server-Layout.md)  
[Design for Optimized Performance](../Topic/Design-for-Optimized-Performance.md)  
[Manage WSUS 3.0 SP2 Storage](../Topic/Manage-WSUS-3.0-SP2-Storage.md)  
  
