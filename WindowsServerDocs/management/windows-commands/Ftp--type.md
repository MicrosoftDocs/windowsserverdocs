---
title: Ftp: type
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6e96dcd4-08f8-4e7b-90b7-1e1761fea4c7 vhorneauthor: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Ftp: type
Sets or displays the file transfer type. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
## Syntax  
```  
type [<TypeName>]  
```  
### Parameters  
|Parameter|Description|  
|-------------|---------------|  
|[<TypeName>]|Specifies the file transfer type.|  
## Remarks  
-   If *TypeName* is not specified, the current type is displayed.  
-   **Ftp** supports two file transfer types, ASCII and binary.  
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
## Additional references  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
