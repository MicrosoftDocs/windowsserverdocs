---
title: nslookup set root
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8ad5393c-d4fd-4594-8187-576b1dcde60a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# nslookup set root

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

changes the name of the root server used for queries.
## Syntax
```
set root=<RootServer>
```
## Parameters

|    Parameter    |                                   Description                                    |
|-----------------|----------------------------------------------------------------------------------|
|  <RootServer>   | Specifies the new name for the root server. The default value is ns.nic.ddn.mil. |
| {help &#124; ?} |              Displays a short summary of **nslookup** subcommands.               |

## Remarks
- The **set root** subcommand affects the **root** subcommand.
  ## additional references
  [Command-Line Syntax Key](command-line-syntax-key.md)
  [nslookup root](nslookup-root.md)
