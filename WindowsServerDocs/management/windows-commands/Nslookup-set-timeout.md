---
title: Nslookup set timeout
description: "Windows Commands"
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
ms.date: 10/12/2016
---

# Nslookup set timeout

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Changes the initial number of seconds to wait for a reply to a lookup request.
## Syntax
```
set timeout=<Number>
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|<Number>|Specifies the number of seconds to wait for a reply. The default number of seconds to wait is 5.|
|{help &#124; ?}|Displays a short summary of **nslookup** subcommands.|
## Remarks
-   When a reply to a request is not received within the specified time period, the time-out is doubled and the request is sent again. You can use the **set retry** command to control the number of retries.
## <a name="BKMK_examples"></a>Examples
The following example sets the timeout for getting a response to 2 seconds:
```
set timeout=2
```
## Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Nslookup set retry](Nslookup-set-retry.md)
