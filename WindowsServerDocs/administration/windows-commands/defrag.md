---
title: defrag
description: Reference article for the defrag command, which locates and consolidates fragmented files on local volumes to improve system performance.
ms.topic: reference
ms.assetid: aaf1d1ac-996a-4282-9b4d-1e8245ff162c
ms.author: wscontent
author: xelu86
ms.date: 09/28/2023
---
# defrag

>Applies to: Windows Server 2022, Windows Server 2019, Windows 11, Windows 10, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Locates and consolidates fragmented files on local volumes to improve system performance.

Membership in the local **Administrators** group, or equivalent, is the minimum required to run this command.

## Syntax

```
defrag <volumes> | /c | /e <volumes>    [/h] [/m [n]| [/u] [v]]
defrag <volumes> | /c | /e <volumes> /a [/h] [/m [n]| [/u] [v]]
defrag <volumes> | /c | /e <volumes> /x [/h] [/m [n]| [/u] [v]]
defrag <volume> [<parameters>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<volume>` | Specifies the drive letter or mount point path of the volume to be defragmented or analyzed. |
| /a | Performs an analysis on the specified volumes. |
| /b | Performs boot optimization to increase boot performance. |
| /c | Performs the operation on all volumes. |
| /d | Performs traditional defrag (this is the default). On a tiered volume though, traditional defrag is performed only on the Capacity tier. |
| /e | Performs the operation on all volumes except those specified. |
| /g | Optimizes the storage tiers on the specified volumes. |
| /h | Runs the operation at normal priority (default is low). |
| /i [n] | Tier optimization would run for at most n seconds on each volume. |
| /k | Performs slab consolidation on the specified volumes. |
| /l | Performs retrim on the specified volumes. |
| /m [n] | Runs the operation on each volume in parallel in the background. At most, *n* threads optimize the storage tiers in parallel. |
| /o | Performs the proper optimization for each media type. |
| /t | Tracks an operation already in progress on the specified volume. |
| /u | Prints the progress of the operation on the screen. |
| /v | Prints verbose output containing the fragmentation statistics. |
| /x | Performs free space consolidation on the specified volumes. |
| /? | Displays the help information. |

#### Remarks

- You can't defragment specific file system volumes or drives, including:

  - Volumes locked by the file system.

  - Volumes the file system marked as dirty, indicating possible corruption.<br>You must run `chkdsk` before you can defragment this volume or drive. You can determine if a volume is dirty by using the `fsutil dirty` command.

  - Network drives.

  - CD-ROMs.

  - File system volumes that aren't **NTFS**, **ReFS**, **Fat** or **Fat32**.

- To perform this procedure, you must be a member of the Administrators group on the local computer, or you must have been delegated the appropriate authority. If the computer is joined to a domain, members of the Domain Admins group might be able to perform this procedure. As a security best practice, consider using **Run As** to perform this procedure.

- A volume must have at least 15% free space for **defrag** to completely and adequately defragment it. **defrag** uses this space as a sorting area for file fragments. If a volume has less than 15% free space, **defrag** will only partially defragment it. To increase the free space on a volume, delete unneeded files or move them to another disk.

- While **defrag** is analyzing and defragmenting a volume, it displays a blinking cursor. When **defrag** is finished analyzing and defragmenting the volume, it displays the analysis report, the defragmentation report, or both reports, and then exits to the command prompt.

- By default, **defrag** displays a summary of both the analysis and defragmentation reports if you don't specify the **/a** or **/v** parameters.

- You can send the reports to a text file by typing **>**<em>FileName.txt</em>, where *FileName.txt* is a file name you specify. For example: `defrag volume /v > FileName.txt`

- To interrupt the defragmentation process, at the command line, press **CTRL+C**.

- Running the **defrag** command and Disk defragmenter are mutually exclusive. If you're using Disk defragmenter to defragment a volume and you run the **defrag** command at a command-line, the **defrag** command fails. Conversely, if you run the **defrag** command and open Disk defragmenter, the defragmentation options in Disk defragmenter are unavailable.

## Examples

To defragment the volume on drive C while providing progress and verbose output, type:

```
defrag c: /u /v
```

To defragment the volumes on drives C and D in parallel in the background, type:

```
defrag c: d: /m
```

To perform a fragmentation analysis of a volume mounted on drive C and provide progress, type:

```
defrag c: mountpoint /a /u
```

To defragment all volumes with normal priority and provide verbose output, type:

```
defrag /c /h /v
```

## Scheduled task

The defragmentation process runs scheduled task as a maintenance task, which typically runs every week. As an Administrator, you can change how often the task runs by using the **Optimize Drives** app.

- When run from the scheduled task, **defrag** uses the below policy guidelines for SSDs:

  - **Traditional optimization processes**. Includes **traditional defragmentation**, for example moving files to make them reasonably contiguous and **retrim**. This is done once per month. However, if both **traditional defragmentation** and **retrim** are skipped, then **analysis** isn't run. Changing the frequency of the scheduled task doesn't affect the once per month cadence for the SSDs.

  - If you manually run **traditional defragmentation** on an SSD, between your normally scheduled runs, the next scheduled task run performs **analysis** and **retrim**, but skips **traditional defragmentation** on that SSD.

  - If you skip **analysis**, you won't see an updated **Last run** time in the **Optimize Drives** app. Because of that, the **Last run** time can be up to a month old.

  - You might find that scheduled task hasn't defragmented all volumes. This is typically because:

    - The process won't wake the computer to run.

    - The computer isn't plugged in. The process won't run if the computer is running on battery power.

    - The computer is resumed from being idle.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [chkdsk](chkdsk.md)

- [fsutil](fsutil.md)

- [fsutil dirty](fsutil-dirty.md)

- [Optimize-Volume PowerShell](/powershell/module/storage/optimize-volume)
