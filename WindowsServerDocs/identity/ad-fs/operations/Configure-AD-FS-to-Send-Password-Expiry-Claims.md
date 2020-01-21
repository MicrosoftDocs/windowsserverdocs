---
ms.assetid: 03c82f43-ae2d-4038-b286-ae3858aed35a
title: Configure AD FS to Send Password Expiry Claims
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---
# Configure AD FS to Send Password Expiry Claims


You can configure Active Directory Federation Services (AD FS) to send password expiry claims to the relying party trusts (applications) that are protected by ADFS. How these claims are used depends on the application. For example, with Office 365 as your relying party, updates have been implemented to Exchange and Outlook to notify federated users of their soon-to-be-expired passwords.

To configure AD FS to send password expiry claims to a relying party trust, you must add the following claim rules to this relying party trust:

```
@RuleName = "Issue Password Expiry Claims"
c1:[Type == "https://schemas.microsoft.com/ws/2012/01/passwordexpirationtime"]
 => issue(store = "_PasswordExpiryStore", types = ("https://schemas.microsoft.com/ws/2012/01/passwordexpirationtime", "https://schemas.microsoft.com/ws/2012/01/passwordexpirationdays", "https://schemas.microsoft.com/ws/2012/01/passwordchangeurl"), query = "{0};", param = c1.Value);
```

> [!NOTE]
> Password expiry claims are only available for username and password and Microsoft Passport for Work authentication types.  If the user authenticates using Windows integrated authentication and Passport is not configured, the claims will not be available and the users will not see password expiry notifications.

> [!NOTE]
> There is a 14 days window so the sent claims will only be populated if the password is expiring within 14 days.

## See Also
[AD FS Operations](../../ad-fs/AD-FS-2016-Operations.md)
