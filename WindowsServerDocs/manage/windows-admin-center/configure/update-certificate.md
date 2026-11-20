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

<a id="troubleshoot-certificate-issues"></a>

## Validate the certificate update

Run the validation commands in an elevated PowerShell session on the Windows Admin Center gateway. These commands work on Desktop Experience and Server Core.

### Select the certificate used for the update

Run only the command block that matches the method you used.

If you used `Set-WACCertificateSubjectName -SubjectName`, replace `<subject name>` with the exact certificate subject that you supplied to that command.

```powershell
$subjectName = '<subject name>'
$matches = @(Get-ChildItem -Path Cert:\LocalMachine\My |
    Where-Object Subject -EQ $subjectName)

if ($matches.Count -ne 1) {
    throw "Expected exactly one certificate with subject '$subjectName'; found $($matches.Count)."
}

$certificate = $matches[0]
```

The command must find exactly one certificate.

If you used `Set-WACCertificateSubjectName -Thumbprint` or the Windows Admin Center installer, replace `<thumbprint>` with the SHA1 thumbprint that you supplied during the update.

```powershell
$expectedThumbprint = ('<thumbprint>' -replace '\s', '').ToUpperInvariant()
$certificate = Get-Item -Path "Cert:\LocalMachine\My\$expectedThumbprint" -ErrorAction Stop
$certificate.Thumbprint -eq $expectedThumbprint
```

The expected result is `True`.

### Check the certificate properties

Run the following command:

```powershell
$now = Get-Date

[pscustomobject]@{
    Subject              = $certificate.Subject
    Thumbprint           = $certificate.Thumbprint
    HasPrivateKey        = $certificate.HasPrivateKey
    CurrentlyValid       = $certificate.NotBefore -le $now -and $now -lt $certificate.NotAfter
    ServerAuthentication = @($certificate.EnhancedKeyUsageList.ObjectId.Value) -contains '1.3.6.1.5.5.7.3.1'
}
```

Compare the results with these values:

| Property | Expected result |
|---|---|
| `Subject` | The subject selected with the subject-name method, if you used that method. |
| `Thumbprint` | The thumbprint selected with the thumbprint or installer method, if you used either method. |
| `HasPrivateKey` | `True` |
| `CurrentlyValid` | `True` |
| `ServerAuthentication` | `True` |

### Validate the certificate chain and gateway name

If you access Windows Admin Center by FQDN, replace `<gateway FQDN>` with the exact FQDN used in the Windows Admin Center URL.

```powershell
Test-Certificate -Cert $certificate -Policy SSL -DNSName 'dns=<gateway FQDN>'
```

The expected result is `True`.

If you access Windows Admin Center by IP address, run:

```powershell
Test-Certificate -Cert $certificate -Policy SSL
certutil.exe -store My $($certificate.Thumbprint)
```

The expected result from `Test-Certificate` is `True`. In the `certutil` output, verify that **Subject Alternative Name** contains the exact gateway IP address used in the Windows Admin Center URL.

### Verify the service and HTTPS port

Verify that the Windows Admin Center service is running:

```powershell
(Get-Service -Name WindowsAdminCenter).Status
```

The expected result is `Running`.

Replace `<gateway FQDN or IP address>` with the gateway address used in the Windows Admin Center URL. Replace `<HTTPS port>` with the port from that URL.

```powershell
Test-NetConnection -ComputerName '<gateway FQDN or IP address>' -Port <HTTPS port>
```

The expected value of `TcpTestSucceeded` is `True`.

### Resolve validation failures

If the certificate-selection check fails, rerun `Set-WACCertificateSubjectName` with the corrected unique subject name or thumbprint.

If a certificate-property or policy check fails, use a certificate that meets the failed prerequisite.

If the service isn't running, grant the required certificate access again:

```powershell
Set-WACCertificateAcl -SubjectName $certificate.Subject
Restart-Service -Name WindowsAdminCenter
```

Repeat the service and port checks once.

