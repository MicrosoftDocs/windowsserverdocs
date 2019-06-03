---
title: nslookup set timeout
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 07afdaf4-ffec-496f-a188-4e91cf1a28f8
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# nslookup set timeout

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

changes the initial number of seconds to wait for a reply to a lookup request.
## Syntax
```
set timeout=<Number>
```
## Parameters

|    Parameter    |                                           Description                                            |
|-----------------|--------------------------------------------------------------------------------------------------|
|    <Number>     | Specifies the number of seconds to wait for a reply. The default number of seconds to wait is 5. |
| {help &#124; ?} |                      Displays a short summary of **nslookup** subcommands.                       |

## Remarks
- When a reply to a request is not received within the specified time period, the time-out is doubled and the request is sent again. You can use the **set retry** command to control the number of retries.
  ## <a name="BKMK_examples"></a>Examples
  The following example sets the timeout for getting a response to 2 seconds:
  ```
  set timeout=2
  ```
  ## additional references
  [Command-Line Syntax Key](command-line-syntax-key.md)
  [nslookup set retry](nslookup-set-retry.md)
