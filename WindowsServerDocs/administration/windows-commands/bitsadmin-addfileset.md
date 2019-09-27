---
title: bitsadmin addfileset
description: "Windows Commands topic for **bitsadmin addfileset** - adds one or more files to the specified job."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 75466994-262f-4724-b14d-f813c5397675
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin addfileset

Adds one or more files to the specified job.

## Syntax

```
bitsadmin /addfileset <Job> <TextFile>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|
|TextFile|A text file, each line of which contains a remote and a local file name.</br>Note: The names are space-delimited. Lines that begin with a # character are treated as a comment.|

## <a name="BKMK_examples"></a>Examples

```
C:\>bitsadmin /addfileset files.txt
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)