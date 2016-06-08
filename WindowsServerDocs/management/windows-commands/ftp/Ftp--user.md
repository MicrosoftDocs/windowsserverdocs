---
title: Ftp: user
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0a77bfeb-27a9-4f2f-a3c4-2fef529fb569
author: vhorne
---
# Ftp: user
Specifies a user to the remote computer. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
  
## Syntax  
  
```  
user <UserName> [<Password>] [<Account>]  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|<UserName>|Specifies a user name with which to log on to the remote computer.|  
|\[<Password>\]|Specifies the password for *UserName*. If a password is not specified but is required,  **ftp** prompts for the password.|  
|\[<Account>\]|Specifies an account with which to log on to the remote computer. If an *Account* is not specified but is required,  **ftp** prompts for the account.|  
  
## <a name="BKMK_Examples"></a>Examples  
Specify User1 with the password Password1.  
  
```  
user User1 Password1  
```  
  
## Additional references  
  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  

