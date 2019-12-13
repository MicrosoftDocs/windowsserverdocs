---
title: cacls
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b5bdbaaa-4557-48b8-80df-e75ee0d2f27d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# cacls

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays or modifies discretionary access control lists (DACL) on specified files.  
## Syntax  
```  
cacls <filename> [/t] [/m] [/l] [/s[:sddl]] [/e] [/c] [/g user:<perm>] [/r user [...]] [/p user:<perm> [...]] [/d user [...]]  
```  
### Parameters  

|        Parameter        |                                                                                            Description                                                                                             |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|      \<filename\>       |                                                                            Required. Displays Acls of specified files.                                                                             |
|           /t            |                                                          changes Acls of specified files in the current directory and all subdirectories.                                                          |
|           /m            |                                                                          changes Acls of volumes mounted to a directory.                                                                           |
|           /l            |                                                                        Work on the Symbolic Link itself versus the target.                                                                         |
|         /s:sddl         |                                       replaces the Acls with those specified in the SDDL string (not valid with **/e**, **/g**, **/r**, **/p**, or **/d**).                                        |
|           /e            |                                                                                 edit ACL instead of replacing it.                                                                                  |
|           /c            |                                                                                 Continue on access denied errors.                                                                                  |
|    /g user:\<perm\>     |   Grant specified user access rights.<br /><br />Valid values for permission:<br /><br />-   n - none<br />-   r - read<br />-   w - write<br />-   c - change (write)<br />-   f - full control   |
|      /r user [...]      |                                                                  Revoke specified user's access rights (only valid with **/e**).                                                                   |
| [/p user:\<perm\> [...] | replace specified user's access rights.<br /><br />Valid values for permission:<br /><br />-   n - none<br />-   r - read<br />-   w - write<br />-   c - change (write)<br />-   f - full control |
|     [/d user [...]      |                                                                                    Deny specified user access.                                                                                     |
|           /?            |                                                                                Displays help at the command prompt.                                                                                |

## Remarks  
- This command has been deprecated. Please use [icacls](icacls.md) instead.  
- Use the following table to interpret the results:  


  |      Output       |                Access control entry (ACE) applies to                |
  |-------------------|---------------------------------------------------------------------|
  |        OI         |               Object inherit. This folder and files.                |
  |        CI         |           Container inherit. This folder and subfolders.            |
  |        IO         | Inherit only. The ACE does not apply to the current file/directory. |
  | No output message |                          This folder only.                          |
  |     (OI)(CI)      |                 This folder, subfolders, and files.                 |
  |   (OI)(CI)(IO)    |                     Subfolders and files only.                      |
  |     (CI)(IO)      |                          Subfolders only.                           |
  |     (OI)(IO)      |                             Files only.                             |


- You can use wildcards (**?** and **\\\***) to specify multiple files.  
- You can specify more than one user.  

#### additional references  
-   [Command-Line Syntax Key](command-line-syntax-key.md)   
-   [icacls](icacls.md)  
