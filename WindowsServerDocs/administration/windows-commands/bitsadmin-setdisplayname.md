---
title: bitsadmin setdisplayname
description: Windows Commands topic for bitsadmin setdisplayname, which sets the display name of the specified job.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 13706c53-fb5f-4879-b5ca-82531361d6e1
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin setdisplayname

Sets the display name of the specified job.

## Syntax

```
bitsadmin /SetDisplayName <Job> <DisplayName>
```

### Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|
|DisplayName|Text used for the display name of the specified job.|

## <a name=BKMK_examples></a>Examples

The following example sets the display name for the job named *myDownloadJob* to *myDownloadJob2*.
```
C:\>bitsadmin /SetDisplayName myDownloadJob Download Music Job
```

## Additional References

[Command-Line Syntax Key](command-line-syntax-key.md)