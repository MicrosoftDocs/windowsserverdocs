---
title: Change port
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3d772c90-e849-4e74-b9ec-b6cae1159336 Lizap
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Change port

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Lists or changes the COM port mappings to be compatible with MS-DOS applications.
For examples of how to use this command, see [Examples](#BKMK_examples).
> [!NOTE]
> In Windows Server 2008 R2, Terminal Services was renamed Remote Desktop Services. To find out what's new in the latest version, see [What’s New in Remote Desktop Services in Windows Server 2012](http://technet.microsoft.com/library/hh831527) in the Windows Server TechNet Library.
## Syntax
```
change port [<PortX>=<PortY> | /d <PortX> | /query]
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|<PortX>=<PortY>|Maps COM <*PortX*> to <*PortY*>.|
|/d <PortX>|Deletes the mapping for COM <*PortX*>.|
|/query|Displays the current port mappings.|
|/?|Displays help at the command prompt.|
## Remarks
-   Most MS-DOS applications support only COM1 through COM4 serial ports. The **change port** command maps a serial port to a different port number, allowing applications that do not support high-numbered COM ports to access the serial port. Remapping works only for the current session and is not retained if you log off from a session and then log on again.
-   Use **change port** without any parameters to display the available COM ports and their current mappings.
## <a name="BKMK_examples"></a>Examples
-   To map COM12 to COM1 for use by an MS-DOS-based application, type:
    ```
    change port com12=com1
    ```
-   To display the current port mappings, type:
    ```
    change port /query
    ```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Change](Change.md)
[Remote Desktop Services &#40;Terminal Services&#41; Command Reference](Remote-Desktop-Services--Terminal-Services--Command-Reference.md)
