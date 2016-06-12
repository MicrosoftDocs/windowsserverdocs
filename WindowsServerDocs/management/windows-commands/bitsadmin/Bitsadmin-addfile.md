---
title: Bitsadmin addfile
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1b31aa93-0364-465b-af36-754968825989
---
# Bitsadmin addfile
Adds a file to the specified job.

## Syntax

```
bitsadmin /AddFile <Job> <RemoteURL> <LocalName>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|
|RemoteURL|The URL of the file on the server.|
|LocalName|The name of the file on the local computer. *LocalName* must contain an absolute path to the file.|

## <a name="BKMK_examples"></a>Examples
Add a file to the job. Repeat this call for each file you want to add. If multiple jobs use *myDownloadJob* as their name, you must replace *myDownloadJob* with the job's GUID to uniquely identify the job.

```
C:\>bitsadmin /addfile myDownloadJob http://downloadsrv/10mb.zip c:\10mb.zip
```

## Additional references
[Command-Line Syntax Key](../Command-Line-Syntax-Key.md)


