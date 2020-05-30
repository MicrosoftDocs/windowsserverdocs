---
title: netcfg
description: Reference topic for **** -

ms.prod: windows-server


ms.technology: manage-windows-commands

ms.topic: article
ms.assetid: e2daaab7-12db-4e36-b70c-db8906d084f7
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# netcfg

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Installs the Windows Preinstallation Environment (WinPE), a lightweight version of Windows used to deploy workstations.
## Syntax
```
netcfg [/v] [/e] [/winpe] [/l ] /c /i
```
#### Parameters
|Parameter|Description|
|-------|--------|
|/v|Run in **verbose** (detailed) mode|
|/e|Use servicing **environment** variables during install and uninstall|
|/winpe|Installs TCP/IP, NetBIOS and Microsoft Client for Windows preinstallation environment (WinPE)|
|/l|Provides the **location** of INF|
|/c|Provides the **class** of the component to be installed; protocol, Service, or client|
|/i|Provides the component **ID**|
|/s|Provides the type of components to **show**.<p>\ta = adapters, n = net components|
|/b|Displays the **binding paths**, when followed by a string containing the name of the path.|
|/?|Displays **help** at the command prompt.|

## Examples

To install the protocol *example* using c:\oemdir\example.inf:
```
netcfg /l c:\oemdir\example.inf /c p /i example
```
To install the *MS_Server* service:
```
netcfg /c s /i MS_Server
```
To install TCP/IP, NetBIOS and Microsoft Client for Windows preinstallation environment
```
netcfg /v /winpe
```
To display if component *MS_IPX* is installed:
```
netcfg /q MS_IPX
```
To uninstall component *MS_IPX*:
```
netcfg /u MS_IPX
```
To show all installed net components:
```
netcfg /s n
```
To display binding paths containing *MS_TCPIP*:
```
netcfg /b ms_tcpip
```
## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)
