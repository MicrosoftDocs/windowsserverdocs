---
title: Bitsadmin getclientcertificate
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4fc8f408-085e-43a0-9fa8-3d798ef107b1
---
# Bitsadmin getclientcertificate
Retrieves the client certificate from the job.

## Syntax

```
bitsadmin /GetClientCertificate <Job>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|

## <a name="BKMK_examples"></a>Examples
The following example retrieves the client certificate for the job named *myDownloadJob*.

```
C:\>bitsadmin / GetClientCertificate myDownloadJob
```

## Additional references
[Command-Line Syntax Key](../Command-Line-Syntax-Key.md)


