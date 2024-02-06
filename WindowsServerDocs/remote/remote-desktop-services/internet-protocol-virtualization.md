---
title: Remote Desktop IP virtualization in Windows Server 2019 and Windows Server 2022
description: How to virtualize a Remote Desktop IP in Windows Server 2019 and Windows Server 2022.
ms.author: helohr
ms.date: 01/18/2024
ms.topic: article
author: Heidilohr
manager: femila
---
# Remote Desktop IP Virtualization in Windows Server 2019 and Windows Server 2022

As of Windows Server 2008 R2, Remote Desktop session hosts support per-session and per-program Remote Desktop IP Virtualization for Winsock applications. Remote Desktop assigns individual IP addresses to user sessions to avoid application compatibility issues that can happen when all Remote Desktop users in the same location share the same IP address. This article gives instructions for how to virtualize IP addresses for your organization's Remote Desktop users.

> [!NOTE]
> This article's instructions for virtualizing IPs only apply to on-premises environments.

## Prerequisites

In order to use IP Virtualization, your system must meet the following requirements:

- Your deployment must run Windows Server 2019 or 2022.

- You must assign the RD Session Host server role to the machine you use to make the changes.

## How to configure IP Virtualization

You can configure IP Virtualization using the Microsoft Management Console (MMC), Group Policy, or running a command in a PowerShell window.

### [Microsoft Management Console](#tab/mmc)

1. Open the RD Session Host Configuration MMC on the machine you the RD Session Host server role.

1. Go to **Edit settings**.

1. Select **IP Virtualization** and go to **Properties**.

1. Select the **Enable IP virtualization** check box.

1. In the **Select the network adapter to be used for IP Virtualization** field, select the network adapter you want to use for IP Virtualization from the drop-down menu.

   > [!NOTE]
   > IP virtualization currently only supports single-network adapter scenarios. If your server has multiple enabled network adapters, you can only use the adapter you specify in the settings for IP virtualization.

1. When you're finished, select **Apply**.

1. Optionally, to configure IP virtualization for specific programs:

   - Return to **Edit settings**, then select **Add program**.

   - Enter or navigate to the file path of the program you want to use.

   - Select **Open**.

   - Repeat for all programs you want to use.

   - When you're finished, select **Apply**.

### [Group Policy](#tab/group-policy)

1. Open the **Group policy editor (gpedit.msc)** on the machine you want to make changes to.

1. Go to **Computer configuration** > **Administrative Templates** > **Windows Components** > **Remote Desktop Services** > **Remote Desktop Session Host** > **Application Compatibility**.

1. Right-click **Select the network adapter to be used for Remote Desktop IP Virtualization**, then select **Edit**.

1. Select **Enabled**.

   > [!NOTE]
   > IP virtualization currently only supports single-network adapter scenarios. If your server has multiple enabled network adapters, you can only use the adapter you specify in the settings for IP virtualization.

1. To apply this policy to a specific IP address and network mask, go to the **Define IP address** field and enter the IP address and network mask based on the format `<IP address/<network mask>`.

1. When you're finished, select **Apply**.

1. Next, right-click **Turn on Remote Desktop IP Virtualization**, then select **Edit**.

1. Select **Enabled**.

1. Optionally, if you want to configure virtualization for per-program mode:

   - Select **Per Program**

   - Enter the name or full file path of each program you want to add.

1. When you're finished, select **Apply**.

Optionally, you can also configure the **Do not use Remote Desktop Session Host server IP address when virtual IP address is not available** policy to prevent your deployment from using the IP address of the Remote Desktop Session Host server when virtualized IP addresses aren't available.

To enable this policy:

1. Right-click **Do not use Remote Desktop Session Host server IP address when virtual IP address is not available**, then select **Edit**.

1. Select **Enabled**.

1. Select **Apply**.

### [PowerShell](#tab/powershell)

1. Open an elevated PowerShell window.

1. Run the following cmdlet to rename the registry key:

   ```powershell
   Rename-Item HKLM:\SYSTEM\CurrentControlSet\Services\WinSock2\Parameters\AppId_Catalog\2C69D9F1 Backup_2C69D9F1
   ```

   > [!NOTE]
   > We recommend you rename the registry key instead of deleting it, as this lets you revert your settings more easily. To revert your settings, change the name and values back to the following default settings:
   >
   > - Name: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinSock2\Parameters\AppId_Catalog\2C69D9F1\`
   >
   >- *AppFullPath*: C:\Windows\System32\svchost.exe\
   >
   >- *PermittedLspCategories*: 0x40000000

1. Restart your machine for the changes to take effect.

1. Run the following command to enable the **Turn on Remote Desktop IP Virtualization** group policy.

   ```powershell
   Set-GPRegistryValue -Name "Remote Desktop IP Virtualization" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -ValueName "IPFilterBitmaps" -Type DWORD -Value 1
   ```

1. Restart your machine for the changes to take effect.

---

## Related content

- [Remote Desktop Services Virtualization recommendations](rds-vdi-recommendations.md)

- [Scale out your Remote Desktop Services deployment by adding an RD Session Host farm](rds-scale-rdsh-farm.md)

- [Manage users in your RDS collection](rds-user-management.md)