---
title: GPT
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1d6f9029-807f-4420-a336-36669b5361bcauthor: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# GPT
On basic GUID partition table (GPT) disks, assigns the GPT attribute(s) to the partition with focus.  GPT partition attributes give additional information about the use of the partition. Some attributes are specific to the partition type GUID.
For examples of how this command can be used, see [Examples](#BKMK_examples).
> [!CAUTION]
> Changing the GPT attributes might cause your basic data volumes to fail to be assigned drive letters, or to prevent the file system from mounting. You should not change the GPT attributes unless you are an original equipment manufacturer (OEM) or an IT professional who is experienced with GPT disks.
## Syntax
```
gpt attributes=<n>
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|attributes=<n>|Specifies the value for the attribute that you want to apply to the partition with focus. The GPT attribute field is a 64-bit field that contains two subfields. The higher field is interpreted only in the context of the partition ID, while the lower field is common to all partition IDs. Accepted values include:<br /><br />-   **0x0000000000000001**. Specifies that the partition is required by the computer to function properly.<br />-   **0x8000000000000000**. Specifies that the partition will not receive a drive letter by default when the disk is moved to another computer or when the disk is seen for the first time by a computer.<br />-   **0x4000000000000000**. Hides a partition's volume. That is, the partition will not be detected by the Mount Manager.<br />-   **0x2000000000000000**. Specifies that the partition is a shadow copy of another partition.<br />-   **0x1000000000000000**. Specifies that the partition is read-only. This attribute prevents the volume from being written to.<br /><b />For more information about these attributes, see the Attributes section at [CREATE_PARTITION_PARAMETERS Structure](http://go.microsoft.com/fwlink/?LinkId=203812) (http://go.microsoft.com/fwlink/?LinkId=203812).|
## Remarks
-   The EFI System partition contains only those binaries necessary to start the operating system. This makes it easy for OEM binaries or binaries specific to an operating system to be placed in other partitions.
-   A basic GPT partition must be selected for this operation to succeed. Use the **select partition** command to select a basic GPT partition and shift the focus to it.
## <a name="BKMK_examples"></a>Examples
If you are moving a GPT disk to a new computer and would like to prevent that computer from automatically assigning a drive letter to the partition with focus, type:
```
gpt attributes=0x8000000000000000
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Diskpart \[LH\]](assetId:///26a4a166-95fa-4faf-95bc-2d5345f4a57a)
