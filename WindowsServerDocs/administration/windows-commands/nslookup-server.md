---
title: nslookup server
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 608267f8-f7b4-412a-8dcd-e08b5ffc2085
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# nslookup server

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Changes the default server to the specified Domain Name System (DNS) domain.
## Syntax
```
server <DNSDomain>
```
## Parameters

|    Parameter    |                          Description                           |
|-----------------|----------------------------------------------------------------|
|   <DNSDomain>   | Required. Specifies the new DNS domain for the default server. |
| {help &#124; ?} |     Displays a short summary of **nslookup** subcommands.      |

## Remarks
- The **server** command uses the current default server to look up the information about the specified DNS domain. This is in contrast to the **lserver** command, which uses the initial server.
  ## additional references
  [Command-Line Syntax Key](command-line-syntax-key.md)
  [nslookup lserver](nslookup-lserver.md)
