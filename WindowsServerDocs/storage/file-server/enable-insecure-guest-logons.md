---
title: Enable insecure guest logons in SMB2 and SMB3
description: This article describes how to enable guest logons in SMB2 and SMB3 for Windows client and Windows Server devices.
ms.topic: how-to
ms.author: wscontent
author: xelu86
ms.date: 05/15/2024
---

# How to enable insecure guest logons in SMB2 and SMB3

This article describes enabling guest access in SMB2 and SMB3, which can be useful in situations where you want to allow users who don't have a user account on the server to access shared resources. In scenarios where a user needs to access a resource on a server but doesn't have a user account on that server, enabling this setting can be useful. By enabling guest access, the server allows the user to access the resource without requiring authentication. However, it's important to note that guest access can also be a security risk, as it allows anyone to access the shared resources without any authentication. Therefore, it's recommended to use guest access only in specific scenarios where it's necessary.

## Reason for enabling guest access

Enabling guest access can be useful in scenarios where a user needs to access a resource on a server but doesn't have a user account on that server. By enabling guest access, the server allows the user to access the resource without requiring authentication.

> [!WARNING]
> It's important to note that enabling guest logons can also be a security risk as it allows anyone to access the shared resources without providing authentication. Therefore, it's recommended to enable guest logons only in specific scenarios where necessary.

## Prerequisites

For server devices, the user needs to be part of the following group:

- Administrators
- Domain Admins
- Enterprise Admins
- Group Policy Creator Owners

For client devices, the user needs to be part of the following group:

- Administrators

## Enable insecure guest logons

Enabling insecure guest logons can be performed through Group Policy or PowerShell.

> [!NOTE]
> If you need to modify the Active Directory domain-based group policy, use **Group Policy Management** (gpmc.msc).

# [Group Policy](#tab/group-policy)

1. Click **Start**, type **gpedit.msc**, and select **Edit group policy**.
1. In the left pane under **Local Computer Policy**, navigate to **Computer Configuration\Administrative Templates\Network\Lanman Workstation**.
1. Open **Enable insecure guest logons**, select **Enabled**, then select **OK**.

# [PowerShell](#tab/powershell)

Run the following command through an elevated PowerShell prompt:

```powershell
Set-SmbClientConfiguration -EnableInsecureGuestLogons $true -Force
```

---

## Audit insecure guest logons

To audit for insecure guest logons, this information is captured in the **Event Viewer**. To review these logs, perform the following steps:

1. Right-click on **Start**, select **Event Viewer**.
1. In the left pane, navigate to **Applications and Service Logs\Microsoft\Windows\SMBClient\Security**
1. In the middle pane, insecure guest logons are captured under **Event ID 31018**.

### Other Considerations

Starting from Windows 10, version 1709 and Windows Server 2019, SMB2 and SMB3 clients no longer allow the following actions by default:

- Guest account access to a remote server.
- Fall back to the Guest account after invalid credentials are provided.

SMB2 and SMB3 have the following behavior for different versions of Windows:

- By default, guest credentials can't be used to connect to a remote share in Windows 10 Enterprise and Windows 10 Education, even if requested by the remote server.

- The use of guest credentials to connect to a remote share is no longer allowed by default in Windows Server 2019 Datacenter and Standard editions, even if requested by the remote server.

- Windows 10 Home and Pro editions still allow the use of guest authentication by default, as they did previously.

- In Windows 11 Pro Insider Preview build 25267, and all subsequent builds, guest credentials can't be used to connect to a remote share by default, even if requested by the remote server.

> [!NOTE]
> This behavior is present in various versions of Windows 10, including 1709, 1803, 1903, 1909, 2004, 20H2, and 21H1, as long as [KB5003173](https://support.microsoft.com/topic/may-11-2021-kb5003173-os-builds-19041-985-19042-985-and-19043-985-2824ace2-eabe-4c3c-8a49-06e249f52527) is installed. While it was originally implemented in Windows 10 1709, it later regressed in Windows 10 2004, 20H2, and 21H1, where guest authentication was not disabled by default but could still be disabled by an administrator.
