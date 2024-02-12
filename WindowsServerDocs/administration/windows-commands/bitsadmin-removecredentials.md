---
title: bitsadmin removecredentials
description: Reference article for the bitsadmin removecredentials command, which removes credentials from a job.
ms.topic: reference
ms.assetid: 4a78ce9a-1feb-4811-a000-cce81287b22b
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin removecredentials

Removes credentials from a job.

> [!NOTE]
> This command isn't supported by BITS 1.2 and earlier.

## Syntax

```
bitsadmin /removecredentials <job> <target> <scheme>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |
| target | Use either **SERVER** or **PROXY**. |
| scheme | Use one of the following:<ul><li>**BASIC.** Authentication scheme where the user name and password are sent in clear-text to the server or proxy.</li><li>**DIGEST.** A challenge-response authentication scheme that uses a server-specified data string for the challenge.</li><li>**NTLM.** A challenge-response authentication scheme that uses the credentials of the user for authentication in a Windows network environment.</li><li>**NEGOTIATE (also known as the Simple and Protected Negotiation protocol).** A challenge-response authentication scheme that negotiates with the server or proxy to determine which scheme to use for authentication. Examples are the Kerberos protocol and NTLM.</li><li>**PASSPORT.** A centralized authentication service provided by Microsoft that offers a single logon for member sites.</li></ul> |

## Examples

To remove credentials from the job named *myDownloadJob*:

```
bitsadmin /removecredentials myDownloadJob SERVER BASIC
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
