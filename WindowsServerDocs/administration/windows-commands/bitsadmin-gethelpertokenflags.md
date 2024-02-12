---
title: bitsadmin gethelpertokenflags
description: Reference article for the bitsadmin gethelpertokenflags command, which returns the usage flags for a helper token that is associated with a BITS transfer job.
ms.topic: reference
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 03/01/2019
---

# bitsadmin gethelpertokenflags

Returns the usage flags for a [helper token](/windows/win32/bits/helper-tokens-for-bits-transfer-jobs) that is associated with a BITS transfer job.

> [!NOTE]
> This command isn't supported by BITS 3.0 and earlier.

## Syntax

```
bitsadmin /gethelpertokenflags <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

### Remarks

Possible return values, including:

- **0x0001.** The helper token is used to open the local file of an upload job, to create or rename the temporary file of a download job, or to create or rename the reply file of an upload-reply job.

- **0x0002.** The helper token is used to open the remote file of a Server Message Block (SMB) upload or download job, or in response to an HTTP server or proxy challenge for implicit NTLM or Kerberos credentials. You must call `/SetCredentialsJob TargetScheme NULL NULL` to allow the credentials to be sent over HTTP.

## Examples

To retrieve the usage flags for a helper token associated with a BITS transfer job named *myDownloadJob*:

```
bitsadmin /gethelpertokenflags myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
