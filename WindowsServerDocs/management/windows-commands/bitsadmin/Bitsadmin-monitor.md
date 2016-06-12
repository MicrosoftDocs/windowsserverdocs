---
title: bitsadmin monitor
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2c424d27-e011-49c2-b579-a2c235467c39
---
# bitsadmin monitor
Monitors jobs in the transfer queue that the current user owns.

## Syntax

```
bitsadmin /Monitor [/allusers] [/refresh <Seconds>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Allusers|Optional—monitors jobs for all users|
|Refresh|Optional—refreshes the data at an interval specified by *Seconds*. The default refresh interval is five seconds.|

## remarks

-   You must have administrator privileges to use the **Allusers** parameter.

-   Use CTRL\+C to stop the refresh.

## <a name="BKMK_examples"></a>Examples
The following example monitors the transfer queue for jobs owned by the current user and refreshes the information every 60 seconds.

```
C:\>bitsadmin /Monitor /refesh 60
```

## additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


