---
description: "Learn more about: Initialize the HGS cluster using TPM mode in an existing bastion forest"
title: Initialize the HGS cluster using TPM mode in a bastion forest
ms.topic: article
manager: dongill
author: meaghanlewis
ms.author: mosagie
ms.date: 08/29/2018
---

# Initialize the HGS cluster using TPM mode in an existing bastion forest

To initialize the HGS cluster using TPM mode in an existing bastion forest, follow the steps below. Active Directory Domain Services will be installed on the machine, but should remain unconfigured.

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

Initialize-HgsServer -UseExistingDomain -ServiceAccount 'HGSgMSA' -JeaReviewersGroup 'HgsJeaReviewers' -JeaAdministratorsGroup 'HgsJeaAdmins' -HgsServiceName 'HgsService' -SigningCertificatePath '.\signCert.pfx' -SigningCertificatePassword $signPass -EncryptionCertificatePath '.\encCert.pfx' -EncryptionCertificatePassword $encryptionCertPass -TrustTpm
```

If you are using certificates installed on the local machine (such as HSM-backed certificates and non-exportable certificates), use the `-SigningCertificateThumbprint` and `-EncryptionCertificateThumbprint` parameters instead.

In a production environment, you should continue to [add additional HGS nodes to your cluster](guarded-fabric-configure-additional-hgs-nodes.md).

## Next step

> [!div class="nextstepaction"]
> [Install TPM root certs](guarded-fabric-install-trusted-tpm-root-certificates.md)
