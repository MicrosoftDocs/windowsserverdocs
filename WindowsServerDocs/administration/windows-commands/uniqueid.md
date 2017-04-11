---
title: uniqueid
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 64235a4a-b91c-46da-b9b0-68ee90571c2a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# uniqueid

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays or sets the GUID partition table (gpt) identifier or master boot record (MBR) signature for the disk with focus.
> [!IMPORTANT]
> This DiskPart command is not available in any edition of Windows Vista.
## Syntax
```
uniqueid disk [id={<dword> | <GUID>}] [noerr]
```
## Parameters
|Parameter|Description|
|-------|--------|
|id={<dword> &#124; <GUID>}|for MBR disks, specifies a four-byte (DWOrd) value in hexadecimal form for the signature.<br /><br />for gpt disks, specifies a GUID for the identifier.|
|noerr|for scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|
## remarks
-   This command works on basic and dynamic disks.
-   A disk must be selected for this command to succeed. Use the **select disk** command to select a disk and shift the focus to it.
## <a name="BKMK_examples"></a>Examples
To display the signature of the MBR disk with focus, type:
```
uniqueid disk
```
To set the signature of the MBR disk with focus to 5f1b2c36, type:
```
uniqueid disk id=5f1b2c36
```
To set the identifier of the gpt disk with focus to baf784e7-6bbd-4cfb-aaac-e86c96e166ee, type:
```
uniqueid disk id=baf784e7-6bbd-4cfb-aaac-e86c96e166ee
```

