---
title: Bitsadmin getcreationtime
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - management
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: be409cb5-ce72-41d9-aafa-edd4e230fd14
author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Bitsadmin getcreationtime
Retrieves the creation time for the specified job.
## Syntax
```
bitsadmin /GetCreationTime <Job>
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|
## <a name="BKMK_examples"></a>Examples
The following example retrieves the creation time for the job named *myDownloadJob*.
```
C:\>bitsadmin /GetCreationTime myDownloadJob
```
## Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
