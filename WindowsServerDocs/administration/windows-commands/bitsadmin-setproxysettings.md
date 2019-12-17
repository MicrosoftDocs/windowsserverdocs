---
title: bitsadmin setproxysettings
description: "Windows Commands topic for **bitsadmin setproxysettings** - Sets the proxy settings for the specified job."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: be8edb1b-614e-4d0b-a8f8-64b4bde3e64b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin setproxysettings



Sets the proxy settings for the specified job.

## Syntax

```
bitsadmin /SetProxySettings <Job> <Usage> [List] [Bypass]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|
|Usage|One of the following values:</br>-   PRECONFIG—use the owner's Internet Explorer defaults.</br>-   NO_PROXY—do not use a proxy server.</br>-   OVERRIDE—use an explicit proxy list and bypass list. A proxy and proxy bypass list must follow.</br>-   AUTODETECT—automatically detect proxy settings.|
|List|Used when the *Usage* parameter is set to OVERRIDE—contains a comma-delimited list of proxy servers to use.|
|Bypass|Used when the *Usage* parameter is set to OVERRIDE—contains a space-delimited list of host names or IP addresses, or both, for which transfers are not to be routed through a proxy. This can be **\<local>** to refer to all servers on the same LAN. Values of NULL or "" may be used for an empty proxy bypass list.|

## <a name="BKMK_examples"></a>Examples

The following example sets the proxy settings for the job named *myDownloadJob*.

```
C:\>bitsadmin /SetProxySettings myDownloadJob PRECONFIG
```

Here are some other examples.

```
bitsadmin /setproxysettings myDownloadJob NO_PROXY
bitsadmin /setproxysettings myDownloadJob OVERRIDE proxy1:80 ""
bitsadmin /setproxysettings myDownloadJob OVERRIDE proxy1,proxy2,proxy3 NULL
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)