---
title: prnqctl
description: Print a test page, pause or resume a printer.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8df9dfa7-984c-4276-bb7d-e7675e7c399e jpjofre
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 07/11/2018
---
# prnqctl

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Prints a test page, pauses or resumes a printer, and clears a printer queue.  

## Syntax  
```  
cscript Prnqctl {-z | -m | -e | -x | -?} [-s <ServerName>]   
[-p <printerName>] [-u <UserName>] [-w <Password>]  
```  
## Parameters  

|Parameter|Description|  
|-------|--------|  
|-z|pauses printing on the printer specified with the **-p** parameter.|  
|-m|Resumes printing on the printer specified with the **-p** parameter.|  
|-e|prints a test page on the printer specified with the **-p** parameter.|  
|-x|Cancels all print jobs on the printer specified with the **-p** parameter.|  
|-s \<ServerName>|Specifies the name of the remote computer that hosts the printer that you want to manage. If you do not specify a computer, the local computer is used.|  
|-p \<printerName>|Specifies the name of the printer that you want to manage. Required.|  
|-u \<UserName> -w \<Password>|Specifies an account with permissions to connect to the computer that hosts the printer that you want to manage. All members of the target computer's local Administrators group have these permissions, but the permissions can also be granted to other users. If you do not specify an account, you must be logged on under an account with these permissions for the command to work.|  
|/?|Displays help at the command prompt.|  

## Remarks  
- The **prnqctl** command is a Visual Basic script located in the %WINdir%\System32\printing_Admin_Scripts\\<language> directory. To use this command, at a command prompt, type **cscript** followed by the full path to the prnqctl file, or change directories to the appropriate folder. For example:  
  ```  
  cscript %WINdir%\System32\printing_Admin_Scripts\en-US\prnqctl  
  ```  
- if the information that you supply contains spaces, use quotation marks around the text (for example, `"computer Name"`).  

## <a name="BKMK_examples"></a>Examples  
To print a test page on the Laserprinter1 printer shared by the \\\Server1 computer, type:  
```  
cscript Prnqctl -e -s Server1 -p Laserprinter1  
```  
To pause printing on the Laserprinter1 printer on the local computer, type:  
```  
cscript Prnqctl -z -p Laserprinter1  
```  
To cancel all print jobs on the Laserprinter1 printer on the local computer, type:  
```  
cscript Prnqctl -x -p Laserprinter1  
```  

#### additional references  
[Command-Line Syntax Key](command-line-syntax-key.md)  
[print Command Reference](print-command-reference.md)  
