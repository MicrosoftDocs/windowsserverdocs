---
title: Prnjobs.vbs
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5ad34199-7a5a-40c1-8053-bccd5929df43
author: jpjofre
---
# Prnjobs.vbs
Pauses, resumes, cancels, and lists print jobs.  
  
For examples of how this command can be used, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
Cscript Prnjobs {-z | -m | -x | -l | -?} [-s <ServerName>]   
[-p <PrinterName>] [-j <JobID>] [-u <UserName>] [-w <Password>]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\-z|Pauses the print job specified with the **\-j** parameter.|  
|\-m|Resumes the print job specified with the **\-j** parameter.|  
|\-x|Cancels the print job specified with the **\-j** parameter.|  
|\-l|Lists all the print jobs in a print queue.|  
|\-s <ServerName>|Specifies the name of the remote computer that hosts the printer that you want to manage. If you do not specify a computer, the local computer is used.|  
|\-p <PrinterName>|Specifies the name of the printer that you want to manage. Required.|  
|\-j <JobID>|Specifies \(by ID number\) the print job you want to cancel.|  
|\-u <UserName> \-w <Password>|Specifies an account with permissions to connect to the computer that hosts the printer that you want to manage. All members of the target computer's local Administrators group have these permissions, but the permissions can also be granted to other users. If you do not specify an account, you must be logged on under an account with these permissions for the command to work.|  
|\/?|Displays help at the command prompt.|  
  
## Remarks  
  
-   The **Prnjobs.vbs** command is a Visual Basic script located in the %WINDIR%\\System32\\Printing\_Admin\_Scripts\\<language> directory. To use this command, at a command prompt, type **Cscript** followed by the full path to the Prnjobs.vbs file, or change directories to the appropriate folder. For example:  
  
    ```  
    Cscript %WINDIR%\System32\Printing_Admin_Scripts\en-US\Prnjobs.vbs  
    ```  
  
-   If the information that you supply contains spaces, use quotation marks around the text \(for example, `"Computer Name"`\).  
  
## <a name="BKMK_examples"></a>Examples  
To pause a print job with a job ID of 27 sent to the remote computer named HRServer for printing on the printer named ColorPrinter, type:  
  
```  
Cscript Prnjobs.vbs -z -s HRServer -p ColorPrinter -j 27  
```  
  
To list all current print jobs in the queue for the local printer named ColorPrinter\_2, type:  
  
```  
Cscript Prnjobs.vbs -l -p ColorPrinter_2  
```  
  
#### Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
[Print Command Reference](../Topic/Print-Command-Reference.md)  
  
