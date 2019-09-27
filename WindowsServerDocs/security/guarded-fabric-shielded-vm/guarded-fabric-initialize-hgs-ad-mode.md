---
title: Initialize HGS using Admin-trusted attestation
ms.custom: na
ms.prod: windows-server
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 08/29/2018
---

# Initialize HGS using Admin-trusted attestation

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

>[!IMPORTANT]
>Admin-trusted attestation (AD mode) is deprecated beginning with Windows Server 2019. For environments where TPM attestation is not possible, configure [host key attestation](guarded-fabric-initialize-hgs-key-mode.md). Host key attestation provides similar assurance to AD mode and is simpler to set up. 


These steps vary depending on whether you are initializing HGS in a new forest or an existing bastion forest:

1. [Initialize the HGS cluster in a new forest (default)](guarded-fabric-initialize-hgs-ad-mode-default.md)

   -Or-

   [Initialize the HGS cluster in an existing bastion forest](guarded-fabric-initialize-hgs-ad-mode-bastion.md)

2. [Configure DNS forwarding in the fabric domain](guarded-fabric-configuring-fabric-dns.md)

3. [Configure DNS forwarding and a one-way trust in the HGS domain](guarded-fabric-configure-dns-forwarding-and-trust.md)



