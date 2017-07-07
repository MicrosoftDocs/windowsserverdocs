---
title: Install HGS in an existing bastion forest 
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 07/05/2017
---

# Install HGS in an existing bastion forest 

>[!div class="step-by-step"]
[« Prepare for HGS](guarded-fabric-prepare-for-hgs.md)
[Initialize HGS »](guarded-fabric-initialize-hgs.md)

## Join the HGS server to the existing domain

In an existing bastion forest, HGS must be added to the root domain. Use Server Manager or [Add-Computer](http://go.microsoft.com/fwlink/?LinkId=821564) to join your HGS server to the root domain.

## Add the HGS server role

[!INCLUDE [Install the HGS server role](../../../includes/guarded-fabric-install-hgs-server-role.md)] 

## Next steps

- For the next steps to set up TPM-based attestation, see [Initialize the HGS cluster using TPM mode in an existing bastion forest](guarded-fabric-initialize-hgs-tpm-mode-bastion.md).
- For the next steps to set up Admin-based attestation, see [Initialize the HGS cluster using AD mode in an existing bastion forest](guarded-fabric-initialize-hgs-ad-mode-bastion.md).

