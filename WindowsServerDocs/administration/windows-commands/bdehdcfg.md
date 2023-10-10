---
title: bdehdcfg
description: Reference article for the bdehdcfg command, which prepares a hard drive with the partitions necessary for BitLocker Drive Encryption.
ms.topic: reference
ms.assetid: 4c92cd74-188e-4fec-b7c4-fe4e8903e032
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bdehdcfg

Prepares a hard drive with the partitions necessary for BitLocker Drive Encryption. Most installations of Windows 7 will not need to use this tool because BitLocker setup includes the ability to prepare and repartition drives as required.

> [!WARNING]
> There is a known conflict with the **Deny write access to fixed drives not protected by BitLocker** Group Policy setting located in **Computer Configuration\Administrative Templates\Windows Components\BitLocker Drive Encryption\Fixed Data Drives**.
>
>If bdehdcfg is run on a computer when this policy setting is enabled, you may encounter the following issues:
>
>- If you attempted to shrink the drive and create the system drive, the drive size will be successfully reduced and a raw partition will be created. However, the raw partition will not be formatted. The following error message is displayed: The new active Drive cannot be formatted. You may need to manually prepare your drive for BitLocker.
>
>- If you attempted to use unallocated space to create the system drive, a raw partition will be created. However, the raw partition will not be formatted. The following error message is displayed: The new active Drive cannot be formatted. You may need to manually prepare your drive for BitLocker.
>
>- If you attempted to merge an existing drive into the system drive, the tool will fail to copy the required boot file onto the target drive to create the system drive. The following error message is displayed: BitLocker setup failed to copy boot files. You may need to manually prepare your drive for BitLocker.
>
>- If this policy setting is being enforced, a hard drive cannot be repartitioned because the drive is protected. If you are upgrading computers in your organization from a previous version of Windows and those computers were configured with a single partition, you should create the required BitLocker system partition before applying the policy setting to the computers.

## Syntax

```
bdehdcfg [–driveinfo <drive_letter>] [-target {default|unallocated|<drive_letter> shrink|<drive_letter> merge}] [–newdriveletter] [–size <size_in_mb>] [-quiet]
```

#### Parameters

| Parameter | Description |
| --------- |----------- |
| [bdehdcfg: driveinfo](bdehdcfg-driveinfo.md) | Displays the drive letter, the total size, the maximum free space, and the partition characteristics of the partitions on the drive specified. Only valid partitions are listed. Unallocated space is not listed if four primary or extended partitions already exist. |
| [bdehdcfg: target](bdehdcfg-target.md) | Defines which portion of a drive to use as the system drive and makes the portion active. |
| [bdehdcfg: newdriveletter](bdehdcfg-newdriveletter.md) | Assigns a new drive letter to the portion of a drive used as the system drive. |
| [bdehdcfg: size](bdehdcfg-size.md) | Determines the size of the system partition when a new system drive is being created. |
| [bdehdcfg: quiet](bdehdcfg-quiet.md) | Prevents the display of all actions and errors in the command-line interface and directs bdehdcfg to use the Yes answer to any Yes/No prompts that may occur during subsequent drive preparation. |
| [bdehdcfg: restart](bdehdcfg-restart.md) | Directs the computer to restart after the drive preparation has finished. |
| /? | Displays Help at the command prompt. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
