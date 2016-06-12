---
title: ksetup:getenctypeattr
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6c7ec002-355e-474d-bc27-27215049f1a8
---
# ksetup:getenctypeattr
Retrieves the encryption type attribute for the domain. for examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
ksetup /getenctypeattr <DomainName> 
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|<DomainName>|Name of the domain to which you want to establish a connection. Use the fully qualified domain name or a simple form of the name, such as corp.contoso.com or contoso.|

## remarks
To view the encryption type for the Kerberos ticket\-granting ticket \(TGT\) and the session key, run the **klist** command and view the output.

if the command succeeds or fails, a status message is displayed upon successful or failed completion.

To set the domain that you want to connect to and use, run the **ksetup \/domain <DomainName>** command.

## <a name="BKMK_Examples"></a>Examples
verify the encryption type attribute for the domain:

```
ksetup /getenctypeattr mit.contoso.com
```

## additional references

-   [klist](klist.md)

-   [ksetup:domain](ksetupdomain.md)

-   [ksetup:addenctypeattr](ksetupaddenctypeattr.md)

-   [ksetup:setenctypeattr](ksetupsetenctypeattr.md)

-   [ksetup:delenctypeattr](ksetupdelenctypeattr.md)

-   [Command-Line Syntax Key](../commandline-syntax-key.md)


