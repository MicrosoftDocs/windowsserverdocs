---
title: DFS Replication overview
description: Learn how to use the Distributed File System (DFS) Replication role service in Windows Server to replicate folders across multiple servers and sites.
ms.date: 03/24/2023
author: JasonGerend
manager: elizapo
ms.author: jgerend
ms.topic: conceptual
---

# DFS Replication overview

> **Applies To**: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

Distributed File System Replication, or DFS Replication, is a role service in Windows Server that enables you to efficiently replicate folders across multiple servers and sites. You can replicate all types of folders, including folders referred to by a DFS namespace path.

DFS Replication is an efficient, multiple-master replication engine that you can use to keep folders synchronized between servers across limited bandwidth network connections. The service replaces the File Replication Service (FRS) as the replication engine for DFS namespaces.

> [!TIP]
> Consider using [Azure File Sync](/azure/storage/file-sync/file-sync-introduction) to reduce your on-premises storage footprint. Azure File Sync can keep multiple Windows file servers in sync. Each server needs to only keep a cache on-premises while the full copy of the data is in the cloud. Azure File Sync also provides the benefit of cloud backups with integrated snapshots. For more information, see [Planning for an Azure File Sync deployment](/azure/storage/file-sync/file-sync-planning).

DFS Replication uses a compression algorithm known as _remote differential compression_, or RDC. RDC detects changes to the data in a file and enables DFS Replication to replicate only the changed file blocks instead of the entire file.

Active Directory Domain Services (AD DS) uses DFS Replication to replicate the sysvol folder in domains that use the Windows Server 2008 or later domain functional level. For more information about replicating the sysvol folder by using DFS Replication, see [Migrate the sysvol folder replication to DFS Replication](migrate-sysvol-to-dfsr.md).

## Understand replication groups

To use DFS Replication, you create _replication groups_ and add replicated folders to the groups. Replicated folders are stored on servers in the group, which are referred to as _members_. DFS Replication establishes connections between the members of a group.

The following figure illustrates the relationship between a replication group, the members in the group, and the replicated folders. 

:::image type="content" source="./media/dfsr-overview.gif" alt-text="Image that shows a replication group with a connection between two members that each have replicated folders." border="false":::

A _replicated folder_ stays synchronized on each member in a group. In the figure, there are two replicated folders: Projects and Proposals. As the data changes in each replicated folder, the changes are replicated across connections between the members of the replication group. The connections between all members form the replication topology.

Creating multiple replicated folders in a single replication group simplifies the process of deploying replicated folders. The topology, schedule, and bandwidth throttling for the replication group are applied to each replicated folder. To deploy more replicated folders, you can run the Dfsradmin.exe tool or use a wizard to define the local path and permissions for the new replicated folder.

Each replicated folder has unique settings, such as file and subfolder filters. The settings let you filter out different files and subfolders for each replicated folder.

The replicated folders stored on each member can be located on different volumes in the member, and the replicated folders don't need to be shared folders or part of a namespace. However, the DFS Management snap-in simplifies sharing replicated folders and optionally publishing them in an existing namespace.

## Deploy and manage DFS Replication

DFS Replication is a part of the File and Storage Services role for Windows Server. The management tools for DFS (DFS Management, the DFS Replication module for Windows PowerShell, and command-line tools) are installed separately as part of the Remote Server Administration Tools (RSAT).

You can install DFS Replication by using Server Manager, Windows PowerShell, or [Windows Admin Center](../../manage/windows-admin-center/overview.md).

You can administer DFS Replication by using DFS Management, the `dfsradmin` and `dfsrdiag` commands, or scripts that call WMI.

### Deployment requirements

Before you can deploy DFS Replication, you must configure your servers as follows:

- **Confirm file system and volume format**. Determine the folders that you want to replicate, and identify any folders located on volumes that are formatted with the NTFS file system. DFS Replication doesn't support the Resilient File System (ReFS) or the FAT file system. DFS Replication also doesn't support replicating content stored on Cluster Shared Volumes.

- **Verify antivirus compatibility**. Contact your antivirus software vendor to confirm your antivirus software is compatible with DFS Replication.

- **Update AD DS schema**. Update the AD DS schema to include Windows Server 2003 R2 or later schema additions. You can't use read-only replicated folders with the Windows Server 2003 R2 or later schema additions.

- **Prepare replication group servers**. Install DFS Replication on all servers that you plan to use as members of a replication group.

- **Check forest location**. Ensure all servers in a replication group are located in the same forest. You can't enable replication across servers in different forests.

