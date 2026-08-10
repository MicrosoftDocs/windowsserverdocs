---
title: Update the certificate used by Windows Admin Center
description: Learn how to update the HTTPS certificate used by Windows Admin Center, including PowerShell commands and steps to apply and activate the new certificate.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 08/19/2025
---
# Update the certificate used by Windows Admin Center

When you have Windows Admin Center deployed as a service, you must provide a certificate for HTTPS. TLS certificates play a critical role in securing communications between the WAC gateway and connected devices. By encrypting data and authenticating identities, these certificates enhance the integrity and security of the system.

You might want to update the certificate if:

- You have a new CA
- Your existing private key was disclosed
- You need to renew your certificate

To update this certificate, follow the guidance in this article.

## Prerequisites

To update the certificate used by Windows Admin Center, you need the following prerequisites:

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

1. Sign-in to your machine. If you're on Server core, from the SConfig menu, enter option **15**, then press Enter to open a PowerShell session. If you're on the desktop experience, remote desktop into your VM and launch PowerShell.

1. Import the Windows Admin Center configuration PowerShell module using the following command:

   ```powershell
   Import-Module "$env:ProgramFiles\WindowsAdminCenter\PowerShellModules\Microsoft.WindowsAdminCenter.Configuration" 
   ```

1. Apply the new certificate using the subject name of the certificate. Make sure the certificate uses a unique subject name. The subject name can be found in the `LocalMachine\My\` certificate store on your computer.

    ```powershell
    Get-ChildItem -Path Cert:\LocalMachine\My
    ```

   ```powershell
   Set-WACCertificateSubjectName -SubjectName "<subject name>" 
   ```

   Alternatively, you can use the SHA1 thumbprint of the certificate using the **Thumbprint** parameter. The thumbprint can be found in the `LocalMachine\My\` certificate store on your computer.

   ```powershell
   Set-WACCertificateSubjectName -Thumbprint "<thumbprint>"
   ```

1. Update the certificate access control list to grant permissions for the _Network Service_ account to access the certificate. Use the following command, replacing `<subject name>` with the subject name of the certificate:

   ```powershell
   Set-WACCertificateAcl -SubjectName "<subject name>" 
   ```

1. You must restart the Windows Admin Center service for the changes to take effect. Restart the Windows Admin Center service using the following command:

   ```powershell
   Restart-Service -Name WindowsAdminCenter
   ```

### [Windows Admin Center](#tab/wac)

  1. Open the installer that matches the version of Windows Admin Center currently installed.

  1. Advance through the wizard to the **Select TLS certificate** screen.
  
  1. Select the **Use the pre-installed TLS certificate** radio button, then select **Next**.

      :::image type="content" source="../media/select-pre-installed-certificate.png" alt-text="Screenshot of the Select TLS certificate screen.":::

  1. Provide the thumbprint of your certificate. The thumbprint can be found in the `LocalMachine\My\` certificate store on your computer.

      :::image type="content" source="../media/select-thumbprint-certificate.png" alt-text="Screenshot of the Certificate thumbprint screen.":::

  1. Complete the wizard and start Windows Admin Center.

---

## Troubleshooting

There are different tools that you can use to find logs and error messages. The following are the best diagnostic tools to use:

- **Events Viewer**: Utilize the Events Viewer under the WindowsAdminCenter Event log to diagnose any issues related to the TLS certificate registration process. This tool provides detailed logs that can help pinpoint specific errors.
- **Browser errors**: If the WAC service is properly set up but the browser indicates an error, verify the configuration of the TLS certificate and ensure it matches the required setup parameters.
- **Ajax error**: An Ajax error might appear when attempting to open a connection with an invalid certificate. To avoid this issue, ensure the certificate is correctly installed and validated.

### Common problems

- **Invalid certificate**
  - A certificate might be invalid. This shows as "invalid certificate."
  - Even if you don't see an error on WindowsAdminCenter event log, the browser could indicate invalid certificate status as icon at the address bar. WACv2 can't be used if an invalid certificate is used when communicating with the sub processes.
  - You shouldn't generate a self-signed certificate because it's a security issue.

- **Mismatched DNS name**
  - The certificate DNS name might be different from the WAC DNS name.
  - If this isn't resolved then WAC might not work or bring errors.

- **Wrong or inaccurate thumbprint**
  - Check that the thumbprint is present, correctly registered, and doesn't match what is expected. WAC might not detect the certificate.

- **Private Key not configured to be accessed by the network service**
  - HTTPS protocol layer reads private key of certificate to encrypt TLS payload when communicating over HTTPS protocol.
  - WAC uses Network Service account, so Private Key must be accessible by Network Service. Use certlm.msc tool to select All Tasks menu to open **Manage Private Keys...** dialog.
  - Make sure `NETWORK SERVICE` is configured to access the private key.

- **Network, Policy and Firewall configuration issues**
  - If you restrict TLS communications, then the WAC Gateway might not be able to access the certificate. This might be firewall or GPO issue.

