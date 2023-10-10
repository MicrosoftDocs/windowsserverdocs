---
title: bitsadmin cache and deleteURL
description: Reference article for the bitsadmin cache and deleteURL command, which deletes all cache entries for the given URL.
ms.topic: reference
ms.assetid: e108b76b-fae9-4c16-bf4c-d74c9f025953
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin cache and deleteURL

Deletes all cache entries for the given URL.

## Syntax

```
bitsadmin /deleteURL URL
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| URL | The Uniform Resource Locator that identifies a remote file. |

## Examples

To delete all cache entries for `https://www.contoso.com/en/us/default.aspx`:

```
bitsadmin /deleteURL https://www.contoso.com/en/us/default.aspx
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin cache command](bitsadmin-cache.md)
