---
title: Ksetup:delkpasswd
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - management
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2db0bfcd-bc08-48e3-9f30-65b6411839c6
author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Ksetup:delkpasswd
Removes a Kerberos password server (Kpasswd) for a realm. For examples of how this command can be used, see [Examples](#BKMK_Examples).
## Syntax
```
ksetup /delkpasswd <RealmName> <KpasswdName>
```
### Parameters
|Parameter|Description|
|-------------|---------------|
|<RealmName>|The realm name is stated as an uppercase DNS name, such as CORP.CONTOSO.COM, and is listed as the default realm or REALM= when **ksetup** is run.|
|<KpasswdName>|The KDC name to be used as the Kerberos password server is stated as a case-insensitive, fully qualified domain name, such as mitkdc.contoso.com. If the KDC name is omitted, DNS might be used to locate KDCs.|
## Remarks
Run the command **ksetup** to verify the KDC name. If **kpasswd =** does not appear in the output, then the mapping has not been configured. Multiple mappings will be listed, if set.
## <a name="BKMK_Examples"></a>Examples
Verify the realm CORP.CONTOSO.COM uses the non-Windows KDC server mitkdc.contoso.com as the password server:
```
ksetup /delkpasswd CORP.CONTOSO.COM mitkdc.contoso.com
```
To verify the command worked as intended, run **ksetup** on the Windows computer to verify the realm CORP.CONTOSO.COM is not mapped to a Kerberos password server (the KDC name).
## Additional references
-   [Ksetup](Ksetup.md)
-   [Ksetup:delkpasswd](Ksetup-delkpasswd.md)
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)
