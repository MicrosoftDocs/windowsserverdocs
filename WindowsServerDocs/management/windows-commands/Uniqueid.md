---
title: Uniqueid
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 64235a4a-b91c-46da-b9b0-68ee90571c2a
---
# Uniqueid
Displays or sets the GUID partition table \(GPT\) identifier or master boot record \(MBR\) signature for the disk with focus.

> [!IMPORTANT]
> This DiskPart command is not available in any edition of [!INCLUDE[nextref_vista](includes/nextref_vista_md.md)].

## Syntax

```
uniqueid disk [id={<dword> | <GUID>}] [noerr]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|id\={<dword> &#124; <GUID>}|For MBR disks, specifies a four\-byte \(DWORD\) value in hexadecimal form for the signature.<br /><br />For GPT disks, specifies a GUID for the identifier.|
|noerr|For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|

## Remarks

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

To set the identifier of the GPT disk with focus to baf784e7\-6bbd\-4cfb\-aaac\-e86c96e166ee, type:

```
uniqueid disk id=baf784e7-6bbd-4cfb-aaac-e86c96e166ee
```

#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)

[Diskpart \[LH\]](assetId:///26a4a166-95fa-4faf-95bc-2d5345f4a57a)


