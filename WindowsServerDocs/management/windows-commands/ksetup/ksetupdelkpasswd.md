---
title: ksetup:delkpasswd
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2db0bfcd-bc08-48e3-9f30-65b6411839c6
---
# ksetup:delkpasswd
removes a Kerberos password server \(Kpasswd\) for a realm. for examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
ksetup /delkpasswd <RealmName> <KpasswdName>
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|<RealmName>|The realm name is stated as an uppercase DNS name, such as CORP.CONTOSO.COM, and is listed as the default realm or REALM\= when **ksetup** is run.|
|<KpasswdName>|The KDC name to be used as the Kerberos password server is stated as a case\-insensitive, fully qualified domain name, such as mitkdc.contoso.com. if the KDC name is omitted, DNS might be used to locate KDCs.|

## remarks
Run the command **ksetup** to verify the KDC name. if **kpasswd \=** does not appear in the output, then the mapping has not been configured. Multiple mappings will be listed, if set.

## <a name="BKMK_Examples"></a>Examples
verify the realm CORP.CONTOSO.COM uses the non\-Windows KDC server mitkdc.contoso.com as the password server:

```
ksetup /delkpasswd CORP.CONTOSO.COM mitkdc.contoso.com
```

To verify the command worked as intended, run **ksetup** on the Windows computer to verify the realm CORP.CONTOSO.COM is not mapped to a Kerberos password server \(the KDC name\).

## additional references

-   [ksetup](../ksetup.md)

-   [ksetup:delkpasswd](ksetupdelkpasswd.md)

-   [Command-Line Syntax Key](../commandline-syntax-key.md)


