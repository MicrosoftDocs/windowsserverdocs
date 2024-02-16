---
title: Configure SMB client encryption mandate in Windows Insider
description: Learn how to configure SMB encryption mandate in Windows Insider
ms.topic: how-to
author: gswashington
ms.author: nedpyle
ms.date: 03/01/2024

---

# Configure SMB client encryption mandate in Windows Insider

>Applies to: Windows and Windows Server Insider builds

SMB supports requiring encryption of all outbound SMB client connections. Administrators can mandate that all destination servers support SMB 3.x and encryption. Clients that do not support SMB 3.x won't connect.  Encryption of all outbound SMB client connections enforces the highest level of network security as well as bringing management parity to SMB signing, which allows both client and server requirements.

## SMB encryption 

SMB Encryption supplies SMB data end-to-end protection from interception attacks and snooping. SMB Encryption includes AES-GCM support to deliver better hardware-accelerated encryption. AES-256-GCM cryptographic suites enable you to configure SMB encryption on a per share basis for the entire file server whether mapping drives or using UNC Hardening. See [SMB encryption](https://aka.ms/SmbEncrypt) for detailed information. 

## SMB client encryption mandate

You can configure the SMB client to always require encryption regardless of server, share, UNC hardening, or mapped drive requirements. An administrator can globally force a Windows machine to use SMB encryption (and therefore SMB 3.x) on all connections, refusing to connect if the SMB server doesn'st support either.

## Configure SMB encryption mandate using Group Policy

To configure SMB client for required encryption to all SMB servers (i.e., for outbound connections), enable the group policy under:

`Computer Configuration \ Administrative Templates \ Network \ Lanman Workstation \ Require encryption`

:::image type="content" source="media/smb-client-encryption-mandate/group-policy-editor-ui.png" alt-text="Screenshot showing Group Policy editor UI.":::

Setting the policy to disabled or not configured removes the encryption requirement.

>[!IMPORTANT]
>Be careful when deploying SMB encryption through group policy to a heterogenous fleet. Legacy SMB servers such as Windows Server 2008 R2 won’t support SMB 3.0. Older third-party SMB servers in some cases can support SMB 3.0 but won't support encryption.

## Configure SMB encryption mandate using PowerShell

To configure the SMB client for required encryption to all SMB servers (that is, for outbound connections):

# [PowerShell](#tab/powershell)

1. From an elevated PowerShell prompt, set the following PowerShell parameter:

```powershell
Set-SmbClientConfiguration -RequireEncryption $true
```

---

1. Run the following command to see the effective setting on a machine:

```powershell
Get-SmbClientConfiguration | FL RequireEncryption
```

---

## SMB encryption vs. SMB signing

SMB encryption has associated performance and compatibility overhead. SMB signing features better performance and tamper protection but does not provide snooping protection. Forgoing encryption and signing completely offers the best performance but of course provides no security beyond connection authorization and pre-auth integrity protection. SMB encryption supersedes SMB signing and supplies the same level of tamper protection; if your SMC client requires signing, SMB encryption turns it off.

## Related content

- []()

- []()