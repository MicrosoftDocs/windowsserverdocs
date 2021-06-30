---
title: format
description: Reference article for the format command, which formats a disk to accept Windows files.
manager: dongill
ms.author: jgerend
ms.topic: reference
ms.assetid: 51ec7423-9a01-4219-868a-25d69cdcc832
author: jasongerend
ms.date: 10/16/2017
---

# Format

> Applies to: Windows 10, Windows Server 2019

Formats a disk to accept Windows files. You must be a member of the Administrators group to format a hard drive.

> [!NOTE]
> You can also use the **format** command, with different parameters, from the Recovery Console. For more information about the recovery console, see [Windows Recovery Environment (Windows RE)](/windows-hardware/manufacture/desktop/windows-recovery-environment--windows-re--technical-reference).

## Syntax

```
format volume [/FS:file-system] [/V:label] [/Q] [/L[:state]] [/A:size] [/C] [/I:state] [/X] [/P:passes] [/S:state]
format volume [/V:label] [/Q] [/F:size] [/P:passes]
format volume [/V:label] [/Q] [/T:tracks /N:sectors] [/P:passes]
format volume [/V:label] [/Q] [/P:passes]
format volume [/Q]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<volume>` | Specifies the mount point, volume name, or drive letter (followed by a colon) of the drive that you want to format. If you do not specify any of the following command-line options, **format** uses the volume type to determine the default format for the disk. |
| /FS:filesystem | Specifies the type of file system (FAT, FAT32, NTFS, exFAT, ReFS, or UDF). |
| /V:`<label>` | Specifies the volume label. If you omit the **/V** command-line option or use it without specifying a volume label, **format** prompts you for the volume label after the formatting is complete. Use the syntax **/V:** to prevent the prompt for a volume label. If you use a single **format** command to format more than one disk, all of the disks will be given the same volume label. |
| /A:`<size>` | Specifies the allocation unit size to use on FAT, FAT32, NTFS, exFAT, or ReFS volumes. If you don't specify *unit size*, it's chosen based on volume size. Default settings are strongly recommended for general use. The following list presents valid values for each type of file system *unit size*:<ul><li>**FAT and FAT32**: 512, 1024, 2048, 4096, 8192, 16K, 32K, 64K. Also 128K and 256K for a sector size greater than 512 bytes.</li><li>**NTFS**: 512, 1024, 2048, 4096, 8192, 16K, 32K, 64K, 128K, 256K, 512K, 1M, 2M</li><li>**exFAT**: 512, 1024, 2048, 4096, 8192, 16K, 32K, 64K, 128K, 256K, 512K, 1M, 2M, 4M, 8M, 16M, 32M</li><li>**ReFS**: 4096, 64K</li></ul>|
| /Q | Performs a quick format. Deletes the file table and the root directory of a previously formatted volume, but does not perform a sector-by-sector scan for bad areas. You should use the **/Q** command-line option to format only previously formatted volumes that you know are in good condition. Note that **/Q** overrides **/Q**. |
| /F:`<size>` | Specifies the size of the floppy disk to format. When possible, use this command-line option instead of the **/T** and **/T** command-line options. Windows accepts the following values for size:<ul><li>1440 or 1440k or 1440kb</li><li>1.44 or 1.44m or 1.44mb</li><li>1.44-MB, double-sided, quadruple-density, 3.5-inch disk</li></ul> |
| /T:`<tracks>` | Specifies the number of tracks on the disk. When possible, use the **/F** command-line option instead. If you use the **/T** option, you must also use the **/N** option. These options together provide an alternative method of specifying the size of the disk that is being formatted. This option is not valid with the **/F** option. |
| /N:`<sectors>` | Specifies the number of sectors per track. When possible, use the **/F** command-line option instead of **/N**. If you use **/N**, you must also use **/T**. These two options together provide an alternative method of specifying the size of the disk that is being formatted. This option is not valid with the **/F** option. |
| /P:`<count>` | Zero every sector on the volume. After that, the volume will be overwritten **count** times using a different random number each time. If **count** is zero, no additional overwrites are made after zeroing every sector. This switch is ignored when **/Q** is specified. |
| /C | NTFS only. Files created on the new volume will be compressed by default. |
| /X | Forces the volume to dismount, if necessary, before it's formatted. Any open handles to the volume will no longer be valid. |
| /R | NTFS only. Files created on the new volume will be compressed by default. |
| /D | UDF 2.50 only. Metadata will be duplicated. |
| /L:`<state>` | NTFS only. Overrides the default size of file record. By default, a non-tiered volume will be formatted with small size file records and a tiered volume will be formatted with large size file records. **/L** and **/L:enable** forces format to use large size file records and **/L:disable** forces format to use small size file records. |
| /S:`<state>` | Specifies support for short filenames. State is either **enable** or **disable**. Short names are disabled by default. |
| /TXF:`<state>` | Specifies TxF is enabled/disabled. State is either **enable** or **disable**. TxF is enabled by default |
| /I:`<state>` | ReFS only. Specifies whether integrity should be enabled on the new volume. State is either **enable** or **disable**. Integrity is enabled on storage that supports data redundancy by default. |
| /DAX:`<state>` | NTFS only. Enable direct access storage (DAX) mode for this volume. In DAX mode, the volume is accessed via the memory bus, boosting IO performance. A volume can be formatted with DAX mode only if the hardware is DAX capable. State is either **enable** or **disable**. **/DAX** is considered the same as **/DAX:enable**. |
| /LogSize::`<size>` | NTFS only Specifies the size for NTFS log file in kilobytes. The minimum supported size is 2MB, so specifying a size smaller than 2MB will result in a 2MB log file. Zero indicates the default value, which generally depends on the volume size. |
| /NoRepairLogs | NTFS only. Disables NTFS repair logs. If the **spotfix** flag for chkdsk is specified (i.e. chkdsk /spotfix), this will not work. |
| /? | Displays help at the command prompt. |

