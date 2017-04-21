---
title: Format
ms.prod: windows-server-threshold
manager: dongill
ms.author: JGerend
ms.technology: storage
ms.topic: article
ms.assetid: 51ec7423-9a01-4219-868a-25d69cdcc832
author: JasonGerend
ms.date: 09/15/2016
---
# Format
> Applies To: Windows 10, Windows Server 2016

Formats a volume so that you can use it to store files. 

The **format** command creates a new root directory and file system for the drive. It can also check for bad areas on the disk, and it can delete all data on the drive.

For examples of how to use this command, see [Examples](#BKMK_examples). To format a volume in a Windows PowerShell session, instead use the newer Format-Volume cmdlet.

> [!NOTE]
> You must be a member of the Administrators group to format a drive.

## Syntax

```powershell
format <Volume> [/fs:{FAT|FAT32|NTFS}] [/v:<Label>] [/q] [/a:<UnitSize>] [/c] [/x] [/s] [/i] [/dax] [/p:<Passes>]
format <Volume> [/v:<Label>] [/q] [/f:<Size>] [/p:<Passes>]
format <Volume> [/v:<Label>] [/q] [/t:<Tracks> /n:<Sectors>] [/p:<Passes>]
format <Volume> [/v:<Label>] [/q] [/p:<Passes>]
format <Volume> [/q]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|&lt;Volume>|Specifies the mount point, volume name, or drive letter \(followed by a colon\) of the drive that you want to format. If you do not specify any of the following command\-line options, **format** uses the volume type to determine the default format for the disk.|
|/fs:{FAT&#124;FAT32&#124;exFAT&#124;NTFS&#124;ReFS&#124;UDF}|Specifies the type of the file system: FAT, FAT32, exFAT, NTFS, ReFS, or UDF. Floppy disks can use only the FAT file system.|
|/v:<Label>|Specifies the volume label. If you omit the **/v** command\-line option or use it without specifying a volume label, **format** prompts you for the volume label after the formatting is complete. Use the syntax **/v:** to prevent the prompt for a volume label. If you use a single **format** command to format more than one disk, all of the disks will be given the same volume label.|
|/a:<UnitSize>|Specifies the allocation unit size to use on FAT, FAT32, exFAT, or NTFS volumes (ReFS uses 64 KB sector sizes). If you do not specify *UnitSize*, it is chosen based on volume size. Default settings are strongly recommended for general use. The following list presents valid values for NTFS, FAT, and FAT32 *UnitSize*:<br /><br />512<br /><br />1024<br /><br />2048<br /><br />4096<br /><br />8192<br /><br />16K<br /><br />32K<br /><br />64K<br /><br />FAT and FAT32 also support 128K and 256K for a sector size greater than 512 bytes. <br>exFAT also supports 128K, 256K, 512K, 1MB, 2MB, 4MB, 8MB, 16MB, and 32MB sector sizes.<br> <br> NTFS compression is not supported for allocation unit sizes above 4096. <br> <br>Note that the FAT and FAT32 files systems impose the following restrictions on the number of clusters on a volume:<br> <br>FAT: Number of clusters <= 65526 <br>FAT32: 65526 < Number of clusters < 4177918 <br> <br>Format will immediately stop processing if it decides that the above requirements cannot be met using the specified cluster size. |
|/q|Performs a quick format. Deletes the file table and the root directory of a previously formatted volume, but does not perform a sector\-by\-sector scan for bad areas. You should use the **/q** command\-line option to format only previously formatted volumes that you know are in good condition. Note that **/q** overrides **/p**.|
|/f:<Size>|Specifies the size of the floppy disk to format. When possible, use this command\-line option instead of the **/t** and **/n** command\-line options. Windows accepts the following values for size:<br /><br />-   1440 or 1440k or 1440kb<br />-   1.44 or 1.44m or 1.44mb<br />-   1.44\-MB, double\-sided, quadruple\-density, 3.5\-inch disk|
|/t:<Tracks>|Specifies the number of tracks on the disk. When possible, use the **/f** command\-line option instead. If you use the **/t** option, you must also use the **/n** option. These options together provide an alternative method of specifying the size of the disk that is being formatted. This option is not valid with the **/f** option.|
|/n:<Sectors>|Specifies the number of sectors per track. When possible, use the **/f** command\-line option instead of **/n**. If you use **/n**, you must also use **/t**. These two options together provide an alternative method of specifying the size of the disk that is being formatted. This option is not valid with the **/f** option.|
|/p:<Passes>|Zeros every sector on the volume for the number of passes specified. This option is not valid with the **/q** option.|
|/c|NTFS only. Files created on the new volume will be compressed by default.|
|/s:| Specifies whether short filenames should be created for compatibility with apps that require short filenames. Use **/s:enable** to enable the creation of short filenames, or **/s:disable** to disable the short filenames. The default is disabled.|
|/i:|ReFS only. Specifies whether integrity short be enabled on the new volume. Use **/i:enable** to enable integrity streams, or **/i:disable** to disable them. Integrity is enabled by default on storage that support data redundancy, such as a mirrored storage space.|
|/x|Causes the volume to dismount, if necessary, before it is formatted. Any open handles to the volume will no longer be valid.|
|/dax|NTFS only with Windows Server 2016 and later. Attempts to format the volume as a DirectAccess (DAX) volume, which allows the use of memory mapping semantics to achieve byte-addressability on Storage Class Memory (SCM) devices, such as NVDIMM-N.|
|/?|Displays help at the command prompt.|

## Remarks

- Quick formatting

    You can speed up the formatting process by using the **/q** command\-line option. Use this option only if there are no bad sectors on your hard disk.

- Using **format** with a reassigned drive or a network drive

    You should not use the **format** command on a drive that was prepared by using the **subst** command. You cannot format disks over a network.

- Using **format** at the Recovery Console

    The **format** command, with different parameters, is available from the Recovery Console.

- **Format** exit codes

    The following table lists each exit code and a brief description of its meaning.

|Exit code|Description|
|-------------|---------------|
|0|The format operation was successful.|
|1|Incorrect parameters were supplied.|
|4|A fatal error occurred \(which is any error other than 0, 1, or 5\).|
|5|The user pressed N in response to the prompt "Proceed with Format \(Y/N\)?" to stop the process.|

You can check these exit codes by using the ERRORLEVEL environment variable with the **if** batch command.


## <a name="BKMK_examples"></a>Examples
To format a new floppy disk in drive A using the default size, type:

```powershell
format a:
```

To perform a quick format operation on a previously formatted floppy disk in drive A, type:

```powershell
format a: /q
```

To format a floppy disk in drive A and assign it the volume label "DATA," type:

```powershell
format a: /v:DATA
```

To perform a quick format of a storage-class memory device as drive F:\ with the NTFS file system and DirectAccess enabled, type

```powershell
format f: /q /dax
```


## Additional references

[Command-Line Syntax Key](http://technet.microsoft.com/library/cc771080.aspx)
