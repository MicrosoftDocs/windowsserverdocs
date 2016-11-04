---
title: fsutil reparsepoint
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c2e983b6-3222-4d2e-a196-12fc3ff92586
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# fsutil reparsepoint

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Queries or deletes reparse points.  The **fsutil reparsepoint** command is typically used by support professionals.  
  
for examples of how to use this command, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
fsutil reparsepoint [query] <FileName>  
fsutil reparsepoint [delete] <FileName>  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------|--------|  
|query|Retrieves the reparse point data that is associated with the file or directory identified by the specified handle.|  
|delete|deletes a reparse point from the file or directory that is identified by the specified handle, but does not delete the file or directory.|  
|<FileName>|Specifies the full path to the file including the file name and extension, for example C:\\documents\\filename.txt.|  
  
## remarks  
  
-   Reparse points are NTFS file system objects that have a definable attribute that contains user\-defined data, and they are used to extend functionality in the input\/output \(I\/O\) subsystem.  
  
-   Reparse points are used for directory junction points and volume mount points. They are also used by file system filter drivers to mark certain files as special to that driver.  
  
-   When a program sets a reparse point, it stores this data, plus a reparse tag, which uniquely identifies the data it is storing. When the file system opens a file with a reparse point, it attempts to find the associated file system filter. if the file system filter is found, the filter processes the file as directed by the reparse data. if no file system filter is found, the File open operation fails.  
  
## <a name="BKMK_examples"></a>Examples  
To retrieve reparse point data associated with C:\\Server, type:  
  
```  
fsutil reparsepoint query c:\server  
```  
  
To delete a reparse point from a specified file or directory, use the following format:  
  
```  
fsutil reparsepoint delete c:\server  
```  
  
#### additional references  
[Command-Line Syntax Key](command-line-syntax-key.md)  
  
[fsutil](fsutil.md)  
  

