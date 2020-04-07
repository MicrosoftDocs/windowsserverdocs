---
title: bitsadmin getproxyusage
description: Windows Commands topic for **bitsadmin getproxyusage**, which retrieves the proxy usage setting for the specified job.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: f940a70e-3b02-497e-a47f-b37b905c299e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
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

## Remarks

The proxy usage values include:

- **Preconfig** - Use the owner's Internet Explorer defaults.

- **No_Proxy** - Don't use a proxy server.

- **Override** - Use an explicit proxy list.

- **Autodetect** - Automatically detect the proxy settings.

## <a name=BKMK_examples></a>Examples

The following example retrieves the proxy usage for the job named *myDownloadJob*.

```
C:\>bitsadmin /getproxyusage myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)