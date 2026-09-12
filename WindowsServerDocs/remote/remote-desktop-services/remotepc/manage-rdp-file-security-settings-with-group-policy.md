---
title: RDP file security in Group Policy on Windows and Windows Server
description: Learn how to configure Group Policy settings that control how Remote Desktop Connection handles signed, unsigned, and trusted-publisher RDP files.
ms.topic: concept-article
ai-usage: ai-assisted
ms.author: phfavrod
author: PhilemonRed
ms.date: 07/14/2026
#customer intent: As an IT administrator, I want to understand the Group Policy settings that control how Remote Desktop Connection handles RDP files so that I can reduce my organization's exposure to RDP-based phishing attacks.
---

# RDP file security settings in Group Policy

An RDP file is a configuration file that the Remote Desktop Connection client (`mstsc.exe`) uses to start a remote session. Group Policy RDP file security settings control which RDP files managed devices can open. Controlling this behavior helps mitigate phishing attacks that use RDP files to attack client endpoints. Starting with [the April 2026 security update](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2026-26151), the client includes redesigned security dialogs when users open RDP files as part of this multilayered approach.

This article explains the Group Policy settings that you can use to control RDP file behavior.
For information about what end users see, see [Understanding security warnings when opening Remote Desktop (RDP) files](understanding-security-warnings.md).

## Group Policy settings for RDP file security

Three Group Policy settings control how Remote Desktop Connection (`mstsc.exe`) handles RDP files:

