---
title: Update the Administration Mode Certificate
description: Learn how to update the single gateway HTTPS certificate used by Windows Admin Center Administration Mode with PowerShell or the installer.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 09/30/2026
ai-usage: ai-assisted
---
# Update the Administration Mode gateway certificate

The gateway HTTPS certificate in Windows Admin Center Administration Mode secures communication between the gateway and connected devices by encrypting data and verifying identities. Update the certificate before it expires, if its private key is compromised, or when your organization changes certificate authorities.

This article explains how to replace the certificate by using PowerShell or the Windows Admin Center installer. The procedure applies only to Administration Mode because Virtualization Mode manages its agent and gateway certificates differently.

You might want to update the certificate in Administration Mode if:

- You have a new certificate authority (CA)
- Your existing private key was disclosed
- You need to renew your certificate

To update this certificate, follow the guidance in this article.

> [!NOTE]
> If you use Windows Admin Center in Virtualization Mode, see [Manage certificates in Windows Admin Center Virtualization Mode](../manage-virtualization-mode-certificates.md) instead.

## Prerequisites

To update the certificate that Windows Admin Center uses, you need the following prerequisites:

- A Windows PC or server with Windows Admin Center installed.

- Administrative privileges or equivalent permissions on the machine you're using Windows Admin Center on.

- A TLS certificate that is:
  - Issued for Server Authentication.
  - Issued by a certificate authority trusted by the Windows Admin Center machine and clients.
  - Valid for the fully qualified domain name (FQDN) or IP address used to access Windows Admin Center.
  - Contains the private key.

> [!NOTE]
> Self-signed certificates aren't recommended for use with Windows Admin Center in production environments.

## Update the certificate

### [PowerShell](#tab/powershell)

1. Sign in to your machine. If you're on Server Core, from the SConfig menu, enter option **15**, then select <kbd>Enter</kbd> to open a PowerShell session. If you're on the desktop experience, remote desktop into your VM and launch PowerShell.

1. Import the Windows Admin Center configuration PowerShell module by using the following command:

   ```powershell
   Import-Module "$env:ProgramFiles\WindowsAdminCenter\PowerShellModules\Microsoft.WindowsAdminCenter.Configuration"
   ```

1. Apply the new certificate by using the subject name of the certificate. Ensure the certificate uses a unique subject name. You can find the subject name in the `LocalMachine\My\` certificate store on your computer.

   ```powershell
   Get-ChildItem -Path Cert:\LocalMachine\My
   ```

   ```powershell
   Set-WACCertificateSubjectName -SubjectName "<subject name>"
   ```

   Alternatively, you can use the SHA1 thumbprint of the certificate by using the **Thumbprint** parameter. You can find the thumbprint in the `LocalMachine\My\` certificate store on your computer.

   ```powershell
   Set-WACCertificateSubjectName -Thumbprint "<thumbprint>"
   ```

1. Update the certificate access control list to grant permissions for the _Network Service_ account to access the certificate. Use the following command, replacing `<subject name>` with the subject name of the certificate:

   ```powershell
   Set-WACCertificateAcl -SubjectName "<subject name>"
   ```

1. You must restart the Windows Admin Center service for the changes to take effect. Restart the Windows Admin Center service by using the following command:

   ```powershell
   Restart-Service -Name WindowsAdminCenter
   ```

### [Windows Admin Center](#tab/wac)

1. Open the installer that matches the version of Windows Admin Center currently installed.

1. Advance through the wizard to the **Select TLS certificate** screen.

1. Select the **Use the pre-installed TLS certificate** option, and then select **Next**.

   :::image type="content" source="../media/select-pre-installed-certificate.png" alt-text="Screenshot of the Windows Admin Center installer with Use the pre-installed TLS certificate selected.":::

1. Enter the thumbprint of your certificate. Find the thumbprint in the `LocalMachine\My\` certificate store on your computer.

   :::image type="content" source="../media/select-thumbprint-certificate.png" alt-text="Screenshot of the Windows Admin Center installer with the empty TLS certificate thumbprint dropdown expanded.":::

1. Complete the wizard and start Windows Admin Center.

---

## Troubleshoot certificate issues

Several tools help you find logs and error messages. The following diagnostic tools are the most useful:

- **Event Viewer**: Use the Event Viewer under the WindowsAdminCenter event log to diagnose any issues related to the TLS certificate registration process. This tool provides detailed logs that can help pinpoint specific errors.
- **Browser errors**: If you set up the Windows Admin Center service properly but the browser indicates an error, verify the TLS certificate configuration and ensure it matches the required setup parameters.
- **Ajax error**: An Ajax error might appear when you attempt to open a connection with an invalid certificate. To avoid this issue, install and validate the certificate correctly.

### Common problems

- **Invalid certificate**
  - A certificate might be invalid. This condition shows as "invalid certificate."
  - Even if you don't see an error on the WindowsAdminCenter event log, the browser could indicate invalid certificate status as an icon at the address bar. You can't use Windows Admin Center if it uses an invalid certificate when communicating with the subprocesses.
  - You shouldn't generate a self-signed certificate because it's a security issue.

- **Mismatched DNS name**
  - The certificate DNS name might be different from the Windows Admin Center DNS name.
  - If you don't resolve this mismatch, Windows Admin Center might not work or return errors.

- **Wrong or inaccurate thumbprint**
  - Check that the thumbprint is present and correctly registered. If the thumbprint doesn't match what Windows Admin Center expects, Windows Admin Center might not detect the certificate.

- **Private key not configured to be accessed by the network service**
  - The HTTPS protocol layer reads the certificate's private key to encrypt the TLS payload when communicating over the HTTPS protocol.
   - Windows Admin Center uses the Network Service account, so Network Service must be able to access the private key. Use the `certlm.msc` tool to select the **All Tasks** menu and open the **Manage Private Keys...** dialog.
   - Ensure `NETWORK SERVICE` can access the private key.

- **Network, policy, and firewall configuration issues**
  - If you restrict TLS communications, the Windows Admin Center gateway might not be able to access the certificate. This issue might stem from a firewall or Group Policy Object (GPO).

