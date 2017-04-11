---
title: bitsadmin rawreturn
description: "Windows Commands topic for **bitsadmin rawreturn** - Returns data suitable for parsing."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bbe97130-26f6-4cdd-84f1-baf530ce38b7
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# bitsadmin rawreturn

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Returns data suitable for parsing.
## Syntax
```
bitsadmin /RawReturn
```
## remarks
Strips new line characters and formatting from the output.
Typically, you use this command in conjunction with the **create** and **Get\*** commands to receive only the value. You must specify this command before other commands.
## <a name="BKMK_examples"></a>Examples
The following example retrieves the raw data for the state of the job named *myDownloadJob*.
```
C:\>bitsadmin /RawReturn /GetState myDownloadJob
```
## additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
