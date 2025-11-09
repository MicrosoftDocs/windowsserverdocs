---
title: chkdsk
description: Reference article for the chkdsk command, which checks the file system and file system metadata of a volume for logical and physical errors.
ms.topic: reference
author: dknappettmsft
ms.author: daknappe
ms.date: 05/23/2025
---

# chkdsk

Checks the file system and file system metadata of a volume for logical and physical errors. If used without parameters, **chkdsk** displays only the status of the volume and doesn't fix any errors. If used with the **/f**, **/r**, **/x**, or **/b** parameters, it fixes errors on the volume.

> [!IMPORTANT]
> Membership in the local **Administrators** group, or equivalent, is the minimum required to run **chkdsk**. To open a command prompt window as an administrator, right-click **Command prompt** in the **Start** menu, and then select **Run as administrator**.

> [!IMPORTANT]
> Interrupting **chkdsk** isn't recommended. However, canceling or interrupting **chkdsk** shouldn't leave the volume any more corrupt than it was before **chkdsk** was run. Running **chkdsk** again checks and should repair any remaining corruption on the volume.

> [!NOTE]
> Chkdsk can be used only for local disks. The command can't be used with a local drive letter that has been redirected over the network.

## Syntax

```cmd
chkdsk [<volume>[[<path>]<filename>]] [/f] [/v] [/r] [/x] [/i] [/c] [/l[:<size>]] [/b] [/scan] [/forceofflinefix] [/perf] [/spotfix] [/sdcleanup] [/offlinescanandfix] [/freeorphanedchains] [/markclean] [/?]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<volume>` | Specifies the drive letter (followed by a colon), mount point, or volume name. |
| `[<path>]<filename>` | Use with file allocation table (FAT) and FAT32 only. Specifies the location and name of a file or set of files that you want **chkdsk** to check for fragmentation. You can use the wildcard characters **?** and **&#42;** to specify multiple files. |
| /f | Fixes errors on the disk. The disk must be locked. If **chkdsk** can't lock the drive, a message appears that asks you if you want to check the drive the next time you restart the computer. |
| /v | Displays the name of each file in every directory as the disk is checked. |
| /r | Locates bad sectors and recovers readable information. The disk must be locked. **/r** includes the functionality of **/f**, with the additional analysis of physical disk errors. |
| /x | Forces the volume to dismount first, if necessary. All open handles to the drive are invalidated. **/x** also includes the functionality of **/f**.  |
| /i | Use with NTFS only. Performs a less vigorous check of index entries, which reduces the amount of time required to run **chkdsk**. |
| /c | Use with NTFS only. Doesn't check cycles within the folder structure, which reduces the amount of time required to run **chkdsk**.  |
| /l[:`<size>`] | Use with NTFS only. Changes the log file size to the size you type. If you omit the size parameter, **/l** displays the current size. |
| /b | Use with NTFS only. Clears the list of bad clusters on the volume and rescans all allocated and free clusters for errors. **/b** includes the functionality of **/r**. Use this parameter after imaging a volume to a new hard disk drive. |
| /scan | Use with NTFS only. Runs an online scan on the volume. |
| /forceofflinefix | Use with NTFS only (must be used with **/scan**). Bypass all online repair; all defects found are queued for offline repair (for example, `chkdsk /spotfix`). |
| /perf | Use with NTFS only (must be used with **/scan**). Uses more system resources to complete a scan as fast as possible. This might have a negative performance impact on other tasks running on the system. |
| /spotfix | Use with NTFS only. Runs spot fixing on the volume. |
| /sdcleanup | Use with NTFS only. Garbage collect unneeded security descriptor data (implies **/f**). |
| /offlinescanandfix | Runs an offline scan and fix on the volume. |
| /freeorphanedchains | Use with FAT/FAT32/exFAT only. Frees any orphaned cluster chains instead of recovering their contents. |
| /markclean | Use with FAT/FAT32/exFAT only. Marks the volume clean if no corruption was detected, even if **/f** wasn't specified. |
| /? | Displays help at the command prompt. |

## Remarks
- It is recommended to use /scan and then /spotfix, instead of using /f or /r, as a way to perform fixes while requiring less downtime.

- The **/i** or **/c** switch reduces the amount of time required to run **chkdsk** by skipping certain volume checks.

