---
title: Install Distributed File System (DFS) Replication on Windows Server
description: Learn how to install DFS Replication on Windows Server using Server Manager or PowerShell. Follow this guide to enable efficient file replication and redundancy. 
ms.topic: how-to
ai-usage: ai-assisted
ms.author: daknappe
author: dknappettmsft
ms.date: 05/28/2025
---

# Install Distributed File System (DFS) Replication on Windows Server

DFS Replication is a Windows Server role service that enables efficient folder replication across multiple servers and sites. This article explains how to install DFS Replication on Windows Server using Server Manager or PowerShell. Installing DFS Replication helps you support file sharing and redundancy in your organization.

To learn more about DFS Replication, see the [DFS Replication overview](dfs-replication-overview.md).

## Prerequisites

Before you deploy DFS Replication, you need to meet the following prerequisites:

- Have server running a supported version of Windows Server. DFS Replication is available in installations of Windows Server with the Desktop Experience or Server Core, however the DFS Management tools are only available with Desktop Experience.

- Determine the folders that you want to replicate, and identify any folders located on volumes that are formatted with the NTFS file system. DFS Replication doesn't support the Resilient File System (ReFS) or the FAT file system. DFS Replication also doesn't support replicating content stored on Cluster Shared Volumes.

- Verify antivirus compatibility. Contact your antivirus software vendor to confirm your antivirus software is compatible with DFS Replication.

- Ensure the schema version for your Active Directory Domain Services forest is version 31 or later. To check the schema version, follow the steps in [Find the current Active Directory schema version](../../identity/ad-ds/deploy/find-active-directory-schema.md).

- Ensure all servers in a replication group are located in the same forest. You can't enable replication across servers in different forests.

## Install DFS Replication from Server Manager

To install DFS Replication, select the relevant tab for the method you want to use.

# [Server Manager](#tab/server-manager)

To install DFS Replication using Server Manager, follow these steps:

1. Open Server Manager.

1. Select **Manage**, and then select **Add Roles and Features**. The **Add Roles and Features** wizard opens.

1. For **Before You Begin**, select **Next**.

1. For **Installation Type**, select **Role-based or feature-based installation** and then select **Next**.

1. For **Server Selection**, select **Select a server from the server pool**, then select a server from the list to which you want to install DFS Replication. Alternatively, select **Select a virtual hard disk**, then select a server from the list and enter a path to the virtual hard disk (VHD) file, making sure to follow the requirements detailed in the wizard. After selecting a server or VHD file, select **Next**.

1. For **Server Roles**, expand **File and Storage Services**, followed by **File and iSCSI Services**. Check the box for **DFS Replication**, then when prompted to add features that are required for DFS Replication, select **Add Features**. Select **Next**.

1. For **Features**, expand **Remote Server Administration Tools**, followed by **Role Administration Tools**, and **File Services Tools**. Check the box for **DFS Management Tools**. Select **Next**. This option installs the DFS Management snap-in, the DFS Replication and DFS Namespaces modules for Windows PowerShell, and the `dfsradmin` and `dfsrdiag` Windows Commands.

1. For **Confirmation**, review the installation selections, and then select **Install**. The installation process begins. Once the installation is complete, select **Close** to exit the wizard.

# [PowerShell](#tab/powershell)

To install DFS Replication using PowerShell, follow these steps:

1. Open a Windows PowerShell session as a local administrator.

1. Run the following command to install the DFS Replication service and the DFS Management Tools:

   ```powershell
   Install-WindowsFeature FS-DFS-Replication
   ```

1. For servers with the Desktop Experience installation, you can also install the DFS Management Tools by running the following command:

   ```powershell
   Install-WindowsFeature RSAT-DFS-Mgmt-Con
   ```

1. Verify that the installation was successful by running the following command:

   ```powershell
   Get-WindowsFeature | Where-Object {$_.Name -eq "FS-DFS-Replication" -or $_.Name -eq "RSAT-DFS-Mgmt-Con"}
   ```

   Here's an example of the output:

   ```output
   Display Name                                            Name                       Install State
   ------------                                            ----                       -------------
           [X] DFS Replication                             FS-DFS-Replication             Installed
               [X] DFS Management Tools                    RSAT-DFS-Mgmt-Con              Installed
   ```

---

> [!TIP]
> You can also install the DFS Management Tools on a remote computer without installing the DFS Replication service, such as for servers with the Server Core installation, enabling you to manage DFS Replication from a different device.
