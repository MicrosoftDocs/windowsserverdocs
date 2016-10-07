---
title: Ftp: lcd
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 60a25808-6abb-408b-8373-0bbdcd0994b4 vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Ftp: lcd

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Changes the working directory on the local computer. By default, the working directory is the directory in which **ftp** was started. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
## Syntax  
```  
lcd [<Directory>]  
```  
### Parameters  
|Parameter|Description|  
|-------------|---------------|  
|[<Directory>]|Specifies the directory on the local computer to which to change. If *Directory* is not specified, the current working directory is changed to the default directory.|  
## <a name="BKMK_Examples"></a>Examples  
Change the working directory on the local computer to **C:\Dir1**  
```  
lcd C:\Dir1  
```  
## Additional references  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
