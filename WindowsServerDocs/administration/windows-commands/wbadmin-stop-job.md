---
title: wbadmin stop job
description: Reference article for wbadmin stop job, which cancels the backup or recovery operation that is currently running. Canceled operations cannot be restarted—you must rerun a canceled backup or recovery operation from the beginning.
ms.topic: article
ms.assetid: 3b83b398-39c7-4410-bf17-5c1fb1a4f46d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# wbadmin stop job



Cancels the backup or recovery operation that is currently running. Canceled operations cannot be restarted—you must rerun a canceled backup or recovery operation from the beginning.

To stop a backup or recovery operation with this subcommand, you must be a member of the **Backup Operators** group or the **Administrators** group, or you must have been delegated the appropriate authority. In addition, you must run **wbadmin** from an elevated command prompt. (To open an elevated command prompt right-click **Command Prompt** and then click **Run as administrator**.)

## Syntax

```
wbadmin stop job
[-quiet]
```

### Parameters

|Parameter|Description|
|---------|-----------|
|-quiet|Runs the subcommand with no prompts to the user.|

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)
-   [Wbadmin](wbadmin.md)