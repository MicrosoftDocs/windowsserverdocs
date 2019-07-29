---
title: Using Disk Cleanup on Windows Server
description: Learn how to use command-line options to configure the Disk Cleanup tool (Cleanmgr.exe) to automatically clean up certain files.
ms.prod: windows-server-threshold
ms.reviewer: cosmosdarwin
author: iangpgh
ms.author: jgerend
manager: daveba
ms.technology: storage-spaces
ms.date: 06/20/2019
---

# Using Disk Cleanup on Windows Server

> Applies to: Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

The Disk Cleanup tool clears unnecessary files in a Windows Server environment. This tool is available by default on Windows Server 2019 and Windows Server 2016, but you might have to take a few manual steps to enable it on earlier versions of Windows Server.

To start the Disk Cleanup tool, either run the Cleanmgr.exe command, or select **Start**, select **Windows Administrative Tools**, and then select **Disk Cleanup**.

You can also run Disk Cleanup by using the [cleanmgr Windows command](../../administration/windows-commands/cleanmgr.md) and use command-line options to specify that Disk Cleanup cleans up certain files.

## Enable Disk Cleanup on an earlier version of Windows Server by installing the Desktop Experience

Follow these steps to use the Add Roles and Features Wizard to install the Desktop Experience on a server running Windows Server 2012 R2 or earlier, which also installs Disk Cleanup.

1. If Server Manager is already open, go on to the next step. If Server Manager is not already open, open it by doing one of the following.

   - On the Windows desktop, start Server Manager by clicking **Server Manager** in the Windows taskbar.

   - Go to **Start** and select the Server Manager tile.

1. On the **Manage** menu, select add **Roles and Features**.

1. On the **Before you begin** page, verify that your destination server and network environment are prepared for the feature that you want to install. Select **Next**.

1. On the **Select installation type** page, select **Role-based or feature-based installation** to install all parts features on a single server. Select **Next**.

1. On the **Select destination server** page, select a server from the server pool, or select an offline VHD. Select **Next**.

1. On the **Select server roles** page, select **Next**.

1. On the **Select features** page, select **User Interface and Infrastructure**, and then select **Desktop Experience**.

1. In **Add features that are required for Desktop Experience?**, select **Add Features**.

1. Proceed with the installation, and then reboot the system.

1. Verify that the **Disk Cleanup** option button appears in the Properties dialog box.

   ![Disk Properties dialog with Disk Cleanup option](media/diskpropswcleanup.png)

## Manually add Disk Cleanup to an earlier version of Windows Server

The Disk Cleanup tool (cleanmgr.exe) isn't present on Windows Server 2012 R2 or earlier unless you have the Desktop Experience feature installed.

To use cleanmgr.exe, install the Desktop Experience as described earlier, or copy two files that are already present on the server, cleanmgr.exe and cleanmgr.exe.mui. Use the following table to locate the files for your operating system.

| Operating System  | Architecture  | File Location  |
| ----------------- | -------------- | --------------- |
| Windows Server 2008 R2 | 64-bit | C:\Windows\winsxs\amd64_microsoft-windows-cleanmgr_31bf3856ad364e35_6.1.7600.16385_none_c9392808773cd7da\cleanmgr.exe 
| Windows Server 2008 R2 | 64-bit | C:\Windows\winsxs\amd64_microsoft-windows-cleanmgr.resources_31bf3856ad364e35_6.1.7600.16385_en-us_b9cb6194b257cc63\cleanmgr.exe.mui |

Locate cleanmgr.exe and move the file to **%systemroot%\System32**.

Locate cleanmgr.exe.mui and move the files to **%systemroot%\System32\en-US**.

You can now launch the Disk cleanup tool by running Cleanmgr.exe from Command Prompt, or by clicking **Start** and typing **Cleanmgr** into the search bar.

To have Disk Cleanup button appear on a disk’s Properties dialog, you will also need to install the Desktop Experience feature.

## Additional references

[Free up drive space in Windows 10](https://support.microsoft.com/en-us/help/12425/windows-10-free-up-drive-space)

[cleanmgr](../../administration/windows-commands/cleanmgr.md)
