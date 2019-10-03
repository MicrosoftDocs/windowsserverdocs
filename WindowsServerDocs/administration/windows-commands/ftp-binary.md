---
title: ftp binary
description: "Windows Commands topic for ftp binary"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ee925b4d-85d2-47b1-b7d6-3832b7ec5505 vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# ftp: binary

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Sets the file transfer type to binary.   
## Syntax  
```  
binary  
```  
### Parameters  
none  
## Remarks <optional section>  
**ftp** supports both ASCII and binary image file transfer types. Use binary when transferring executable files. In binary mode, files are transferred in one-byte units. For more information about ASCII file transfer, see  **ftp: ascii** in additional references.  
## <a name="BKMK_Examples"></a>Examples  
Set the file transfer type to binary.  
```  
binary  
```  
## additional references  
-   [ftp: ascii](ftp-ascii.md)  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
