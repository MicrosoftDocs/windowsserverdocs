---
title: WSUS: WSUS content should be installed on a nonsystem drive
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4dc6b8f3-5785-4b31-87f5-2bb3814acf69
author: britw
---
# WSUS: WSUS content should be installed on a nonsystem drive
*This topic is intended to address a specific issue identified by a [!INCLUDE[bpa](../Token/bpa_md.md)] scan. You should apply the information in this topic only to computers that have had the Windows Server Update Services \(WSUS\) [!INCLUDE[bpa](../Token/bpa_md.md)] run against them and are experiencing the issue addressed by this topic. For more information about [!INCLUDE[bpa](../Token/bpa_md.md)] and scans, see [Best Practices Analyzer](http://go.microsoft.com/fwlink/?LinkId=122786) on Microsoft TechNet.*  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|  
|**Product\/Feature**|Windows Server Update Services 3.0 SP2 \(WSUS 3.0 SP2\)|  
|**Severity**|Warning|  
|**Category**|Performance|  
  
## Issue  
  
> *WSUS content is installed on the system drive.*  
  
## Impact  
  
> *If the system drive runs out of disk space, this can lead to corruption of the operating system and denial of service for any other service.*  
  
## Resolution  
  
> *Move content to another drive to prevent WSUS content from consuming all disk space on the system drive.*  
  
The **wsusutil** command\-line utility is used by administrators to manage WSUS servers and is located in the **WSUSInstallDir\\Tools** folder of the WSUS server. This utility is installed only on WSUS server machines, not on console\-only installations. When you run the **movecontent** command, **wsusutil** does the following:  
  
-   Copies the update files from the old location to the new location. The old location is not deleted.  
  
-   Updates the WSUS database to refer to the new location of the update files.  
  
-   Makes sure that the content and metadata are synchronized.  
  
The destination folder to which update files are moved must be on an NTFS partition. The utility will not try to copy update files if they already exist in the destination folder. The destination folder will have the same permissions that were set on the original folder.  
  
**Syntax**: wsusutil movecontent *contentpath logfile*  
  
|Parameter|Description|  
|-------------|---------------|  
|contentpath|The new root for content files. The path must exist.|  
|logfile|The path and file name of the log file to create.|  
  
#### To move WSUS content to another drive  
  
1.  Create a new content directory on another drive.  
  
2.  Open a command shell.  
  
3.  Locate the WSUSUtil.exe utility in the *WSUSInstallDir***\\Tools** directory of your WSUS installation. Type **cd \/d WSUSInstallDir\\Tools**.  
  
4.  Type **wsusutil movecontent** *NewContentPath logfile* where *NewContentPath* is the new content directory, and *logfile* is the path and file name of the log for this operation.  
  
    For example, type **wsusutil movecontent D:\\WSUS D:\\WSUS\\movecontent.log** where **D:\\WSUS** is the new path for local WSUS update storage, and **D:\\WSUS\\move.log** is the path of the log file.  
  
