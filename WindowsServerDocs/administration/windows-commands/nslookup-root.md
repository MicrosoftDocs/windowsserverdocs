---
title: nslookup root
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9c29edc3-ec49-43f2-bc49-86bf0612d816
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# nslookup root

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

changes the default server to the server for the root of the Domain Name System (DNS) domain name space.
## Syntax
```
root 
```
## Parameters

|    Parameter    |                      Description                      |
|-----------------|-------------------------------------------------------|
| {help &#124; ?} | Displays a short summary of **nslookup** subcommands. |

## Remarks
- Currently, the ns.nic.ddn.mil name server is used. This command is a synonym for lserver ns.nic.ddn.mil. You can change the name of the root server with the **set root** command.
  ## additional references
  [Command-Line Syntax Key](command-line-syntax-key.md)
  [nslookup set root](nslookup-set-root.md)
