---
title: bitsadmin getaclflags
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 99266def-7479-4430-a61c-98ec433fa88b
---
# bitsadmin getaclflags
Retrieves the access control list propagations flags.

## Syntax

```
bitsadmin /GetAclFlags <Job>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|

## remarks
Displays one or more of the following flag values:

-   O: copy owner information with file.

-   G: copy group information with file.

-   D: copy DACL information with file.

-   S: copy SACL information with file.

## <a name="BKMK_examples"></a>Examples
The following example retrieves the access control list propagation flags for the job named *myDownloadJob*.

```
C:\>bitsadmin /getaclflags myDownloadJob
```

## additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


