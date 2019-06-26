---
title: cleanmgr
description: Learn how to use command-line options to configure the Disk Cleanup tool (Cleanmgr.exe) to automatically clean up certain files.
ms.prod: windows-server-threshold
ms.reviewer: cosmosdarwin
author: iangpgh
ms.author: jgerend
manager: daveba
ms.technology: storage-spaces
ms.date: 06/20/2019
---
# cleanmgr

> Applies to: Windows Server 2019, Windows Server 2016, Windows Server 2012, Windows Server 2008 R2, Windows Server (Semi-Annual Channel)

Clears unnecessary files from your computer's hard disk. You can use command-line options to specify that Cleanmgr cleans up Temp files, Internet files, downloaded files, and recycle bin files. You can then schedule the task to run at a specific time by using the Scheduled Tasks tool.

For examples of how to use this command, see [Examples](#examples).

## Syntax

```
cleanmgr [/d <driveletter>] [/sageset:n]  [/sagerun:n] [/TUNEUP:n] [/LOWDISK] [/VERYLOWDISK]
```

## Parameters

|      Parameter      |    Description     |
| ------------------- | ------------------ |
|  /d \<driveletter>          | Specifies the drive that you want Disk Cleanup to clean.<br>**Note:** The /d option is not utilized with /sagerun:n. |
| /sageset:n | Displays the Disk Cleanup Settings dialog box and also creates a registry key to store the settings that you select. The `n` value, which is stored in the registry, allows you to specify tasks for Disk Cleanup to run. The `n` value can be any integer value from 0 to 65535. To have all of the options available when you use the /sageset option, specify the drive where Windows is installed.  |
|  /sagerun:n  |  Runs the specified tasks that are assigned to the n value if you use the \sageset option. All drives on the computer are enumerated and the selected profile runs against each drive.           |
| /TUNEUP:n    | Run /sageset and /sagerun for the same `n` . |
| /LOWDISK     | Run with the default settings. |
| /VERYLOWDISK | Run with the default settings, no user prompts. |
| /?           | Display help. |

## Options

The options for the files that you can specify for Disk Cleanup by using /sageset and /sagerun include:

- **Temporary Setup Files** - These are files that were created by a Setup program that is no longer running.

- **Downloaded Program Files** - Downloaded program files are ActiveX controls and Java programs that are downloaded automatically from the Internet when you view certain pages. These files are temporarily stored in the Downloaded Program Files folder on the hard disk. This option includes a View Files button so that you can see the files before Disk Cleanup removes them. The button opens the C:\Winnt\Downloaded Program Files folder.

- **Temporary Internet Files** - The Temporary Internet Files folder contains Web pages that are stored on your hard disk for quick viewing. Disk Cleanup removes these page but leaves your personalized settings for Web pages intact. This option also includes a View Files button, which opens the C:\Documents and Settings\Username\Local Settings\Temporary Internet Files\Content.IE5 folder. 

- **Old Chkdsk Files** - When Chkdsk checks a disk for errors, Chkdsk might save lost file fragments as files in the root folder on the disk. These files are unnecessary.

- **Recycle Bin** - The Recycle Bin contains files that you have deleted from the computer. These files are not permanently removed until you empty the Recycle Bin. This option includes a View Files button that opens the Recycle Bin. **Note:** A Recycle Bin may appear in more than one drive, for example, not just in %SystemRoot%.

- **Temporary Files** - Programs sometimes store temporary information in a Temp folder. Before a program quits, the program usually deletes this information. You can safely delete temporary files that have not been modified within the last week.

- **Temporary Offline Files** - Temporary offline files are local copies of recently used network files. These files are automatically cached so that you can use them after you disconnect from the network. A View Files button opens the Offline Files folder.

- **Offline Files** - Offline files are local copies of network files that you specifically want to have available offline so that you can use them after you disconnect from the network. A View Files button opens the Offline Files folder.

- **Compress Old Files** - Windows can compress files that you have not used recently. Compressing files saves disk space, but you can still use the files. No files are deleted. Because files are compressed at different rates, the displayed amount of disk space that you will gain is approximate. An Options button permits you to specify the number of days to wait before Disk Cleanup compresses an unused file.

- **Catalog Files for the Content Indexer** - The Indexing service speeds up and improves file searches by maintaining an index of the files that are on the disk. These Catalog files remain from a previous indexing operation and can be deleted safely. **Note:** Catalog File may appear in more than one drive, for example, not just in %SystemRoot%.

**Note** If you specify cleaning up the drive that contains the Windows installation, all of these options are available on the Disk Cleanup tab. If you specify any other drive, only the Recycle Bin and the Catalog files for content index options are available on the Disk Cleanup tab. 

## Examples

To run the Disk Cleanup app so that you can use its dialog box to specify options for use later, saving the settings to the set **1**, type the following:

```
cleanmgr /sageset:1
```

To run Disk Cleanup and include the options that you specified with the cleanmgr /sageset:1 command, type:

```
cleanmgr /sagerun:1
```

To run ```cleanmgr /sageset:1``` and ```cleanmgr /sagerun:1``` together, type:

```
cleanmgr /tuneup:1
```

## Additional references

[Free up drive space in Windows 10](https://support.microsoft.com/en-us/help/12425/windows-10-free-up-drive-space)
