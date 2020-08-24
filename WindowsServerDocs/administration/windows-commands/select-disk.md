---
title: select disk
description: Reference article for **** -




ms.topic: article
ms.assetid: a0da614b-09d9-433b-b4eb-9127f84431cb
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# select disk

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

selects the specified disk and shifts the focus to it.



## Syntax

```
select disk={ <n> | <disk path> | system | next }
```

> [!NOTE]
> The **<disk path>**, **system**, and **next** parameters are only available in Windows 7 and Windows Server 2008 R2.

### Parameters

|  Parameter  |                                                                                                                                                                                                            Description                                                                                                                                                                                                            |
|-------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|     <n>     | Specifies the number of the disk to receive focus. You can view the numbers for all the disks on the computer by using the **list disk** command in DiskPart. **Note:** When configuring systems with multiple disks, do not use **select disk\=0** to specify the system disk. The computer may reassign disk numbers when you reboot, and different computers with the same disk configuration can have different disk numbers. |
| <disk path> |                                                                                                                 Specifies the location of the disk to receive focus, for example, **PCIROOT\(0\)\#PCI\(0F02\)\#atA\(C00T00L00\)**. To view the location path of a disk, select it and then type **detail disk**.                                                                                                                  |
|   system    |                                 On BIOS computers, specifies that disk 0 receives focus. On EFI computers, the disk containing the EFI system partition \(ESP\) that is used for the current boot  receives focus. On EFI computers, the command will fail if there is no ESP, if there is more than one ESP, or the computer is booted from Windows Preinstallation Environment \(Windows PE\).                                  |
|    next     |                                                                                                                                     Once a disk is selected, this command iterates over all disks in the disk list. When you run this command, the next disk in the list will receive focus.                                                                                                                                      |

## Examples
To shift the focus to disk 1, type:

```
select disk=1
```

To select a disk by using its location path, type:

```
select disk=PCIROOT(0)#PCI(0100)#atA(C00T00L01)
```

To shift the focus to the system disk, type:

```
select disk=system
```

To shift the focus to the next disk on the computer, type:

```
select disk=next
```

## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)




