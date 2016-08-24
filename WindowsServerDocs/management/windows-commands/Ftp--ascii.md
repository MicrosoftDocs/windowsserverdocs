---
title: Ftp: ascii
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 523be48e-eab0-4237-8fb5-ca222824f0b6 vhorneauthor: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Ftp: ascii
Sets the file transfer type to ASCII. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
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
