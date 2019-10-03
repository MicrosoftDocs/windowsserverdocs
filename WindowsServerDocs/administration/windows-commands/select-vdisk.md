---
title: select vdisk
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8808872a-3523-4205-a6c6-83fa738ee37a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# select vdisk

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

selects the specified virtual hard disk \(VHD\) and shifts the focus to it.  
  
> [!NOTE]  
> This command is only applicable to Windows 7 and Windows Server 2008 R2.  
  
## Syntax  
  
```  
select vdisk file=<full path> [noerr]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------|--------|  
|file\=<full path>|Specifies the full path and file name of an existing VHD file.|  
|noerr|Used for scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|  
  
## <a name="BKMK_examples"></a>Examples  
To shift the focus to the VHD named Test.vhd, type:  
  
```  
select vdisk file="c:\test\test.vhd"  
```  
  
#### additional references  
  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
  
-   [attach vdisk](attach-vdisk.md)  
  
-   [compact vdisk](compact-vdisk.md)  
  
  
  
-   [Detach vdisk](detach-vdisk.md)  
  
-   [detail vdisk](detail-vdisk.md)  
  
-   [expand vdisk](expand-vdisk.md)  
  
-   [Merge vdisk](merge-vdisk.md)  
  
-   [list_1](list_1.md)  
  

