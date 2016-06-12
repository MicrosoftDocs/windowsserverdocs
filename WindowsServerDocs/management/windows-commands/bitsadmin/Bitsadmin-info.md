---
title: bitsadmin info
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5c306677-0d64-41c0-8276-5bba7750cecb
---
# bitsadmin info
Displays summary information about the specified job.

## Syntax

```
bitsadmin /Info <Job> [/verbose]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|

## remarks
Use the \/verbose parameter to provide detailed information about the job.

## <a name="BKMK_examples"></a>Examples
The following example retrieves information about the job named *myDownloadJob*.

```
C:\>bitsadmin /Info myDownloadJob
```

## additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


