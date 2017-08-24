---
title: Custom ID Tokens in AD FS 2016
description: A technical overview of the custom id token conecpts in AD FS 2016
author: anandy
ms.author: billmath
manager: femila
ms.date: 08/24/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.reviewer: anandy
ms.technology: identity-adfs
---

# Custom ID Tokens Overview
The article [here](Customize-Id-Token-AD-FS-2016.md) shows how to build an app that uses AD FS for OpenID Connect sign on. However, by default there are only a fixed set of claims available in the id_token. AD FS 2016 has the capability to customize the id_token in OpenID Connect scenarios.

## When are custom ID token used?
In certain scenarios it is possible that the client application does not have a resource that it is trying to access. Therefore, it doesn’t really need an access token. In such cases, the client application essentially needs only an ID token but with some additional claims to help in the functionality.

## What are the restrictions on getting custom claims in ID token?

### Scenario 1

![Restrict](media/Custom-Id-Tokens-in-AD-FS/res1.png)

1.	response_mode is set as form_post
2.	Only public clients can get custom claims in ID token
3.	Relying Party Identifier should be same as client identifier

### Scenario 2

![Restrict](media/Custom-Id-Tokens-in-AD-FS/restrict2.png)

With [KB4019472](https://support.microsoft.com/help/4019472/windows-10-update-kb4019472) installed on your AD FS servers
1.	response_mode is set as form_post
2.	Assign scope allatclaims to the client – RP pair.
You can assign the scope by using the Grant-ADFSApplicationPermission cmdlet as indicated in the example below:
Grant-AdfsApplicationPermission -ClientRoleIdentifier "https://my/privateclient" -ServerRoleIdentifier "https://rp/fedpassive" -ScopeNames "allatclaims","openid"
