---
title: Remote Desktop IP virtualization in Windows Server 2019 and Windows Server 2022
description: How to virtualize a Remote Desktop IP in Windows Server 2019 and Windows Server 2022.
ms.author: helohr
ms.date: 11/27/2023
ms.topic: article
author: Heidilohr
manager: femila
---
# Remote Desktop IP Virtualization in Windows Server 2019 and Windows Server 2022

Starting with Windows Server 2008 R2, Remote Desktop session hosts support per-session and per-program Remote Desktop IP Virtualization for Winsock applications. Remote Desktop assigns individual IP addresses to user sessions to avoid avoid the application compatibility issues that come with all Remote Desktop users in the same location sharing the same IP address. This article will show you how to virtualize IP addresses for your organization's Remote Desktop users.

> [!NOTE]
> This article's instructions for virtualizing IPs only apply to on-premises environments.

## How to configure IP Virtualization

You can configure IP Virtualization using the Microsoft Management Console, Group Policy, or running a command in a PowerShell window.

<!---MMC--->


<!--Group policy-->


<!--PowerShell-->

To use IP virtualization, follow these steps:

1. Start an elevated PowerShell window, and run the following cmdlet to rename the registry key:

   ```powershell
   Rename-Item HKLM:\SYSTEM\CurrentControlSet\Services\WinSock2\Parameters\AppId_Catalog\2C69D9F1 Backup_2C69D9F1
   ```

   > [!NOTE]
   > Deleting the key has the same effects, but the rename provides a way to revert back more easily if desired. The following is the default values:
   >
   > `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinSock2\Parameters\AppId_Catalog\2C69D9F1\`
   > **AppFullPath**: C:\Windows\System32\svchost.exe\
   > **PermittedLspCategories**: 0x40000000

2. Restart the computer.
3. Enable the IP Virtualization feature. To do so, open **gpedit.msc**, go to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Remote Desktop Services** > **Remote Desktop Session Host** > **Application Compatibility**, and then enable the **Turn on Remote Desktop IP Virtualization** policy.

4. Restart the computer.

## Related content

<!--Placeholder-->