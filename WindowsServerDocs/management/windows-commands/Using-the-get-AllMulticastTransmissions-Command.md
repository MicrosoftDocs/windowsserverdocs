---
title: Using the get-AllMulticastTransmissions Command
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 95b8fb79-7a8a-4f0c-88f4-92bc1111c67f
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Using the get-AllMulticastTransmissions Command

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Displays information about all multicast transmissions on a server.
## Syntax
For Windows Server 2008:
```
WDSUTIL /Get-AllMulticastTransmissions [/Server:<Server name>] [/Show:Clients] [/ExcludeDeletePending]
```
For Windows Server 2008 R2:
```
WDSUTIL /Get-AllMulticastTransmissions [/Server:<Server name>] [/Show:{Boot | Install | All}] [/Details:Clients]  [/ExcludeDeletePending]
```
## Parameters
|Parameter|Explanation|
|-------------|---------------|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
|[/Show]|**Windows Server 2008**<br /><br />/Show:Clients - Displays information about client computers that are connected to the multicast transmissions.<br /><br />**Windows Server 2008 R2**<br /><br />Show: {Boot &#124; Install &#124; All} - The type of image to return.                                **Boot** returns only boot image transmissions.                                  **Install** returns only install image                                 transmissions. **All** returns both image                                 types.|
|||
|/Details:clients|Only supported for Windows Server 2008 R2. If present, clients that are connected to                              the transmission will be displayed.|
|[/ExcludeDeletePending]|Excludes any deactivated transmissions from the list.|
## <a name="BKMK_examples"></a>Examples
To view information about all transmissions, type:
-   Windows Server 2008: `WDSUTIL /Get-AllMulticastTransmissions`
-   Windows Server 2008 R2: `WDSUTIL /Get-AllMulticastTransmissions /Show:All`
To view information about all transmissions except deactivated transmissions, type:
-   Windows Server 2008: `WDSUTIL /Get-AllMulticastTransmissions /Server:MyWDSServer /Show:Clients /ExcludeDeletePending`
-   Windows Server 2008 R2: `WDSUTIL /Get-AllMulticastTransmissions /Server:MyWDSServer /Show:All /Details:Clients /ExcludeDeletePending`
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Using the get-MulticastTransmission Command](Using-the-get-MulticastTransmission-Command.md)
[Using the new-MulticastTransmission Command](Using-the-new-MulticastTransmission-Command.md)
[Using the remove-MulticastTransmission Command](Using-the-remove-MulticastTransmission-Command.md)
[Subcommand: start-MulticastTransmission](Subcommand--start-MulticastTransmission.md)
