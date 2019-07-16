---
title: Troubleshooting AD FS
description:  This document describes how to troubleshoot various aspects of AD FS
author: billmath
ms.author: billmath
manager: mtillman
ms.date: 01/12/2018
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: identity-adfs
---

# Troubleshooting AD FS
AD FS has a lot of moving pieces, touches many different things and has many different dependencies.  Naturally, this can give rise to various issues.  This document is designed to get you started on troubleshooting these issues.  This document will introduce you to the typical areas that you should focus on, how to enable features for additional information, and various tools that can be used to track down problems.  

>[!NOTE]
>For additional information see [ADFS Help](http://adfshelp.microsoft.com) which provides effective tools in one place that makes it easier for users and administrators to resolve authentication issues at a quicker pace. 


## What to Check First
Before you dive into in-depth troubleshooting, there are a few things that you should check first.  They are:
- **DNS Configuration** - can you resolve the name of the federation service?  This should resolve to either the load balancer's IP address or the IP address of one of the AD FS servers in your farm.  For more information see [AD FS Troubleshooting - DNS](ad-fs-tshoot-dns.md).
- **AD FS Endpoints** - can you browse to the AD FS endpoints?  By browsing to this you can determine whether or not your AD FS web server is responding to requests.  If you can get to this file, then you know that AD FS is servicing requests over 443 just fine.  For more information see [AD FS Troubleshooting - Endpoints](ad-fs-tshoot-endpoints.md).
- **Idp-Initiated Sign On** - can you log in and authenticate via the Idp-Initiated Sign On page?  You need to ensure that this page was enabled because it is disabled by default.  Use `Set-AdfsProperties -EnableIdPInitiatedSignOn $true` to enable the page.  If you can sign in and authenticate then you know that AD FS is working in this area.  For more information see [AD FS Troubleshooting - SignOn](ad-fs-tshoot-initiatedsignon.md).
  ##  Common Troubleshooting Areas

|Name|Description|
|-----|-----|
|[Event Logging and Auditing](ad-fs-tshoot-logging.md)|Use the Windows Event Logs to view high level and low level information via the Admin and Trace logs.  It can also be used to view security auditing.|
|[SQL Connectivity](ad-fs-tshoot-sql.md)|Information on testing the connectivity between your AD FS servers and the backend SQL databases|
|[Claims Issuance](ad-fs-tshoot-claims-issuance.md)|Information on determining whether AD FS is issuing claims correctly.|
|[Loop Detection](ad-fs-tshoot-loop.md)|Information on determining and preventing users from being bounced back and forth between the Idp and an RP.|
|[Certificates](ad-fs-tshoot-certs.md)|Typcial certificate issues that can arise|
|[Fiddler](ad-fs-tshoot-fiddler.md)|Information on how to install and using Fiddler|
|[WS-Federation with Fiddler](ad-fs-tshoot-fiddler-ws-fed.md)|Detailed Fiddler trace of a WS-Federation interaction|
|[Claim Rules](ad-fs-tshoot-claims-rules.md)|Information on troubleshooting claim rules and their syntax|
|[Integrated Windows Authentication](ad-fs-tshoot-iwa.md)|Information on troubleshooting integrated authentication.|
|[Azure AD](ad-fs-tshoot-azure.md)|Information on troubleshooting AD FS interaction with Azure AD.|
|[AD FS Diagnostics Analyzer](ad-fs-diagnostics-analyzer.md)|AD FS Help Diagnostics Analyzer can help perform basic AD FS checks using the diagnostics PowerShell module. 