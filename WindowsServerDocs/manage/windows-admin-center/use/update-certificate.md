---
title: Update the certificate used by Windows Admin Center
description: Learn how to update the HTTPS certificate used by Windows Admin Center, including PowerShell commands and steps to apply and activate the new certificate.
ms.topic: how-to
author: meaghanlewis
ms.author: mosagie
ms.date: 06/23/2025
---
# Update the certificate used by Windows Admin Center

When you have Windows Admin Center (WAC) deployed as a service, you must provide a certificate for HTTPS. TLS certificates play a critical role in securing communications between the WAC gateway and connected devices. By encrypting data and authenticating identities, these certificates enhance the integrity and security of the system.

You might want to update the certificate if:

- You have a new CA
- Your existing private key was disclosed
- You need to renew your certificate

To update this certificate, follow the guidance in this article.

## Prerequisites

To update the certificate used by Windows Admin Center, you need the following prerequisites:

- A Windows PC or server with Windows Admin Center installed.

- Administrative privileges or equivalent permissions on the machine you're using Windows Admin Center on.

- A SSL certificate that is:
  - Issued for Server Authentication (1.3.6.1.5.5.7.3.1).
  - Issued by a certificate authority trusted by the Windows Admin Center machine and clients.
  - Installed in the local computers certificate store.

## Update the certificate

1. Sign-in to your machine. If you're on Server core, from the SConfig menu, enter option **15**, then press Enter to open a PowerShell session. If you're on the desktop experience, remote desktop into your VM and launch PowerShell.

1. Import the Windows Admin Center configuration PowerShell module using the following command:

   ```powershell
   Import-Module "$env:ProgramFiles\WindowsAdminCenter\PowerShellModules\Microsoft.WindowsAdminCenter.Configuration" 
   ```

1. Apply the new certificate using the following command, making sure to replace `<subject name>` with the subject name of the certificate:

   ```powershell
   Set-WACCertificateSubjectName -SubjectName "<subject name>" 
   ```

   >[!TIP]
   > Make sure the certificate uses a unique subject name. Alternatively, you can use the SHA1 thumbprint of the certificate using the **Thumbprint** parameter.

1. Update the certificate access control list to grant permissions for the _Network Service_ account to access the certificate. Use the following command, replacing `<subject name>` with the subject name of the certificate:

   ```powershell
   Set-WACCertificateAcl -SubjectName "<subject name>" 
   ```

1. You must restart the Windows Admin Center service for the changes to take effect. Restart the Windows Admin Center service using the following command:

   ```powershell
   Restart-Service -Name WindowsAdminCenter 
   ```

You've now updated the certificate used by Windows Admin Center.
