---
title: Troubleshoot AD FS
description: Learn about the strategies and tools you can use to diagnose and troubleshoot various aspects of AD FS.
author: billmath
ms.author: wscontent
manager: amycolannino
ms.date: 05/19/2023
ms.topic: article
---

# Troubleshoot AD FS

Active Directory Federation Services (AD FS) has many moving pieces, touches many different things and has many different dependencies. Naturally, this complexity can give rise to various issues. This article is designed to get you started on troubleshooting these issues. It introduces you to the common areas that you should focus on, how to enable features for additional information, and various tools to track down problems.

> [!NOTE]
> For more information, see [AD FS help](https://adfshelp.microsoft.com), which provides effective tools in one place that make it easier for users and administrators to resolve authentication issues at a quicker pace.

## What to check first

Before you dive into in-depth troubleshooting, there are a few things that you should check first. They are:

- **DNS Configuration** - Can you resolve the name of the federation service? This connection should resolve to either the load balancer's IP address or the IP address of one of the AD FS servers in your farm. For more information, see [AD FS troubleshooting - DNS](ad-fs-tshoot-dns.md).
- **AD FS Endpoints** - Can you browse to the AD FS endpoints? Browsing to this endpoint can determine whether or not your AD FS web server is responding to requests. If you can get to this file, then you know that AD FS is servicing requests over 443 fine. For more information, see [AD FS Troubleshooting - AD FS metadata endpoints](ad-fs-tshoot-endpoints.md).
- **Idp-Initiated Sign On** - Can you sign in and authenticate via the idP-initiated sign on page? You need to ensure that this page is enabled, because it's disabled by default. Use `Set-AdfsProperties -EnableIdPInitiatedSignOn $true` to enable the page. If you can sign in and authenticate, then you know that AD FS is working in this area. For more information, see [AD FS troubleshooting - idP-Initiated Sign On](ad-fs-tshoot-initiatedsignon.md).

## Common troubleshooting areas

|Name|Description|
|-----|-----|
|[Events and logging](ad-fs-tshoot-logging.md)|Use the Windows Event Logs to view high level and low level information via the admin and trace logs. It can also be used to view security auditing.|
|[SQL connectivity](ad-fs-tshoot-sql.md)|Information on testing the connectivity between your AD FS servers and the backend SQL databases.|
|[Claims issuance](ad-fs-tshoot-claims-issuance.md)|Information on determining whether AD FS is issuing claims correctly.|
|[Loop detection](ad-fs-tshoot-loop.md)|Information on determining and preventing users from being bounced back and forth between the Identity Provider (idP) and a Relying Party (RP).|
|[Certificates](ad-fs-tshoot-certs.md)|Typical certificate issues that can arise.|
|[Fiddler](ad-fs-tshoot-fiddler.md)|Information on how to install and use Fiddler.|
|[WS-Federation with Fiddler](ad-fs-tshoot-fiddler-ws-fed.md)|Detailed Fiddler trace of a WS-Federation interaction.|
|[Claim rules syntax](ad-fs-tshoot-claims-rules.md)|Information on troubleshooting claim rules and their syntax.|
|[Integrated Windows authentication](ad-fs-tshoot-iwa.md)|Information on troubleshooting integrated authentication.|
|[Microsoft Entra ID](ad-fs-tshoot-azure.md)|Information on troubleshooting AD FS interaction with Microsoft Entra ID.|
|[AD FS Diagnostics Analyzer](ad-fs-diagnostics-analyzer.md)|AD FS Help Diagnostics Analyzer performs basic AD FS checks by using the diagnostics PowerShell module.|
