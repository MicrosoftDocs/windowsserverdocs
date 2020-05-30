---
title: get-AllMulticastTransmissions
description: Reference topic for get-AllMulticastTransmissions, which displays information about all multicast transmissions on a server. 
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 95b8fb79-7a8a-4f0c-88f4-92bc1111c67f
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# get-AllMulticastTransmissions

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays information about all multicast transmissions on a server.

## Syntax
for Windows Server 2008:
```
wdsutil /Get-AllMulticastTransmissions [/Server:<Server name>] [/Show:Clients] [/ExcludedeletePending]
```
for Windows Server 2008 R2:
```
wdsutil /Get-AllMulticastTransmissions [/Server:<Server name>] [/Show:{Boot | Install | All}] [/details:Clients]  [/ExcludedeletePending]
```
### Parameters

|        Parameter        |                                                                                                                                                                                                                                                                   Explanation                                                                                                                                                                                                                                                                    |
|-------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [/Server:<Server name>] |                                                                                                                                                                                 Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.                                                                                                                                                                                  |
|         [/Show]         | **Windows Server 2008**<p>/Show:Clients - Displays information about client computers that are connected to the multicast transmissions.<p>**Windows Server 2008 R2**<p>Show: {Boot &#124; Install &#124; All} - The type of image to return.                                **Boot** returns only boot image transmissions.                                  **Install** returns only install image                                 transmissions. **All** returns both image                                 types. |
|                         |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|    /details:clients     |                                                                                                                                                                                              Only supported for Windows Server 2008 R2. If present, clients that are connected to                              the transmission will be displayed.                                                                                                                                                                                               |
| [/ExcludedeletePending] |                                                                                                                                                                                                                                              Excludes any deactivated transmissions from the list.                                                                                                                                                                                                                                               |

## Examples
To view information about all transmissions, type:
- Windows Server 2008: `wdsutil /Get-AllMulticastTransmissions`
- Windows Server 2008 R2: `wdsutil /Get-AllMulticastTransmissions /Show:All`
  To view information about all transmissions except deactivated transmissions, type:
- Windows Server 2008: `wdsutil /Get-AllMulticastTransmissions /Server:MyWDSServer /Show:Clients /ExcludedeletePending`
- Windows Server 2008 R2: `wdsutil /Get-AllMulticastTransmissions /Server:MyWDSServer /Show:All /details:Clients /ExcludedeletePending`
  ## Additional References
  - [Command-Line Syntax Key](command-line-syntax-key.md)
  [Using the get-MulticastTransmission Command](using-the-get-multicasttransmission-command.md)
  [Using the new-MulticastTransmission Command](using-the-new-multicasttransmission-command.md)
  [Using the remove-MulticastTransmission Command](using-the-remove-multicasttransmission-command.md)
  [Subcommand: start-MulticastTransmission](subcommand-start-multicasttransmission.md)
