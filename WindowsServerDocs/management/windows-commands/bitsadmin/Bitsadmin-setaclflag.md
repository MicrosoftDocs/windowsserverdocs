---
title: bitsadmin setaclflag
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6e3bcda0-827d-4dfd-8384-d1da018f3e10
---
# bitsadmin setaclflag
Sets the access control list propagations flags.

## Syntax

```
bitsadmin /SetAclFlags <Job> <Flags>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|
|Flags|Specify one or more of the following flag values:<br /><br />-   O: copy owner information with file.<br />-   G: copy group information with file.<br />-   D: copy DACL information with file.<br />-   S :copy SACL information with file.|

## remarks
The SetAclFlags command is used to maintain Owner and access control list information when a job is downloading data from a Windows \(SMB\) share.

## <a name="BKMK_examples"></a>Examples
The following example sets the access control list propagation flags for the job named *myDownloadJob* to maintain the owner and group information with the downloaded files.

```
C:\>bitsadmin /setaclflags myDownloadJob OG
```

## additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


