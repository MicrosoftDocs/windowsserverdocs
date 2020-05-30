---
title: bitsadmin sethttpmethod
description: Reference topic for the bitsadmin sethttpmethod command, which sets the HTTP verb to use.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 03/01/2019
---

# bitsadmin sethttpmethod

Sets the HTTP verb to use.

## Syntax

```
bitsadmin /sethttpmethod <job> <httpmethod>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| job | The job's display name or GUID. |
| httpmethod | The HTTP verb to use. For information about available verbs, see [Method Definitions](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html). |

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
