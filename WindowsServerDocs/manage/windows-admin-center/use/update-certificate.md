---
title: Update the certificate used by Windows Admin Center
description: Learn how to update the HTTPS certificate used by Windows Admin Center, including PowerShell commands and steps to apply and activate the new certificate.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 05/28/2025
---
# Update the certificate used by Windows Admin Center

When you have Windows Admin Center deployed as a service, you must provide a certificate for HTTPS. To update this certificate, use the following these steps.

>[!IMPORTANT]
>When changing your certificate, you need to restart the Windows Admin Center service for the changes to take effect.

1. Sign-in to your machine. If you're on Server core, from the SConfig menu, enter option **15**, then press <kbd>Enter</kbd>

   to open a PowerShell session. If you're on the desktop experience, remote desktop into your VM and launch PowerShell.

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

1. Updated the certificate access control list to grant permissions for the _Network Service_ account to access the certificate. Use the following command, replacing `<subject name>` with the subject name of the certificate:

   ```powershell
   Set-WACCertificateAcl -SubjectName "<subject name>" 
   ```

1. Restart the Windows Admin Center service using the following command:

   ```powershell
   Restart-Service -Name WindowsAdminCenter 
   ```

You've now updated the certificate used by Windows Admin Center.
