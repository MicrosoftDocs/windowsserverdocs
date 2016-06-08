---
title: Ftp: send_1
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 000aa80a-60a0-4b51-815f-3237a4f3e0f4
author: vhorne
---
# Ftp: send_1
Copies a local file to the remote computer using the current file transfer type. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
  
## Syntax  
  
```  
send <LocalFile> [<RemoteFile>]  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|<LocalFile>|Specifies the local file to copy.|  
|<RemoteFile>|Specifies the name to use on the remote computer.|  
  
## Remarks  
  
-   The **send** command is identical to the **put** command.  
  
-   If *RemoteFile* is not specified, the file is given the *LocalFile* name.  
  
## <a name="BKMK_Examples"></a>Examples  
Copy the local file **test.txt** and name it **test1.txt** on the remote computer.  
  
```  
send test.txt test1.txt  
```  
  
Copy the local file **program.exe** to the remote computer.  
  
```  
send program.exe  
```  
  
## Additional references  
  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  

