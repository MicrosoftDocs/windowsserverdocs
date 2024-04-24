---
title: bitsadmin setproxysettings
description: Reference article for the bitsadmin setproxysettings command, which sets the proxy settings for the specified job.
ms.topic: reference
ms.assetid: be8edb1b-614e-4d0b-a8f8-64b4bde3e64b
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin setproxysettings

Sets the proxy settings for the specified job.

## Syntax

```
bitsadmin /setproxysettings <job> <usage> [list] [bypass]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| job | The job's display name or GUID. |
| usage | Sets the proxy usage, including:<ul><li>**PRECONFIG.** Use the owner's Internet Explorer defaults.</li><li>**NO_PROXY.** Don't use a proxy server.</li><li>**OVERRIDE.** Use an explicit proxy list and bypass list. The proxy list and proxy bypass information must follow.</li><li>**AUTODETECT.** Automatically detects proxy settings.</li></ul> |
| list | Used when the *Usage* parameter is set to OVERRIDE. Must contain a comma-delimited list of proxy servers to use. |
| bypass | Used when the *Usage* parameter is set to OVERRIDE. Must contain a space-delimited list of host names or IP addresses, or both, for which transfers are not to be routed through a proxy. This can be `<local>` to refer to all servers on the same LAN. Values of NULL may be used for an empty proxy bypass list. |

## Examples

To set the proxy settings using the various usage options for the job named *myDownloadJob*:

```
bitsadmin /setproxysettings myDownloadJob PRECONFIG
```

```
bitsadmin /setproxysettings myDownloadJob NO_PROXY
```
```
bitsadmin /setproxysettings myDownloadJob OVERRIDE proxy1:80
```

```
bitsadmin /setproxysettings myDownloadJob OVERRIDE proxy1,proxy2,proxy3 NULL
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
