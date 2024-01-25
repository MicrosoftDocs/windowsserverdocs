---
title: set option
description: Reference article for the set option command, which sets the options for shadow copy creation.
ms.topic: reference
ms.assetid: 4d8d4921-9fdd-4a3c-bb0f-9df5458c4b84
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# set option

Sets the options for shadow copy creation. If used without parameters, **set option** displays help at the command prompt.

## Syntax

```
set option {[differential | plex] [transportable] [[rollbackrecover] [txfrecover] | [noautorecover]]}
```

### Parameters

| Parameter | Description |
|--|--|
| [differential] | Specifies to create a point-in-time snapshot of specified volumes. |
| [plex] | Specifies to create a point-in-time clone copy of the data on a specified volume. |
| [transportable] | Specifies that the shadow copy is not to be imported yet. The metadata .cab file can later be used to import the shadow copy to the same or a different computer. |
| [rollbackrecover] | Signals writers to use *autorecover* during the **PostSnapshot** event. This is useful if the shadow copy will be used for rollback (for example, with data mining). |
| [txfrecover] | Requests VSS to make the shadow copy transactionally consistent during creation. |
| [noautorecover] | Stops writers and the file system from performing any recovery changes to the shadow copy to a transactionally consistent state. **Noautorecover** can't be used with **txfrecover** or **rollbackrecover**. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [set context command](set-context.md)

- [set metadata command](set-metadata.md)

- [set verbose command](set-verbose.md)
