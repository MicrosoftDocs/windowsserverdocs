---
title: secedit validate
description: Reference article for the secedit validate command, which validates the security settings stored in a security template.
ms.topic: reference
ms.assetid: 9fb06354-f55a-4ca4-9fbc-9a872eb9b9cf
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# secedit /validate

Validates the security settings stored in a security template (.inf file). Validating security templates can help you determine if one is corrupted or inappropriately set. Corrupted or inappropriately set security templates aren't applied.

## Syntax

```
secedit /validate <configuration file name>
```

### Parameters

| Parameter | Description |
|--|--|
| `<configuration file name>` | Required. Specifies the path and file name for the security template that will be validated. Log files aren't updated by this command. |

## Examples

To verify that the rollback .inf file, *secRBKcontoso.inf*, is still valid after rollback, type:

```
secedit /validate secRBKcontoso.inf
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [secedit /analyze](secedit-analyze.md)

- [secedit /configure](secedit-configure.md)

- [secedit /export](secedit-export.md)

- [secedit /generaterollback](secedit-generaterollback.md)

- [secedit /import](secedit-import.md)