---
title: bitsadmin getproxylist
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: eebfa727-d8f1-4ae3-9382-6d8ffe8c3df3
---
# bitsadmin getproxylist
Retrieves the proxy list for the specified job.

## Syntax

```
bitsadmin /GetProxylist <Job>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|

## remarks

-   The proxy list is the list of proxy servers to use. The list is comma\-delimited.

## <a name="BKMK_examples"></a>Examples
The following example retrieves the proxy list for the job named *myDownloadJob*.

```
C:\>bitsadmin /GetProxylist myDownloadJob
```

## additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


