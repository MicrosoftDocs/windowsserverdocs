---
title: bitsadmin util and getieproxy
description: "Windows Commands topic for **bitsadmin util and getieproxy** - Retrieves the proxy usage for the given service account."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6d50c7e3-f4eb-4ca5-9f0c-4ed396087db6
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# bitsadmin util and getieproxy

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Retrieves the proxy usage for the given service account.
## Syntax
```
bitsadmin /Util /GetIEProxy <Account> [/Conn <ConnectionName>]
```
## Parameters
|Parameter|Description|
|-------|--------|
|Account|Specifies the service account whose proxy settings you want to retrieve. Possible values are:<br /><br />-   LOCALSYSTEM<br />-   NETWORKSERVICE<br />-   LOCALSERVICE|
|ConnectionName|Optional used with the **/Conn** command to specify the use of a modem connection. If you do not specify the **/Conn** command, BITS uses the LAN connection. Specify the modem connection name immediately following the **/Conn** parameter.|
## remarks
This command shows the value for each proxy usage, not just the proxy usage you specified for the service account. For details on setting the proxy usage for service accounts, see the [bitsadmin util and setieproxy](bitsadmin-util-and-setieproxy.md) command.
## <a name="BKMK_examples"></a>Examples
The following example displays the proxy usage for the NETWORK SERVICE account.
```
C:\>bitsadmin /Util /GetIEProxy NETWORKSERVICE
```
## additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
