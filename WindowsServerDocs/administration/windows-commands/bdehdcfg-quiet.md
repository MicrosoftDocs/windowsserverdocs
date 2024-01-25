---
title: bdehdcfg quiet
description: Reference article for the bdehdcfg quiet command, which tells bdehdcfg to not display all actions and errors.
ms.topic: reference
ms.assetid: 7f75b702-890b-4ff9-805c-edf5cadd8822
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bdehdcfg: quiet

Informs the bdehdcfg command-line tool that all actions and errors are not to be displayed in the command-line interface. Any Yes/No (Y/N) prompts displayed during the drive preparation will assume a "Yes" answer. To view any error that occurred during drive preparation, review the system event log under the **Microsoft-Windows-BitLocker-DrivePreparationTool** event provider.

## Syntax

```
bdehdcfg -target {default|unallocated|<drive_letter> shrink|<drive_letter> merge} -quiet
```

#### Parameters

This command has no additional parameters.

## Examples

To use the **quiet** command:

```
bdehdcfg -target default -quiet
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bdehdcfg](bdehdcfg.md)
