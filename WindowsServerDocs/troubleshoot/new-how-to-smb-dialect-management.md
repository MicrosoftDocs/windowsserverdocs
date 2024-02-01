---
title: Managing SMB dialects in Windows Server Insider builds
description: Learn about SMB dialect management in Windows Server Insider builds 
ms.topic: how-to
author: gswashington
ms.author: nedpyle
ms.date: 02/14/2024

---

# Managing SMB dialects in Windows Server Insider builds

>Applies to: Windows Server Insider Builds

To improve security in Windows and Windows Server, SMB server supports the ability to manage SMB2 and SMB3 dialects in Windows Server Insider builds. Previously, Windows SMB Server automatically negotiated the highest matched server dialect from SMB 2.0.2 to 3.1.1 clients. Windows 10 introduced the ability to manage SMB client dialects, but not SMB server dialects. 

You can remove specific SMB protocols from usage in your organization, blocking older, less secure, less capable Windows devices and third parties from connecting to the server. For example, you can limit users to SMB 3.1.1, the most secure dialect of the protocol.

## Configure SMB dialect max and min

You can configure this option with Group Policy and PowerShell. Both SMB client and server now include complete management support (previously the client support was only manual registry editing).

## Configure group policy (SMB server)

To configure SMB dialect minimum and maximum for the SMB server (that is, for inbound connection):

1. Enable the group policy under:

`Computer Configuration \ Administrative Templates \ Network \ Lanman Server \ Mandate the Maximum version of SMB`

and

`Computer Configuration \ Administrative Templates \ Network \ Lanman Server \ Mandate the Minimum version of SMB`

:::image type="content" source="media/managing-smb-dialects/mandate-minimum-version-smb.jpg" alt-text="Screenshot showing group policy editor and mandate minimum version of smb setting.":::

1. Select the minimum and maximum version of the dialects using the dropdown menu when the policy is enabled.

:::image type="content" source="media/managing-smb-dialects/select-minimum-maximum.jpg" alt-text="Screenshot showing group policy editor and select SMB version dropdown.":::

## Configure group policy (SMB client)

To configure SMB dialect minimum and maximum for the SMB client (i.e. for outbound connection):

1. Enable group policy under: 

`Computer Configuration \ Administrative Templates \ Network \ Lanman Workstation\ Mandate the minimum version of SMB`

and

`Computer Configuration \ Administrative Templates \ Network \ Lanman Workstation \ Mandate the Maximum version of SMB`

1. Select the minimum and maximum version of the dialects using a dropdown menu when the policy is enabled.

## Configure group policy (SMB server) using Powershell

# [PowerShell](#tab/powershell)

From an elevated PowerShell prompt, run the following commands:

```powershell
Set-SmbServerConfiguration -Smb2DialectMax {SMB202 | SMB210 |
SMB300 | SMB302 | SMB311 | None} -Smb2DialectMin {None | SMB202 | SMB210 | SMB300 | SMB302 | SMB311}
```

---

## Configure group policy (SMB client) using Powershell

# [PowerShell](#tab/powershell)

From an elevated PowerShell prompt, run the following commands:

```powershell
Set-SmbClientConfiguration -Smb2DialectMax {SMB202 | SMB210 |
SMB300 | SMB302 | SMB311 | None} -Smb2DialectMin {None | SMB202 | SMB210 | SMB300 | SMB302 | SMB311}
```

---

## Verify dialect management is working

You can use a network capture tool like Wireshark to examine the client and server responses for the SMB2 Negotiate Protocol. In the following example, client requests only SMB 3.1.1 because it's been configured with a minimum and maximum dialect of 3.1.1:

:::image type="content" source="media/managing-smb-dialects/capture-SMB-session-creation.jpg" alt-text="Screenshot showing ethernet capture of SMB session creation.":::

## Related content

- [Protect SMB traffic from interception](https://learn.microsoft.com/en-gb/windows-server/storage/file-server/smb-interception-defense?tabs=group-policy#use-smb-311)