### Interoperability with Azure virtual machines

DFS Replication on an Azure virtual machine is a verified scenario for Windows Server. However, there are some limitations and requirements for this implementation.

- **Snapshots and saved states**. To restore a server that's running DFS Replication, don't use snapshots or saved states to replicate anything other than the sysvol folder. If you attempt this type of restore, DFS Replication fails. This restoration requires special database recovery steps. Also, don't export, clone, or copy the virtual machines. For more information, see [DFSR no longer replicates files after restoring a virtualized server's snapshot](/support/windows-server/networking/distributed-file-system-replication-not-replicate-files) and [Safely virtualizing DFSR](https://techcommunity.microsoft.com/t5/storage-at-microsoft/safely-virtualizing-dfsr/ba-p/424671).

- **DFS Replication backups**. To back up data in a replicated folder that's stored in a virtual machine, use backup software that's located on the guest virtual machine. Don't back up or restore a virtualized DFS Replication server from the host virtual machine.

- **Domain controller access**. DFS Replication requires access to physical or virtualized domain controllers. The DFS Replication service can't communicate directly with Azure Active Directory.

- **VPN connection**. DFS Replication requires a VPN connection between your on-premises replication group members and any members hosted in Azure virtual machines. You also need to configure the on-premises router (such as Forefront Threat Management Gateway) to allow the RPC Endpoint Mapper (port 135) and a randomly assigned port between 49152 and 65535 to pass over the VPN connection. You can use the `Set-DfsrMachineConfiguration` cmdlet or the `dfsrdiag` command-line tool to specify a static port instead of the random port. For more information about how to specify a static port for DFS Replication, see [`Set-DfsrServiceConfiguration`](/powershell/module/dfsr/set-dfsrserviceconfiguration). For information about related ports to open for managing Windows Server, see [Service overview and network port requirements for Windows](/support/windows-server/networking/service-overview-and-network-port-requirements).

To learn how to get started with Azure virtual machines, visit the [Microsoft Azure website](/azure/virtual-machines/).

## Install DFS Replication from Server Manager

To install DFS Replication by using Server Manager, follow these steps:

1. Open Server Manager.

1. Select **Manage**, and then select **Add Roles and Features**. The **Add Roles and Features** wizard opens.

1. Under **Server Selection**, select the server or virtual hard disk (VHD) where you want to install DFS Replication. The server or VHD should be an offline virtual machine.

1. To install the DFS Replication service, go to **Server Roles**.

1. Expand **File and Storage Services** > **File and iSCSI Services**, and then select **DFS Replication**.
   
1. To install the DFS Management Tools, go to **Features**.

   1. Expand **Remote Server Administration Tools**, **Role Administration Tools**, and then expand **File Services Tools**.
   
   1. Select **DFS Management Tools**.
   
   The **DFS Management Tools** option installs the DFS Management snap-in, the DFS Replication and DFS Namespaces modules for Windows PowerShell, and command-line tools. The option doesn't install any DFS services on the server.

## Install DFS Replication from PowerShell

To install the DFS Replication by using Windows PowerShell, follow these steps:

1. Open a Windows PowerShell session with elevated user rights.

1. Enter the following command to install the desired RSAT role services or features to support DFS replication.

   For the `<name\>` parameter, enter of the names of the RSAT role services or features that you want to install. You can install one or multiple services and features in a single command. The table lists the names of the relevant RSAT role services and features.

   ```powershell
   Install-WindowsFeature <name>
   ```

   | RSAT role service/feature | Value for `<name>` parameter |
   | --- | --- |
   | DFS Replication | `FS-DFS-Replication` |
   | DFS Management Tools | `RSAT-DFS-Mgmt-Con` |

   - To install the DFS Replication service only, enter the following command:

      ```powershell
      Install-WindowsFeature "RSAT-DFS-Mgmt-Con"
      ```
      
   - To install both the DFS Replication service and the DFS Management Tools, enter the following command:

      ```powershell
      Install-WindowsFeature "FS-DFS-Replication", "RSAT-DFS-Mgmt-Con"
      ```

## Related links

- [DFS Namespaces and DFS Replication overview](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj127250(v%3dws.11))
- [Checklist: Deploy DFS Replication](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc772201(v%3dws.11))
- [Checklist: Manage DFS Replication](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc755035(v%3dws.11))
- [Deploying DFS Replication](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc770925(v%3dws.11))
- [Troubleshooting DFS Replication](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc732802(v%3dws.11))