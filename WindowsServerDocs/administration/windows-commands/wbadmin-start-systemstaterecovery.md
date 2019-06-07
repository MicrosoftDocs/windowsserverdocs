---
title: wbadmin start systemstaterecovery
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 208b1be9-3452-4aba-bb49-46bc587fca96
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# wbadmin start systemstaterecovery



Performs a system state recovery to a location and from a backup that you specify.

> [!NOTE]
> Windows Server Backup does not back up or recover registry user hives (HKEY_CURRENT_USER) as part of system state backup or system state recovery.

To perform a system state recovery with this subcommand, you must be a member of the **Backup Operators** group or the **Administrators** group, or you must have been delegated the appropriate permissions. In addition, you must run **wbadmin** from an elevated command prompt. (To open an elevated command prompt right-click **Command Prompt**, and then click **Run as administrator**.)

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

Syntax for Windows Server 2008:
```
wbadmin start systemstaterecovery
-version:<VersionIdentifier>
-showsummary
[-backupTarget:{<BackupDestinationVolume> | <NetworkSharePath>}]
[-machine:<BackupMachineName>]
[-recoveryTarget:<TargetPathForRecovery>]
[-authsysvol]
[-quiet]
```
Syntax for Windows Server 2008 R2 or later:
```
wbadmin start systemstaterecovery
-version:<VersionIdentifier>
-showsummary
[-backupTarget:{<BackupDestinationVolume> | <NetworkSharePath>}]
[-machine:<BackupMachineName>]
[-recoveryTarget:<TargetPathForRecovery>]
[-authsysvol]
[-autoReboot]
[-quiet]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|-version|Specifies the version identifier for the backup to recover in MM/DD/YYYY-HH:MM format. If you do not know the version identifier, type **wbadmin get versions**.|
|-showsummary|Reports the summary of the last system state recovery (after the restart required to complete the operation). This parameter cannot be accompanied by any other parameters.|
|-backupTarget|Specifies the storage location that contains the backup or backups you want to recover. This parameter is useful when the storage location is different from where the backups of this computer are usually stored.|
|-machine|Specifies the name of the computer that you want to recover. This parameter is useful when multiple computers have been backed up to the same location. Should be used when the **-backupTarget** parameter is specified.|
|-recoveryTarget|Specifies the directory to restore to. This parameter is useful if the backup is restored to an alternate location.|
|-authsysvol|If used, performs an authoritative restore of SYSVOL (the System Volume shared directory).|
|-autoReboot|Specifies to restart the system at the end of the system state recovery operation. This parameter is valid only for a recovery to the original location. We do not recommend you use this parameter if you need to perform steps after the recovery operation.|
|-quiet|Runs the subcommand with no prompts to the user.|

## <a name="BKMK_examples"></a>Examples

- To perform a system state recovery of the backup from 03/31/2013 at 9:00 A.M., type:  
  ```
  wbadmin start systemstaterecovery -version:03/31/2013-09:00
  ```  
- To perform a system state recovery of the backup from 04/30/2013 at 9:00 A.M. that is stored on the shared resource \\\\servername\share for server01, type:  
  ```
  wbadmin start systemstaterecovery -version:04/30/2013-09:00 -backupTarget:\\servername\share -machine:server01
  ```

#### Additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)
-   [Wbadmin](wbadmin.md)
-   [Start-WBSystemStateRecovery](https://technet.microsoft.com/library/jj902449.aspx) cmdlet