| Policy | What it controls | Reference |
|--|--|--|
| **Allow .rdp files from valid publishers and user's default .rdp settings** | Whether users can open signed RDP files or manually launch connections. Disable to block all Remote Desktop Connection launches unless they originate from an RDP file signed by a trusted publisher. | [CSP reference — signed files (machine)](/windows/client-management/mdm/policy-csp-admx-terminalserver#ts_client_allow_signed_files_1)<br>[CSP reference — signed files (user)](/windows/client-management/mdm/policy-csp-admx-terminalserver#ts_client_allow_signed_files_2) |
| **Allow .rdp files from unknown publishers** | Whether users can open unsigned RDP files. Disable to block all unsigned files. | [CSP reference — unknown publishers (machine)](/windows/client-management/mdm/policy-csp-admx-terminalserver#ts_client_allow_unsigned_files_1)<br>[CSP reference — unknown publishers (user)](/windows/client-management/mdm/policy-csp-admx-terminalserver#ts_client_allow_unsigned_files_2) |
| **Specify thumbprints of certificates representing trusted .rdp publishers** | The thumbprints of the trusted publisher. When a matching certificate signs a file, Remote Desktop Connection doesn't display the security warning and automatically enables the redirections (for example, drive, clipboard, or printer sharing) requested in the RDP file. | [CSP reference — trusted thumbprints (machine)](/windows/client-management/mdm/policy-csp-admx-terminalserver#ts_client_trusted_certificate_thumbprints_1)<br>[CSP reference — trusted thumbprints (user)](/windows/client-management/mdm/policy-csp-admx-terminalserver#ts_client_trusted_certificate_thumbprints_2) |

The **Reference** column links to the Configuration Service Provider (CSP) documentation for each policy.

### Where to find these settings

Find these RDP file policies in the Local Group Policy Editor (`gpedit.msc`) under **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Remote Desktop Services** > **Remote Desktop Connection Client**. Each policy includes a **Help** section that describes how to configure it on the local computer.

Before the July 2026 security update, the **Specify thumbprints of certificates representing trusted .rdp publishers** policy was named **Specify SHA1 thumbprints of certificates representing trusted .rdp publishers** and only accepted SHA-1 thumbprints. After the update, it supports SHA-2 thumbprints.

> [!WARNING]
> SHA-1 thumbprints are supported for backward compatibility only. Don't use them for certificate pinning.
> SHA-1 is a deprecated, insecure cryptographic algorithm.
> A future release will remove support for SHA-1 thumbprints in the **Specify thumbprints of certificates representing trusted .rdp publishers** Group Policy.
> Migrate to SHA-256 thumbprints or a stronger algorithm to avoid disruption.
> After installing the July 2026 security update, refer to the Help section of the policy in the Local Group Policy Editor to learn more about how to configure SHA-2 certificates and the required prefixes.

## Recommended deployment configurations

The right configuration depends on your organization's security posture and how you use RDP files in your environment.

### High-security environments

Use this configuration for all organizations, regardless of security posture or risk profile, whenever your environment allows it.
It's especially important for organizations that handle sensitive data or are frequent targets of phishing.

| Policy | Setting |
|--|--|
| **Allow .rdp files from valid publishers and user's default .rdp settings** | Disabled |
| **Allow .rdp files from unknown publishers** | Disabled |
| **Specify thumbprints of certificates representing trusted .rdp publishers** | Enabled: list only the certificate thumbprints that your organization uses for RDP file signing, preferably by using a SHA-2 thumbprint |

#### Effect of the high-security configuration

Users can only open RDP files signed by an explicitly trusted publisher. All other RDP files are blocked, including files signed by valid but untrusted publishers and connections launched from the user interface of the Remote Desktop Connection application.
This configuration eliminates most phishing attack vectors while still allowing legitimate remote desktop scenarios when you deploy it correctly.

### Permissive environments

Use this configuration for organizations that can't yet adopt the high-security configuration. For example, you still use unsigned RDP files and can't immediately replace them with signed alternatives.

| Policy | Setting |
|--|--|
| **Allow .rdp files from valid publishers and user's default .rdp settings** | Enabled (default) |
| **Allow .rdp files from unknown publishers** | Enabled (default) |
| **Specify thumbprints of certificates representing trusted .rdp publishers** | Enabled (list only the certificate thumbprints that your organization uses for RDP file signing, preferably by using a SHA-2 thumbprint) or Disabled (default) |

#### Effect of the permissive configuration

Users can open all RDP files and launch connections from the user interface. The [security warnings](understanding-security-warnings.md) still protect them: redirections are off by default, and users must explicitly opt in to each redirection. However, this configuration relies entirely on end user judgment.

> [!WARNING]
> Consider this configuration temporary.
> Plan to sign your organization's RDP files and move to a high-security configuration to reduce your phishing attack surface.

## RDP file signing

If your organization distributes RDP files to users, signing them reduces phishing risk and provides a better user experience.

### Manual signing with rdpsign.exe

Manual signing suits RDP files that you create and distribute manually, for example, files shared through email, a file share, or an intranet portal. The [rdpsign.exe tool](../../../administration/windows-commands/rdpsign.md) included with Windows signs an individual RDP file with a certificate, which makes it a good fit for one-off or small-scale distribution.

### Automated signing in Remote Desktop Services collections

Automated signing suits organizations that publish resources through Remote Desktop Services (RDS) session collections or virtual desktop collections. The certificate associated with the RDPublishing role can automatically sign all RemoteApp programs and desktop connections published through the collection, so every published RDP file is signed without extra manual steps.

The Server Manager UI for RDS certificates generates self-signed certificates and deploys them to the certificate store of target devices. For a chained certificate, the [Set-RDCertificate](/powershell/module/remotedesktop/set-rdcertificate) PowerShell cmdlet assigns the certificate to the RDPublishing role instead.

For details, see [Configure RDS certificates](../remote-desktop-services-certificates.md).

### Distributing the thumbprint

Regardless of the signing method, managed devices skip the security warning only for a signing certificate that they trust. The **Specify thumbprints of certificates representing trusted .rdp publishers** Group Policy carries the signing certificate's thumbprint to those devices.

## Related content

- [Understanding security warnings when opening Remote Desktop (RDP) files](understanding-security-warnings.md)
- [rdpsign.exe](../../../administration/windows-commands/rdpsign.md)
- [Configure RDS certificates](../remote-desktop-services-certificates.md)
