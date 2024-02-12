---
title: mqbkup
description: Reference article for the mqbkup command, which backs up MSMQ message files and registry settings to a storage device and restores previously-stored messages and settings.
ms.topic: reference
ms.assetid: 7bdd41c4-75ef-455f-b241-1d64a4c7acf5
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# mqbkup

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Backs up MSMQ message files and registry settings to a storage device and restores previously-stored messages and settings.

Both the backup and the restore operations stop the local MSMQ service. If the MSMQ service was started beforehand, the utility will attempt to restart the MSMQ service at the end of the backup or the restore operation. If the service was already stopped before running the utility, no attempt to restart the service is made.

Before using the MSMQ Message Backup/Restore utility you must close all local applications that are using MSMQ.

## Syntax

```
mqbkup {/b | /r} <folder path_to_storage_device>
```

### Parameters

| Parameter | Description |
| ------- | -------- |
| /b | Specifies backup operation. |
| /r | Specifies restore operation. |
| `<folder path_to_storage_device>` | Specifies the path where the MSMQ message files and registry settings are stored. |
| /? | Displays help at the command prompt. |

#### Remarks

- If a specified folder doesn't exist while performing either the backup or restore operation, the folder is automatically created by the utility.

- If you choose to specify an existing folder, it must be empty. If you specify a non-empty folder, the utility deletes every file and subfolder contained within it. In this case, you'll be prompted to give permission to delete existing files and subfolders. You can use the **/y** parameter to indicate that you agree beforehand to the deletion of all existing files and subfolders in the specified folder.

- The locations of folders used to store MSMQ message files are stored in the registry. Therefore, the utility restores MSMQ message files to the folders specified in the registry and not to the storage folders used before the restore operation.

### Examples

To backup all MSMQ message files and registry settings, and to store them in the *msmqbkup* folder on your C: drive, type:

```
mqbkup /b c:\msmqbkup
```

To delete all existing files and subfolders in the *oldbkup* folder on your C: drive, and then to store MSMQ message files and registry settings in the folder, type:

```
mqbkup /b /y c:\oldbkup
```

To restore MSMQ messages and registry settings, type:

```
mqbkup /r c:\msmqbkup
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [MSMQ Powershell Reference](/powershell/module/msmq/)
