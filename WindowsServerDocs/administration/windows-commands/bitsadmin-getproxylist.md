---
title: bitsadmin getproxylist - Retrieves the proxy list for the specified job.
description: Windows Commands topic for bitsadmin getproxylist, which retrieves the proxy list for the specified job.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: eebfa727-d8f1-4ae3-9382-6d8ffe8c3df3
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getproxylist

Retrieves the proxy list for the specified job.

## Syntax

```
bitsadmin /GetProxyList <Job>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|

## Remarks

The proxy list is the list of proxy servers to use. The list is comma-delimited.

## <a name=BKMK_examples></a>Examples

The following example retrieves the proxy list for the job named *myDownloadJob*.
```
C:\>bitsadmin /GetProxyList myDownloadJob
```

## Additional References

[Command-Line Syntax Key](command-line-syntax-key.md)