---
title: bdehdcfg quiet
description: Windows Commands topic for bdehdcfg quiet - Tells bdehdcfg to not display all actions and errors.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7f75b702-890b-4ff9-805c-edf5cadd8822
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bdehdcfg: quiet



Informs the Bdehdcfg command-line tool that all actions and errors are not to be displayed in the command-line interface. For an example of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
bdehdcfg -target {default|unallocated|<DriveLetter> shrink|<DriveLetter> merge} -quiet
```

### Parameters

This command takes no additional parameters.

## Remarks

If any Yes/No (Y/N) prompts would have been displayed during the drive preparation, a "Yes" answer is assumed. To view any error that occurred during drive preparation, review the system event log under the **Microsoft-Windows-BitLocker-DrivePreparationTool** event provider.

## <a name="BKMK_Examples"></a>Examples

The following example illustrates using the **quiet** command.
```
bdehdcfg -target default -quiet
```

#### Additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)
-   [Bdehdcfg](bdehdcfg.md)