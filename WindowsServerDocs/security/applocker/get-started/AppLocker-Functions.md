---
title: AppLocker Functions
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b65420d2-07bd-4955-a267-88313845d0e7
---
# AppLocker Functions
This topic for the IT professional lists the functions and security levels for the Software Restriction Policies \(SRP\) and AppLocker features.

## Functions
The following list includes the SRP functions beginning with Windows Server 2003 and AppLocker functions beginning with [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] and links to current documentation on MSDN:

-   [SaferGetPolicyInformation Function](http://go.microsoft.com/fwlink/?LinkId=159781) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=159781\)

-   [SaferCreateLevel Function](http://go.microsoft.com/fwlink/?LinkId=159782) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=159782\)

-   [SaferCloseLevel Function](http://go.microsoft.com/fwlink/?LinkId=159783) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=159783\)

-   [SaferIdentifyLevel Function](http://go.microsoft.com/fwlink/?LinkId=159784) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=159784\)

-   [SaferComputeTokenFromLevel Function](http://go.microsoft.com/fwlink/?LinkId=159785) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=159785\)

-   [SaferGetLevelInformation Function](http://go.microsoft.com/fwlink/?LinkId=159787) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=159787\)

-   [SaferRecordEventLogEntry Function](http://go.microsoft.com/fwlink/?LinkId=159789) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=159789\)

-   [SaferiIsExecutableFileType Function](http://go.microsoft.com/fwlink/?LinkId=159790) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=159790\)

## Security level ID
AppLocker and SRP use the security level IDs to stipulate the access requirements to files listed in policies. The following table shows those security levels supported in SRP and AppLocker.

|Security level ID|SRP|AppLocker|
|---------------------|-------|-------------|
|SAFER\_LEVELID\_FULLYTRUSTED|Supported|Supported|
|SAFER\_LEVELID\_NORMALUSER|Supported|Not supported|
|SAFER\_LEVELID\_CONSTRAINED|Supported|Not supported|
|SAFER\_LEVELID\_UNTRUSTED|Supported|Not supported|
|SAFER\_LEVELID\_DISALLOWED|Supported|Supported|

In addition, URL zone ID is not supported in AppLocker.

## See Also
[AppLocker Technical Reference](AppLocker-Technical-Reference.md)


