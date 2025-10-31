---
title: nslookup set class
description: Reference article for the nslookup set class command, which changes the query class.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---

# nslookup set class

Changes the query class. The class specifies the protocol group of the information.

## Syntax

```
set class=<class>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<class>` | The valid values include:<ul><li>**IN:** Specifies the Internet class. This is the default value.</li><li>**CHAOS:** Specifies the Chaos class.</li><li>**HESIOD:** Specifies the MIT Athena Hesiod class.</li><li>**ANY:** Specifies to use any of the previously listed values.</li></ul> |
| /? | Displays help at the command prompt. |
| /help | Displays help at the command prompt. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
