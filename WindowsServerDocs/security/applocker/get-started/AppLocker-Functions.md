---
title: AppLocker Functions
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b65420d2-07bd-4955-a267-88313845d0e7
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# AppLocker Functions

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic for the IT professional lists the functions and security levels for the Software Restriction Policies (SRP) and AppLocker features.

## Functions
The following list includes the SRP functions beginning with Windows Server 2003 and AppLocker functions beginning with  Windows Server 2008 R2  and links to current documentation on MSDN:

-   [SaferGetPolicyInformation Function](http://go.microsoft.com/fwlink/?LinkId=159781) (http://go.microsoft.com/fwlink/?LinkId=159781)

-   [SaferCreateLevel Function](http://go.microsoft.com/fwlink/?LinkId=159782) (http://go.microsoft.com/fwlink/?LinkId=159782)

-   [SaferCloseLevel Function](http://go.microsoft.com/fwlink/?LinkId=159783) (http://go.microsoft.com/fwlink/?LinkId=159783)

-   [SaferIdentifyLevel Function](http://go.microsoft.com/fwlink/?LinkId=159784) (http://go.microsoft.com/fwlink/?LinkId=159784)

-   [SaferComputeTokenFromLevel Function](http://go.microsoft.com/fwlink/?LinkId=159785) (http://go.microsoft.com/fwlink/?LinkId=159785)

-   [SaferGetLevelInformation Function](http://go.microsoft.com/fwlink/?LinkId=159787) (http://go.microsoft.com/fwlink/?LinkId=159787)

-   [SaferRecordEventLogEntry Function](http://go.microsoft.com/fwlink/?LinkId=159789) (http://go.microsoft.com/fwlink/?LinkId=159789)

-   [SaferiIsExecutableFileType Function](http://go.microsoft.com/fwlink/?LinkId=159790) (http://go.microsoft.com/fwlink/?LinkId=159790)

## Security level ID
AppLocker and SRP use the security level IDs to stipulate the access requirements to files listed in policies. The following table shows those security levels supported in SRP and AppLocker.

|Security level ID|SRP|AppLocker|
|-----------|----|-------|
|SAFER_LEVELID_FULLYTRUSTED|Supported|Supported|
|SAFER_LEVELID_NORMALUSER|Supported|Not supported|
|SAFER_LEVELID_CONSTRAINED|Supported|Not supported|
|SAFER_LEVELID_UNTRUSTED|Supported|Not supported|
|SAFER_LEVELID_DISALLOWED|Supported|Supported|

In addition, URL zone ID is not supported in AppLocker.

## See Also
[AppLocker Technical Reference](applocker-technical-reference.md)


