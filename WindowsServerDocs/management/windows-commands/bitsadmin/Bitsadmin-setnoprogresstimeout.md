---
title: bitsadmin setnoprogresstimeout
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7fac50d9-cc6b-46a4-a96f-fab751ee1756
---
# bitsadmin setnoprogresstimeout
Sets the length of time, in seconds, that the service tries to transfer the file after a transient error occurs.

## Syntax

```
bitsadmin /SetNoProgresstimeout <Job> <timeOutvalue>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|
|timeOutvalue|A number represented in seconds.|

## remarks

-   The no progress timeout interval begins when the job encounters a transient error.

-   The timeout interval stops or resets when a byte of data is successfully transferred.

-   if no progress timeout interval exceeds the *timeOutvalue*, then the job is placed in a fatal error state.

## <a name="BKMK_examples"></a>Examples
The following example sets the no progress time out value for the job named *myDownloadJob* to 20 seconds

```
C:\>bitsadmin /SetNoProgresstimeout myDownloadJob 20
```

## additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


