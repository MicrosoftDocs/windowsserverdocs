---
title: Prnmngr.vbs
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 39eee1a8-4b41-4c9f-941e-486495135eb8
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Prnmngr.vbs

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Adds, deletes, and lists printers or printer connections, in addition to setting and displaying the default printer.

## Syntax
```
Cscript Prnmngr {-a | -d | -x | -g | -t | -l | -?}[c] [-s <ServerName>] 
[-p <PrinterName>] [-m <PrinterModel>] [-r <PortName>] [-u <UserName>] 
[-w <Password>]
```
## Parameters
|Parameter|Description|
|-------|--------|
|-a|Adds a local printer connection.|
|-d|Deletes a printer connection.|
|-x|Deletes all printers from the server specified with the **-s** parameter. If you do not specify a server, Windows deletes all printers on the local computer.|
|-g|Displays the default printer.|
|-t|Sets the default printer to the printer specified by the **-p** parameter.|
|-l|Lists all printers installed on the server specified by the **-s** parameter. If you do not specify a server, Windows lists the printers installed on the local computer.|
|c|Specifies that the parameter applies to printer connections. Can be used with the **-a** and **-x** parameters.|
|-s <ServerName>|Specifies the name of the remote computer that hosts the printer that you want to manage. If you do not specify a computer, the local computer is used.|
|-p <PrinterName>|Specifies the name of the printer that you want to manage.|
|-m <DriverModelName>|Specifies (by name) the driver you want to install. Drivers are often named for the model of printer they support. See the printer documentation for more information.|
|-r <PortName>|Specifies the port where the printer is connected. If this is a parallel or a serial port, use the ID of the port (for example, LPT1: or COM1:). If this is a TCP/IP port, use the port name that was specified when the port was added.|
|-u <UserName> -w <Password>|Specifies an account with permissions to connect to the computer that hosts the printer that you want to manage. All members of the target computer's local Administrators group have these permissions, but the permissions can also be granted to other users. If you do not specify an account, you must be logged on under an account with these permissions for the command to work.|
|/?|Displays help at the command prompt.|
## Remarks
-   The **Prndrvr.vbs** command is a Visual Basic script located in the %WINDIR%\System32\Printing_Admin_Scripts\\<language> directory. To use this command, at a command prompt, type **Cscript** followed by the full path to the **Prnmngr.vbs** file, or change directories to the appropriate folder. For example:
    ```
    Cscript %WINDIR%\System32\Printing_Admin_Scripts\en-US\Prnmngr.vbs
    ```
-   If the information that you supply contains spaces, use quotation marks around the text (for example, `"Computer Name"`).
## <a name="BKMK_examples"></a>Examples
To add a printer named ColorPrinter_2 that is connected to LPT1 on the local computer and requires a printer driver called Color Printer Driver1, type:
```
Cscript Prnmngr.vbs -a -p ColorPrinter_2 -m "Color Printer Driver1" -r lpt1:
```
To delete the printer named ColorPrinter_2 from the remote computer named HRServer, type:
```
Cscript Prnmngr.vbs -d -s HRServer -p ColorPrinter_2 
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Print Command Reference](Print-Command-Reference.md)
