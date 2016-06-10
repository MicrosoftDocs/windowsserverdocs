---
title: Data Deduplication Interoperability
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3a11f03a-58e4-402b-938a-6ab334cbba11
author: JasonGerend
---
# Data Deduplication Interoperability
When using the Data Deduplication feature for the first time or migrating from a previous version of Windows Server, be sure to consider the following related technologies and issues:  
  
-   BranchCache  
  
-   Failover Clusters  
  
-   DFS Replication  
  
-   FSRM quotas  
  
-   Single Instance Storage  
  
## BranchCache  
Access to the data over the network can be optimized by enabling BranchCache on servers and clients. When a BranchCache\-enabled system communicates over a WAN with a remote  file server that is running data deduplication, all of the deduplicated files are already indexed and hashed, so requests for data from a branch office are quickly computed. This is similar to preindexing or prehashing a BranchCache\-enabled server.  
  
**About BranchCache** BranchCache is a feature that can reduce wide area network \(WAN\) utilization and enhance network application responsiveness when users access content in a central office from branch office locations. When you enable BranchCache, a copy of the content that is retrieved from the web server or file server is cached within the branch office. If another client in the branch requests the same content, the client can download it directly from the local branch network without needing to retrieve the content by using the WAN.  
  
## Failover clusters  
Failover clusters are fully supported, and deduplicated volumes will failover gracefully. Each node that accesses deduplicated volumes must be running the Data Deduplication feature. A deduplicated volume is a self\-contained and portable unit—all of the data and configuration information is contained on the volume. Deduplication schedules are managed by using the task scheduler and when a cluster is formed, the schedule information is put into the schedule for the cluster. If a deduplicated volume is taken over by another node, the scheduled job will be applied on the next scheduled interval.  
  
## DFS Replication  
Data Deduplication works fine with Distributed File System \(DFS\) Replication. Optimizing or unoptimizing a file will not trigger a replication because the file does not change. DFS Replication uses Remote Differential Compression \(RDC\), not the chunks in the chunk store, for over\-the\-wire savings. The files on the replica can also be optimized by using deduplication if the replica is using Data Deduplication.  
  
## File Server Resource Manager quotas  
Creating a hard quota on a volume root folder that also has deduplication enabled is not supported. When a hard quota is present on a volume root, the actual free space on the volume and the quota restricted space on the volume are not the same. This may cause deduplication optimization jobs to fail.  
  
Creating a soft quota on a volume root that has deduplication enabled is supported. When FSRM quotas encounter a deduplicated file, File Server Resource Manager accounts for it based on the file’s logical size. Quota usage \(including any quota thresholds\) does not change when a file is processed by deduplication. All other FSRM quota functionality, including volume\-root soft quotas and quotas on subfolders, work normally when using deduplication.  
  
## Single Instance Storage  
Volumes that have been created and optimized by using the Windows Storage Server version of deduplication, Single Instance Storage \(SIS\), must not also run Data Deduplication. We recommend that prior to migrating a volume to  Windows Server 2012 R2  or  Windows Server 2012 , you remove SIS from the volume by using SISAdmin.exe within Windows Storage Server or by copying the data to a different volume that is not running SIS.  Windows Server 2012 R2  and  Windows Server 2012  support reading and writing to SIS\-controlled volumes, but you cannot continue to use SIS by using  Windows Server 2012 R2  or  Windows Server 2012 . You can use the following command syntax to install the SIS\-Limited feature \(which includes the SIS filter driver\) on  Windows Server 2012 R2  or  Windows Server 2012 :  
  
You can install the SIS filter driver to read SIS\-controlled volumes. The data can be copied to a non\-SIS controlled volume so that data deduplication can be installed on the volume.  
  
You can use the following command syntax to install the SIS\-Limited feature \(which includes the SIS filter driver\) on  Windows Server 2012 R2  or  Windows Server 2012 :  
  
```  
C:\> dism /online /enable-feature:SIS-Limited  
```  
  
> [!NOTE]  
>  Windows Server 2012 R2  and  Windows Server 2012  do not support sisadmin.exe and cannot be used to remove SIS from a volume.  
  
Before you install the SIS filter driver, consider the following:  
  
1.  You should remove SIS from your volumes before you install Data Deduplication.  
  
2.  Do not restore SIS links from a backup to a deduplicated volume.  
  
3.  Restoring SIS volumes to  Windows Server 2012 R2  or  Windows Server 2012  is supported if you load the SIS\-Limited feature.  
  
### Migrating SIS volumes  
You have several options when it comes to migrating Windows Storage Server 2008 volumes to  Windows Server 2012 R2  or  Windows Server 2012  to take advantage of the Data Deduplication feature.  
  
You can migrate your existing SIS\-installed Windows Storage Server 2008 volumes. However, migration is not automatic because Single Instance Storage \(SIS\) and data deduplication are mutually\-exclusive technologies.  
  
You need to first open the volumes in Windows Storage Server 2008, remove SIS from the volumes, and then uninstall SIS before migrating to  Windows Server 2012 .  
  
**To remove SIS**  
  
-   From a command prompt in Windows Storage Server 2008 R2 or Windows Storage Server 2008, type:  
  
    ```  
    sisadmin.exe [/m <server>] [/u <volumes>  
    ```  
  
    where:  
  
    **\/m <server>** shifts the focus of the command line to a remote server. If the **\/m** option is not specified, the command line is applied to the local server. **<server>** can be expressed as a host name, fully qualified domain name \(FQDN\), or an IP address.  
  
    **\/u <volumes>** is used to remove SIS from a volume. This restores all file copies and removes reparse points.  
  
    For each command option that uses **<volumes>** as a parameter, **<volumes>** represents a space\-delimited list of volume names \(for example, D: E: F: G:\).  
  
    For example:  
  
    To remove SIS entirely from volume F: of a remote server by using the IP address of the server, you might use the following command:  
  
    ```  
    sisadmin.exe /m 192.168.1.50 /u F:  
    ```  
  
## Windows Search  
Windows Search unfortunately doesn’t support Data Deduplication. Because Data Deduplication uses reparse points, which Windows Search can’t index, Windows Search skips all deduplicated files, excluding them from the index. As a result, search results might be incomplete for deduplicated volumes.  
  

