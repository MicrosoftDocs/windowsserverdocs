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
ms.date: 10/16/2017
---
# defrag

>Applies To: Windows 10, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Locates and consolidates fragmented files on local volumes to improve system performance.
Membership in the local **Administrators** group, or equivalent, is the minimum required to run this command.

## Syntax
```
defrag <volumes> | /C | /E <volumes>    [/H] [/M [n]| [/U] [/V]]
defrag <volumes> | /C | /E <volumes> /A [/H] [/M [n]| [/U] [/V]]
defrag <volumes> | /C | /E <volumes> /X [/H] [/M [n]| [/U] [/V]]
defrag <volume> [/<Parameter>]*
```
## Parameters

|Parameter|Description|
|-------|--------|
|`<volume>`|Specifies the drive letter or mount point path of the volume to be defragmented or analyzed.|
|A|Perform analysis on the specified volumes.|
|C|Perform the operation on all volumes.|
|D|Perform traditional defrag (this is the default). On a tiered volume though, traditional defrag is performed only on the Capacity tier.|
|E|Perform the operation on all volumes except those specified.|
|G|Optimize the storage tiers on the specified volumes.|
|H|Run the operation at normal priority (default is low).|
|I n|Tier optimization would run for at most n seconds on each volume.|
|K|Perform slab consolidation on the specified volumes.|
|L|Perform retrim on the specified volumes.|
|M [n]|Run the operation on each volume in parallel in the background. At most n threads optimize the storage tiers in parallel.|
|O|Perform the proper optimization for each media type.|
|T|Track an operation already in progress on the specified volume.|
|U|print the progress of the operation on the screen.|
|V|print verbose output containing the fragmentation statistics.|
|X|Perform free space consolidation on the specified volumes.|
|?|Displays this help information.|

## Remarks
- You cannot defragment specific types of file system volumes or drives:
  -   You cannot defragment volumes that the file system has locked.
  -   You cannot defragment volumes that the file system has marked as dirty, which indicates possible corruption. You must run **chkdsk** on a dirty volume before you can defragment it. You can determine if a volume is dirty by using the **fsutil** dirty query command. For more information about **chkdsk** and **fsutil** dirty, see [additional references](defrag.md#BKMK_additionalRef).
  -   You cannot defragment network drives.
  -   You cannot defragment cdROMs.
  -   You cannot defragment file system volumes that are not **NTFS**, **ReFS**, **Fat** or **Fat32**.
- With  Windows Server 2008 R2 ,  Windows Server 2008 , and, Windows Vista, you can schedule to defragment a volume. However, you cannot schedule to defragment a Solid State Drive (SSD) or a volume on a Virtual Hard Disk (VHD) that resides on an SSD.
- To perform this procedure, you must be a member of the Administrators group on the local computer, or you must have been delegated the appropriate authority. If the computer is joined to a domain, members of the Domain Admins group might be able to perform this procedure. As a security best practice, consider using **Run As** to perform this procedure.
- A volume must have at least 15% free space for **defrag** to completely and adequately defragment it. **defrag** uses this space as a sorting area for file fragments. If a volume has less than 15% free space, **defrag** will only partially defragment it. To increase the free space on a volume, delete unneeded files or move them to another disk.
- While **defrag** is analyzing and defragmenting a volume, it displays a blinking cursor. When **defrag** is finished analyzing and defragmenting the volume, it displays the analysis report, the defragmentation report, or both reports, and then exits to the command prompt.
- By default, **defrag** displays a summary of both the analysis and defragmentation reports if you do not specify the **/a** or **/v** parameters.
- You can send the reports to a text file by typing **>**<em>FileName.txt</em>, where *FileName.txt* is a file name you specify. For example: `defrag volume /v > FileName.txt`
- To interrupt the defragmentation process, at the command line, press **CTRL+C**.
- Running the **defrag** command and Disk defragmenter are mutually exclusive. If you are using Disk defragmenter to defragment a volume and you run the **defrag** command at a command-line, the **defrag** command fails. Conversely, if you run the **defrag** command and open Disk defragmenter, the defragmentation options in Disk defragmenter are unavailable.

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

## <a name="BKMK_scheduledTask"></a>Scheduled task
Defrag's scheduled task runs as a maintenance task and is usually scheduled to run every week. Administrator can change the frequency using **Optimize Drives** application.
- When run from the scheduled task, **defrag** has below policy for SSDs:
   - **Traditional defrag** (i.e. moving files to make them reasonably contiguous) and **retrim** is run only once every month.
   - If both **traditional defrag** and **retrim** are skipped, **analysis** is not run.
      - If user ran **traditional defrag** manually on an SSD, say 3 weeks after the last scheduled task run, then the next scheduled task run will perform **analysis** and **retrim** but skip **traditional defrag** on that SSD.
   - If **analysis** is skipped, the **Last run** time in **Optimize Drives** will not be updated.  So for SSDs the **Last run** time in **Optimize Drives** can be a month old.
- This maintenance task might not defrag all the volumes, at times because this task does the following:
   - Doesn't wake the computer in order to run defrag
   - Starts only if the computer is on AC power, and stops if the computer switches to battery power
   - Stops if the computer ceases to be idle

## <a name="BKMK_additionalRef"></a>Additional references
-   [chkdsk](chkdsk.md)
-   [fsutil](fsutil.md)
-   [fsutil dirty](fsutil-dirty.md)
-   [Command-Line Syntax Key](command-line-syntax-key.md)
