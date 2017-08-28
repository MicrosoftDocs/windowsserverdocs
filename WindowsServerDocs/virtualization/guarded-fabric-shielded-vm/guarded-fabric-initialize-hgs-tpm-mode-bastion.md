---
title: Initialize the HGS cluster using TPM mode in a bastion forest
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 07/05/2017
---

# Initialize the HGS cluster using TPM mode in an existing bastion forest

>Applies To: Windows Server 2016

>[!div class="step-by-step"]
[« Install HGS in an existing bastion forest](guarded-fabric-install-hgs-in-a-bastion-forest.md)
[Install TPM root certs »](guarded-fabric-install-trusted-tpm-root-certificates.md)

Active Directory Domain Services will be installed on the machine, but should remain unconfigured.

[!INCLUDE [Obtain certificates for HGS](../../../includes/guarded-fabric-initialize-hgs-default-step-two.md)]

If you are using PFX-based certificates, run the following commands on the HGS server:

```powershell
$signingCertPass = Read-Host -AsSecureString -Prompt "Signing certificate password"
$encryptionCertPass = Read-Host -AsSecureString -Prompt "Encryption certificate password"

Install-ADServiceAccount -Identity 'HGSgMSA'

Initialize-HgsServer -UseExistingDomain -ServiceAccount 'HGSgMSA' -JeaReviewersGroup 'HgsJeaReviewers' -JeaAdministratorsGroup 'HgsJeaAdmins' -HgsServiceName 'HgsService' -SigningCertificatePath 'C:\temp\SigningCert.pfx' -SigningCertificatePassword $signPass -EncryptionCertificatePath 'C:\temp\EncryptionCert.pfx' -EncryptionCertificatePassword $encryptionCertPass -TrustTpm
```

If you prestaged cluster objects, make sure that the virtual computer object name matches the value provided to `-HgsServiceName`.

If you are using certificates installed on the local machine (such as HSM-backed certificates and non-exportable certificates), use the `-SigningCertificateThumbprint` and `-EncryptionCertificateThumbprint` parameters instead.
