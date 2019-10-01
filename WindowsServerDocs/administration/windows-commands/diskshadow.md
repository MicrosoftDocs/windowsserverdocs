---
title: diskshadow
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e962537d-b759-4368-b6f1-e8391cf7b221
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# diskshadow

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

diskshadow.exe is a tool that exposes the functionality offered by the volume shadow copy Service \(VSS\). By default, diskshadow uses an interactive command interpreter similar to that of diskraid or DiskPart. diskshadow also includes a scriptable mode.  
  
> [!NOTE]  
> Membership in the local Administrators group, or equivalent, is the minimum required to run diskshadow.  
  
for examples of how to use diskshadow commands, see [Examples](#BKMK_examples).  
  
## Syntax  
for interactive mode, type the following at the command prompt to start the diskshadow command interpreter:  
  
```  
diskshadow  
```  
  
for script mode, type the following, where *script.txt* is a script file containing diskshadow commands:  
  
```  
diskshadow -s script.txt  
```  
  
## diskshadow commands  
You can run the following commands in the diskshadow command interpreter or through a script file:  
  
|Parameter|Description|  
|-------|--------|  
|[set_2](set_2.md)|Sets the context, options, verbose mode, and metadata file for creating shadow copies.|  
|[Simulate restore](simulate-restore.md)|Tests writer involvement in restore sessions on the computer without issuing **PreRestore** or **PostRestore** events to writers.|  
|[Load metadata](load-metadata.md)|Loads a metadata .cab file prior to importing a transportable shadow copy or loads the writer metadata in the case of a restore.|  
|[writer](writer.md)|verifies that a writer or component is included or excludes a writer or component from the backup or restore procedure.|  
|[add_1](add_1.md)|adds volumes to the set of volumes that are to be shadow copied, or adds aliases to the alias environment.|  
|[create_1](create_1.md)|starts the shadow copy creation process, using the current context and option settings.|  
|[exec](exec.md)|executes a file on the local computer.|  
|[Begin backup](begin-backup.md)|starts a full backup session.|  
|[End backup](end-backup.md)|Ends a full backup session and issues a **Backupcomplete** event with the appropriate writer state, if needed.|  
|[Begin restore](begin-restore.md)|starts a restore session and issues a **PreRestore** event to involved writers.|  
|[End restore](end-restore.md)|Ends a restore session and issues a **PostRestore** event to involved writers.|  
|[reset](reset.md)|resets diskshadow to the default state.|  
|[list](list.md)|lists writers, shadow copies, or currently registered shadow copy providers that are on the system.|  
|[delete shadows](delete-shadows.md)|deletes shadow copies.|  
|[import](import.md)|imports a transportable shadow copy from a loaded metadata file into the system.|  
|[mask](mask.md)|removes hardware shadow copies that were imported by using the **import** command.|  
|[expose](expose.md)|exposes a persistent shadow copy as a drive letter, share, or mount point.|  
|[unexpose](unexpose.md)|unexposes a shadow copy that was exposed by using the **expose** command.|  
|[break_2](break_2.md)|Disassociates a shadow copy volume from VSS.|  
|[revert](revert.md)|reverts a volume back to a specified shadow copy.|  
|[exit_1](exit_1.md)|exits diskshadow.|  
  
## Remarks  
  
-   at a minimum, only **add** and **create** are necessary to create a shadow copy. However, this will forfeit the context and option settings, will be a copy backup, and will only create a shadow copy with no backup execution script.  
  
## <a name="BKMK_examples"></a>Examples  
This is a sample sequence of commands that will create a shadow copy for backup. It can be saved to file as script.dsh, and executed with diskshadow \/s script.dsh  
  
Assume the following:  
  
-   You have an existing directory called c:\\diskshadowdata.  
  
-   Your system volume is C: and your data volume is D:.  
  
-   You have a backupscript.cmd file in c:\\diskshadowdata.  
  
-   Your backupscript.cmd file will perform the copy of shadow data p: and q: to your backup drive.  
  
You can enter these commands manually or script them:  
  
```  
#diskshadow script file  
set context persistent nowriters  
set metadata c:\diskshadowdata\example.cab  
set verbose on  
begin backup  
add volume c: alias Systemvolumeshadow  
add volume d: alias Datavolumeshadow  
  
create  
  
expose %Systemvolumeshadow% p:  
expose %Datavolumeshadow% q:  
exec c:\diskshadowdata\backupscript.cmd  
end backup  
#End of script  
```  
  
#### additional references  
[Command-Line Syntax Key](command-line-syntax-key.md)  
  

