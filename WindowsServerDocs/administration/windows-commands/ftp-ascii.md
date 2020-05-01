---
title: ftp ascii
description: Reference topic for ftp ascii 

ms.prod: windows-server


ms.technology: manage-windows-commands

ms.topic: article
ms.assetid: 523be48e-eab0-4237-8fb5-ca222824f0b6 vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# ftp: ascii

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Sets the file transfer type to ASCII.   
## Syntax  
```  
ascii  
```  
#### Parameters  
none  
## Remarks  
- The default file transfer type is ASCII.  
- In ASCII mode, character conversions to and from the network standard character set are performed. For example, end-of-line characters are converted as necessary, based on the target operating system.  
- **ftp** supports both ASCII and binary image file transfer types. Use ASCII when transferring text files. For more information about binary file transfer, see **ftp: binary** in additional references.  
  ## Examples  
  Set the file transfer type to ASCII.  
  ```  
  ascii  
  ```  
  ## Additional References  
- [ftp: binary](ftp-binary.md)  
- - [Command-Line Syntax Key](command-line-syntax-key.md)  
