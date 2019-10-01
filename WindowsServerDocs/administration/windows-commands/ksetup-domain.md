---
title: ksetup:domain
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2ef766e3-6071-44f2-946b-22ea5b61a508
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# ksetup:domain



Sets the domain name for all Kerberos operations. For examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
ksetup /domain <DomainName>
```

### Parameters

|Parameter|Description|
|---------|-----------|
|\<DomainName>|Name of the domain to which you want to establish a connection. Use the fully qualified domain name or a simple form of the name, such as contoso.com or contoso.|

## Remarks

None.

## <a name="BKMK_Examples"></a>Examples

Establish a connection to a valid domain, such as Microsoft by using the /mapuser subcommand:
```
ksetup /mapuser principal@realm domain-user /domain domain-name
```
When the connection is successful, you will receive a new TGT or an existing TGT will be refreshed.

#### Additional references

-   [Ksetup](ksetup.md)
-   [Command-Line Syntax Key](command-line-syntax-key.md)