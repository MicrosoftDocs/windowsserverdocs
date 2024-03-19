---
title: wdsutil disconnect-client
description: Reference article for the wdsutil disconnect-client command, which disconnects a client from a multicast transmission or namespace.
ms.topic: reference
ms.assetid: 876bbe6c-76ab-4de5-879b-d2066e700326
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil disconnect-client

Disconnects a client from a multicast transmission or namespace. Unless you specify **/Force**, the client will fall back to another transfer method (if it's supported by the client).

## Syntax

```
wdsutil /Disconnect-Client /ClientId:<Client ID> [/Server:<Server name>] [/Force]
```

### Parameters

| Parameter | Description |
|--|--|
| /ClientId:`<ClientID>` | Specifies the ID of the client to be disconnected. To view the ID of a client, run the `wdsutil /get-multicasttransmission /show:clients` command. |
| [/Server:`<Servername>`] | Specifies the name of the server. This can be the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server is used. |
| [/Force] | Stops the installation completely and does not use a fallback method. Because Wdsmcast.exe doesn't support any fallback mechanism, the default behavior is as follows:<ul><li>**If you're using the Windows Deployment Services client:** The client continues the installation by using unicasting.</li><li>**If you aren't using the Windows Deployment Services client:** The installation fails.</li></ul>**Important:** We strongly recommend using this parameter cautiously because if the installation fails, the computer can be left in an unusable state. |

## Examples

To disconnect a client, type:

```
wdsutil /Disconnect-Client /ClientId:1
```

To disconnect a client and force the installation to fail, type:

```
wdsutil /Disconnect-Client /Server:MyWDSServer /ClientId:1 /Force
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wdsutil get-multicasttransmission command](wdsutil-get-multicasttransmission.md)

- [Windows Deployment Services cmdlets](/powershell/module/wds)
