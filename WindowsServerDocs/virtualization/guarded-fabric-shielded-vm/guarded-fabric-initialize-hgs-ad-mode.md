---
title: Initialize HGS using Admin-trusted attestation
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 07/23/2018
---

# Initialize HGS using Admin-trusted attestation

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

>[!IMPORTANT]
>AD mode is deprecated beginning with Windows Server 2019. You can configure [host key attestation](guarded-fabric-initialize-hgs-key-mode.md) instead. 


These steps vary depending on whether you are initializing HGS in a new forest or an existing bastion forest:

1. [Initialize the HGS cluster in a new forest (default)](guarded-fabric-initialize-hgs-ad-mode-default.md)

   -Or-

   [Initialize the HGS cluster in an existing bastion forest](guarded-fabric-initialize-hgs-ad-mode-bastion.md)

2. [Configure DNS forwarding in the fabric domain](guarded-fabric-configuring-fabric-dns.md)

3. [Configure DNS forwarding and a one-way trust in the HGS domain](guarded-fabric-configure-dns-forwarding-and-trust.md)



