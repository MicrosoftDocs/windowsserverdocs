---
title: Bitsadmin getaclflags
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 99266def-7479-4430-a61c-98ec433fa88b
---
# Bitsadmin getaclflags
Retrieves the access control list propagations flags.

## Syntax

```
bitsadmin /GetAclFlags <Job>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|

## Remarks
Displays one or more of the following flag values:

-   O: Copy owner information with file.

-   G: Copy group information with file.

-   D: Copy DACL information with file.

-   S: Copy SACL information with file.

## <a name="BKMK_examples"></a>Examples
The following example retrieves the access control list propagation flags for the job named *myDownloadJob*.

```
C:\>bitsadmin /getaclflags myDownloadJob
```

## Additional references
[Command-Line Syntax Key](../Command-Line-Syntax-Key.md)


