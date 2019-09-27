---
title: print
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: aa2325d5-a993-4ed3-b996-255165452db8
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# print



Sends a text file to a printer.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
Print [/d:<PrinterName>] [<Drive>:][<Path>]<FileName>[ ...]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|/d:\<PrinterName>|Specifies the printer that you want to print the job. To print to a locally connected printer, specify the port on your computer where the printer is connected.</br>-   Valid values for parallel ports are LPT1, LPT2, and LPT3.</br>-   Valid values for serial ports are COM1, COM2, COM3, and COM4.</br>You can also specify a network printer by using its queue name (\\\\*ServerName*\*PrinterName*). If you do not specify a printer, the print job is sent to LPT1 by default.|
|\<Drive>:|Specifies the logical or physical drive where the file you want to print is located. This parameter is not required if the file you want to print is located on the current drive.|
|\<Path>|Specifies the location of the file you want to print. This parameter is not required if the file you want to print is located in the current directory.|
|\<FileName>[ ...]|Required. Specifies the file you want to print. You can include multiple files in one command.|
|/?|Displays help at the command prompt.|

## Remarks

-   A file can print in the background if you send it to a printer connected to a serial or parallel port on the local computer.
-   You can perform many configuration tasks from the command prompt by using the **Mode** command.

    See [Mode](mode.md) for more information about:  
    -   Configuring a printer connected to a parallel port
    -   Configuring a printer connected to a serial port
    -   Displaying the status of a printer
    -   Preparing a printer for code page switching

## <a name="BKMK_examples"></a>Examples

To send the file Report.txt in the current directory to a printer connected to LPT2 on the local computer, type:
```
print /d:lpt2 report.txt
```
To send the file Report.txt in the c:\Accounting directory to the Printer1 print queue on the \\\\CopyRoom server, type:
```
print /d:\\copyroom\printer1 c:\accounting\report.txt 
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)

[Print Command Reference](print-command-reference.md)

[Mode](mode.md)