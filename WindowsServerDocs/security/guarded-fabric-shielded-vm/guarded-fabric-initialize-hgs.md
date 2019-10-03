---
title: Initialize HGS
ms.custom: na
ms.prod: windows-server
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 08/29/2018
---

# Initialize the Host Guardian Service (HGS)

>Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016

When you initialize HGS, you specify the mode that HGS will use to measure the health of guarded hosts. There are two mutually exclusive options. For background information about which mode to choose, see [Guarded Fabric and Shielded VM Planning Guide for Hosters](guarded-fabric-planning-for-hosters.md).

The following topics cover deployment steps for each mode:

- [TPM-trusted attestation (TPM mode)](guarded-fabric-initialize-hgs-tpm-mode.md)
- [Host key attestation (Key mode)](guarded-fabric-initialize-hgs-key-mode.md)
- [Admin-trusted attestation (AD mode)](guarded-fabric-initialize-hgs-ad-mode.md)

You should perform these steps on a physical server.