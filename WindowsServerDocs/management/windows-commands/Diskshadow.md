---
title: Diskshadow
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e962537d-b759-4368-b6f1-e8391cf7b221 JasonGerend
---
# Diskshadow
DiskShadow.exe is a tool that exposes the functionality offered by the Volume Shadow Copy Service \(VSS\). By default, DiskShadow uses an interactive command interpreter similar to that of DiskRAID or DiskPart. DiskShadow also includes a scriptable mode.  
  
> [!NOTE]  
> Membership in the local Administrators group, or equivalent, is the minimum required to run DiskShadow.  
  
For examples of how to use DiskShadow commands, see [Examples](#BKMK_examples).  
  
## Syntax  
For interactive mode, type the following at the command prompt to start the DiskShadow command interpreter:  
  
```  
diskshadow  
```  
  
For script mode, type the following, where *script.txt* is a script file containing DiskShadow commands:  
  
```  
diskshadow -s script.txt  
```  
  
## DiskShadow commands  
You can run the following commands in the DiskShadow command interpreter or through a script file:  
  
|Parameter|Description|  
|-------------|---------------|  
|[Set_2](Set_2.md)|Sets the context, options, verbose mode, and metadata file for creating shadow copies.|  
|[Simulate restore](Simulate-restore.md)|Tests writer involvement in restore sessions on the computer without issuing **PreRestore** or **PostRestore** events to writers.|  
|[Load metadata](Load-metadata.md)|Loads a metadata .cab file prior to importing a transportable shadow copy or loads the writer metadata in the case of a restore.|  
|[Writer](Writer.md)|Verifies that a writer or component is included or excludes a writer or component from the backup or restore procedure.|  
|[Add_1](Add_1.md)|Adds volumes to the set of volumes that are to be shadow copied, or adds aliases to the alias environment.|  
|[Create_1](Create_1.md)|Starts the shadow copy creation process, using the current context and option settings.|  
|[Exec](Exec.md)|Executes a file on the local computer.|  
|[Begin backup](Begin-backup.md)|Starts a full backup session.|  
|[End backup](End-backup.md)|Ends a full backup session and issues a **BackupComplete** event with the appropriate writer state, if needed.|  
|[Begin restore](Begin-restore.md)|Starts a restore session and issues a **PreRestore** event to involved writers.|  
|[End restore](End-restore.md)|Ends a restore session and issues a **PostRestore** event to involved writers.|  
|[Reset](Reset.md)|Resets DiskShadow to the default state.|  
|[List](List.md)|Lists writers, shadow copies, or currently registered shadow copy providers that are on the system.|  
|[Delete shadows](Delete-shadows.md)|Deletes shadow copies.|  
|[Import](Import.md)|Imports a transportable shadow copy from a loaded metadata file into the system.|  
|[Mask](Mask.md)|Removes hardware shadow copies that were imported by using the **import** command.|  
|[Expose](Expose.md)|Exposes a persistent shadow copy as a drive letter, share, or mount point.|  
|[Unexpose](UnExpose.md)|Unexposes a shadow copy that was exposed by using the **expose** command.|  
|[Break_2](Break_2.md)|Disassociates a shadow copy volume from VSS.|  
|[Revert](Revert.md)|Reverts a volume back to a specified shadow copy.|  
|[Exit_1](Exit_1.md)|Exits DiskShadow.|  
  
## Remarks  
  
-   At a minimum, only **add** and **create** are necessary to create a shadow copy. However, this will forfeit the context and option settings, will be a copy backup, and will only create a shadow copy with no backup execution script.  
  
## <a name="BKMK_examples"></a>Examples  
This is a sample sequence of commands that will create a shadow copy for backup. It can be saved to file as script.dsh, and executed with DISKSHADOW \/s script.dsh  
  
Assume the following:  
  
-   You have an existing directory called c:\\diskshadowdata.  
  
-   Your system volume is C: and your data volume is D:.  
  
-   You have a backupscript.cmd file in c:\\diskshadowdata.  
  
-   Your backupscript.cmd file will perform the copy of shadow data p: and q: to your backup drive.  
  
You can enter these commands manually or script them:  
  
```  
#DiskShadow script file  
set context persistent nowriters  
set metadata c:\diskshadowdata\example.cab  
set verbose on  
begin backup  
add volume c: alias SystemVolumeShadow  
add volume d: alias DataVolumeShadow  
  
create  
  
expose %SystemVolumeShadow% p:  
expose %DataVolumeShadow% q:  
exec c:\diskshadowdata\backupscript.cmd  
end backup  
#End of script  
```  
  
#### Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  

