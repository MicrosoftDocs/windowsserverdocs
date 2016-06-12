---
title: bitsadmin setpriority
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 90788363-01a2-4d7c-a560-a3eba45b5e9e
---
# bitsadmin setpriority
Sets the priority of the specified job.

## Syntax

```
bitsadmin /SetPriority <Job> <Priority>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|
|Priority|One of the following values:<br /><br />-   foregROUND<br />-   HIGH<br />-   NORMAL<br />-   LOW|

## <a name="BKMK_examples"></a>Examples
The following example sets the priority for the job named *myDownloadJob* to normal.

```
C:\>bitsadmin /SetPriority myDownloadJob NORMAL
```

## additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