- If you want **chkdsk** to correct disk errors, you can't have open files on the drive. If files are open, the following error message appears:

  ```error
  Chkdsk cannot run because the volume is in use by another process. Would you like to schedule this volume to be checked the next time the system restarts? (Y/N)
  ```

- If you choose to check the drive the next time you restart the computer, **chkdsk** checks the drive and corrects errors automatically when you restart the computer. If the drive partition is a boot partition, **chkdsk** automatically restarts the computer after it checks the drive.

- You can also use the `chkntfs /c` command to schedule the volume to be checked the next time the computer is restarted. Use the `fsutil dirty set` command to set the volume's dirty bit (indicating corruption), so that Windows runs **chkdsk** when the computer is restarted.

- You should use **chkdsk** occasionally on FAT and NTFS file systems to check for disk errors. **Chkdsk** examines disk space and disk use and provides a status report specific to each file system. The status report shows errors found in the file system. If you run **chkdsk** without the **/f** parameter on an active partition, it might report spurious errors because it can't lock the drive.

- **Chkdsk** corrects logical disk errors only if you specify the **/f** parameter. **Chkdsk** must be able to lock the drive to correct errors.

  Because repairs on FAT file systems usually change a disk's file allocation table and sometimes cause a loss of data, **chkdsk** might display a confirmation message similar to the following:

  ```
  10 lost allocation units found in 3 chains.
  Convert lost chains to files?
  ```

  - If you press **Y**, Windows saves each lost chain in the root directory as a file with a name in the format `File<nnnn>.chk`. When **chkdsk** finishes, you can check these files to see if they contain any data you need.

  - If you press **N**, Windows fixes the disk, but it doesn't save the contents of the lost allocation units.

- If you don't use the **/f** parameter, **chkdsk** displays a message that the file needs to be fixed, but it doesn't fix any errors.

- If you use `chkdsk /f*` on a large disk or a disk with a large number of files (for example, millions of files), `chkdsk /f` might take a long time to complete.

- Use the **/r** parameter to find physical disk errors in the file system and attempt to recover data from any affected disk sectors.

- If you specify the **/f** parameter, **chkdsk** displays an error message if there are open files on the disk. If you don't specify the **/f** parameter and open files exist, **chkdsk** might report lost allocation units on the disk. This could happen if open files haven't yet been recorded in the file allocation table. If **chkdsk** reports the loss of a large number of allocation units, consider repairing the disk.

- Because the Shadow Copies for Shared Folders source volume can't be locked while **Shadow Copies for Shared Folders** is enabled, running **chkdsk** against the source volume might report false errors or cause **chkdsk** to unexpectedly quit. You can, however, check shadow copies for errors by running **chkdsk** in Read-only mode (without parameters) to check the Shadow Copies for Shared Folders storage volume.

- The **chkdsk** command, with different parameters, is available from the Recovery Console.

- On servers that are infrequently restarted, you might want to use the **chkntfs** or the `fsutil dirty query` commands to determine whether the volume's dirty bit is already set before running chkdsk.

## How chkdsk performs on different media

# [Hard Disk Drive (HDD)](#tab/hdd)

- **Physical nature:** HDDs use spinning magnetic platters. Sectors and blocks are physically read from the platter.

- **When chkdsk runs:**

  - The physical head must move to each data location being checked, which is **slower** due to mechanical movement.
  - Checking for *bad sectors* (with `/r`) takes longer as every sector's physical integrity is checked and bad ones are replaced if possible.
  - High-hour runtimes aren't uncommon for large drives.

Normally, on large capacity HDDs, `/r` or `/b` would take a considerable amount of time as it reads every sector. Even without errors and with a mostly empty drive, the physical read speed bottlenecks the process.

There might be cases where on large capacity HDDs where `chkdsk` might complete its process too quickly. If this occurs, it might be that:

- The volume is mounted dirty or locked by the operating system (OS) or another process.
- The `chkdsk` operation didn't actually scan every sector on the drive.
- The HDD might have a failing read head or other hardware issue that causes `chkdsk` to behave unpredictably.
- The `chkdsk` operation only performed an online scan of the file system structure and wasn't explicitly made to run an offline scan before booting into the OS.

