---
description: "Learn more about: Configure HGS for HTTPS communications"
title: Configure HGS for HTTPS communications
ms.topic: how-to
author: dknappettmsft
ms.author: daknappe
ms.date: 08/29/2018
---

# Configure HGS for HTTPS communications

By default, when you initialize the HGS server it will configure the IIS web sites for HTTP-only communications.
All sensitive material being transmitted to and from HGS are always encrypted using message-level encryption, however if you desire a higher level of security you can also enable HTTPS by configuring HGS with an SSL certificate.

[!INCLUDE [Configure HTTPS](../../../includes/configure-hgs-for-https.md)]



