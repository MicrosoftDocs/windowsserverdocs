---
title: bitsadmin util and repairservice
description: Reference article for the bitsadmin util and repairservice command, which fixes known issues in various versions of BITS service.
ms.topic: reference
ms.assetid: 2ac7baeb-4340-4186-bfcb-66478195378d
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin util and repairservice

If BITS fails to start, this switch attempts to resolve errors related to incorrect service configuration and dependencies on Windows services (such as LANManworkstation) and the network directory. This switch also generates output that indicates if the issues that were resolved.

> [!NOTE]
> This command isn't supported by BITS 1.5 and earlier.

## Syntax

```
bitsadmin /util /repairservice [/force]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| /force | Optional. Deletes and creates the service again.|

> [!NOTE]
> If BITS creates the service again, the service description string might be set to English even in a localized system.

## Examples

To repair the BITS service configuration:

```
bitsadmin /util /repairservice
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin util command](bitsadmin-util.md)

- [bitsadmin command](bitsadmin.md)