Viewing the `chkdsk` logs might point to a potential issue during scans. To learn more, see [Viewing chkdsk logs](#viewing-chkdsk-logs).

# [Solid State Drive (SSD)](#tab/ssd)

- **Physical nature:** SSDs store data electronically with no moving parts.

- **When chkdsk runs:**

  - **No seek time:** Reading any sector is equally fast; there's no mechanical latency.
  - Checking for *bad sectors* (with `/r`) is faster but still requires reading **every single sector**. However, NAND flash can read much **faster** than an HDD can.
  - Marking *clusters bad* is logical, not physical remapping.

As sector reads are faster on SSDs, running the `/r` and `/b` parameters complete the process faster due to its physical makeup.

There might be cases where on large capacity SSDs where `chkdsk` might complete its process too quickly. If this occurs, it might be that:

- The `chkdsk` operation didn't actually scan every sector on the drive.
- The SSD didn't have much data to process (more free space).
- The SSD scanned is an NVMe that isn't heavily fragmented.
- The SSD might internally optimize "full scans" efficiently, thus further improving scan speed.

Viewing the `chkdsk` logs might point to a potential issue during scans. To learn more, see [Viewing chkdsk logs](#viewing-chkdsk-logs).

> [!CAUTION]
> While running chkdsk on an SSD isn't dangerous, repeated full-surface scans (especially with `/r`) could unnecessarily increase write/erase cycles, slightly reducing the SSD lifespan. But for occasional checks, this isn't a significant concern.

---

## Understanding exit codes

The following table lists the exit codes that **chkdsk** reports after it has finished.

| Exit code | Description |
| --------- | ----------- |
| 0 | No errors were found. |
| 1 | Errors were found and fixed. |
| 2 | Performed disk cleanup (such as garbage collection) or didn't perform cleanup because **/f** was not specified. |
| 3 | Could not check the disk, errors could not be fixed, or errors were not fixed because **/f** was not specified. |

## Examples

To check the disk in drive D and have Windows fix errors, type:

```cmd
chkdsk d: /f
```

If it encounters errors, **chkdsk** pauses and displays messages. **Chkdsk** finishes by displaying a report that lists the status of the disk. You can't open any files on the specified drive until `chkdsk` finishes.

To check all files on a FAT disk in the current directory for noncontiguous blocks, type:

```cmd
chkdsk *.*
```

**Chkdsk** displays a status report, and then lists the files that match the file specifications that have noncontiguous blocks.

## Viewing chkdsk logs

There are two methods that can be used to retrieve chkdsk log files in Windows, using the Event Viewer and PowerShell.

# [Event Viewer](#tab/event-viewer)

To view logs with Event Viewer, perform the following actions:

1. Start > **Control Panel** > **Administrative Tools** > **Event Viewer**.

   _Alternatively_, press **Win + R** keys to bring up the run dialog box, type **eventvwr.msc**, and select **OK**.

1. Expand **Windows Logs** > right-click on **Application**  > select **Filter Current Log**.
1. Within the **Filter Current Log** window, navigate to **Event sources** drop-down menu, select **Chkdsk** and **Wininit**.
1. Select **OK** to finish filtering for these two sources.

# [PowerShell](#tab/powershell)

There are two source types when retrieving logs in PowerShell, **chkdsk** and **wininit**. Run one of the two commands in PowerShell to view the most current chkdsk log:

```powershell
get-winevent -FilterHashTable @{logname="Application"} | ?{$_.providername -match "chkdsk"} | fl timecreated, message
```

```powershell
get-winevent -FilterHashTable @{logname="Application"} | ?{$_.providername -match "wininit"} | fl timecreated, message
```

To export the log to a specific location, add the following to the end of the command `| out-file "$env:userprofile\location\filename.txt"`. Example:

```powershell
get-winevent -FilterHashTable @{logname="Application"} | ?{$_.providername -match "chkdsk"} | fl timecreated, message | out-file "C:\Users\Administrator\Desktop\Chkdsk_Log.txt"
```

```powershell
get-winevent -FilterHashTable @{logname="Application"} | ?{$_.providername -match "wininit"} | fl timecreated, message | out-file "C:\Users\Administrator\Desktop\Wininit_Log.txt"
```

---

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
