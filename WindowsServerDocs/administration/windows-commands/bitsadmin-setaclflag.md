---
title: bitsadmin setaclflag
description: "Windows Commands topic for **bitsadmin setaclflag** - Sets the access control list propagations flags."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6e3bcda0-827d-4dfd-8384-d1da018f3e10
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin setaclflag

Sets the access control list (ACL) propagations flags for the job. The flags indicate that you want to maintain the owner and ACL information with the file being downloaded. For example, to maintain the owner and group with the file, set **Flags** to `OG`.

## Syntax

```
bitsadmin /SetAclFlags <Job> <Flags>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|
|Flags|Specify one or more of the following flag values:</br>-   O: Copy owner information with file.</br>-   G: Copy group information with file.</br>-   D: Copy DACL information with file.</br>-   S :Copy SACL information with file.|

## Remarks

The SetAclFlags switch is used to maintain Owner and access control list information when a job is downloading data from a Windows (SMB) share.

## <a name="BKMK_examples"></a>Examples

The following example sets the access control list propagation flags for the job named *myDownloadJob* to maintain the owner and group information with the downloaded files.
```
C:\>bitsadmin /setaclflags myDownloadJob OG
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)