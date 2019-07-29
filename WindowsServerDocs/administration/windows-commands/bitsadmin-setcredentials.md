---
title: bitsadmin setcredentials
description: "Windows Commands topic for **bitsadmin setcredentials** - adds credentials to a job."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3cd099a4-9e85-46d8-8527-edb6dfab7f97
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin setcredentials

Adds credentials to a job.

**BITS 1.2 and earlier**: Not supported.

## Syntax

```
bitsadmin /SetCredentials <Job> <Target> <Scheme> <Username> <Password>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|
|Target|SERVER or PROXY|
|Scheme|One of the following:</br>-   BASIC—authentication scheme in which the user name and password are sent in clear-text to the server or proxy.</br>-   DIGEST—a challenge-response authentication scheme that uses a server-specified data string for the challenge.</br>-   NTLM—a challenge-response authentication scheme that uses the credentials of the user for authentication in a Windows network environment.</br>-   NEGOTIATE—also known as the Simple and Protected Negotiation protocol (Snego) is a challenge-response authentication scheme that negotiates with the server or proxy to determine which scheme to use for authentication. Examples are the Kerberos protocol and NTLM.</br>-   PASSPORT—a centralized authentication service provided by Microsoft that offers a single logon for member sites.|
|Username|The name of the provided credentials|
|Password|The password associated with the provided *Username*|

## <a name="BKMK_examples"></a>Examples

The following example Adds credentials to the job named *myDownloadJob*.
```
C:\>bitsadmin /RemoveCredentials myDownloadJob SERVER BASIC Edward Password20
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)