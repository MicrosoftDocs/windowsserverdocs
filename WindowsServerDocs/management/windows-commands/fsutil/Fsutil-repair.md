---
title: Fsutil repair
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b5990ea6-b578-4459-ae7f-ca441c213e5f
---
# Fsutil repair
Administers and monitors NTFS self\-healing repair operations.

for examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
fsutil repair [initiate] <volumepath> <FileReference>
fsutil repair [query] <volumepath>
fsutil repair [set] <volumepath> <Flags>
fsutil repair [wait][<Waittype>] <volumepath>

```

## Parameters

|Parameter|Description|
|-------------|---------------|
|initiate|Initiates NTFS self\-healing.|
|<volumepath>|Specifies the volume as the drive name followed by a colon.|
|<FileReference>|Specifies the NTFS volume\-specific file ID \(file reference number\). The file reference includes the segment number of the file.|
|query|Queries the self\-healing state of the NTFS volume.|
|set|Sets the self\-healing state of the volume.|
|<Flags>|Specifies the repair method to be used when setting the self\-healing state of the volume.<br /><br />The **Flags** parameter can be set to three values:<br /><br />-   **0x01**: Enables general repair.<br />-   **0x09**: Warns about potential data loss without repair.<br />-   **0x00**: Disables NTFS self\-healing repair operations.|
|wait|Waits for repair\(s\) to complete. if NTFS has detected a problem on a volume on which it is performing repairs, this option allows the system to wait until the repair is complete before it runs any pending scripts.|
|\[Waittype {0&#124;1}\]|Indicates whether to wait for the current repair to complete or to wait for all repairs to complete. *Waittype* can be set to the following values:<br /><br />-   **0**: Waits for all repairs to complete. \(default value\)<br />-   **1**: Waits for the current repair to complete.|

## remarks

-   Self\-healing NTFS attempts to correct corruptions of the NTFS file system online, without requiring **Chkdsk.exe** to be run. This feature was introduced in Windows Server 2008. for more information, see [Self Healing NTFS](http://go.microsoft.com/fwlink/?LinkID=165401).

## <a name="BKMK_examples"></a>Examples
To enable self\-healing repair on drive C, type:

```
fsutil repair set c: 1
```

To disable self\-healing repair on drive C, type:

```
fsutil repair set c: 0
```

#### additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)

[Fsutil]()

[Self Healing NTFS](http://go.microsoft.com/fwlink/?LinkID=165401)


