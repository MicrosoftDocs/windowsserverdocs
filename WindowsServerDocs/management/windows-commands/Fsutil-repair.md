---
title: Fsutil repair
description: "Windows Commands topic for **** -- "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b5990ea6-b578-4459-ae7f-ca441c213e5f
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Fsutil repair

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Administers and monitors NTFS self\-healing repair operations.  
  
For examples of how to use this command, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
fsutil repair [initiate] <VolumePath> <FileReference>  
fsutil repair [query] <VolumePath>  
fsutil repair [set] <VolumePath> <Flags>  
fsutil repair [wait][<WaitType>] <VolumePath>  
  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|initiate|Initiates NTFS self\-healing.|  
|<VolumePath>|Specifies the volume as the drive name followed by a colon.|  
|<FileReference>|Specifies the NTFS volume\-specific file ID \(file reference number\). The file reference includes the segment number of the file.|  
|query|Queries the self\-healing state of the NTFS volume.|  
|set|Sets the self\-healing state of the volume.|  
|<Flags>|Specifies the repair method to be used when setting the self\-healing state of the volume.<br /><br />The **Flags** parameter can be set to three values:<br /><br />-   **0x01**: Enables general repair.<br />-   **0x09**: Warns about potential data loss without repair.<br />-   **0x00**: Disables NTFS self\-healing repair operations.|  
|wait|Waits for repair\(s\) to complete. If NTFS has detected a problem on a volume on which it is performing repairs, this option allows the system to wait until the repair is complete before it runs any pending scripts.|  
|\[WaitType {0&#124;1}\]|Indicates whether to wait for the current repair to complete or to wait for all repairs to complete. *WaitType* can be set to the following values:<br /><br />-   **0**: Waits for all repairs to complete. \(default value\)<br />-   **1**: Waits for the current repair to complete.|  
  
## Remarks  
  
-   Self\-healing NTFS attempts to correct corruptions of the NTFS file system online, without requiring **Chkdsk.exe** to be run. This feature was introduced in Windows Server 2008. For more information, see [Self Healing NTFS](http://go.microsoft.com/fwlink/?LinkID=165401).  
  
## <a name="BKMK_examples"></a>Examples  
To enable self\-healing repair on drive C, type:  
  
```  
fsutil repair set c: 1  
```  
  
To disable self\-healing repair on drive C, type:  
  
```  
fsutil repair set c: 0  
```  
  
#### Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  
[Fsutil](Fsutil.md)  
  
[Self Healing NTFS](http://go.microsoft.com/fwlink/?LinkID=165401)  
  

