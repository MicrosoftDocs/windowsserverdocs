---
title: wbadmin delete catalog
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d3041407-4577-4716-a39f-2c8ab48818d1
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# wbadmin delete catalog



Deletes the backup catalog that is stored on the local computer. Use this command when the backup catalog has been corrupted and you cannot restore it using **wbadmin restore catalog**.

To delete a backup catalog with this subcommand, you must be a member of the **Backup Operators** group or the **Administrators** group, or you must have been delegated the appropriate permissions. In addition, you must run **wbadmin** from an elevated command prompt. (To open an elevated command prompt right-click **Command Prompt**, and then click **Run as administrator**.)

## Syntax

```
wbadmin delete catalog
[-quiet]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|-quiet|Runs the subcommand with no prompts to the user.|

## Remarks

If you delete the backup catalog for a computer, you will not be able to access the backups created of that computer using the Windows Server Backup snap-in. In this case, if you can access another backup location, use **wbadmin restore catalog** to restore the backup catalog from that location. You should create a new backup once your backup catalog is deleted.

#### Additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)
-   [Wbadmin](wbadmin.md)
-   [Remove-WBCatalog](https://technet.microsoft.com/library/jj902445.aspx)