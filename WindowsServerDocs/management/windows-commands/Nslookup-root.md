---
title: Nslookup root
description: "Windows Commands"
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
ms.date: 10/12/2016
---

# Nslookup root

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Changes the default server to the server for the root of the Domain Name System (DNS) domain name space.
## Syntax
```
root 
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|{help &#124; ?}|Displays a short summary of **nslookup** subcommands.|
## Remarks
-   Currently, the ns.nic.ddn.mil name server is used. This command is a synonym for lserver ns.nic.ddn.mil. You can change the name of the root server with the **set root** command.
## Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Nslookup set root](Nslookup-set-root.md)
