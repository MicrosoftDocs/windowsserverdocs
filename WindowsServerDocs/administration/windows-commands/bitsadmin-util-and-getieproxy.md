---
title: bitsadmin util and getieproxy
description: Reference article for the bitsadmin util and getieproxy command, which retrieves the proxy usage for the given service account.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---
# bitsadmin util and getieproxy



Retrieves the proxy usage for the given service account. This command shows the value for each proxy usage, not just the proxy usage you specified for the service account. For details about setting the proxy usage for specific service accounts, see the [bitsadmin util and setieproxy](bitsadmin-util-and-setieproxy.md) command.

## Syntax

```
bitsadmin /util /getieproxy <account> [/conn <connectionname>]
```

### Parameters

| Parameter | Description |
| --------- | ---------- |
| account | Specifies the service account whose proxy settings you want to retrieve. Possible values include:<ul><li>LOCALSYSTEM</li><li>   NETWORKSERVICE</li><li>LOCALSERVICE.</li></ul> |
| connectionname | Optional. Used with the **/conn** parameter to specify which modem connection to use. If you don't specify the **/conn** parameter, BITS uses the LAN connection. |

## Examples

To display the proxy usage for the NETWORK SERVICE account:

```
bitsadmin /util /getieproxy NETWORKSERVICE
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin util command](bitsadmin-util.md)

- [bitsadmin command](bitsadmin.md)
