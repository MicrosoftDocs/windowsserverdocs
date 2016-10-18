---
title: Ftp: ascii
description: "Windows Commands topic for **** -- "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 523be48e-eab0-4237-8fb5-ca222824f0b6 vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Ftp: ascii

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Sets the file transfer type to ASCII.   
## Syntax  
```  
ascii  
```  
### Parameters  
none  
## Remarks  
-   The default file transfer type is ASCII.  
-   In ASCII mode, character conversions to and from the network standard character set are performed. For example, end-of-line characters are converted as necessary, based on the target operating system.  
-   **Ftp** supports both ASCII and binary image file transfer types. Use ASCII when transferring text files. For more information about binary file transfer, see **Ftp: binary** in Additional references.  
## <a name="BKMK_Examples"></a>Examples  
Set the file transfer type to ASCII.  
```  
ascii  
```  
## Additional references  
-   [Ftp: binary](Ftp--binary.md)  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
