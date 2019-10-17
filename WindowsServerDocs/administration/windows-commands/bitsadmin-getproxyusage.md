---
title: bitsadmin getproxyusage
description: "Windows Commands topic for **bitsadmin getproxyusage** - Retrieves the proxy usage setting for the specified job."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f940a70e-3b02-497e-a47f-b37b905c299e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getproxyusage



Retrieves the proxy usage setting for the specified job.

## Syntax

```
bitsadmin /GetProxyUsage <Job>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|

## Remarks

The possible values are:
-   PRECONFIG—use the owner's Internet Explorer defaults.
-   NO_PROXY—do not use a proxy server.
-   OVERRIDE—Use an explicit proxy list.
-   AUTODETECT—Automatically detect the proxy settings.

## <a name="BKMK_examples"></a>Examples

The following example retrieves the proxy usage for the job named *myDownloadJob*.
```
C:\>bitsadmin /GetProxyUsage myDownloadJob
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)