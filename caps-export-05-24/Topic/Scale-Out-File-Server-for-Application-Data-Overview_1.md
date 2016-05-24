---
title: Scale-Out File Server for Application Data Overview_1
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0a6029b2-9390-414f-b486-98d31d033ff0
---
# Scale-Out File Server for Application Data Overview_1
Scale\-Out File Server is a feature that is designed to provide scale\-out file shares that are continuously available for file\-based server application storage. Scale\-out file shares provides the ability to share the same folder from multiple nodes of the same cluster. This scenario focuses on how to plan for and deploy Scale\-Out File Server.  
  
|||  
|-|-|  
|![](b93f8edc-baa1-46ad-aed5-99c8690273c0)|Did you know that Microsoft Azure provides similar functionality in the cloud? Learn more about [Microsoft Azure storage solutions](http://aka.ms/y03tdi).<br /><br />Create a hybrid storage solution in Microsoft Azure:<br />\- [Migrate to Azure Premium Storage](http://aka.ms/mk36m5)<br />\- [Learn about StorSimple hybrid cloud storage](http://aka.ms/fuxxdp)|  
  
You can deploy and configure a clustered file server by using either of the following methods:  
  
-   **Scale\-Out File Server for application data** This clustered file server feature was introduced in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and it lets you store server application data, such as Hyper\-V virtual machine files, on file shares, and obtain a similar level of reliability, availability, manageability, and high performance that you would expect from a storage area network. All file shares are simultaneously online on all nodes. File shares associated with this type of clustered file server are called scale\-out file shares. This is sometimes referred to as active\-active. This is the recommended file server type when deploying either Hyper\-V over Server Message Block \(SMB\) or Microsoft SQL Server over SMB.  
  
-   **File Server for general use** This is the continuation of the clustered file server that has been supported in Windows Server since the introduction of Failover Clustering. This type of clustered file server, and therefore all the shares associated with the clustered file server, is online on one node at a time. This is sometimes referred to as active\-passive or dual\-active. File shares associated with this type of clustered file server are called clustered file shares. This is the recommended file server type when deploying information worker scenarios.  
  
## <a name="BKMK_OVER"></a>Scenario description  
With scale\-out file shares, you can share the same folder from multiple nodes of a cluster. For instance, if you have a four\-node file server cluster that is using Server Message Block \(SMB\) Scale\-Out, a computer running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] can access file shares from any of the four nodes. This is achieved by leveraging new Windows Server Failover Clustering features and the capabilities of the Windows file server protocol, SMB 3.0. File server administrators can provide scale\-out file shares and continuously available file services to server applications and respond to increased demands quickly by simply bringing more servers online. All of this can be done in a production environment, and it is completely transparent to the server application.  
  
Key benefits provided by Scale\-Out File Server in include:  
  
-   **Active\-Active file shares** All cluster nodes can accept and serve SMB client requests. By making the file share content accessible through all cluster nodes simultaneously, SMB 3.0 clusters and clients cooperate to provide transparent failover to alternative cluster nodes during planned maintenance and unplanned failures with service interruption.  
  
-   **Increased bandwidth** The maximum share bandwidth is the total bandwidth of all file server cluster nodes. Unlike previous versions of Windows Server, the total bandwidth is no longer constrained to the bandwidth of a single cluster node; but rather, the capability of the backing storage system defines the constraints. You can increase the total bandwidth by adding nodes.  
  
-   **CHKDSK with zero downtime** CHKDSK in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] is significantly enhanced to dramatically shorten the time a file system is offline for repair. Clustered shared volumes \(CSVs\) take this one step further by eliminating the offline phase. A CSV File System \(CSVFS\) can use CHKDSK without impacting applications with open handles on the file system.  
  
-   **Clustered Shared Volume cache** CSVs in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] introduces support for a Read cache, which can significantly improve performance in certain scenarios, such as in Virtual Desktop Infrastructure \(VDI\).  
  
-   **Simpler management** With Scale\-Out File Server, you create the scale\-out file servers, and then add the necessary CSVs and file shares. It is no longer necessary to create multiple clustered file servers, each with separate cluster disks, and then develop placement policies to ensure activity on each cluster node.  
  
-   **Automatic rebalancing of Scale\-Out File Server clients** In [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], automatic rebalancing improves scalability and manageability for scale\-out file servers. SMB client connections are tracked per file share \(instead of per server\), and clients are then redirected to the cluster node with the best access to the volume used by the file share. This improves efficiency by reducing redirection traffic between file server nodes. Clients are redirected following an initial connection and when cluster storage is reconfigured.  
  
