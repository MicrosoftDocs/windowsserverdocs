---
title: Authority Information Access in Windows
description: Learn how to manage Authority Information Access (AIA) URL retrieval in Windows, ensuring certificate trust chains are built safely.
ms.topic: how-to
ms.author: roharwoo
author: robinharwood
ms.date: 07/22/2025
---

# AIA URL retrieval in Windows

The Authority Information Access (AIA) extension in X.509 certificates specifies a URL where the issuing Certificate Authority (CA) certificate can be obtained. If a system is unable to build a complete certificate trust chain using only the certificates in its local store, it might attempt to download missing intermediate certificates from the network using the AIA URL. AIA automates the retrieval of missing certificates and minimizes the manual effort required to update local certificate stores.

The automatic retrieval helps complete the trust chain but can introduce security risks if not properly managed. To enhance security, ensure that your certificate stores are properly configured and contain only certificates from trusted CAs. You can further strengthen your environment by disabling AIA retrieval system-wide. This forces Windows APIs to build certificate chains exclusively from certificates already present in the local store, reducing the risk of inadvertently trusting unverified or malicious certificates retrieved from external sources. Adopting this defense-in-depth strategy helps safeguard your systems against unauthorized or unexpected certificate trust paths.

Best practices for managing your CAs include:

- Keep the list of trusted root and intermediate CAs up-to-date. This involves regularly updating the local certificate store with new or updated certificates from trusted sources.

- Ensure intermediate certificates are consistently added to the local store, especially if AIA retrieval is disabled. This prevents potential disruptions in certificate validation.

- Conduct regular audits of the certificate store to identify and remove expired or untrusted certificates. This practice helps maintain trustworthiness and reduces security risks associated with outdated certificates.

## Prerequisites

To make changes to the AIA, you must be a member of the **Administrators**, **Domain Admins**, or **Enterprise Admins** security group.

## Manage AIA retrieval

To disable AIA retrieval system-wide in your environment, follow one of these methods:

# [Group Policy](#tab/gp)

1. Select **Start**, type **gpedit**, and select **Edit group policy**.

1. Navigate to **Computer Configuration\Windows Settings\Security Settings\Public Key Policies** and open **Certificate Path Validation Settings**.

1. Select the **Network Retrieval** tab. Select **Define these policy settings**, uncheck **Allow issuer certificate (AIA) retrieval during path validation**, then select **OK**.

If you need to reenable AIA retrieval, uncheck **Define these policy settings** and then select **OK**.

# [Registry Editor](#tab/registry)

1. Select **Start**, type **regedit**, and select **Registry Editor**.

   *Alternatively*, in **Server Manager**, select **Tools**, then select **Registry Editor**.

1. Navigate to the following path and expand it **HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\SystemCertificates**.

If it's the *first time* you're editing the AIA setting, the **ChainEngine\Config** folder and entries must be manually created.

1. Right-click on **SystemCertificates**. Select **New** > **Key**, type **ChainEngine**, then press **Enter**.

1. Right-click on **ChainEngine** select **New** > **Key**, type **Config**, then press **Enter**.

1. Right-click on **Config** select **New** > **DWORD**, type **Options**, then press **Enter**.

1. Open **Options**, in the **Value data** field, type **2**, then press **Enter**.

If you *previously* edited the AIA setting, these entries are already present. While in **HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\SystemCertificates\ChainEngine\Config**, set the **Options** value to **2**.

If you need to reenable AIA retrieval, set the **Options** value to **0**.

# [PowerShell](#tab/powershell)

Open PowerShell in an elevated window and perform the following steps:

1. Run the following command to add the registry path and entries to disable AIA retrieval if it **doesn't** exist:

   ```powershell
   $registryPath = "HKLM:\Software\Policies\Microsoft\SystemCertificates\ChainEngine\Config"

   New-Item -Path $registryPath -Force | Out-Null
   New-ItemProperty -Path $registryPath -Name "Options" -PropertyType DWORD -Value 2 -Force | Out-Null
   ```

1. Run the following command if the registry path and entries **does** exist to disable AIA retrieval:

   ```powershell
   $registryPath = "HKLM:\Software\Policies\Microsoft\SystemCertificates\ChainEngine\Config"

   New-ItemProperty -Path $registryPath -Name "Options" -PropertyType DWORD -Value 2 -Force | Out-Null
   ```

1. Run the following command if you need to reenable AIA retrieval:

   ```powershell
   $registryPath = "HKLM:\Software\Policies\Microsoft\SystemCertificates\ChainEngine\Config"

   Set-ItemProperty -Path $registryPath -Name "Options" -Value 0 -Force | Out-Null
   ```

---

## Retrieve AIA status

By default, AIA is enabled on your device. AIA retrieval is triggered by the **CCertChainEngine::GetIssuerUrlStore()** function in **crypt32.dll**. The **CERT_CHAIN_DISABLE_AIA** and **CERT_CHAIN_ENSABLE_AIA** is set in the **dwFlags** passed to create the engine or in the call to **CertGetCertificateChain**. To retrieve your current AIA status, run the following command:

```powershell
$registryPath = "HKLM:\Software\Policies\Microsoft\SystemCertificates\ChainEngine\Config"
$propertyName = "Options"
 
try {
    $regCheck = (Get-ItemProperty -Path $registryPath -Name $propertyName -ErrorAction Stop).$propertyName
 
    switch ($value) {
        0 { "AIA is Enabled" }
        2 { "AIA is Disabled" }
        default { "Unexpected value: $regCheck" }
    }
} catch {
    "AIA has not been set"
}
```

## See also

- [Active Directory Certificate Services documentation](/windows-server/identity/ad-cs)

- [Microsoft’s Zero Trust Best Practices](/azure/security/fundamentals/zero-trust)

