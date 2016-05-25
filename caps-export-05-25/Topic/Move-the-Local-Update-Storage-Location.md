---
title: Move the Local Update Storage Location
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d91ad718-d826-48ce-8a6b-a8cd984b315a
author: britw
---
# Move the Local Update Storage Location
If you store updates on the local WSUS server, you can move the update files to a different location by using the **wsusutil.exe** tool. This can become necessary if the storage disk becomes full, or if a hardware change causes the computer to use a different drive to store the update file.  
  
> [!IMPORTANT]  
> Only local volumes are supported for storage locations.  
  
Follow these steps to move the storage location:  
  
### To move local update files  
  
1.  Create the new file path for the new local WSUS update storage location.  
  
2.  Find and run the **wsusutil.exe** tool by following the instructions at [To run the wsusutil tool](../Topic/Manage-WSUS-3.0-SP2-from-the-Command-Line.md#wsutilproc).  
  
3.  Run the following command:  
  
    **wsusutil movecontent***contentpath logfile**\[\-skipcopy\]*  
  
    where:  
  
    -   *contentpath* is the new path for local WSUS update files.  
  
    -   *logfile* is the log file.  
  
    -   *\[\-skipcopy\]* is an optional parameter that lets you change the storage location without copying the update files.  
  
## See Also  
[Manage WSUS 3.0 SP2 from the Command Line](../Topic/Manage-WSUS-3.0-SP2-from-the-Command-Line.md)  
  
