---
title: change port
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3d772c90-e849-4e74-b9ec-b6cae1159336 Lizap
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# change port

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

lists or changes the COM port mappings to be compatible with MS-DOS applications.
for examples of how to use this command, see [Examples](#BKMK_examples).
> [!NOTE]
> In Windows Server 2008 R2, Terminal Services was renamed Remote Desktop Services. To find out what's new in the latest version, see [What s New in Remote Desktop Services in Windows Server 2012](https://technet.microsoft.com/library/hh831527) in the Windows Server TechNet Library.
> ## Syntax
> ```
> change port [<PortX>=<PortY> | /d <PortX> | /query]
> ```
> ## Parameters
> 
> |    Parameter    |              Description               |
> |-----------------|----------------------------------------|
> | <PortX>=<PortY> |    Maps COM <*PortX*> to <*PortY*>.    |
> |   /d <PortX>    | deletes the mapping for COM <*PortX*>. |
> |     /query      |  Displays the current port mappings.   |
> |       /?        |  Displays help at the command prompt.  |
> 
> ## Remarks
> - Most MS-DOS applications support only COM1 through COM4 serial ports. The **change port** command maps a serial port to a different port number, allowing applications that do not support high-numbered COM ports to access the serial port. remapping works only for the current session and is not retained if you log off from a session and then log on again.
> - Use **change port** without any parameters to display the available COM ports and their current mappings.
>   ## <a name="BKMK_examples"></a>Examples
> - To map COM12 to COM1 for use by an MS-DOS-based application, type:
>   ```
>   change port com12=com1
>   ```
> - To display the current port mappings, type:
>   ```
>   change port /query
>   ```
>   #### additional references
>   [Command-Line Syntax Key](command-line-syntax-key.md)
>   [change](change.md)
>   [Remote Desktop Services &#40;Terminal Services&#41; Command Reference](remote-desktop-services-terminal-services-command-reference.md)
