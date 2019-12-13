---
title: Configure HGS for Https communications
ms.custom: na
ms.prod: windows-server
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 08/29/2018
---

# Configure HGS for HTTPS communications

>Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016

By default, when you initialize the HGS server it will configure the IIS web sites for HTTP-only communications.
All sensitive material being transmitted to and from HGS are always encrypted using message-level encryption, however if you desire a higher level of security you can also enable HTTPS by configuring HGS with an SSL certificate.

[!INCLUDE [Configure HTTPS](../../../includes/configure-hgs-for-https.md)] 

