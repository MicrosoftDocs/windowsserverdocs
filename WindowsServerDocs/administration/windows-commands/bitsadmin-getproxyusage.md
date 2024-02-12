---
title: bitsadmin getproxyusage
description: Reference article for the bitsadmin getproxyusage command, which retrieves the proxy usage setting for the specified job.
ms.topic: reference
ms.assetid: f940a70e-3b02-497e-a47f-b37b905c299e
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin getproxyusage

Retrieves the proxy usage setting for the specified job.

## Syntax

```
bitsadmin /getproxyusage <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

#### Output

The returned proxy usage values can be:

- **Preconfig** - Use the owner's Internet Explorer defaults.

- **No_Proxy** - Don't use a proxy server.

- **Override** - Use an explicit proxy list.

- **Autodetect** - Automatically detect the proxy settings.

## Examples

To retrieve the proxy usage for the job named *myDownloadJob*:

```
bitsadmin /getproxyusage myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
