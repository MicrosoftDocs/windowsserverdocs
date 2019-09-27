---
title: wbadmin get status
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2911b944-7b95-46aa-8c1e-1d55a2fcc94c
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# wbadmin get status



Reports the status of the backup or recovery operation that is currently running.

To use this subcommand, you must be a member of the **Backup Operators** group or the **Administrators** group, or you must have been delegated the appropriate permissions. In addition, you must run **wbadmin** from an elevated command prompt. (To open an elevated command prompt right-click **Command Prompt**, and then click **Run as administrator**.)

## Syntax

```
wbadmin get status
```

## Parameters

This subcommand has no parameters.

## Remarks

-   This subcommand will not stop until the current backup or recovery operation is finished—the subcommand will continue to run even if you close the command window.
-   If you want to stop the current backup or recovery operation, use the **wbadmin stop job** subcommand.

#### Additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)
-   [Wbadmin](wbadmin.md)
-   [Get-WBJob](https://technet.microsoft.com/library/jj902426.aspx) cmdlet