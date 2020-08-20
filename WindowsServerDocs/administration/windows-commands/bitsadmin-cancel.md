---
title: bitsadmin cancel
description: Reference article for the bitsadmin cancel command, which removes the job from the transfer queue and deletes all temporary files associated with the job.
ms.topic: article
ms.assetid: 7374b544-6a16-4d3e-872c-dcf4c02ad89d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin cancel

Removes the job from the transfer queue and deletes all temporary files associated with the job.

## Syntax

```
bitsadmin /cancel <job>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| job | The job's display name or GUID. |

## Examples

To remove the *myDownloadJob* job from the transfer queue:

```
bitsadmin /cancel myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
