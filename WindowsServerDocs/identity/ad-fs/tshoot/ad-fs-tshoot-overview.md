---
title: Troubleshooting AD FS
description:  This document describes how to troubleshoot various aspects of AD FS
author: billmath
ms.author: billmath
manager: mtillman
ms.date: 11/09/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: identity-adfs
---

# Troubleshooting AD FS
AD FS has a lot of moving pieces, touches many different things and has many different dependencies.  Naturally, this can give rise to various issues.  This document is designed to get you started on troubleshooting these issues.  This document will introduce you to the typical areas that you should focus on, how to enable features for additional information, and various tools that can be used to track down problems.  

## What to Check First
Before you dive into in-depth troubleshooting, there are a few things that you should check first.  They are:
- **DNS Configuration** - can you resolve the name of the federation service?  This should resolve to either the load balancer's IP address or the IP address of one of the AD FS servers in your farm.
- **AD FS MetaData** - can you browse to the AD FS metadata file?  This file will be located at something like: https://sts.contoso.com/adfs/ls/FederationMetadata/2007-06/FederationMetadata.xml.  Replace the sts.contoso.com with your URL.  By browsing to this you can determine whether or not your AD FS web server is responding to requests.  If you can get to this file, then you know that AD FS is servicing requests over 443 just fine.
- **AD FS web service URL** - can you browse to one of the AD FS web service URLs such as https://sts.contoso.com/adfs/services/trust/mex?  If you get a response you can determine that the web service is working okay.
- **Idp-Initiated Sign On** - can you log in and authenticate via the Idp-Initiated Sign On page?  You need to ensure that this page was enabled because it is disabled by default.  Use `Set-AdfsProperties -EnableIdPInitiatedSignOn $true` to enable the page.  If you can sign in and authenticate then you know that AD FS is working in this area.
##  Common Troubleshooting Areas

|Name|Description|
|-----|-----|
|[Event Logging and Auditing](event-auditing-ad-fs.md)|Use the Windows Event Logs to view high level and low level information via the Admin and Trace logs.  It can also be used to view security auditing.|
|SQL Connectivity|Information on testing the connectivity between your AD FS servers and the backend SQL databases|
|Token Issuance|Information on determining whether AD FS is issuing tokens correctly.|
|Loop Detection|Information on determing and preventing users from being bounced ack and forth between the Idp and an RP.|
|Certificates|Typcial certificate issues that can arise|
|Fiddler|Information on how to insall and using Fiddler|
|Claim Rules|Information on troubleshooting claim rules and their syntax|
|Integrated Authentication|Information on troubleshooting integrated authentication so users can enjoy a seamless SSO experience.|
|Debug Tracing|Information on enabling WIF and WCF tracing for AD FS|
|Azure AD|Information on troubleshooting AD FS interaction with Azure AD.|