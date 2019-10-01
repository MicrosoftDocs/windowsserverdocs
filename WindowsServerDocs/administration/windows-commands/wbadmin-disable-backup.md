---
title: wbadmin disable backup
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5176cbd9-0696-4b3f-9c35-272dd84f7898
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# wbadmin disable backup



Stops running the existing scheduled daily backups.

To disable a scheduled daily backup, you must be a member of the **Administrators** group, or you must have been delegated the appropriate permissions. In addition, you must run **wbadmin** from an elevated command prompt. (To open an elevated command prompt right-click **Command Prompt** and then click **Run as administrator**.)

## Syntax

```
wbadmin disable backup
[-quiet]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|-quiet|Runs the subcommand with no prompts to the user.|

#### Additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)
-   [Wbadmin](wbadmin.md)