---
title: Device Authentication controls in AD FS
description:  This document describes how to enable device authentication in AD FS for Windows Server 2016 and 2012 R2
author: billmath
ms.author: billmath
manager: mtillman
ms.date: 11/09/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: identity-adfs
---

# Device authentication controls in AD FS
The following document shows how to enable device authentication controls in Windows Server 2016 and 2012 R2.

## Device Authentication controls in AD FS 2012 R2
Originally in AD FS 2012 R2 there was one global authentication property called `DeviceAuthenticationEnabled` that controlled device authentication.

To configure the setting, the `Set-AdfsGlobalAuthenticationPolicy` cmdlet was used as shown below:


``` powershell
PS:\>Set-AdfsGlobalAuthenticationPolicy –DeviceAuthenticationEnabled $true
```



To disable device authentication, the same cmdlet was used to set the value to $false.

## Device Authentication controls in AD FS 2016
The only type of device authentication supported in 2012 R2 was clientTLS.  In AD FS 2016, in addition to clientTLS there are two new types of device authentication for modern devices authentication.  These are:
- PKeyAuth
- PRT

To control the new behavior, the `DeviceAuthenticationEnabled` property is used in combination with a new property called `DeviceAuthenticationMethod`.  

The device authentication method determines the type of device authentication that will be done: PRT, PKeyAuth, clientTLS, or some combination.
It has the following values:
 - SignedToken: PRT only
 - PKeyAuth: PRT + PKeyAuth
 - ClientTLS: PRT + clientTLS
 - All: All of the above

As you can see, PRT is part of all device authentication methods, making it in effect the default method that is always enabled when `DeviceAuthenticationEnabled` is set to `$true`.

Example:
To configure the method(s), use the DeviceAuthenticationEnabled cmdlet as above, along with new property:

``` powershell
PS:\>Set-AdfsGlobalAuthenticationPolicy –DeviceAuthenticationEnabled $true
```

>[!NOTE]
> In ADFS 2019, `DeviceAuthenticationMethod` can be used with the `Set-AdfsRelyingPartyTrust` command.

``` powershell
PS:\>Set-AdfsRelyingPartyTrust -DeviceAuthenticationMethod ClientTLS
```

>[!NOTE]
> Enabling device authentication (setting `DeviceAuthenticationEnabled` to `$true`) means the `DeviceAuthenticationMethod` is implicitly set to `SignedToken`, which equates to **PRT**.


``` powershell
PS:\>Set-AdfsGlobalAuthenticationPolicy –DeviceAuthenticationMethod All
```
> [!NOTE]
> The default device authentication method is `SignedToken`.  Other values are **PKeyAuth,**<strong>ClientTLS,</strong> and **All**.

The meanings of the `DeviceAuthenticationMethod` values have changed slightly since AD FS 2016 was released.  See the table below for the meaning of each value, depending on the update level:


|AD FS version|DeviceAuthenticationMethod value|Means|
| ----- | ----- | ----- |
|2016 RTM|SignedToken|PRT + PkeyAuth|
||clientTLS|clientTLS|
||All|PRT + PkeyAuth + clientTLS|
|2016 RTM + up to date with Windows Update|SignedToken (changed meaning)|PRT (only)|
||PkeyAuth (new)|PRT + PkeyAuth|
||clientTLS|PRT + clientTLS|
||All|PRT + PkeyAuth + clientTLS|

## See Also
[AD FS Operations](../../ad-fs/AD-FS-2016-Operations.md)
