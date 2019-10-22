---
title: ftp type
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6e96dcd4-08f8-4e7b-90b7-1e1761fea4c7 vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# ftp: type

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Sets or displays the file transfer type.   
## Syntax  
```  
type [<typeName>]  
```  
### Parameters  

|  Parameter   |            Description            |
|--------------|-----------------------------------|
| [<typeName>] | Specifies the file transfer type. |

## Remarks  
- if *typeName* is not specified, the current type is displayed.  
- **ftp** supports two file transfer types, ASCII and binary.  
  The default file transfer type is ASCII.  The **ascii** command should be used when transferring text files. In ASCII mode, character conversions to and from the network standard character set are performed. For example, end-of-line characters are converted as required, based on the operating system at the destination.  
  The **binary** command should be used when transferring executable files. In binary mode, the file is moved in one-byte units.  
  ## <a name="BKMK_Examples"></a>Examples  
  Set the file transfer type to ASCII.  
  ```  
  type ascii  
  ```  
  Set the transfer file type to binary.  
  ```  
  type binary  
  ```  
  ## additional references  
- [Command-Line Syntax Key](command-line-syntax-key.md)  
