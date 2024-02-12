---
title: bitsadmin util and version
description: Reference article for the bitsadmin util and version command, which displays the version of BITS service.
ms.topic: reference
ms.assetid: 98f17328-dfbd-4cbb-93c1-b8d424bc3f0a
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin util and version

Displays the version of BITS service (for example, 2.0).

> [!NOTE]
> This command isn't supported by BITS 1.5 and earlier.

## Syntax

```
bitsadmin /util /version [/verbose]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| /verbose | Use this switch to display the file version for each BITS-related DLL and to verify whether the BITS service can start.|

## Examples

To display the version of the BITS Service.

```
bitsadmin /util /version
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin util command](bitsadmin-util.md)

- [bitsadmin command](bitsadmin.md)
