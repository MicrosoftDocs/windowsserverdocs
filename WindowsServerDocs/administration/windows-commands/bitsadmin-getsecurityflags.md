---
title: bitsadmin getsecurityflags
description: "Windows Commands topic for **bitsadmin getsecurityflags** - Reports the HTTP security flags for URL redirection and checks performed on the server certificate during the transfer."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c2e73519-34f4-487b-af11-97d5d08ef9bb
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# bitsadmin getsecurityflags

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Reports the HTTP security flags for URL redirection and checks performed on the server certificate during the transfer.

## Syntax

```
bitsadmin /GetSecurityFlags <Job> 
```

## Parameters

|Parameter|Description|
|-------|--------|
|Job|The job's display name or GUID|

## <a name="BKMK_examples"></a>Examples
The following example retrieves the securitly flags from a job named *myJob*.

```
C:\>bitsadmin /GetSecurityFlags myJob 
```

## additional references
[Command-Line Syntax Key](command-line-syntax-key.md)


