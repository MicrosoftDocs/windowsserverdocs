---
title: ftp user
description: Reference topic for **** - 

ms.prod: windows-server


ms.technology: manage-windows-commands

ms.topic: article
ms.assetid: 0a77bfeb-27a9-4f2f-a3c4-2fef529fb569 vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# ftp: user

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Specifies a user to the remote computer.   
## Syntax  
```  
user <UserName> [<Password>] [<Account>]  
```  
#### Parameters  

|  Parameter   |                                                                      Description                                                                      |
|--------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|
|  <UserName>  |                                          Specifies a user name with which to log on to the remote computer.                                           |
| [<Password>] |               Specifies the password for *UserName*. If a password is not specified but is required,  **ftp** prompts for the password.               |
| [<Account>]  | Specifies an account with which to log on to the remote computer. If an *Account* is not specified but is required,  **ftp** prompts for the account. |

## Examples  
Specify User1 with the password Password1.  
```  
user User1 Password1  
```  
## Additional References  
-   - [Command-Line Syntax Key](command-line-syntax-key.md)  
