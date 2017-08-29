---
title: Initialize HGS
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 07/05/2017
---

# Initialize the Host Guardian Service (HGS)

>Applies To: Windows Server 2016

>[!div class="step-by-step"]
[« Install HGS](guarded-fabric-choose-where-to-install-hgs.md)
[Configure Https »](guarded-fabric-configure-hgs-https.md)

When you initialize HGS, you specify the mode that HGS will use to measure the health of guarded hosts. There are two mutually exclusive options. For background information about which mode to choose, see [Guarded Fabric and Shielded VM Planning Guide for Hosters](guarded-fabric-planning-for-hosters.md).

The following topics cover deployment steps for each mode:

- [TPM-trusted attestation (TPM mode)](guarded-fabric-initialize-hgs-tpm-mode.md)
- [Admin-trusted attestation (AD mode)](guarded-fabric-initialize-hgs-ad-mode.md)

You should perform these steps on a physical server with Windows Server 2016 installed.