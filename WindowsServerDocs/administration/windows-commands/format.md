---
title: Format
ms.prod: windows-server
manager: dongill
ms.author: JGerend
ms.technology: storage
ms.topic: article
ms.assetid: 51ec7423-9a01-4219-868a-25d69cdcc832
author: JasonGerend
ms.date: 10/16/2017
---

# Format
> Applies To: Windows 10, Windows Server 2016

Formats a disk to accept Windows files.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
format <Volume> [/fs:{FAT|FAT32|NTFS}] [/v:<Label>] [/q] [/a:<UnitSize>] [/c] [/x] [/p:<Passes>]
format <Volume> [/v:<Label>] [/q] [/f:<Size>] [/p:<Passes>]
format <Volume> [/v:<Label>] [/q] [/t:<Tracks> /n:<Sectors>] [/p:<Passes>]
format <Volume> [/v:<Label>] [/q] [/p:<Passes>]
format <Volume> [/q]
```

## Parameters

|   Parameter    |                                                                                                                                                                                                                    Description                                                                                                                                                                                                                     |
|----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|   \<Volume>    |                                                                                         Specifies the mount point, volume name, or drive letter (followed by a colon) of the drive that you want to format. If you do not specify any of the following command-line options, **format** uses the volume type to determine the default format for the disk.                                                                                         |
|    /fs:{FAT    |                                                                                                                                                                                                                       FAT32                                                                                                                                                                                                                        |
|  /v:\<Label>   |                           Specifies the volume label. If you omit the **/v** command-line option or use it without specifying a volume label, **format** prompts you for the volume label after the formatting is complete. Use the syntax **/v:** to prevent the prompt for a volume label. If you use a single **format** command to format more than one disk, all of the disks will be given the same volume label.                            |
| /a:\<UnitSize> | Specifies the allocation unit size to use on FAT, FAT32, or NTFS volumes. If you do not specify *UnitSize*, it is chosen based on volume size. Default settings are strongly recommended for general use. The following list presents valid values for NTFS, FAT, and FAT32 *UnitSize*:</br>512</br>1024</br>2048</br>4096</br>8192</br>16K</br>32K</br>64K</br>FAT and FAT32 also support 128K and 256K for a sector size greater than 512 bytes. |
|       /q       |                                                       Performs a quick format. Deletes the file table and the root directory of a previously formatted volume, but does not perform a sector-by-sector scan for bad areas. You should use the **/q** command-line option to format only previously formatted volumes that you know are in good condition. Note that **/q** overrides **/p**.                                                       |
|   /f:\<Size>   |                                                         Specifies the size of the floppy disk to format. When possible, use this command-line option instead of the **/t** and **/n** command-line options. Windows accepts the following values for size:</br>-   1440 or 1440k or 1440kb</br>-   1.44 or 1.44m or 1.44mb</br>-   1.44-MB, double-sided, quadruple-density, 3.5-inch disk                                                         |
|  /t:\<Tracks>  |                                                    Specifies the number of tracks on the disk. When possible, use the **/f** command-line option instead. If you use the **/t** option, you must also use the **/n** option. These options together provide an alternative method of specifying the size of the disk that is being formatted. This option is not valid with the **/f** option.                                                     |
| /n:\<Sectors>  |                                                         Specifies the number of sectors per track. When possible, use the **/f** command-line option instead of **/n**. If you use **/n**, you must also use **/t**. These two options together provide an alternative method of specifying the size of the disk that is being formatted. This option is not valid with the **/f** option.                                                         |
|  /p:\<Passes>  |                                                                                                                                                               Zeros every sector on the volume for the number of passes specified. This option is not valid with the **/q** option.                                                                                                                                                                |
|       /c       |                                                                                                                                                                                     NTFS only. Files created on the new volume will be compressed by default.                                                                                                                                                                                      |
|       /x       |                                                                                                                                                            Causes the volume to dismount, if necessary, before it is formatted. Any open handles to the volume will no longer be valid.                                                                                                                                                            |
|       /?       |                                                                                                                                                                                                        Displays help at the command prompt.                                                                                                                                                                                                        |

## Remarks

-   Administrative credentials

    You must be a member of the Administrators group to format a hard drive.
-   Using **format**

    The **format** command creates a new root directory and file system for the disk. It can also check for bad areas on the disk, and it can delete all data on the disk. To be able to use a new disk, you must first use this command to format the disk.
-   Adding a volume label

    After formatting a floppy disk, **format** displays the following message:

    `Volume label (11 characters, ENTER for none)?`

    To add a volume label, type up to 11 characters (including spaces). If you do not want to add a volume label to the disk, press ENTER.
-   Formatting a hard disk

> [!NOTE]
> You must be a member of the Administrators group to format a hard disk.

When you use the **format** command to format a hard disk, a warning message similar to the following displays:
```
WARNING, ALL DATA ON NON-REMOVABLE DISK 
DRIVE x: WILL BE LOST! 
Proceed with Format (Y/N)? _ 
```
To format the hard disk, press Y; if you do not want to format the disk, press N.
-   Unit size

    FAT file systems restrict the number of clusters to no more than 65526. FAT32 file systems restrict the number of clusters to between 65527 and 4177917.

    NTFS compression is not supported for allocation unit sizes above 4096.

> [!NOTE]
> **Format** will immediately stop processing if it determines that the previous requirements cannot be met using the specified cluster size.
> -   **Format** messages

    When formatting is complete, **format** displays messages that show the total disk space, the spaces marked as defective, and the space available for your files.
- Quick formatting

  You can speed up the formatting process by using the **/q** command-line option. Use this option only if there are no bad sectors on your hard disk.
- Using **format** with a reassigned drive or a network drive

  You should not use the **format** command on a drive that was prepared by using the **subst** command. You cannot format disks over a network.
- **Format** exit codes

  The following table lists each exit code and a brief description of its meaning.  

  |Exit code|Description|
  |---------|-----------|
  |0|The format operation was successful.|
  |1|Incorrect parameters were supplied.|
  |4|A fatal error occurred (which is any error other than 0, 1, or 5).|
  |5|The user pressed N in response to the prompt "Proceed with Format (Y/N)?" to stop the process.|

  You can check these exit codes by using the ERRORLEVEL environment variable with the **if** batch command.
- Using **format** at the Recovery Console

  The **format** command, with different parameters, is available from the Recovery Console.

## <a name="BKMK_examples"></a>Examples

To format a new floppy disk in drive A using the default size, type:
```
format a:
```
To perform a quick format operation on a previously formatted floppy disk in drive A, type:
```
format a: /q
```
To format a floppy disk in drive A and assign it the volume label "DATA," type:
```
format a: /v:DATA
```

#### Additional references

[Command-Line Syntax Key](https://technet.microsoft.com/library/cc771080.aspx)