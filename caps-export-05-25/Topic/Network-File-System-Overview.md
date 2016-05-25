---
title: Network File System Overview
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 00ee2cd2-bda5-48dc-ac4c-e741a190a5de
author: JasonGerend
---
# Network File System Overview
This topic describes the Network File System role service and features that are included with the File and Storage Services server role in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. Network File System \(NFS\) provides a file sharing solution for enterprises that have heterogeneous environments that consist of both Windows and non\-Windows computers.  
  
**Did you mean…**  
  
-   [Deploy Network File System](../Topic/Deploy-Network-File-System.md)  
  
-   [File and Storage Services Overview](../Topic/File-and-Storage-Services-Overview.md)  
  
-   [Services for NFS Step\-by\-Step Guide for Windows Server 2008 R2](http://technet.microsoft.com/library/dd758767(v=ws.10).aspx)  
  
## <a name="BKMK_OVER"></a>Feature description  
Using the NFS protocol, you can transfer files between computers running Windows and other non\-Windows operating systems, such as Linux or UNIX.  
  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], NFS includes the components, Server for NFS and Client for NFS. Server for NFS enables a computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to act as a NFS file server for other non\-Windows client computers. Client for NFS enables a Windows\-based computer that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to access files that are stored on a non\-Windows NFS server.  
  
## <a name="BKMK_APP"></a>Practical applications  
Some practical applications for NFS include:  
  
-   Use a Windows NFS file server to provide multi\-protocol access to the same file share over both the SMB and NFS protocols from multi\-platform clients.  
  
-   Deploy a Windows NFS file server in a predominantly non\-Windows operating system environment to provide access to NFS file shares for non\-Windows client computers.  
  
-   Migrate applications from one operating system to another by storing the data on file shares that are accessible by both SMB and NFS protocols.  
  
## New and changed functionality  
New and changed functionality in Network File System includes support for the NFS version 4.1 and easier deployment and manageability. For information about functionality that is new or changed in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], review the following table:  
  
