---
title: Prepare Your Environment for Windows Admin Center
description: Prepare your environment for Windows Admin Center (Project Honolulu).
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 06/07/2019
---

# Prepare your environment for Windows Admin Center

Some server versions need more preparation before they're ready for you to manage with Windows Admin Center:

- [Windows Server 2012 and 2012 R2](#prepare-windows-server-2012-and-2012-r2)
- [Microsoft Hyper-V Server 2016](#prepare-microsoft-hyper-v-server-2016)
- [Microsoft Hyper-V Server 2012 R2](#prepare-microsoft-hyper-v-server-2012-r2)

There are also some scenarios where you might need to modify [port configuration on the target server](#port-configuration-on-the-target-server) before you can manage with Windows Admin Center.

## Prepare Windows Server 2012 and 2012 R2

### Install Windows Management Framework version 5.1 or higher

Windows Admin Center requires Windows PowerShell features that aren't included by default in Windows Server 2012 and 2012 R2. To manage Windows Server 2012 or 2012 R2 with Windows Admin Center, you need to install Windows Management Framework version 5.1 or higher on those servers.

Enter `$PSVersiontable` in PowerShell to verify that Windows Management Framework is installed and that the version is 5.1 or higher.

If it isn't installed, [download and install Windows Management Framework 5.1](/powershell/scripting/wmf/setup/install-configure).

## Prepare Microsoft Hyper-V Server 2016

To manage Microsoft Hyper-V Server 2016 with Windows Admin Center, you need to enable some server roles.

### Manage Microsoft Hyper-V Server 2016 with Windows Admin Center

1. Enable remote management.
1. Enable the File Server role.
1. Enable the Hyper-V module for PowerShell.

### Step 1: Enable remote management

To enable remote management in Hyper-V Server:

1. Sign in to Hyper-V Server.
1. At the **Server Configuration** (`SCONFIG`) tool, enter **4** to configure remote management.
1. Enter **1** to enable remote management.
1. Enter **4** to return to the main menu.

### Step 2: Enable the File Server role

To enable the File Server role for basic file sharing and remote management:

1. On the **Tools** menu, select **Roles & features**.
1. In the **Roles and features** pane, find **File and Storage Services**, and select **File and iSCSI Services** > **File Server**.

   ![Screenshot that shows the Roles and features pane with the File Server role selected.](../media/prepare-environment/prepare-your-environment-image-1.png)

### Step 3: Enable Hyper-V module for PowerShell

To enable Hyper-V module for PowerShell features:

1. On the **Tools** menu, select **Roles & features**.
1. In the **Roles and features** pane, find **Remote Server Administration Tools** and select **Role Administration Tools** > **Hyper-V Module for Windows PowerShell**.

   ![Screenshot that shows Roles and features with Hyper-V roles selected.](../media/prepare-environment/prepare-your-environment-image-2.png)

Microsoft Hyper-V Server 2016 is now ready for management with Windows Admin Center.

## Prepare Microsoft Hyper-V Server 2012 R2

To manage Microsoft Hyper-V Server 2012 R2 with Windows Admin Center, you need to enable some server roles. You also need to install Windows Management Framework version 5.1 or higher.

### Manage Microsoft Hyper-V Server 2012 R2 with Windows Admin Center

1. Install Windows Management Framework version 5.1 or higher.
1. Enable remote management.
1. Enable the File Server role.
1. Enable the Hyper-V module for PowerShell.

### Step 1: Install Windows Management Framework 5.1

Windows Admin Center requires PowerShell features that aren't included by default in Microsoft Hyper-V Server 2012 R2. To manage Microsoft Hyper-V Server 2012 R2 with Windows Admin Center, you need to install Windows Management Framework version 5.1 or higher.

Enter `$PSVersiontable` in PowerShell to verify that Windows Management Framework is installed and that the version is 5.1 or higher.

If it isn't installed, you can [download Windows Management Framework 5.1](/powershell/scripting/wmf/setup/install-configure).

### Step 2: Enable remote management

To enable Hyper-V Server remote management:

1. Sign in to Hyper-V Server.
1. At the **Server Configuration** (`SCONFIG`) tool, enter **4** to configure remote management.
1. Enter **1** to enable remote management.
1. Enter **4** to return to the main menu.

### Step 3: Enable the File Server role

To enable the File Server role for basic file sharing and remote management:

1. On the **Tools** menu, select **Roles & features**.
1. In the **Roles and features** pane, find **File and Storage Services** and select **File and iSCSI Services** > **File Server**.

   ![Screenshot that shows the Roles and features pane with the File Server role selected.](../media/prepare-environment/prepare-your-environment-image-1.png)

### Step 4: Enable the Hyper-V module for PowerShell

To enable the Hyper-V module for PowerShell features:

1. On the **Tools** menu, select **Roles & features**.
1. In the **Roles and features** pane, find **Remote Server Administration Tools** and select **Role Administration Tools** > **Hyper-V Module for Windows PowerShell**.

   ![Screenshot that shows the Roles and features pane with Hyper-V Module for Windows PowerShell selected.](../media/prepare-environment/prepare-your-environment-image-2.png)

Microsoft Hyper-V Server 2012 R2 is now ready for management with Windows Admin Center.

## Port configuration on the target server

Windows Admin Center uses the Server Message Block (SMB) file-sharing protocol for some file-copying tasks, such as importing a certificate on a remote server. For these file copy operations to succeed, the firewall on the remote server must allow inbound connections on port 445. You can use the Firewall tool in Windows Admin Center to verify that the incoming rule for `File Server Remote Management (SMB-In)` is set to allow access on this port.

> [!TIP]
> Ready to install Windows Admin Center? [Download now](../overview.md#download-now).