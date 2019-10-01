---
title: Remote Desktop Services - Access from anywhere
description: Planning information for an RD Gateway
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5c38fab1-3586-4b7a-8bf0-7d85a8d5361d
author: lizap
ms.author: elizapo
ms.date: 11/03/2016
manager: dongill
---
# Remote Desktop Services - Access from anywhere

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016

End users can connect to internal network resources securely from outside the corporate firewall through RD Gateway.

Regardless of how you configure the desktops for your end-users, you can easily plug the RD Gateway into the connection flow for a fast, secure connection. For end-users connecting through published feeds, you can configure the RD Gateway property as you configure the overall deployment properties. For end-users connecting through to their desktops without a feed, they can easily add the name of the organization's RD Gateway as a connection property no matter which Remote Desktop client application they use.

The three primary purposes of the RD Gateway, in the order of the connection sequence, are:
1. **Establish an encrypted SSL tunnel between the end-user's device and the RD Gateway Server**: In order to connect through any RD Gateway server, the RD Gateway server must have a certificate installed that the end-user's device recognizes. In testing and proofs of concepts, self-signed certificates can be used, but only publicly trusted certificates from a certificate authority should be used in any production environment.
2. **Authenticate the user into the environment**: The RD Gateway uses the inbox IIS service to perform authentication, and can even utilize the RADIUS protocol to leverage [multi-factor authentication](rds-plan-mfa.md) solutions such as Azure MFA. Aside from the default policies created, you can create additional RD Resource Authorization Policies (RD RAPs) and RD Connection Authorization Policies (RD CAPs) to more specifically define which users should have access to which resources within the secure environment.
3. **Pass traffic back and forth between the end-user's device and the specified resource**: The RD Gateway continues to perform this task for as long as the connection is established. You can specify different timeout properties on the RD Gateway servers to maintain the security of the environment in case the user walks away from the device.

You can find additional details on the overall architecture of a Remote Desktop Services deployment [in the desktop hosting reference architecture](desktop-hosting-reference-architecture.md).