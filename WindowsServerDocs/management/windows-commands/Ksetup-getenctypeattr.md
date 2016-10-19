---
title: Ksetup:getenctypeattr
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6c7ec002-355e-474d-bc27-27215049f1a8
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Ksetup:getenctypeattr

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Retrieves the encryption type attribute for the domain. For examples of how this command can be used, see [Examples](#BKMK_Examples).
## Syntax
```
ksetup /getenctypeattr <DomainName> 
```
### Parameters
|Parameter|Description|
|-------|--------|
|<DomainName>|Name of the domain to which you want to establish a connection. Use the fully qualified domain name or a simple form of the name, such as corp.contoso.com or contoso.|
## Remarks
To view the encryption type for the Kerberos ticket-granting ticket (TGT) and the session key, run the **klist** command and view the output.
If the command succeeds or fails, a status message is displayed upon successful or failed completion.
To set the domain that you want to connect to and use, run the **ksetup /domain <DomainName>** command.
## <a name="BKMK_Examples"></a>Examples
Verify the encryption type attribute for the domain:
```
ksetup /getenctypeattr mit.contoso.com
```
## Additional references
-   [Klist](Klist.md)
-   [Ksetup:domain](Ksetup-domain.md)
-   [Ksetup:addenctypeattr](Ksetup-addenctypeattr.md)
-   [Ksetup:setenctypeattr](Ksetup-setenctypeattr.md)
-   [Ksetup:delenctypeattr](Ksetup-delenctypeattr.md)
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)
