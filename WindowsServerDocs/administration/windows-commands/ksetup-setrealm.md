---
title: ksetup:setrealm
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ab268c40-276b-46ef-ab16-d5ce7667fbed
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# ksetup:setrealm



Sets the name of a Kerberos realm. For examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
ksetup /setrealm <DNSDomainName>
```

### Parameters

|Parameter|Description|
|---------|-----------|
|\<DNSDomainName>|The DNS domain name can be in the form of a fully qualified domain name or simple domain name.|

## Remarks

The DNS domain name parameter should be entered in uppercase letters. Otherwise, the **ksetup** command will ask for verification to continue.

Setting the Kerberos realm on a domain controller is not supported. Attempting to do so will cause a warning and a command failure.

## <a name="BKMK_Examples"></a>Examples

Set the realm for this computer to a specific domain name to restrict access by a non-domain controller just to the CONTOSO Kerberos realm:
```
ksetup /setrealm CONTOSO
```

#### Additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)
-   [Ksetup](ksetup.md)
-   [Ksetup:removerealm](ksetup-removerealm.md)