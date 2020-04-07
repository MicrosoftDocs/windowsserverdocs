---
title: nslookup set
description: Windows Commands topic for **** - 

ms.prod: windows-server


ms.technology: manage-windows-commands

ms.topic: article
ms.assetid: 1fe5b36d-e93e-468b-abca-43b0204b32d1
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# nslookup set

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Changes configuration settings that affect how lookups function.
## Syntax
```
set <KeyWord>[=<Value>]
```
### Parameters

|    Parameter    |                                                                                                                    Description                                                                                                                    |
|-----------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|    <KeyWord>    | Identifies subcommands that are derived from the **set** subcommand. For example, the subcommand **set d2** has a keyword of [**no**]**d2**. For the list of subcommands that are derived from the **set** subcommand, see additional references. |
|     <Value>     |                                                                                      Specifies the nslookup configuration setting value for each subcommand.                                                                                      |
| {help &#124; ?} |                                                                                               Displays a short summary of **nslookup** subcommands.                                                                                               |

## Remarks
Use **set all** to see a listing of the current settings.
## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)
[nslookup set all](nslookup-set-all.md)
