---
title: bitsadmin sethelpertokenflags
description: "Windows Commands topic for **bitsadmin sethelpertokenflags** - Sets the usage flags for a helper token that is associated with a BITS transfer job."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 03/01/2019
---

# bitsadmin sethelpertokenflags

Sets the usage flags for a [helper token](/windows/desktop/bits/helper-tokens-for-bits-transfer-jobs) that is associated with a BITS transfer job.

**BITS 3.0 and earlier**: Not supported.

## Syntax

```
bitsadmin /SetHelperTokenFlags <Job> <Flags>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID.|
|Flags|Possible values include the following. 0x0001&mdash;The helper token is used to open the local file of an upload job, to create or rename the temporary file of a download job, or to create or rename the reply file of an upload-reply job. 0x0002&mdash;The helper token is used to open the remote file of a Server Message Block (SMB) upload or download job, or in response to an HTTP server or proxy challenge for implicit NTLM or Kerberos credentials. You must call `/SetCredentialsJob TargetScheme NULL NULL` to allow the credentials to be sent over HTTP.|

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
