---
title: prnmngr
description: Learn how to add, delete, and list printers and connections.
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
ms.date: 07/11/2018
---
# prnmngr

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Adds, deletes, and lists printers or printer connections, in addition to setting and displaying the default printer.

## Syntax
```
cscript Prnmngr {-a | -d | -x | -g | -t | -l | -?}[c] [-s <ServerName>] 
[-p <printerName>] [-m <printermodel>] [-r <PortName>] [-u <UserName>] 
[-w <Password>]
```

## Parameters

|           Parameter           |                                                                                                                                                                                        Description                                                                                                                                                                                        |
|-------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|              -a               |                                                                                                                                                                             adds a local printer connection.                                                                                                                                                                              |
|              -d               |                                                                                                                                                                               deletes a printer connection.                                                                                                                                                                               |
|              -x               |                                                                                                               deletes all printers from the server specified with the **-s** parameter. If you do not specify a server, Windows deletes all printers on the local computer.                                                                                                               |
|              -g               |                                                                                                                                                                               Displays the default printer.                                                                                                                                                                               |
|              -t               |                                                                                                                                                        Sets the default printer to the printer specified by the **-p** parameter.                                                                                                                                                         |
|              -l               |                                                                                                         lists all printers installed on the server specified by the **-s** parameter. If you do not specify a server, Windows lists the printers installed on the local computer.                                                                                                         |
|               c               |                                                                                                                                      Specifies that the parameter applies to printer connections. Can be used with the **-a** and **-x** parameters.                                                                                                                                      |
|        -s <ServerName>        |                                                                                                                  Specifies the name of the remote computer that hosts the printer that you want to manage. If you do not specify a computer, the local computer is used.                                                                                                                  |
|       -p \<printerName>       |                                                                                                                                                                Specifies the name of the printer that you want to manage.                                                                                                                                                                 |
|     -m \<DrivermodelName>     |                                                                                                          Specifies (by name) the driver you want to install. Drivers are often named for the model of printer they support. See the printer documentation for more information.                                                                                                           |
|        -r \<PortName>         |                                                                         Specifies the port where the printer is connected. If this is a parallel or a serial port, use the ID of the port (for example, LPT1: or COM1:). If this is a TCP/IP port, use the port name that was specified when the port was added.                                                                          |
| -u \<UserName> -w \<Password> | Specifies an account with permissions to connect to the computer that hosts the printer that you want to manage. All members of the target computer's local Administrators group have these permissions, but the permissions can also be granted to other users. If you do not specify an account, you must be logged on under an account with these permissions for the command to work. |
|              /?               |                                                                                                                                                                           Displays help at the command prompt.                                                                                                                                                                            |

## Remarks
-   The **prndrvr** command is a Visual Basic script located in the %WINdir%\System32\printing_Admin_Scripts\\<language> directory. To use this command, at a command prompt, type **cscript** followed by the full path to the **prnmngr** file, or change directories to the appropriate folder. For example:
    ```
    cscript %WINdir%\System32\printing_Admin_Scripts\en-US\prnmngr
    ```
-   if the information that you supply contains spaces, use quotation marks around the text (for example, `"computer Name"`).

## <a name="BKMK_examples"></a>Examples
To add a printer named colorprinter_2 that is connected to LPT1 on the local computer and requires a printer driver called color printer Driver1, type:
```
cscript prnmngr -a -p colorprinter_2 -m "color printer Driver1" -r lpt1:
```
To delete the printer named colorprinter_2 from the remote computer named HRServer, type:
```
cscript prnmngr -d -s HRServer -p colorprinter_2 
```

#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
[print Command Reference](print-command-reference.md)