#### Remarks

- The **format** command creates a new root directory and file system for the disk. It can also check for bad areas on the disk, and it can delete all data on the disk. To be able to use a new disk, you must first use this command to format the disk.

- After formatting a floppy disk, **format** displays the following message:

    `Volume label (11 characters, ENTER for none)?`

    To add a volume label, type up to 11 characters (including spaces). If you do not want to add a volume label to the disk, press ENTER.

- When you use the **format** command to format a hard disk, a warning message similar to the following displays:

  ```
  WARNING, ALL DATA ON NON-REMOVABLE DISK
  DRIVE x: WILL BE LOST!
  Proceed with Format (Y/N)? _
  ```

  To format the hard disk, press **Y**; if you do not want to format the disk, press **N**.

- FAT file systems restrict the number of clusters to no more than 65526. FAT32 file systems restrict the number of clusters to between 65527 and 4177917.

- NTFS compression is not supported for allocation unit sizes above 4096.

  > [!NOTE]
  > **Format** will immediately stop processing if it determines that the previous requirements can't be met using the specified cluster size.

- When formatting is complete, **format** displays messages that show the total disk space, the spaces marked as defective, and the space available for your files.

- You can speed up the formatting process by using the **/q** command-line option. Use this option only if there are no bad sectors on your hard disk.

- You shouldn't use the **format** command on a drive that was prepared by using the **subst** command. You can't format disks over a network.

- The following table lists each exit code and a brief description of its meaning.

  | Exit code | Description |
  | --------- | ----------- |
  | 0 | The format operation was successful. |
  | 1 | Incorrect parameters were supplied. |
  | 4 | A fatal error occurred (which is any error other than 0, 1, or 5). |
  | 5 | The user pressed N in response to the prompt "Proceed with Format (Y/N)?" to stop the process. |

  You can check these exit codes by using the ERRORLEVEL environment variable with the **if** batch command.

### Examples

To format a new floppy disk in drive A using the default size, type:

```
format a:
```

To perform a quick format operation on a previously formatted floppy disk in drive A, type:

```
format a: /q
```

To format a floppy disk in drive A and assign it the volume label *DATA*, type:

```
format a: /v:DATA
```

## Additional References

- [Command-Line Syntax Key](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc771080(v=ws.11))