|Feature\/functionality|New or updated|Description|  
|--------------------------|------------------|---------------|  
|[NFS version 4.1](../Topic/Network-File-System-Overview.md#BKMK_NFSv41)|New|Increases security, performance, and interoperability over NFS version 3.|  
|[NFS infrastructure](../Topic/Network-File-System-Overview.md#BKMK_Infrastructure)|Updated|Provides easier deployment and manageability, and increases security.|  
|[NFS version 3 continuous availability](../Topic/Network-File-System-Overview.md#BKMK_CA)|Updated|Improves continuous availability on NFS version 3 clients.|  
|[Deployment and manageability improvements](../Topic/Network-File-System-Overview.md#BKMK_manage)|Updated|Enables you to easily deploy and manage NFS using new Windows PowerShell cmdlets and a new WMI provider.|  
||||  
  
### <a name="BKMK_NFSv41"></a>NFS version 4.1  
NFS version 4.1 implements all of the required aspects, in addition to some of the optional aspects, of [RFC 5661](http://tools.ietf.org/html/rfc5661):  
  
-   **Pseudo file system.** This file system includes a separation of the physical and logical namespace and is compatible with NFS version 3 and NFS version 2. An alias is provided for the exported file system, which is part of the pseudo file system.  
  
-   **Compound RPCs.** Combines relevant operations and reduces chattiness.  
  
-   **Sessions and session trunking.** Enables just one semantic and allows continuous availability and better performance while utilizing multiple networks between NFS 4.1 clients and the NFS Server.  
  
### <a name="BKMK_Infrastructure"></a>NFS infrastructure  
Improvements to the overall NFS infrastructure in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] are detailed below:  
  
-   **Remote Procedure Call \(RPC\)\/External Data Representation \(XDR\).** The RPC\/XDR transport infrastructure is powered by the WinSock network protocol and is available for both Server for NFS and Client for NFS. This replaces Transport Device Interface \(TDI\), offers better support, and provides better scalability and Receive Side Scaling \(RSS\).  
  
-   **RPC port multiplexer.** This feature is firewall\-friendly \(less ports to manage\) and simplifies deployment of NFS.  
  
-   **Auto\-tuned caches and thread pools.** The resource management capability of the new RPC\/XDR infrastructure is dynamic and automatically tunes the cache and thread pools based on the workload. This completely removes the guesswork involved when tuning parameters, and therefore, provides optimal performance as soon as NFS is deployed.  
  
-   **New Kerberos privacy implementation and authentication options.** NFS deployments are more secure with the addition of Kerberos privacy \(Krb5p\) support along with the existing krb5 and krb5i authentication options.  
  
-   **Identity Mapping Windows PowerShell module.** These new cmdlets make it easier to manage identity mapping, configure Active Directory Lightweight Directory Services \(AD LDS\), and set up UNIX and Linux passwd and flat files.  
  
-   **Volume mount point.** Volumes mounted under an NFS share can be accessed using NFS version 4.1.  
  
-   **Port Multiplexing.** This feature supports the RPC port multiplexer \(port 2049\), which is firewall\-friendly and simplifies deployment of NFS.  
  
### <a name="BKMK_CA"></a>NFS version 3 continuous availability  
NFS version 3 clients can have fast and transparent failovers with more availability and reduced downtime. The failover process is faster for NFS version 3 clients because:  
  
-   The clustering infrastructure now allows one resource per network name instead of one resource per share. This significantly improves the failover time of resources.  
  
-   Failover paths within an NFS server are tuned for better performance.  
  
-   Wildcard registration in an NFS server is no longer required, and the failovers are more fine\-tuned.  
  
-   Network Status Monitor \(NSM\) notifications are sent out after a failover process and clients no longer need to wait for TCP timeouts to reconnect to the server that failed over.  
  
### <a name="BKMK_manage"></a>Deployment and manageability improvements  
Deploying and managing NFS has improved in the following ways:  
  
-   Over forty new Windows PowerShell cmdlets make it easier to configure and manage NFS file shares. For more information, see [NFS Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/jj603081.aspx).  
  
-   Identity mapping is improved with a local flat file mapping store and with new Windows PowerShell cmdlets available to configure identity mapping.  
  
-   The Server Manager graphical user interface is easier to use.  
  
-   The new WMI version 2 provider is available for easier management.  
  
-   The RPC port multiplexer \(port 2049\) is firewall\-friendly and simplifies deployment of NFS.  
  
## Server Manager information  
In Server Manager, use the Add Roles and Features Wizard to add the Server for NFS role service \(under the File and iSCSI Services role\). For general information about installing features, see [Install or Uninstall Roles, Role Services, or Features](http://go.microsoft.com/fwlink/p/?LinkID=239563). Tools for Server for NFS include the Services for Network File System MMC snap\-in to manage the Server for NFS and Client for NFS components. Using the snap\-in, you can manage the Server for NFS components that are installed on the computer. Server for NFS also contains several Windows command\-line administration tools:  
  
-   **Mount.** Mounts a remote NFS share \(also known as an export\) locally and maps it to a local drive letter on the Windows client computer.  
  
-   **Nfsadmin.** Manages configuration settings of the Server for NFS and Client for NFS components.  
  
-   **Nfsshare.** Configures NFS share settings for folders that are shared using Server for NFS.  
  
-   **Nfsstat.** Displays or resets statistics of calls received by Server for NFS.  
  
-   **Showmount.** Displays mounted file systems exported by Server for NFS.  
  
-   **Umount.** Removes NFS\-mounted drives.  
  
NFS in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] introduces the NFS module for Windows PowerShell with several new cmdlets specifically for NFS. These cmdlets provide an easy way to automate NFS management tasks. For more information, see [NFS Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/jj603081.aspx).  
  
## <a name="BKMK_LINKS"></a>See also  
The following table provides additional resources for evaluating NFS.  
  
|Content type|References|  
|----------------|--------------|  
|**Deployment**|[Deploy Network File System](../Topic/Deploy-Network-File-System.md)|  
|**Operations**|[NFS Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/jj603081.aspx)|  
|**Related technologies**|[File and Storage Services Overview](../Topic/File-and-Storage-Services-Overview.md)|  
  
