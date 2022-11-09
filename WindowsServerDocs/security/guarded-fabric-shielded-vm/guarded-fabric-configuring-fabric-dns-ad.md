---
description: "Learn more about: Configure the fabric DNS for guarded hosts (AD)"
title: Configure the fabric DNS for guarded hosts (AD)
ms.topic: article
ms.assetid: 074b6d09-f16e-49bf-b88a-377139d35067
manager: dongill
author: IngridAtMicrosoft
ms.author: inhenkel
ms.date: 08/29/2018
---

# Configure the fabric DNS for guarded hosts (AD)

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016


>[!IMPORTANT]
>AD mode is deprecated beginning with Windows Server 2019. For environments where TPM attestation is not possible, configure [host key attestation](guarded-fabric-initialize-hgs-key-mode.md). Host key attestation provides similar assurance to AD mode and is simpler to set up.

A fabric administrator needs to configure the fabric DNS takes to allow guarded hosts to resolve the HGS cluster.
The HGS cluster must already be set up by the [HGS administrator](/windows-server/security/guarded-fabric-shielded-vm/guarded-fabric-initialize-hgs).



[!INCLUDE [Configure fabric DNS](../../../includes/guarded-fabric-configure-fabric-dns.md)]


## Next step

> [!div class="nextstepaction"]
> [Configure HGS DNS and a one-way trust](guarded-fabric-configure-dns-forwarding-and-trust.md)
