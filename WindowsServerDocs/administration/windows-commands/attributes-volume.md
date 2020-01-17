---
title: attributes volume
description: "Windows Commands topic for **attributes volume** - Displays, sets, or clears the attributes of a volume."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e40e8284-3d57-4de8-a46c-e4ade34a0d53
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# attributes volume

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays, sets, or clears the attributes of a volume.  
  
  
  
## Syntax  
  
```  
attributes volume [{set | clear}] [{hidden | readonly | nodefaultdriveletter | shadowcopy}] [noerr]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------|--------|  
|set|Sets the specified attribute of the volume with focus.|  
|clear|Clears the specified attribute of the volume with focus.|  
|readonly|Specifies that the volume is read\-only.|  
|hidden|Specifies that the volume is hidden.|  
|nodefaultdriveletter|Specifies that the volume does not receive a drive letter by default.|  
|shadowcopy|Specifies that the volume is a shadow copy volume.|  
|noerr|for scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|  
  
## Remarks  
  
-   On basic master boot record \(MBR\) disks, the **hidden**, **readonly**, and **nodefaultdriveletter** parameters apply to all volumes on the disk.  
  
-   On basic GUID partition table \(gpt\) disks, and on dynamic MBR and gpt disks, the **hidden**, **readonly**, and **nodefaultdriveletter** parameters apply only to the selected volume.  
  
-   A volume must be selected for the **attributes volume** command to succeed. Use the **select volume** command to select a volume and shift the focus to it.  
  
## <a name="BKMK_examples"></a>Examples  
To display the current attributes on the selected volume, type:  
  
```  
attributes volume  
```  
  
To set the selected volume as hidden and read\-only, type:  
  
```  
attributes volume set hidden readonly  
```  
  
To remove the hidden and read\-only attributes on the selected volume, type:  
  
```  
attributes volume clear hidden readonly  
```  
  
#### additional references  
[Command-Line Syntax Key](command-line-syntax-key.md)  
  

  

