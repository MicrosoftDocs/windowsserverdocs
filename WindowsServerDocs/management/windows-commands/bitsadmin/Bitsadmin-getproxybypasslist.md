---
title: Bitsadmin getproxybypasslist
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 50959be3-7014-4bc9-9a7b-68f1ff94a94a
---
# Bitsadmin getproxybypasslist
Retrieves the proxy bypass list for the specified job.

## Syntax

```
bitsadmin /GetProxyBypassList <Job>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|

## Remarks

-   The bypass list contains the host names or IP addresses, or both, that are not to be routed through a proxy. The list can contain "<local>" to refer to all servers on the same LAN. The list can be semicolon or space\-delimited.

## <a name="BKMK_examples"></a>Examples
The following example retrieves the proxy bypass list for the job named *myDownloadJob*.

```
C:\>bitsadmin /GetProxyBypassList myDownloadJob
```

## Additional references
[Command-Line Syntax Key](../Command-Line-Syntax-Key.md)