## In this scenario  
The following topics are available to help you deploy a Scale\-Out File Server:  
  
-   [Plan for Scale\-out File Server](assetId:///f2206f48-3658-4fb3-9f18-6ffcd732e488)  
  
    -   [Step 1: Plan for storage in Scale\-out File Server](assetId:///56490f5d-358b-473f-825c-7428a9753120)  
  
    -   [Step 2: Plan for networking in Scale\-out File Server](assetId:///e0625935-bd81-415f-a310-ffbe5dc427b1)  
  
-   [Deploy Scale\-Out File Servers](assetId:///11415db9-8fb8-4aea-a6c0-38f706a0586e)  
  
    -   [Step 1: Install prerequisites for Scale\-Out File Server](assetId:///3847444c-b148-4d45-bb40-ce438ef36cd6)  
  
    -   [Step 2: Configure Scale\-Out File Server](assetId:///b5e3a0c1-d4e8-4761-975a-10c042c7455e)  
  
    -   [Step 3: Configure Hyper-V to Use Scale-Out File Server](../Topic/Step-3--Configure-Hyper-V-to-Use-Scale-Out-File-Server.md)  
  
    -   [Step 4: Configure Microsoft SQL Server to Use Scale-Out File Server](../Topic/Step-4--Configure-Microsoft-SQL-Server-to-Use-Scale-Out-File-Server.md)  
  
## When to use Scale\-Out File Server  
You should not use Scale\-Out File Server if your workload generates a high number of metadata operations, such as opening files, closing files, creating new files, or renaming existing files. A typical information worker would generate a lot of metadata operations. You should use a Scale\-Out File Server if you are interested in the scalability and simplicity that it offers and if you only require technologies that are supported with Scale\-Out File Server.  
  
The following table lists the capabilities in SMB 3.0, the common Windows file systems, file server data management technologies, and common workloads. You can see whether the technology is supported with Scale\-Out File Server, or if it requires a traditional clustered file server \(also known as a file server for general use\).  
  
|Technology Area|Feature|General Use File Server Cluster|Scale\-Out File Server|  
|-------------------|-----------|-----------------------------------|--------------------------|  
|SMB|SMB Continuous Availability|Yes|Yes|  
|SMB|SMB Multichannel|Yes|Yes|  
|SMB|SMB Direct|Yes|Yes|  
|SMB|SMB Encryption|Yes|Yes|  
|SMB|SMB Transparent failover|Yes \(if continuous availability is enabled\)|Yes|  
|File System|NTFS|Yes|NA|  
|File System|Resilient File System ReFS\)|Yes|NA|  
|File System|Cluster Shared Volume File System \(CSV\)|NA|Yes|  
|File Management|BranchCache|Yes|No|  
|File Management|Data Deduplication \(Windows Server 2012\)|Yes|No|  
|File Management|Data Deduplication \(Windows Server 2012 R2\)|Yes|Yes \(VDI only\)|  
|File Management|DFS Namespace \(DFSN\) root server root|Yes|No|  
|File Management|DFS Namespace \(DFSN\) folder target server|Yes|Yes|  
|File Management|DFS Replication \(DFSR\)|Yes|No|  
|File Management|File Server Resource Manager \(Screens and Quotas\)|Yes|No|  
|File Management|File Classification Infrastructure|Yes|No|  
|File Management|Dynamic Access Control \(claim\-based access, CAP\)|Yes|No|  
|File Management|Folder Redirection|Yes|Not recommended\*|  
|File Management|Offline Files \(client side caching\)|Yes|Not recommended\*|  
|File Management|Roaming User Profiles|Yes|Not recommended\*|  
|File Management|Home Directories|Yes|Not recommended\*|  
|File Management|Work Folders|Yes|No|  
|NFS|NFS Server|Yes|No|  
|Applications|Hyper\-V|Not recommended|Yes|  
|Applications|Microsoft SQL Server|Not recommended|Yes|  
  
\* Folder Redirection, Offline Files, Roaming User Profiles, or Home Directories generate a large number of writes that must be immediately written to disk \(without buffering\) when using continuously available file shares, reducing performance as compared to general purpose file shares. Continuously available file shares are also incompatible with File Server Resource Manager and PCs running Windows XP. Additionally, Offline Files might not transition to offline mode for 3\-6 minutes after a user loses access to a share, which could frustrate users who aren’t yet using the Always Offline mode of Offline Files.  
  
## <a name="BKMK_APP"></a>Practical applications  
Scale\-Out File Servers are ideal for server application storage. Some examples of server applications that can store their data on a scale\-out file share are listed below:  
  
-   The Internet Information Services \(IIS\) Web server can store configuration and data for Web sites on a scale\-out file share. For more information, see [Shared Configuration](http://www.iis.net/learn/manage/managing-your-configuration-settings/shared-configuration_264).  
  
-   Hyper\-V can store configuration and live virtual disks on a scale\-out file share. For more information, see [Deploy Hyper\-V over SMB](assetId:///5a169fa2-f5c8-4c0d-a122-79ecdbdebc98).  
  
-   SQL Server can store live database files on a scale\-out file share. For more information, see [Install SQL Server with SMB file share as a storage option](http://msdn.microsoft.com/en-us/library/hh759341.aspx).  
  
-   Virtual Machine Manager \(VMM\) can store a library share \(which contains virtual machine templates and related files\) on a scale\-out file share. However, the library server itself can't be a Scale\-Out File Server \- it must be on a stand\-alone server or a failover cluster that doesn't use the Scale\-Out File Server cluster role.  
  
    If you use a scale\-out file share as a library share, you can use only technologies that are compatible with Scale\-Out File Server. For example, you can’t use DFS Replication to replicate a library share hosted on a scale\-out file share. It's also important that the scale\-out file server have the latest software updates installed.  
  
    To use a scale\-out file share as a library share, first add a library server \(likely a virtual machine\) with a local share or no shares at all. Then when you add a library share, choose a file share that’s hosted on a scale\-out file server. This share should be VMM\-managed and created exclusively for use by the library server. Also make sure to install the latest updates on the scale\-out file server. For more information about adding VMM library servers and library shares, see [How to Add a VMM Library Server or VMM Library Share](http://technet.microsoft.com/en-us/library/gg610579.aspx). For a list of currently available hotfixes for File and Storage Services, see [Microsoft Knowledge Base article 2899011](http://support.microsoft.com/kb/2899011).  
  
> [!NOTE]  
> Some users, such as information workers, have workloads that have a greater impact on performance. For example, operations like opening and closing files, creating new files, and renaming existing files, when performed by multiple users, have an impact on performance. If a file share is enabled with continuous availability, it provides data integrity, but it also affects the overall performance. Continuous availability requires that data writes through to the disk to ensure integrity in the event of a failure of a cluster node in a Scale\-Out File Server. Therefore, a user that copies several large files to a file server can expect significantly slower performance on continuously available file share.  
  
## <a name="BKMK_NEW"></a>Features included in this scenario  
The following table lists the features that are part of this scenario and describes how they support it.  
  
|Feature|How it supports this scenario|  
|-----------|---------------------------------|  
|[Failover Clustering](assetId:///6eeffe4f-3558-495b-bcea-c640fe4d6c49)|Failover clusters added the following features in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to support scale\-Out file server: Distributed Network Name, the Scale\-Out File Server resource type, Cluster Shared Volumes \(CSV\) 2, and the Scale\-Out File Server High Availability role. For more information about these features, see [What's New in Failover Clustering in Windows Server 2012 \[redirected\]](assetId:///187d6191-4f92-4f98-9cae-c5e6d5b74e76) on Microsoft TechNet.|  
|[Server Message Block Overview](../Topic/Server-Message-Block-Overview.md)|SMB 3.0 added the following features in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to support scale\-Out File Server: SMB Transparent Failover, SMB Multichannel, and SMB Direct.<br /><br />For more information on new and changed functionality for SMB in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], see [What's New in SMB in Windows Server 2012 R2](assetId:///46c0ac80-a54a-4324-948a-2dee66bcec75).|  
  
## See also  
  
-   [Provide cost\-effective storage for Hyper\-V workloads by using Windows Server](http://technet.microsoft.com/en-us/library/dn554251.aspx)  
  
-   [Increasing Server, Storage, and Network Availability: scenario overview](assetId:///22c42d93-e045-4491-8906-4273569d160f)  
  
-   [Deploy Hyper\-V over SMB](assetId:///5a169fa2-f5c8-4c0d-a122-79ecdbdebc98)  
  
-   [Deploying Fast and Efficient File Servers for Server Applications](assetId:///b70360f2-d079-47d3-b3f4-4f29fe6d6095)  
  
-   [To scale out or not to scale out, that is the question](http://blogs.technet.com/b/filecab/archive/2013/12/05/to-scale-out-or-not-to-scale-out-that-is-the-question.aspx) \(blog post\)  
  
-   [Folder Redirection, Offline Files, and Roaming User Profiles overview](../Topic/Folder-Redirection,-Offline-Files,-and-Roaming-User-Profiles-overview.md)  
  
