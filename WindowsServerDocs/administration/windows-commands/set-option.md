---
title: Set option
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4d8d4921-9fdd-4a3c-bb0f-9df5458c4b84
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# Set option



Sets the options for shadow copy creation. If used without parameters, **set option** displays help at the command prompt.

## Syntax

```
set option {[differential | plex] [transportable] [[rollbackrecover] [txfrecover] | [noautorecover]]}
```

## Parameters

|     Parameter     |                                                                                                  Description                                                                                                  |
|-------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|   [differential   |                                                                                                     plex]                                                                                                     |
|  [transportable]  |                       Specifies that the shadow copy is not to be imported yet. The metadata .cab file can later be used to import the shadow copy to the same or a different computer.                       |
| [rollbackrecover] |                     Signals writers to use *autorecover* during the **PostSnapshot** event. This is useful if the shadow copy will be used for rollback (for example, with data mining).                      |
|   [txfrecover]    |                                                               Requests VSS to make the shadow copy transactionally consistent during creation.                                                                |
|  [noautorecover]  | Stops writers and the file system from performing any recovery changes to the shadow copy to a transactionally consistent state. **Noautorecover** cannot be used with **txfrecover** or **rollbackrecover**. |

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)