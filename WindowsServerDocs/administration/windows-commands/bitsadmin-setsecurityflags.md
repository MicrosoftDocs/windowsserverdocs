---
title: bitsadmin setsecurityflags
description: Windows Commands topic for **bitsadmin setsecurityflags**, which sets security flags for HTTP to determine if BITS should check the certificate revocation list, ignore certain certificate errors, and define the policy to use when a server redirects the HTTP request.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 0da5cbf5-5f7f-4833-bbbe-c4e8379a78ab
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin setsecurityflags

Sets security flags for HTTP to determine if BITS should check the certificate revocation list, ignore certain certificate errors, and define the policy to use when a server redirects the HTTP request. The value is an unsigned integer.

## Syntax

```
bitsadmin /setsecurityflags <job> <value>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |
| value | Can include one or more of the following notification flags, including:<ul><li>Set the least significant bit to enable CRL Check.</li><li>Set the 2nd bit from the right to ignore incorrect common names in the server certificate.</li><li>Set the 3rd bit from the right to ignore incorrect dates in the server certificate.</li><li>Set the 4th bit from the right to ignore incorrect certification authorities in the server certificate.</li><li>Set the 5th bit from the right to ignore incorrect usage of the server certificate.</li><li>Set the 9th through the 11th bits from the right to implement your specified redirection policy, including:<ul><li>**0,0,0.** Redirects are automatically allowed.</li><li>**0,0,1.** Remote name in the **IBackgroundCopyFile** interface is updated if a redirect occurs.</li><li>**0,1,0.** BITS fails the job if a redirect occurs.</li></ul></li><li>Set the 12th bit from the right to allow redirection from HTTPS to HTTP.</li></ul> |

## Examples

The following example sets the security flags to enable a CRL check for the job named *myDownloadJob*.

```
C:\>bitsadmin /setsecurityflags myDownloadJob 0x0001
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)