---
title: bitsadmin monitor
description: Reference article for the bitsadmin monitor command, which monitors jobs in the transfer queue that are owned by the current user.
ms.topic: reference
ms.assetid: 2c424d27-e011-49c2-b579-a2c235467c39
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin monitor

Monitors jobs in the transfer queue that are owned by the current user.

## Syntax

```
bitsadmin /monitor [/allusers] [/refresh <seconds>]
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| /allusers | Optional. Monitors jobs for all users. You must have administrator privileges to use this parameter. |
| /refresh | Optional. Refreshes the data at an interval specified by `<seconds>`. The default refresh interval is five seconds. To stop the refresh, press CTRL+C. |

## Examples

To monitor the transfer queue for jobs owned by the current user and refreshes the information every 60 seconds.

```
bitsadmin /monitor /refresh 60
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
