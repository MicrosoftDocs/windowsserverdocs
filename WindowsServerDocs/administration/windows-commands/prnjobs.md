---
title: prnjobs
description: Learn how to manage print jobs from the command line.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5ad34199-7a5a-40c1-8053-bccd5929df43
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 07/11/2018
---
# prnjobs

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Pauses, resumes, cancels, and lists print jobs.

## Syntax
```
cscript Prnjobs {-z | -m | -x | -l | -?} [-s <ServerName>] 
[-p <printerName>] [-j <JobID>] [-u <UserName>] [-w <Password>]
```

## Parameters

|          Parameter           |                                                                                                                                                                                        Description                                                                                                                                                                                        |
|------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|              -z              |                                                                                                                                                                 pauses the print job specified with the **-j** parameter.                                                                                                                                                                 |
|              -m              |                                                                                                                                                                Resumes the print job specified with the **-j** parameter.                                                                                                                                                                 |
|              -x              |                                                                                                                                                                Cancels the print job specified with the **-j** parameter.                                                                                                                                                                 |
|              -l              |                                                                                                                                                                        lists all the print jobs in a print queue.                                                                                                                                                                         |
|       -s \<ServerName>       |                                                                                                                  Specifies the name of the remote computer that hosts the printer that you want to manage. If you do not specify a computer, the local computer is used.                                                                                                                  |
|      -p \<printerName>       |                                                                                                                                                           Specifies the name of the printer that you want to manage. Required.                                                                                                                                                            |
|         -j \<JobID>          |                                                                                                                                                                Specifies (by ID number) the print job you want to cancel.                                                                                                                                                                 |
| -u \<UserName> -w <Password> | Specifies an account with permissions to connect to the computer that hosts the printer that you want to manage. All members of the target computer's local Administrators group have these permissions, but the permissions can also be granted to other users. If you do not specify an account, you must be logged on under an account with these permissions for the command to work. |
|              /?              |                                                                                                                                                                           Displays help at the command prompt.                                                                                                                                                                            |

## Remarks
-   The **prnjobs** command is a Visual Basic script located in the %WINdir%\System32\printing_Admin_Scripts\\<language> directory. To use this command, at a command prompt, type **cscript** followed by the full path to the prnjobs file, or change directories to the appropriate folder. For example:
    ```
    cscript %WINdir%\System32\printing_Admin_Scripts\en-US\prnjobs.vbs
    ```
-   If the information that you supply contains spaces, use quotation marks around the text (for example, `"computer Name"`).

## <a name="BKMK_examples"></a>Examples
To pause a print job with a job ID of 27 sent to the remote computer named HRServer for printing on the printer named colorprinter, type:
```
cscript prnjobs.vbs -z -s HRServer -p colorprinter -j 27
```
To list all current print jobs in the queue for the local printer named colorprinter_2, type:
```
cscript prnjobs.vbs -l -p colorprinter_2
```

#### Additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)
-   [Print Command Reference](print-command-reference.md)
