---
title: Prnqctl.vbs
description: "Windows Commands topic for **** -- "
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
ms.date: 10/12/2016
---

# Prnqctl.vbs

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Prints a test page, pauses or resumes a printer, and clears a printer queue.  
  
## Syntax  
```  
Cscript Prnqctl {-z | -m | -e | -x | -?} [-s <ServerName>]   
[-p <PrinterName>] [-u <UserName>] [-w <Password>]  
```  
## Parameters  
|Parameter|Description|  
|-------------|---------------|  
|-z|Pauses printing on the printer specified with the **-p** parameter.|  
|-m|Resumes printing on the printer specified with the **-p** parameter.|  
|-e|Prints a test page on the printer specified with the **-p** parameter.|  
|-x|Cancels all print jobs on the printer specified with the **-p** parameter.|  
|-s <ServerName>|Specifies the name of the remote computer that hosts the printer that you want to manage. If you do not specify a computer, the local computer is used.|  
|-p <PrinterName>|Specifies the name of the printer that you want to manage. Required.|  
|-u <UserName> -w <Password>|Specifies an account with permissions to connect to the computer that hosts the printer that you want to manage. All members of the target computer's local Administrators group have these permissions, but the permissions can also be granted to other users. If you do not specify an account, you must be logged on under an account with these permissions for the command to work.|  
|/?|Displays help at the command prompt.|  
## Remarks  
-   The **Prnqctl.vbs** command is a Visual Basic script located in the %WINDIR%\System32\Printing_Admin_Scripts\\<language> directory. To use this command, at a command prompt, type **Cscript** followed by the full path to the Prnqctl.vbs file, or change directories to the appropriate folder. For example:  
    ```  
    Cscript %WINDIR%\System32\Printing_Admin_Scripts\en-US\Prnqctl.vbs  
    ```  
-   If the information that you supply contains spaces, use quotation marks around the text (for example, `"Computer Name"`).  
## <a name="BKMK_examples"></a>Examples  
To print a test page on the LaserPrinter1 printer shared by the \\\Server1 computer, type:  
```  
Cscript Prnqctl -e -s Server1 -p LaserPrinter1  
```  
To pause printing on the LaserPrinter1 printer on the local computer, type:  
```  
Cscript Prnqctl -z -p LaserPrinter1  
```  
To cancel all print jobs on the LaserPrinter1 printer on the local computer, type:  
```  
Cscript Prnqctl -x -p LaserPrinter1  
```  
#### Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
[Print Command Reference](Print-Command-Reference.md)  
