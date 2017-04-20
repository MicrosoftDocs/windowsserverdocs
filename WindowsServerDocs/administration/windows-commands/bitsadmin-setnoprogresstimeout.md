---
title: bitsadmin setnoprogresstimeout
description: "Windows Commands topic for **bitsadmin setnoprogresstimeout** - Sets the length of time, in seconds, that the service tries to transfer the file after a transient error occurs."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7fac50d9-cc6b-46a4-a96f-fab751ee1756
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# bitsadmin setnoprogresstimeout

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Sets the length of time, in seconds, that the service tries to transfer the file after a transient error occurs.
## Syntax
```
bitsadmin /SetNoProgresstimeout <Job> <timeOutvalue>
```
## Parameters
|Parameter|Description|
|-------|--------|
|Job|The job's display name or GUID|
|timeOutvalue|A number represented in seconds.|
## remarks
-   The no progress timeout interval begins when the job encounters a transient error.
-   The timeout interval stops or resets when a byte of data is successfully transferred.
-   if no progress timeout interval exceeds the *timeOutvalue*, then the job is placed in a fatal error state.
## <a name="BKMK_examples"></a>Examples
The following example sets the no progress time out value for the job named *myDownloadJob* to 20 seconds
```
C:\>bitsadmin /SetNoProgresstimeout myDownloadJob 20
```
## additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
