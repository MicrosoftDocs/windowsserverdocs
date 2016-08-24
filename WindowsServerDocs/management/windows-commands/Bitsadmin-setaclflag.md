---
title: Bitsadmin setaclflag
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6e3bcda0-827d-4dfd-8384-d1da018f3e10author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Bitsadmin setaclflag
Sets the access control list propagations flags.
## Syntax
```
bitsadmin /SetAclFlags <Job> <Flags>
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|
|Flags|Specify one or more of the following flag values:<br /><br />-   O: Copy owner information with file.<br />-   G: Copy group information with file.<br />-   D: Copy DACL information with file.<br />-   S :Copy SACL information with file.|
## Remarks
The SetAclFlags command is used to maintain Owner and access control list information when a job is downloading data from a Windows (SMB) share.
## <a name="BKMK_examples"></a>Examples
The following example sets the access control list propagation flags for the job named *myDownloadJob* to maintain the owner and group information with the downloaded files.
```
C:\>bitsadmin /setaclflags myDownloadJob OG
```
## Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
