---
title: ksetup:addenctypeattr
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 32cc87d7-b9e1-4d14-9eb7-3b439c55aa3a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# ksetup:addenctypeattr



Adds the encryption type attribute to the list of possible types for the domain. For examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
ksetup /addenctypeattr <DomainName> {DES-CBC-CRC | DES-CBC-MD5 | RC4-HMAC-MD5 | AES128-CTS-HMAC-SHA1-96 | AES256-CTS-HMAC-SHA1-96}
```

### Parameters

|Parameter|Description|
|---------|-----------|
|\<DomainName>|Name of the domain to which you want to establish a connection. Use the fully qualified domain name or a simple form of the name, such as corp.contoso.com or contoso.|
|Encryption type|Must be one of the following supported encryption types:</br>-   DES-CBC-CRC</br>-   DES-CBC-MD5</br>-   RC4-HMAC-MD5</br>-   AES128-CTS-HMAC-SHA1-96</br>-   AES256-CTS-HMAC-SHA1-96|

## Remarks

To view the encryption type for the Kerberos ticket-granting ticket (TGT) and the session key, run the **klist** command and view the output.

You can set or add multiple encryption types by separating the encryption types in the command with a space. However, you can only do so for one domain at a time.

If the command succeeds or fails, a status message is displayed.

To set the domain that you want to connect to and use, run the **ksetup /domain \<DomainName>** command.

## <a name="BKMK_Examples"></a>Examples

Determine the current encryption types that are set on this computer:
```
klist
```
Set the domain to corp.contoso.com:
```
ksetup /domain corp.contoso.com
```
Add the encryption type AES-256-CTS-HMAC-SHA1-96 to the list of possible types for the domain corp.contoso.com:
```
ksetup /addenctypeattr corp.contoso.com AES-256-CTS-HMAC-SHA1-96
```
Set the encryption type attribute to AES-256-CTS-HMAC-SHA1-96 for the domain corp.contoso.com:
```
ksetup /setenctypeattr corp.contoso.com AES-256-CTS-HMAC-SHA1-96
```
Verify that the encryption type attribute was set as intended for the domain:
```
ksetup /getenctypeattr corp.contoso.com
```

#### Additional references

-   [Klist](klist.md)
-   [Ksetup:domain](ksetup-domain.md)
-   [Ksetup:setenctypeattr](ksetup-setenctypeattr.md)
-   [Ksetup:getenctypeattr](ksetup-getenctypeattr.md)
-   [Ksetup:delenctypeattr](ksetup-delenctypeattr.md)
-   [Command-Line Syntax Key](command-line-syntax-key.md)