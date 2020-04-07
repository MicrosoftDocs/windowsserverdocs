---
title: bitsadmin cache and deleteurl
description: Windows Commands topic for **bitsadmin cache and deleteurl**, which deletes all cache entries for the given URL.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: e108b76b-fae9-4c16-bf4c-d74c9f025953
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin cache and deleteurl

Deletes all cache entries for the given URL.

## Syntax

```
bitsadmin /deleteURL url
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| url | The Uniform Resource Locator that identifies a remote file. |

## <a name=BKMK_examples></a>Examples

The following example deletes all cache entries for `https://www.contoso.com/en/us/default.aspx`

```
C:\>bitsadmin /deleteURL https://www.contoso.com/en/us/default.aspx 
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)