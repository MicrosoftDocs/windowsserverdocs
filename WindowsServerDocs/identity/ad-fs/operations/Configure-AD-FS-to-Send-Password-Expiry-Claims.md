---
title: Configure AD FS to Send Password Expiry Claims
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 94f6ac86-2db6-4bf3-b7ef-bfae08e45ba6
---
# Configure AD FS to Send Password Expiry Claims
You can configure Active Directory Federation Services \(AD FS\) to send password expiry claims to the relying party trusts \(applications\) that are protected by ADFS. How these claims are used depends on the application. For example, with Office 365 as your relying party, updates have been implemented to Exchange and Outlook to notify federated users of their soon\-to\-be\-expired passwords.

To configure AD FS to send password expiry claims to a relying party trust, you must add the following claim rules to this relying party trust:

```
c1:[Type == "http://schemas.microsoft.com/ws/2012/01/passwordexpirationtime"]
=> issue(store = "_PasswordExpiryStore", types = ("http://schemas.microsoft.com/ws/2012/01/passwordexpirationtime", "http://schemas.microsoft.com/ws/2012/01/passwordexpirationdays", "http://schemas.microsoft.com/ws/2012/01/passwordchangeurl"), query = "{0};", param = c1.Value);
```

> [!NOTE]
> There is a 14 days window so the sent claims will only be populated if the password is expiring within 14 days.

## See Also
[AD FS Operations](../../ad-fs/AD-FS-2016-Operations.md)


