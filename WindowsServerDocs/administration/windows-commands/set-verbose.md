---
title: set verbose
description: Reference article for the set verbose command, which specifies whether verbose output is provided during shadow copy creation.
ms.topic: reference
ms.assetid: 93cb93c9-666f-4c74-814b-1c404a949935
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# Set verbose

Specifies whether verbose output is provided during shadow copy creation. If used without parameters, **set verbose** displays help at the command prompt.

## Syntax

```
set verbose {on | off}
```

### Parameters

| Parameter | Description |
|--|--|
| on | Turns on verbose output logging  during the shadow copy creation process. If verbose mode is on, **set** provides details of writer inclusion or exclusion and details of metadata compression and extraction. |
| off | Turns off verbose output logging during the shadow copy creation process. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [set context command](set-context.md)

- [set metadata command](set-metadata.md)

- [set option command](set-option.md)
