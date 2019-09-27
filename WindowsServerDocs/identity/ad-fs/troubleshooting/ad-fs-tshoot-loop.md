---
title: AD FS Troubleshooting - Loop Detection
description:  This document describes how to troubleshoot loop detection
author: billmath
ms.author: billmath
manager: mtillman
ms.date: 02/21/2017
ms.topic: article
ms.prod: windows-server
ms.technology: identity-adfs
---

# AD FS Troubleshooting - Loop Detection 
 
Looping in AD FS occurs when a relying party continuously rejects a valid security token and redirects back to AD FS.

## Loop detection cookie
To prevent this from happening, AD FS has implemented what is called a loop detection cookie. By default, AD FS writes a cookie to web passive clients named **MSISLoopDetectionCookie**. This cookie holds a timestamp value and a number of tokens issued value.  This allows AD FS to keep track of how often and how many times a client has visited the Federation Service within a specific timespan.

If a passive client visits the Federation Service for a token five (5) times within 20 seconds, AD FS throws the following error:

**MSIS7042: The same client browser session has made '{0}' requests in the last '{1}' seconds. Contact your administrator for details.**

Entering into infinite loops is often caused by a misbehaving relying party application that is not successfully consuming the token issued by AD FS, and the application is sending the passive client back to AD FS, repeatedly, for a new token.  AD FS is will issue the passive client a new token each time, as long as they do not exceed 5 requests within 20 seconds. 

## Adjusting the loop detection cookie
You can use PowerShell to change the number of tokens issued value and the timespan value.

```powershell
Set-AdfsProperties -LoopDetectionMaximumTokensIssuedInterval 5  -LoopDetectionTimeIntervalInSeconds 20
```
The minimum value for **LoopDetectionMaximumTokensIssuedInterval** is 1.

The minimum value for **LoopDetectionTimeIntervalInSeconds** is 5.

You can also disable loop detection when you are doing performance testing.

```powershell
Set-AdfsProperties -EnableLoopDetection $false
```

>[!IMPORTANT]
>It is not recommend to permanently disable loop detection as this prevents users from entering into infinite loop states.


## Next Steps

- [AD FS Troubleshooting](ad-fs-tshoot-overview.md)



