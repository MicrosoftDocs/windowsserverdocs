---
title: Initialize the HGS cluster using AD mode in a bastion forest 
ms.custom: na
ms.prod: windows-server
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 08/29/2018
---

# Initialize the HGS cluster using AD mode in an existing bastion forest

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016


>[!IMPORTANT]
>Admin-trusted attestation (AD mode) is deprecated beginning with Windows Server 2019. For environments where TPM attestation is not possible, configure [host key attestation](guarded-fabric-initialize-hgs-key-mode-bastion.md). Host key attestation provides similar assurance to AD mode and is simpler to set up. 

Active Directory Domain Services will be installed on the machine, but should remain unconfigured.

[!INCLUDE [Obtain certificates for HGS](../../../includes/guarded-fabric-initialize-hgs-default-step-two.md)] 

Before you continue, ensure that you have prestaged your cluster objects for the Host Guardian Service and granted the logged in user **Full Control** over the VCO and CNO objects in Active Directory.
The virtual computer object name needs to be passed to the `-HgsServiceName` parameter, and the cluster name to the `-ClusterName` parameter.

> [!TIP]
> Double check your AD Domain Controllers to ensure your cluster objects have replicated to all DCs before continuing.

If you are using PFX-based certificates, run the following commands on the HGS server:

```powershell
$signingCertPass = Read-Host -AsSecureString -Prompt "Signing certificate password"
$encryptionCertPass = Read-Host -AsSecureString -Prompt "Encryption certificate password"

Install-ADServiceAccount -Identity 'HGSgMSA'

Initialize-HgsServer -UseExistingDomain -ServiceAccount 'HGSgMSA' -JeaReviewersGroup 'HgsJeaReviewers' -JeaAdministratorsGroup 'HgsJeaAdmins' -HgsServiceName 'HgsService' -ClusterName 'HgsCluster' -SigningCertificatePath '.\signCert.pfx' -SigningCertificatePassword $signPass -EncryptionCertificatePath '.\encCert.pfx' -EncryptionCertificatePassword $encryptionCertPass -TrustActiveDirectory
```

If you are using certificates installed on the local machine (such as HSM-backed certificates and non-exportable certificates), use the `-SigningCertificateThumbprint` and `-EncryptionCertificateThumbprint` parameters instead.

## Next step

> [!div class="nextstepaction"]
> [Configure fabric DNS](guarded-fabric-configuring-fabric-dns-ad.md)

