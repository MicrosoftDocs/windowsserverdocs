---
title: bitsadmin util and setieproxy
description: Reference article for the bitsadmin util and setieproxy command, which sets the proxy settings to use when transferring files using a service account.
ms.topic: reference
ms.assetid: 0e9f31ba-3070-4ffd-a94c-388c8d78f688
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin util and setieproxy

Set the proxy settings to use when transferring files using a service account. You must run this command from an elevated command prompt for it to complete successfully.

> [!NOTE]
> This command isn't supported by BITS 1.5 and earlier.

## Syntax

```
bitsadmin /util /setieproxy <account> <usage> [/conn <connectionname>]
```

### Parameters

| Parameter | Description |
| --------- | ---------- |
| account | Specifies the service account whose proxy settings you want to define. Possible values include:<ul><li>LOCALSYSTEM</li><li>   NETWORKSERVICE</li><li>LOCALSERVICE.</li></ul> |
| usage | Specifies the form of proxy detection to use. Possible values include:<ul><li>**NO_PROXY.** Don't use a proxy server.</li><li>**AUTODETECT.** Automatically detect the proxy settings.</li><li>**MANUAL_PROXY.** Use a specified proxy list and bypass list. You must specify your lists immediately after the usage tag. For example, `MANUAL_PROXY proxy1,proxy2 NULL`.<ul><li>**Proxy list.** A comma-delimited list of proxy servers to use.</li><li>**Bypass list.** A space-delimited list of host names or IP addresses, or both, for which transfers are not to be routed through a proxy. This can be \<local> to refer to all servers on the same LAN. Values of NULL or  may be used for an empty proxy bypass list.</li></ul><li>**AUTOSCRIPT.** Same as **AUTODETECT**, except it also runs a script. You must specify the script URL immediately after the usage tag. For example, `AUTOSCRIPT http://server/proxy.js`.</li><li>**RESET.** Same as **NO_PROXY**, except it removes the manual proxy URLs (if specified) and any URLs discovered using automatic detection.</li></ul> |
| connectionname | Optional. Used with the **/conn** parameter to specify which modem connection to use. If you don't specify the **/conn** parameter, BITS uses the LAN connection. |

### Remarks

Each successive call using this switch replaces the previously specified usage, but not the parameters of the previously defined usage. For example, if you specify **NO_PROXY**, **AUTODETECT**, and **MANUAL_PROXY** on separate calls, BITS uses the last supplied usage, but keeps the parameters from the previously defined usage.

## Examples

To set the proxy usage for the LOCALSYSTEM account:

```
bitsadmin /util /setieproxy localsystem AUTODETECT
```

```
bitsadmin /util /setieproxy localsystem MANUAL_PROXY proxy1,proxy2,proxy3 NULL
```

```
bitsadmin /util /setieproxy localsystem MANUAL_PROXY proxy1:80
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin util command](bitsadmin-util.md)

- [bitsadmin command](bitsadmin.md)
