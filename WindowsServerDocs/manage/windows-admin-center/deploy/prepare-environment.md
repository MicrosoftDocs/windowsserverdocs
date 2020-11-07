---
title: Prepare your environment for Windows Admin Center
description: Prepare your environment for Windows Admin Center (Project Honolulu)
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 06/07/2019
ms.localizationpriority: medium
---

# Prepare your environment for Windows Admin Center

> Applies to: Windows Admin Center, Windows Admin Center Preview

There are some Server versions that need additional preparation before they are ready to manage with Windows Admin Center:

- [Windows Server 2012 and 2012 R2](#prepare-windows-server-2012-and-2012-r2)
- [Microsoft Hyper-V Server 2016](#prepare-microsoft-hyper-v-server-2016)
- [Microsoft Hyper-V Server 2012 R2](#prepare-microsoft-hyper-v-server-2012-r2)

There are also some scenarios where [port configuration on the target server](#port-configuration-on-the-target-server) may need to be modified before managing with Windows Admin Center.

## Prepare Windows Server 2012 and 2012 R2

### Install WMF version 5.1 or higher

Windows Admin Center requires PowerShell features that are not included by default in Windows Server 2012 and 2012 R2. To manage Windows Server 2012 or 2012 R2 with Windows Admin Center, you will need to install WMF version 5.1 or higher on those servers.

Type `$PSVersiontable` in PowerShell to verify that WMF is installed,
and that the version is 5.1 or higher.

If it is not installed, you can [download and install WMF 5.1](/powershell/scripting/wmf/setup/install-configure).

## Prepare Microsoft Hyper-V Server 2016

To manage Microsoft Hyper-V Server 2016 with Windows Admin Center, there are some Server roles you'll need to enable before you can do so.

### To manage Microsoft Hyper-V Server 2016 with Windows Admin Center:

1. Enable Remote Management.
2. Enable File Server Role.
3. Enable Hyper-V Module for PowerShell.

### **Step 1:** Enable Remote Management

To enable remote management in Hyper-V Server:

1. Log into Hyper-V Server.
2. At the **Server Configuration** (SCONFIG) tool, type **4** to configure remote management.
3. Type **1** to enable Remote Management.
4. Type **4** to return to the main menu.

### **Step 2:** Enable File Server Role

To enable File Server Role for basic file sharing and remote management:

1. Click **Roles and Features** in the **Tools** menu.
2. In **Roles and Features**, find **File and Storage Services**, and check **File and iSCSI Services** and **File Server**:

![Screenshot of Roles and Features showing the File and iSCSI Services role selected](../media/prepare-environment/prepare-your-environment-image-1.png)

### **Step 3:** Enable Hyper-V Module for PowerShell

To enable Hyper-V Module for PowerShell features:

1. Click **Roles and Features** in the **Tools** menu.
2. In **Roles and Features**, find **Remote Server Administration Tools** and check **Role Administration Tools** and **Hyper-V Module for PowerShell**:

![Screenshot of Roles and Features showing Hyper-V roles selected](../media/prepare-environment/prepare-your-environment-image-2.png)

Microsoft Hyper-V Server 2016 is now ready for management with Windows Admin Center.

## Prepare Microsoft Hyper-V Server 2012 R2

To manage Microsoft Hyper-V Server 2012 R2 with Windows Admin Center, there are some Server roles you'll need to enable before you can do so.  In addition, you will need to install WMF version 5.1 or higher.

### To manage Microsoft Hyper-V Server 2012 R2 with Windows Admin Center:

1. Install Windows Management Framework (WMF) version 5.1 or higher
2. Enable Remote Management
3. Enable File Server Role
4. Enable Hyper-V Module for PowerShell

### Step 1: Install Windows Management Framework 5.1

Windows Admin Center requires PowerShell features that are not included by default in Microsoft Hyper-V Server 2012 R2. To manage Microsoft Hyper-V Server 2012 R2 with Windows Admin Center, you will need to install WMF version 5.1 or higher.

Type `$PSVersiontable` in PowerShell to verify that WMF is installed,
and that the version is 5.1 or higher.

If it is not installed, you can [download WMF 5.1](/powershell/scripting/wmf/setup/install-configure).

### Step 2: Enable Remote Management

To enable Hyper-V Server remote management:

1. Log into Hyper-V Server.
2. At the **Server Configuration** (SCONFIG) tool, type **4** to configure remote management.
3. Type **1** to enable remote management.
4. Type **4** to return to the main menu.

### Step 3: Enable File Server Role

To enable File Server Role for basic file sharing and remote management:

1. Click **Roles and Features** in the **Tools** menu.
2. In **Roles and Features**, find **File and Storage Services** and check **File and iSCSI Services** and **File Server**:

![Screenshot of Roles and Features showing the File and iSCSI Services role selected](../media/prepare-environment/prepare-your-environment-image-1.png)

### Step 4: Enable Hyper-V Module for PowerShell

To enable Hyper-V Module for PowerShell features:

1. Click **Roles and Features** in the **Tools** menu.
2. In **Roles and Features**, find **Remote Server Administration Tools** and check **Role Administration Tools** and **Hyper-V Module for PowerShell**:

![Screenshot of Roles and Features showing Hyper-V remote server administration tools selected](../media/prepare-environment/prepare-your-environment-image-2.png)

Microsoft Hyper-V Server 2012 R2 is now ready for management with Windows Admin Center.

## Port configuration on the target server

Windows Admin Center uses the SMB file sharing protocol for some file copying tasks, such as when importing a certificate on a remote server. For these file copy operations to succeed, the firewall on the remote server must allow inbound connections on port 445.  You can use the Firewall tool in Windows Admin Center to verify the incoming rule for ‘File Server Remote Management (SMB-In)' is set to allow access on this port.

> [!Tip]
> Ready to install Windows Admin Center? [Download now](../overview.md#download-now)