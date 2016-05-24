---
title: DFS Namespaces and DFS Replication Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b201c1e6-91b2-46d9-a218-65db403f4154
---
# DFS Namespaces and DFS Replication Overview
This topic discusses the DFS Namespaces \(DFSN or DFS\-N\) and DFS Replication \(DFSR or DFS\-R\) role services, which together comprise Distributed File System \(DFS\) in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. This topic discusses how to install DFS, what’s new, and where to find evaluation and deployment information.  
  
**Did you mean…**  
  
-   [What's New in DFS Namespaces and DFS Replication in Windows Server 2012 R2](assetId:///7ced384c-ed6d-42dc-a813-cf3a28e77601)  
  
-   [DFS Management](http://technet.microsoft.com/library/cc732006.aspx) \(online Help\)  
  
-   [DFS Step\-by\-Step Guide for Windows Server 2008](http://technet.microsoft.com/library/cc732863.aspx)  
  
-   [DFS Replication: Frequently Asked Questions](http://technet.microsoft.com/library/cc773238.aspx)  
  
-   [DFS Namespaces: Frequently Asked Questions](http://technet.microsoft.com/library/ee404780.aspx)  
  
## <a name="BKMK_OVER"></a>Role service descriptions  
DFS Namespaces and DFS Replication are role services in the File and Storage Services role.  
  
-   **DFS Namespaces** Enables you to group shared folders that are located on different servers into one or more logically structured namespaces. Each namespace appears to users as a single shared folder with a series of subfolders. However, the underlying structure of the namespace can consist of numerous file shares that are located on different servers and in multiple sites.  
  
-   **DFS Replication** Enables you to efficiently replicate folders \(including those referred to by a DFS namespace path\) across multiple servers and sites. DFS Replication uses a compression algorithm known as remote differential compression \(RDC\). RDC detects changes to the data in a file, and it enables DFS Replication to replicate only the changed file blocks instead of the entire file.  
  
## Practical applications  
You can use DFS Namespaces and DFS Replication to achieve the following goals:  
  
-   **DFS Namespaces** Provide users with a centralized folder namespace through which to access and store files. You can host the underlying file shares on different servers and in different sites to improve availability and performance.  
  
-   **DFS Replication** Synchronize folder contents efficiently between servers, across LAN or WAN network connections.  
  
> [!NOTE]  
> DFS Replication can also be used to replicate the SYSVOL folder in Active Directory Domain Services \(AD DS\) in domains that use the [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Windows Server 2008 R2, or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain functional levels.  
  
## <a name="BKMK_NEW"></a>New and changed functionality  
The following table describes the changes in DFS Namespaces and DFS Replication functionality.  
  
For more information about what’s new in DFS Replication in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], see [What's New in DFS Namespaces and DFS Replication in Windows Server 2012 R2](assetId:///7ced384c-ed6d-42dc-a813-cf3a28e77601); for Windows Server 2012, see [What's New in DFS Namespaces and DFS Replication in Windows Server 2012 \[redirected\]](assetId:///c36d214f-e585-4021-970c-cd1344477853).  
  
|Feature\/functionality|New or updated?|Description|  
|--------------------------|-------------------|---------------|  
|Windows PowerShell module for DFS Replication|New in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|Provides Windows PowerShell cmdlets for performing the majority of administration tasks for DFS Replication, as well as new functionality.|  
|DFS Replication: Windows Management Infrastructure provider|New in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|Provides the latest Windows Management Infrastructure \(WMI\)\-based methods to manage DFS Replication.|  
|DFS Replication: Database cloning for initial sync|New in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|Provides support for bypassing initial replication when creating new replicated folders, replacing servers, or recovering from a disaster.|  
|DFS Replication: Database corruption recovery|New in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|Provides support for rebuilding corrupt databases without unexpected data loss caused by non\-authoritative initial sync.|  
|DFS Replication: Cross\-file RDC disable|New in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|Provides the option to disable cross\-file remote differential compression \(RDC\) between servers.|  
|DFS Replication: File staging tuning|New in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|Provides the option to configure variable file staging sizes on individual servers.|  
|DFS Replication: Preserved file restoration|New in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|Provides the capability to restore files from the ConflictAndDeleted and PreExisting folders.|  
|DFS Replication: Database dirty shutdown recovery|Updated in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|Enables automatic recovery after a loss of power or an unexpected stopping of the DFS Replication service.|  
|DFS Replication: Membership disable|Updated in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|Stops DFSR private folder cleanup when disabling a server’s membership in a replicated folder.|  
|Windows PowerShell module for DFS Namespaces|New in Windows Server 2012|Provides Windows PowerShell cmdlets for performing the majority of administration tasks for DFS Namespaces.|  
|DFS Namespaces: Site awareness for DirectAccess clients|New in Windows Server 2012|Provides remote client computers with optimal referrals to corporate resources when the computers connect by using DirectAccess to the corporate network.|  
|DFS Namespaces: Windows Management Infrastructure provider|New in Windows Server 2012|Provides the latest Windows Management Infrastructure\-based management methods to manage DFS Namespaces.|  
|DFS Replication: Support for Data Deduplication volumes|New in Windows Server 2012|Provides support for replicated folders stored on volumes that use Data Deduplication.|  
  
## <a name="BKMK_DEP"></a>Removed or deprecated functionality  
The following features are included in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], but they are being phased out, and they likely will be removed from future versions of the Windows Server operating system.  
  
|Deprecated feature|Replacement|  
|----------------------|---------------|  
|DFS Namespaces command\-line tool, Dfscmd|DFS Namespaces module for Windows PowerShell|  
|File Replication Service \(FRS\)|DFS Replication<br /><br />In [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], it is no longer possible to use Windows PowerShell or Server Manager to create new domains with a Windows Server 2003 domain functional level. This means that new FRS deployments are now blocked and DFS Replication will always be used for SYSVOL replication in new domains.|  
  
For a complete list of deprecated features in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], see [Features Removed or Deprecated in Windows Server 2012](../Topic/Features-Removed-or-Deprecated-in-Windows-Server-2012.md).  
  
For more information about FRS support in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and Windows Server 2008 R2, see [File Replication Service \(FRS\) Is Deprecated in Windows Server 2008 R2](http://msdn.microsoft.com/library/ff384840.aspx).  
  
## Requirements for running DFS  
There are no additional hardware or software requirements for running DFS Management or using DFS Namespaces.  
  
Before you can deploy DFS Replication, you must configure your servers as follows:  
  
-   Update the Active Directory Domain Services \(AD DS\) schema to include [!INCLUDE[win8_server_2_help](../Token/win8_server_2_help_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], or Windows Server 2003 R2 schema additions. \(If you install a domain controller running [!INCLUDE[win8_server_2_help](../Token/win8_server_2_help_md.md)] the schema is automatically updated.\) You cannot use read\-only replicated folders with the Windows Server 2003 R2 or older schema additions.  
  
-   Ensure that all servers in a replication group are located in the same forest. You cannot enable replication across servers in different forests.  
  
-   Install DFS Replication on all servers that will act as members of a replication group.  
  
-   Contact your antivirus software vendor to check that your antivirus software is compatible with DFS Replication.  
  
-   Locate any folders that you want to replicate on volumes formatted with the NTFS file system. DFS Replication does not support the Resilient File System \(ReFS\) or the FAT file system. DFS Replication also does not support replicating content stored on Cluster Shared Volumes.  
  
## <a name="BKMK_INSTALL"></a>Server Manager information  
DFS Namespaces and DFS Replication are a part of the File and Storage Services role. The management tools for DFS \(DFS Management, the DFS Namespaces module for Windows PowerShell, and command\-line tools\) are installed separately as part of the Remote Server Administration Tools.  
  
### Installing DFS Namespaces, DFS Replication, and DFS Management  
To install the role services and the DFS Management Tools, use one of the following methods.  
  
-   [Use Server Manager](#BKMK_UI)  
  
-   [Use Windows PowerShell](#BKMK_Cmd)  
  
##### <a name="BKMK_UI"></a>To install DFS by using Server Manager  
  
1.  Open Server Manager, click **Manage**, and then click **Add Roles and Features**. The Add Roles and Features Wizard appears.  
  
2.  On the **Server Selection** page, select the server or virtual hard disk \(VHD\) of an offline virtual machine on which you want to install DFS.  
  
3.  Select the role services and features that you want to install.  
  
    -   To install the DFS Namespaces and DFS Replication services, on the **Server Roles** page, select **DFS Namespaces** and **DFS Replication**.  
  
    -   To install only the DFS Management Tools, on the **Features** page, expand **Remote Server Administration Tools**, **Role Administration Tools**, expand **File Services Tools**, and then select **DFS Management Tools**.  
  
        **DFS Management Tools** installs the DFS Management snap\-in, the DFS Namespaces module for Windows PowerShell, and command\-line tools, but it does not install any DFS services on the server.  
  
##### <a name="BKMK_Cmd"></a>To install DFS by using Windows PowerShell  
  
-   Open a Windows PowerShell session with elevated user rights, and then type the following command, where <name> is the role service or feature that you want to install \(see the following table for a list of relevant role service or feature names\):  
  
    ```  
    Install-WindowsFeature <name>  
    ```  
  
    |Role service or feature|Name|  
    |---------------------------|--------|  
    |DFS Namespaces|`FS-DFS-Namespace`|  
    |DFS Replication|`FS-DFS-Replication`|  
    |DFS Management Tools|`RSAT-DFS-Mgmt-Con`|  
  
    For example, to install the Distributed File System Tools portion of the Remote Server Administration Tools feature, type:  
  
    ```  
    Install-WindowsFeature RSAT-DFS-Mgmt-Con  
    ```  
  
    To install the DFS Namespaces, DFS Replication, and the Distributed File System Tools portions of the Remote Server Administration Tools feature, type:  
  
    ```  
    Install-WindowsFeature FS-DFS-Namespace, FS-DFS-Replication, RSAT-DFS-Mgmt-Con  
    ```  
  
## Interoperability with [!INCLUDE[azure_2](../Token/azure_2_md.md)] virtual machines  
Using DFS Namespaces and DFS Replication on a virtual machine in [!INCLUDE[azure_2](../Token/azure_2_md.md)] has been tested with [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]; however, there are some limitations and requirements that you must follow.  
  
For DFS Namespaces:  
  
-   You can’t cluster stand\-alone namespaces in Azure virtual machines.  
  
-   You can host domain\-based namespaces in Azure virtual machines, including environments with [!INCLUDE[aad_2](../Token/aad_2_md.md)], though a single namespace can’t encompass both on premise namespace servers and namespace servers hosted in Azure VMs, even when using Active Directory Federation Services.  
  
For DFS Replication:  
  
-   Using snapshots or saved states to restore a server running DFS Replication for replication of anything other than the SYSVOL folder causes DFS Replication to fail, which requires special database recovery steps. Similarly, don’t export, clone, or copy the virtual machines. For more information, see article [2517913](http://support.microsoft.com/kb/2517913) in the Microsoft Knowledge Base, as well as [Safely Virtualizing DFSR](http://blogs.technet.com/b/filecab/archive/2013/04/05/safely-virtualizing-dfsr.aspx).  
  
-   When backing up data in a replicated folder hosed in a virtual machine, you must use backup software from within the guest virtual machine.  
  
-   DFS Replication requires access to physical or virtualized domain controllers – it can’t communicate directly with [!INCLUDE[aad_2](../Token/aad_2_md.md)].  
  
-   DFS Replication requires a VPN connection between your on premise replication group members and any members hosted in Azure VMs. You also need to configure the on premise router \(such as Forefront Threat Management Gateway\) to allow the RPC Endpoint Mapper \(port 135\) and a randomly assigned port between 49152 and 65535 to pass over the VPN connection. You can use the Set\-DfsrMachineConfiguration cmdlet or the Dfsrdiag command line tool to specify a static port instead of the random port. For more information about how to specify a static port for DFS Replication, see [Set\-DfsrServiceConfiguration](http://technet.microsoft.com/library/dn296587.aspx). For information about related ports to open for managing Windows Server, see article [832017](http://support.microsoft.com/kb/832017) in the Microsoft Knowledge Base.  
  
To learn about how to get started with Azure virtual machines, visit the [Microsoft Azure web site](http://www.windowsazure.com/documentation/services/virtual-machines).  
  
## <a name="BKMK_LINKS"></a>See also  
For additional related information, see the following resources.  
  
|Content type|References|  
|----------------|--------------|  
|**Product evaluation**|[What's New in DFS Namespaces and DFS Replication](assetId:///7ced384c-ed6d-42dc-a813-cf3a28e77601) \([!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]\) &#124; [What's New in DFS Namespaces and DFS Replication in Windows Server 2012 \[redirected\]](assetId:///c36d214f-e585-4021-970c-cd1344477853) \(Windows Server 2012\) &#124; [What's New in Distributed File System in Windows Server 2008 R2](http://technet.microsoft.com/library/ee307957.aspx)|  
|**Deployment**|[SYSVOL Replication Migration Guide: FRS to DFS Replication](http://technet.microsoft.com/library/dd640019.aspx) &#124; [DFS Operations Guide: Migrating from FRS to DFS Replication](http://go.microsoft.com/fwlink/p/?LinkID=192776) &#124; [DFS Namespace Scalability Considerations](http://blogs.technet.com/b/filecab/archive/2012/08/26/dfs-namespace-scalability-considerations.aspx)|  
|**Operations**|[DFS Namespaces: Frequently Asked Questions](http://technet.microsoft.com/library/ee404780.aspx) &#124; [DFS Replication: Frequently Asked Questions](http://technet.microsoft.com/library/cc773238.aspx) &#124; [Administering DFS\-Replicated SYSVOL](http://technet.microsoft.com/library/cc816919.aspx) &#124; [Windows Server 2008 Command Reference](http://technet.microsoft.com/library/cc754340.aspx)|  
|**Troubleshooting**|[Understanding DFSR Dirty \(Unexpected\) Shutdown Recovery](http://blogs.technet.com/b/filecab/archive/2012/07/23/understanding-dfsr-dirty-unexpected-shutdown-recovery.aspx) &#124; [Types of DFS Replication Errors](http://msdn.microsoft.com/library/dd340946.aspx) &#124; [DFSR Event 1008 \(DFS Replication\)](http://social.technet.microsoft.com/wiki/contents/articles/dfsr-event-1008-dfs-replication.aspx) &#124; [DFSR Event 1202 \(DFS Replication\)](http://social.technet.microsoft.com/wiki/contents/articles/dfsr-event-1202-dfs-replication.aspx) &#124; [DFSR Event 5002 \(DFS Replication\)](http://social.technet.microsoft.com/wiki/contents/articles/dfsr-event-5002-dfs-replication.aspx) &#124; [DFSR Event 5012 \(DFS Replication\)](http://social.technet.microsoft.com/wiki/contents/articles/dfsr-event-5012-dfs-replication.aspx) &#124; [DFSR Event 6002 \(DFS Replication\)](http://social.technet.microsoft.com/wiki/contents/articles/dfsr-event-6002-dfs-replication.aspx)|  
|**Community resources**|[The File Services and Storage TechNet Forum](http://social.technet.microsoft.com/forums/winserverfiles/threads/) &#124; [DFSR in Windows Server 2012 R2](http://curah.microsoft.com/33103/dfsr-in-windows-server-2012-r2) \(curated links on Curah\!\)&#124; [Storage Team at Microsoft File Cabinet Blog](http://blogs.technet.com/filecab/) &#124; [Ask the Directory Services Team Blog](http://blogs.technet.com/b/askds/) &#124; [Jose Barreto's Blog](http://blogs.technet.com/b/josebda/) &#124;[DFS Replication Survival Guide \(TechNet Wiki\)](http://social.technet.microsoft.com/wiki/contents/articles/dfs-replication-survival-guide.aspx) &#124; [Windows Server Information Experience on Twitter](http://twitter.com/windowsserver)|  
|**Protocols**|[File Services Windows Server Protocols](http://msdn.microsoft.com/library/cc239875.aspx)|  
|**Related technologies**|[Folder Redirection, Offline Files, and Roaming User Profiles overview](../Topic/Folder-Redirection,-Offline-Files,-and-Roaming-User-Profiles-overview.md) &#124; [Failover Clustering](assetId:///6eeffe4f-3558-495b-bcea-c640fe4d6c49)|  
  
