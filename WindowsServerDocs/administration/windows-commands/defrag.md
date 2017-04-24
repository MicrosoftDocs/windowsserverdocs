---
title: defrag
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: aaf1d1ac-996a-4282-9b4d-1e8245ff162c
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# defrag

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Locates and consolidates fragmented files on local volumes to improve system performance.
Membership in the local **Administrators** group, or equivalent, is the minimum required to run this command.

## Syntax
```
defrag <volumes> | /C | /E <volumes>    [/H] [/M | [/U] [/V]]
defrag <volumes> | /C | /E <volumes> /A [/H] [/M | [/U] [/V]]
defrag <volumes> | /C | /E <volumes> /X [/H] [/M | [/U] [/V]]
defrag <volume> /T [/H] [/U] [/V]
```
## Parameters
|Parameter|Description|
|-------|--------|
|<volume>|Specifies the drive letter or mount point path of the volume to be defragmented or analyzed.|
|C|Perform the operation on all volumes.|
|A|Perform analysis on the specified volumes.|
|E|Perform the operation on all volumes except those specified.|
|H|Run the operation at normal priority (default is low).|
|M|Run the operation on each volume in parallel in the background.|
|T|Track an operation already in progress on the specified volume.|
|U|print the progress of the operation on the screen.|
|V|print verbose output containing the fragmentation statistics.|
|X|Perform free space consolidation on the specified volumes.|
|?|Displays this help information.|
## remarks
-   You cannot defragment specific types of file system volumes or drives:
    -   You cannot defragment volumes that the file system has locked.
    -   You cannot defragment volumes that the file system has marked as dirty, which indicates possible corruption. You must run **chkdsk** on a dirty volume before you can defragment it. You can determine if a volume is dirty by using the **fsutil** dirty query command. For more information about **chkdsk** and **fsutil** dirty, see [additional references](defrag.md#BKMK_additionalRef).
    -   You cannot defragment network drives.
    -   You cannot defragment cdROMs.
    -   You cannot defragment file system volumes that are not **NTFS**, **Fat** or **Fat32**.
-   With  Windows Server 2008 R2 ,  Windows Server 2008 , and, Windows Vista, you can schedule to defragment a volume. However, you cannot schedule to defragment a Solid State Drive (SSD) or a volume on a Virtual Hard Disk (VHD) that resides on an SSD.
-   To perform this procedure, you must be a member of the Administrators group on the local computer, or you must have been delegated the appropriate authority. If the computer is joined to a domain, members of the Domain Admins group might be able to perform this procedure. As a security best practice, consider using Run as to perform this procedure.
-   A volume must have at least 15% free space for **defrag** to completely and adequately defragment it. **defrag** uses this space as a sorting area for file fragments. If a volume has less than 15% free space, **defrag** will only partially defragment it. To increase the free space on a volume, delete unneeded files or move them to another disk.
-   While **defrag** is analyzing and defragmenting a volume, it displays a blinking cursor. When **defrag** is finished analyzing and defragmenting the volume, it displays the analysis report, the defragmentation report, or both reports, and then exits to the command prompt.
-   By default, **defrag** displays a summary of both the analysis and defragmentation reports if you do not specify the **/a** or **/v** parameters.
-   You can send the reports to a text file by typing **>***FileName.txt*, where *FileName.txt* is a file name you specify. For example: `defragvolume/v>FileName.txt`
-   To interrupt the defragmentation process, at the command line, press **CTRL+C**.
-   Running the **defrag** command and Disk defragmenter are mutually exclusive. If you are using Disk defragmenter to defragment a volume and you run the **defrag** command at a command-line, the **defrag** command fails. Conversely, if you run the **defrag** command and open Disk defragmenter, the defragmentation options in Disk defragmenter are unavailable.
## <a name="BKMK_examples"></a>Examples
To defragment the volume on drive C while providing progress and verbose output, type:
```
defrag C: /U /V
```
To defragment the volumes on drives C and D in parallel in the background, type:
```
defrag C: D: /M
```
To perform a fragmentation analysis of a volume mounted on drive C and provide progress, type:
```
defrag C: mountpoint /A /U
```
To defragment all volumes with normal priority and provide verbose output, type:
```
defrag /C /H /V
```
#### <a name="BKMK_additionalRef"></a>additional references
-   [chkdsk](chkdsk.md)
-   [fsutil](fsutil.md)
-   [fsutil dirty](fsutil-dirty.md)
-   [Command-Line Syntax Key](command-line-syntax-key.md)
