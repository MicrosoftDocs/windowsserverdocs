---
title: bitsadmin sethelpertoken
description: "Windows Commands topic for **bitsadmin sethelpertoken** - Sets the current command prompt's primary token (or an arbitrary local user account's token, if specified) as a BITS transfer job's helper token."
ms.custom: na
ms.prod: windows-server-threshold
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

# bitsadmin sethelpertoken

Sets the current command prompt's primary token (or an arbitrary local user account's token, if specified) as a BITS transfer job's [helper token](/windows/desktop/bits/helper-tokens-for-bits-transfer-jobs).

**BITS 3.0 and earlier**: Not supported.

## Syntax

```
bitsadmin /SetHelperToken <Job> [\<username@domain\> \<password\>]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID.|
|\<username@domain\> \<password\>|Optional&mdash;The credentials of a local user account whose token to use.|

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
