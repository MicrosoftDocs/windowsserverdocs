---
title: lpr
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: afc8790b-8b52-45c4-acdf-be0ffa9da534 jpjofre
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# lpr

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Sends a file to a computer or printer sharing device running the Line printer Daemon (LPD) service in preparation for printing.  

## Syntax  
```  
lpr [-S <ServerName>] -P <printerName> [-C <BannerContent>] [-J <JobName>] [-o | "-o l"] [-x] [-d] <filename>  
```  
## Parameters  

|     Parameter      |                                                                                                           Description                                                                                                           |
|--------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|  -S <ServerName>   |                                    Specifies (by name or IP address) the computer or printer sharing device that hosts the LPD print queue with a status that you want to display. Required.                                    |
|  -P <printerName>  |                                                              Specifies (by name) the printer for the print queue with a status that you want to display. Required.                                                              |
| -C <BannerContent> |                Specifies the content to print on the banner page of the print job. If you do not include this parameter, the name of the computer from which the print job was sent appears on the banner page.                 |
|    -J <JobName>    |                           Specifies the print job name that will be printed on the banner page. If you do not include this parameter, the name of the file being printed appears on the banner page.                            |
| [-o&#124; "-o l"]  | Specifies the type of file that you want to print. The parameter **-o** specifies that you want to print a text file. The parameter **"-o l"** specifies that you want to print a binary file (for example, a PostScript file). |
|         -d         |              Specifies that the data file must be sent before the control file. Use this parameter if your printer requires the data file to be sent first. For more information, see your printer documentation.               |
|         -x         |                               Specifies that the **lpr** command must be compatible with the Sun Microsystems operating system (referred to as SunOS) for releases up to and including 4.1.4_u1.                                |
|     <FileName>     |                                                                                      Specifies (by name) the file to be printed. Required.                                                                                      |
|         /?         |                                                                                              Displays help at the command prompt.                                                                                               |

## Remarks  
- To find the name of the printer, open the printers folder.  
- The **-S**, **-P**, **-C**, and **-J** parameters are case sensitive and must be typed in upper-case letters.  
  ## <a name="BKMK_examples"></a>Examples  
  This example shows how to print the "Document.txt" text file to the Laserprinter1 printer queue on an LPD host at 10.0.0.45:  
  ```  
  lpr -S 10.0.0.45 -P Laserprinter1 -o Document.txt  
  ```  
  This example shows how to print the "PostScript_file.ps" Adobe PostScript file to the Laserprinter1 printer queue on an LPD host at 10.0.0.45:  
  ```  
  lpr -S 10.0.0.45 -P Laserprinter1 "-o l" PostScript_file.ps  
  ```  

#### additional references  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
-   [print Command Reference](print-command-reference.md)  
