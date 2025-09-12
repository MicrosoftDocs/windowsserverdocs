---
title: AD FS Troubleshooting - Loop Detection
description: This article describes how to troubleshoot loop detection for Active Directory Federation Services (AD FS).
ms.date: 02/13/2024
ms.topic: troubleshooting-general
---

# AD FS troubleshooting: Loop detection

Looping in Active Directory Federation Services (AD FS) occurs when a relying party continuously rejects a valid security token and redirects back to AD FS.

## Loop detection cookie

To prevent this problem from happening, AD FS implemented a loop detection cookie. By default, AD FS writes a cookie to web passive clients named `MSISLoopDetectionCookie`. This cookie holds a timestamp value and a value for the number of tokens issued. This information allows AD FS to keep track of how often and how many times a client visited the federation service within a specific timespan.

If a passive client visits the federation service for a token five times within 20 seconds, AD FS throws the following error:

`MSIS7042: The same client browser session has made '{0}' requests in the last '{1}' seconds. Contact your administrator for details.`

Entering into infinite loops is often caused by a misbehaving relying party application that isn't successfully consuming the token issued by AD FS. The application then sends the passive client back to AD FS, repeatedly, for a new token. AD FS issues the passive client a new token each time, with a limit of five requests within 20 seconds.

## Adjust the loop detection cookie

You can use PowerShell to change the value for the number of tokens issued and the timespan value.

```powershell
Set-AdfsProperties -LoopDetectionMaximumTokensIssuedInterval 5  -LoopDetectionTimeIntervalInSeconds 20
```
The minimum value for `LoopDetectionMaximumTokensIssuedInterval` is 1.

The minimum value for `LoopDetectionTimeIntervalInSeconds` is 5.

You can also disable loop detection when you're doing performance testing.

```powershell
Set-AdfsProperties -EnableLoopDetection $false
```

> [!IMPORTANT]
> Don't disable loop detection permanently because it prevents users from entering into infinite loop states.

## Related content

- [AD FS troubleshooting](ad-fs-tshoot-overview.md)



