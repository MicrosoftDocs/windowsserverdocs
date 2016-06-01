---
title: Bitsadmin addfileset
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 75466994-262f-4724-b14d-f813c5397675
---
# Bitsadmin addfileset
Adds one or more files to the specified job.

## Syntax

```
bitsadmin /addfileset <Job> <TextFile>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|
|TextFile|A text file containing remote and local file names. **Note:** The names are space\-delimited. Lines that begin with a \# character are treated as a comment.|

## <a name="BKMK_examples"></a>Examples

```
C:\>bitsadmin /addfileset files.txt
```

## Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)


