---
title: lpr
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: afc8790b-8b52-45c4-acdf-be0ffa9da534
author: jpjofre
---
# lpr
Sends a file to a computer or printer sharing device running the Line printer Daemon \(LPD\) service in preparation for printing.  
  
for examples of how this command can be used, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
lpr [-S <ServerName>] -P <printerName> [-C <BannerContent>] [-J <JobName>] [-o | "-o l"] [-x] [-d] <filename>  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\-S <ServerName>|Specifies \(by name or IP address\) the computer or printer sharing device that hosts the LPD print queue with a status that you want to display. Required.|  
|\-P <printerName>|Specifies \(by name\) the printer for the print queue with a status that you want to display. Required.|  
|\-C <BannerContent>|Specifies the content to print on the banner page of the print job. if you do not include this parameter, the name of the computer from which the print job was sent appears on the banner page.|  
|\-J <JobName>|Specifies the print job name that will be printed on the banner page. if you do not include this parameter, the name of the file being printed appears on the banner page.|  
|\[\-o&#124; "\-o l"\]|Specifies the type of file that you want to print. The parameter **\-o** specifies that you want to print a text file. The parameter **"\-o l"** specifies that you want to print a binary file \(for example, a PostScript file\).|  
|\-d|Specifies that the data file must be sent before the control file. Use this parameter if your printer requires the data file to be sent first. for more information, see your printer documentation.|  
|\-x|Specifies that the **lpr** command must be compatible with the Sun Microsystems operating system \(referred to as SunOS\) for releases up to and including 4.1.4\_u1.|  
|<FileName>|Specifies \(by name\) the file to be printed. Required.|  
|\/?|Displays help at the command prompt.|  
  
## remarks  
  
-   To find the name of the printer, open the printers folder.  
  
-   The **\-S**, **\-P**, **\-C**, and **\-J** parameters are case sensitive and must be typed in upper\-case letters.  
  
## <a name="BKMK_examples"></a>Examples  
This example shows how to print the "Document.txt" text file to the Laserprinter1 printer queue on an LPD host at 10.0.0.45:  
  
```  
lpr -S 10.0.0.45 -P Laserprinter1 -o Document.txt  
```  
  
This example shows how to print the "PostScript\_file.ps" Adobe PostScript file to the Laserprinter1 printer queue on an LPD host at 10.0.0.45:  
  
```  
lpr -S 10.0.0.45 -P Laserprinter1 "-o l" PostScript_file.ps  
```  
  
#### additional references  
[Command-Line Syntax Key](commandline-syntax-key.md)  
  
[print Command Reference](print-command-reference.md)  
  

