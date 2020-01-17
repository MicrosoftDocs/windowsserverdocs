---
title: Set id
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5793d7ad-827e-4285-b2c6-ae60eeb0e886
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Set id

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The Diskpart Set ID command changes the partition type field for the partition with focus.  
  
> [!IMPORTANT]  
> This command is intended for use by original equipment manufacturers \(OEMs\) only. Changing partition type fields with this parameter might cause your computer to fail or be unable to boot. Unless you are an OEM or experienced with gpt disks, you should not change partition type fields on gpt disks by using this parameter. Instead, always use the [create partition efi](create-partition-efi.md) command to create EFI system partitions, the [create partition msr](create-partition-msr.md) command to create Microsoft Reserved partitions, and the [create partition primary](create-partition-primary.md) command without the ID parameter to create primary partitions on gpt disks.  
  
  
  
## Syntax  
  
```  
set id={ <byte> | <GUID> } [override] [noerr]  
```  
  
## Parameters  
  
| Parameter |                                                                                                                                                                                                                                                                                                                                                                   Description                                                                                                                                                                                                                                                                                                                                                                   |
|-----------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|  <byte>   |                                                                                                                                                                                                       for master boot record \(MBR\) disks, specifies the new value for the type field, in hexadecimal form, for the partition. Any partition type byte can be specified with this parameter except for type 0x42, which specifies an LDM partition. Note that the leading  0x is omitted when specifying the hexadecimal partition type.                                                                                                                                                                                                       |
|  <GUID>   | for GUID partition table \(gpt\) disks, specifies the new GUID value for the type field for the partition. Recognized GUIDs include:<br /><br />-   EFI system partition: c12a7328\-f81f\-11d2\-ba4b\-00a0c93ec93b<br />-   Basic data partition: ebd0a0a2\-b9e5\-4433\-87c0\-68b6b72699c7<br /><br />Any partition type GUID can be specified with this parameter except the following:<br /><br />-   Microsoft Reserved partition: e3c9e316\-0b5c\-4db8\-817d\-f92df00215ae<br />-   LDM metadata partition on a dynamic disk:5808c8aa\-7e8f\-42e0\-85d2\-e1e90434cfb3<br />-   LDM data partition on a dynamic disk: af9b60a0\-1431\-4f62\-bc68\-3311714a69ad<br />-   Cluster metadata partition: db97dba9\-0840\-4bae\-97f0\-ffb9a327c7e1 |
| override  |                                                                forces the file system on the volume to dismount before changing the partition type. When you run the **Set id** command, DiskPart attempts to lock and dismount the file system on the volume. If **override** is not specified, and the call to lock the file system fails \(for example, because there is an open handle\), the operation will fail. When **override** is specified, DiskPart forces the dismount even if the call to lock the file system fails, and any open handles to the volume will become invalid.<br /><br />This command is only available for Windows 7 and Windows Server 2008 R2.                                                                 |
|   noerr   |                                                                                                                                                                                                                                                                    Used for scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.                                                                                                                                                                                                                                                                    |
  
## Remarks  
  
-   Other than the limitations previously mentioned, DiskPart does not check the validity of the value that you specify \(except to ensure that it is a byte in hexadecimal form or a GUID\).  
  
-   This command does not work on dynamic disks or on Microsoft Reserved partitions.  
  
## <a name="BKMK_examples"></a>Examples  
To set the type field to 0x07 and force the file system to dismount, type:  
  
```  
set id=0x07 override  
```  
  
To set the type field to be a basic data partition, type:  
  
```  
set id=ebd0a0a2-b9e5-4433-87c0-68b6b72699c7  
```  
  
#### additional references  
[Command-Line Syntax Key](command-line-syntax-key.md)  
  

  

