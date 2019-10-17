---
title: ksetup:addkpasswd
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d3196995-1b38-48ff-ba08-911cfab77317
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# ksetup:addkpasswd



Adds a Kerberos password (Kpasswd) server address for a realm. For examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
ksetup /addkpasswd <RealmName> [<KpasswdName>]
```

### Parameters

If the Kerberos realm that the workstation will be authenticating to supports the Kerberos change password protocol, you can configure a client computer running the Windows operating system to use a Kerberos password server. This setting is configured on the realm side.

|Parameter|Description|
|---------|-----------|
|\<RealmName>|The realm name is stated as an uppercase DNS name, such as CORP.CONTOSO.COM, and is listed as the default realm or Realm= when **ksetup** is run.|
|\<KpasswdName>|The KDC name that is to be used as the Kerberos password server is stated as a case insensitive fully qualified domain name, such as mitkdc.microsoft.com. If the KDC name is omitted, DNS might be used to locate KDCs.|

## Remarks

If the Kerberos realm that the workstation will be authenticating to supports the Kerberos change password protocol, you can configure a client computer running the Windows operating system to use a Kerberos password server.

Run the command **ksetup** to verify the KDC name. If **kpasswd =** does not appear in the output, the mapping has not been configured.

You can add additional KDC names one at a time.

## <a name="BKMK_Examples"></a>Examples

Configure the realm, CORP.CONTOSO.COM, so that it uses the non-Windows KDC server, mitkdc.contoso.com, as the password server:
```
ksetup /addkpasswd CORP.CONTOSO.COM mitkdc.contoso.com
```
This results in a non-Windows Kerberos password server that controls all the passwords for authentication between it and the realm.

#### Additional references

-   [Ksetup](ksetup.md)
-   [Ksetup:delkpasswd](ksetup-delkpasswd.md)
-   [Command-Line Syntax Key](command-line-syntax-key.md)