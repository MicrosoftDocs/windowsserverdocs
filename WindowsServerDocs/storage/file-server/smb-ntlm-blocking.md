---
title: Block NTLM connections on SMB (preview)
description: Learn how to make SMB more secure by blocking NTLM.
ms.topic: how-to
author: Heidilohr
ms.author: helohr
ms.date: 01/22/2024
ms.prod: windows-server
---
# Block NTLM connections on SMB (preview)

> [!IMPORTANT]
> NTLM blocking in SMB is currently in PREVIEW.
> See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

The SMB client now supports blocking NTLM queries for remote outbound connections. Blocking NTLM queries prevents bad actors from tricking clients into sending NTLM requests to malicious servers, counteracting brute force, cracking, and pass-the-hash attacks. NTLM blocking is also required for switching an organization's authentication protocols to Kerberos, which is more secure than NTLM because it can verify server identities with its ticket system. However, organizations can also enable this layer of protection without having to disable NTLM entirely.

## Configure SMB client NTLM blocking

Starting with Windows Server Preview build 25951 and Windows 11, the SMB client blocks NTLM by default. To improve the security of deployments running earlier versions of Windows, you must disable NTLM manually, either by editing the relevant Group Policy or running a specific command in PowerShell.

To configure NTLM blocking:

#### [Group Policy](#tab/group-policy)

1. Open the **Group Policy Management Console**.

1. In the console tree, go to **Computer Configuration** > **Administrative Templates** > **Network** > **Lanman Workstation**.

1. Right-click **Block NTLM (LM, NTLM, NTLMv2)** and select **Edit**.

1. Select **Disabled**.

#### [PowerShell](#tab/powershell)

1. Open an elevated PowerShell window.

1. Run the following command to enable NTLM blocking:

   ```powershell
   Set-SMbClientConfiguration -BlockNTLM $true 
   ```

---

## Enable exceptions to NTLM blocking

There may be scenarios where you need to allow certain machines to use NTLM instead of blocking it globally, particularly when running earlier versions of Windows or Windows Server.

To enable a list of exceptions to NTLM blocking:

#### [Group Policy](#tab/group-policy)

1. In the **Group Policy Editor Console** tree, go to **Computer Configuration** > **Administrative Templates** > **Network** > **Lanman Workstation**.

1. Right-click **Block NTLM Server Exception List** and select **Edit**.

1. Select **Enabled**.

1. Enter the names, NetBIOS names, and fully-qualified domain name (FQDNS) names for the remote machines you want to allow NTLM authentication for.

#### [PowerShell](#tab/powershell)

There isn't currently a PowerShell equivalent to the Block NTLM Server Exception List Group Policy object. In order to set up an exception list, you must go into the Group Policy Editor and configure the setting manually. However, once you've completed the manual setup, you can make individual exceptions for certain IPs by running this command:

  ```powershell
  Set-SmbServerConfiguration -ExceptionList "<IP Address>"
  ```

---

## Block NTLM while mapping SMB drives

You can also block NTLM when mapping new SMB drives by running the following commands.

Run this command to specify NTLM blocking when mapping a drive with NET USE:

   ```powershell
   NET USE \\server\share /BLOCKNTLM
   ```

Run this command to specify NTLM blocking when mapping an SMB drive:

   ```powershell
   New-SmbMapping -RemotePath \\server\share -BlockNTLM $true
   ```

## Related content

- [Protect SMB traffic from interception](smb-interception-defense.md)

- [SMB security](smb-security.md)

- [Secure SMB traffic in Windows Server](smb-secure-traffic.md)