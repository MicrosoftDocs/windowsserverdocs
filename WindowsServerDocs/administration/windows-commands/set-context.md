---
title: Set context
description: Reference article for Set context, which sets the context for shadow copy creation.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: fc16c7dd-e8f0-4c2a-8742-0bddb2848bfd
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# Set contex

Sets the context for shadow copy creation. If used without parameters, **set context** displays help at the command prompt.



## Syntax

```
set context {clientaccessible | persistent [nowriters] | volatile [nowriters]}
```

### Parameters

|Parameter|Description|
|---------|-----------|
|clientaccessible|Specifies that the shadow copy is usable by client versions of Windows.|
|persistent|Specifies that the shadow copy persists across program exit, reset, or restart.|
|volatile|Deletes the shadow copy on exit or reset.|
|nowriters|Specifies that all writers are excluded.|

## Remarks

-   The *clientaccessible* context is persistent by default.

## Examples

To prevent shadow copies from being deleted when you exit DiskShadow, type:
```
set context persistent
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)