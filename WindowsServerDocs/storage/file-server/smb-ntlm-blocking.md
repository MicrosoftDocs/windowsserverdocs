---
title: Block NTLM connections on SMB (preview)
description: Learn how to make SMB more secure by blocking NTLM.
ms.topic: article
author: Heidilohr
ms.author: helohr
ms.date: 01/22/2024
ms.prod: windows-server
---
# Block NTLM connections on SMB (preview)

> [!IMPORTANT]
> NTLM blocking in SMB is currently in PREVIEW.
> See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

The SMB client now supports blocking NTLM queries for remote outbound connections. This new feature prevents bad actors from tricking clients into sending NTLM requests to malicious servers, counteracting brute force, cracking, and pass-the-hash attacks. However, organizations can also enable this layer of protection without having to disable NTLM entirely.

## Configure NTLM blocking

To configure NTLM blocking:

#### [Group Policy](#tab/group-policy)

1. Open the **Group Policy editor**.

1. Go to **Computer Configuration** > **Administrative Templates** > **Network** > **Lanman Workstation** > **Block NTLM (LM, NTLM, NTLMv2)**.

1. Set the policy to **Disabled**.

#### [PowerShell](#tab/powershell)

1. Open an elevated PowerShell window.

1. Run the following command to enable NTLM blocking:

   ```powershell
   NET USE \\server\share /BLOCKNTLM
   ```

1. Run this command to specify NTLM blocking when mapping an SMB drive:

   ```powershell
   New-SmbMapping -RemotePath \\server\share -BlockNTLM $true
   ```

--- 

## Enable exceptions to NTLM blocking

To enable a list of exceptions to NTLM blocking:

#### [Group Policy](#tab/group-policy)

1. Go to **Computer Configuration** > **Administrative Templates** > **Network** > **Lanman Workstation** > **Block NTLM Server Exception List**.

1. Set the policy to **Enabled**.

1. Enter the names, NetBIOS names, and fully-qualified domain name (FQDNS) names for the remote machines you want to allow NTLM authentication for.

#### [PowerShell](#tab/powershell)

<!--- Content here  -->

--- 