---
title: bitsadmin setcredentials
description: Reference article for the bitsadmin setcredentials command, which adds credentials to a job.
ms.topic: reference
ms.assetid: 3cd099a4-9e85-46d8-8527-edb6dfab7f97
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin setcredentials

Adds credentials to a job.

> [!NOTE]
> This command isn't supported by BITS 1.2 and earlier.

## Syntax

```
bitsadmin /setcredentials <job> <target> <scheme> <username> <password>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |
| target | Use either **SERVER** or **PROXY**. |
| scheme | Use one of the following:<ul><li>**BASIC.** Authentication scheme where the user name and password are sent in clear-text to the server or proxy.</li><li>**DIGEST.** A challenge-response authentication scheme that uses a server-specified data string for the challenge.</li><li>**NTLM.** A challenge-response authentication scheme that uses the credentials of the user for authentication in a Windows network environment.</li><li>**NEGOTIATE (also known as the Simple and Protected Negotiation protocol).** A challenge-response authentication scheme that negotiates with the server or proxy to determine which scheme to use for authentication. Examples are the Kerberos protocol and NTLM.</li><li>**PASSPORT.** A centralized authentication service provided by Microsoft that offers a single logon for member sites.</li></ul> |
| user_name | The name of the user. |
| password | The password associated with the provided *Username*. |

## Examples

To add credentials to the job named *myDownloadJob*:

```
bitsadmin /setcredentials myDownloadJob SERVER BASIC Edward password20
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
