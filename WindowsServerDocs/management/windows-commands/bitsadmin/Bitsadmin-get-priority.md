---
title: bitsadmin get priority
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ff958003-fcc8-4ad8-a9c7-868a48d9bdeb
---
# bitsadmin get priority
Retrieves the priority of the specified job.

## Syntax

```
bitsadmin /GetPriority <Job>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|

## remarks

-   The priority is either foregROUND, HIGH, NORMAL, LOW, or UNKNOWN.

## <a name="BKMK_examples"></a>Examples
The following example retrieves the priority for the job named *myDownloadJob*.

```
C:\>bitsadmin /GetPriority myDownloadJob
```

## additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


