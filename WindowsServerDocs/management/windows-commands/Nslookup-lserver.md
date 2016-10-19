---
title: Nslookup lserver
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: aee5ea0b-bb17-4c14-bde7-2f7a91f2f22b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Nslookup lserver

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Changes the default server to the specified Domain Name System (DNS) domain.
## Syntax
```
lserver <DNSDomain> 
```
## Parameters
|Parameter|Description|
|-------|--------|
|<DNSDomain>|Specifies the new DNS domain for the default server.|
|{help &#124; ?}|Displays a short summary of **nslookup** subcommands.|
## Remarks
-   The **lserver** command uses the initial server to look up the information about the specified DNS domain. This is in contrast to the **server** command, which uses the current default server.
## Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Nslookup server](Nslookup-server.md)
