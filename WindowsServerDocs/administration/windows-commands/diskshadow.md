---
title: Diskshadow
description: Reference article for the Diskshadow command, which is a tool that exposes the functionality offered by the volume shadow copy service (VSS).
ms.topic: reference
ms.assetid: e962537d-b759-4368-b6f1-e8391cf7b221
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# Diskshadow

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Diskshadow.exe is a tool that exposes the functionality offered by the volume shadow copy Service (VSS). By default, Diskshadow uses an interactive command interpreter similar to that of Diskraid or Diskpart. Diskshadow also includes a scriptable mode.

> [!NOTE]
> Membership in the local Administrators group, or equivalent, is the minimum required to run Diskshadow.

## Syntax

For interactive mode, type the following at the command prompt to start the Diskshadow command interpreter:

```
diskshadow
```

For script mode, type the following, where *script.txt* is a script file containing Diskshadow commands:

```
diskshadow -s script.txt
```

### Parameters

You can run the following commands in the Diskshadow command interpreter or through a script file. At a minimum, only **add** and **create** are necessary to create a shadow copy. However, this forfeits the context and option settings, will be a copy backup, and creates a shadow copy with no backup execution script.

| Command | Description |
| --------- | ----------- |
| [set command](./set.md) | Sets the context, options, verbose mode, and metadata file for creating shadow copies. |
| [load metadata command](load-metadata.md) | Loads a metadata .cab file prior to importing a transportable shadow copy or loads the writer metadata in the case of a restore. |
| [writer command](writer.md) | verifies that a writer or component is included or excludes a writer or component from the backup or restore procedure. |
| [add command](add.md) | Adds volumes to the set of volumes that are to be shadow copied, or adds aliases to the alias environment. |
| [create command](create.md) | Starts the shadow copy creation process, using the current context and option settings. |
| [exec command](exec.md) | Executes a file on the local computer. |
| [begin backup command](begin-backup.md) | Starts a full backup session. |
| [end backup command](end-backup.md) | Ends a full backup session and issues a **backupcomplete** event with the appropriate writer state, if needed. |
| [begin restore command](begin-restore.md) | Starts a restore session and issues a **prerestore** event to involved writers. |
| [end restore command](end-restore.md) | Ends a restore session and issues a **postrestore** event to involved writers. |
| [reset command](reset.md) | Resets Diskshadow to the default state. |
| [list command](list.md) | Lists writers, shadow copies, or currently registered shadow copy providers that are on the system. |
| [delete shadows command](delete-shadows.md) | Deletes shadow copies. |
| [import command](import.md) | Imports a transportable shadow copy from a loaded metadata file into the system. |
| [mask command](mask.md) | Removes hardware shadow copies that were imported by using the **import** command. |
| [expose command](expose.md) | Exposes a persistent shadow copy as a drive letter, share, or mount point. |
| [unexpose command](unexpose.md) | Unexposes a shadow copy that was exposed by using the **expose** command. |
| [break command](break_2.md) | Disassociates a shadow copy volume from VSS. |
| [revert command](revert.md) | Reverts a volume back to a specified shadow copy. |
| [exit command](exit.md) | Exits the command interpreter or script. |

## Examples

This is a sample sequence of commands that will create a shadow copy for backup. It can be saved to file as script.dsh, and executed using `diskshadow /s script.dsh`.

Assume the following:

- You have an existing directory called c:\\diskshadowdata.

- Your system volume is C: and your data volume is D:.

- You have a backupscript.cmd file in c:\\diskshadowdata.

- Your backupscript.cmd file will perform the copy of shadow data p: and q: to your backup drive.

You can enter these commands manually or script them:

```
#Diskshadow script file
set context persistent nowriters
set metadata c:\diskshadowdata\example.cab
set verbose on
begin backup
add volume c: alias systemvolumeshadow
add volume d: alias datavolumeshadow

create

expose %systemvolumeshadow% p:
expose %datavolumeshadow% q:
exec c:\diskshadowdata\backupscript.cmd
end backup
#End of script
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
