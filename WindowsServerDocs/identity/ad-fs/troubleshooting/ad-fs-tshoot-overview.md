---
title: Troubleshoot AD FS
description: Learn about the strategies and tools that you can use to diagnose and troubleshoot various aspects of Active Directory Federation Services.
ms.date: 05/19/2023
ms.topic: troubleshooting-general
---

# Troubleshoot AD FS

Active Directory Federation Services (AD FS) has many moving pieces, touches many different things, and has many different dependencies. This complexity can give rise to various issues. This article helps to get you started on troubleshooting these issues. It introduces you to the common areas where you should focus, how to enable features for more information, and the various tools to track down problems.

## What to check first

Before you dive into in-depth troubleshooting, check these things first:

- **Domain Name System (DNS) configuration**: Can you resolve the name of the federation service? This connection should resolve to either the load balancer's IP address or the IP address of one of the AD FS servers in your farm. For more information, see [AD FS troubleshooting: DNS](ad-fs-tshoot-dns.md).
- **AD FS endpoints**: Can you browse to the AD FS endpoints? Browsing to this endpoint can determine whether or not your AD FS web server is responding to requests. If you can get to this file, you know that AD FS is servicing requests over 443. For more information, see [AD FS troubleshooting: AD FS metadata endpoints](ad-fs-tshoot-endpoints.md).
- **Identity Provider (IdP)-initiated sign-in**: Can you sign in and authenticate via the IdP-initiated sign-in page? Ensure that this page is enabled because it's disabled by default. Use `Set-AdfsProperties -EnableIdPInitiatedSignOn $true` to enable the page. If you can sign in and authenticate, you know that AD FS is working in this area. For more information, see [AD FS troubleshooting: IdP-initiated sign-in](ad-fs-tshoot-initiatedsignon.md).

## Common troubleshooting areas

|Name|Description|
|-----|-----|
|[Events and logging](ad-fs-tshoot-logging.md)|Use Windows Event Logs to view high-level and low-level information via the admin and trace logs. You can also use logs to view security auditing.|
|[SQL connectivity](ad-fs-tshoot-sql.md)|Information on how to test the connectivity between your AD FS servers and the back-end SQL databases.|
|[Claims issuance](ad-fs-tshoot-claims-issuance.md)|Information on how to determine whether AD FS is issuing claims correctly.|
|[Loop detection](ad-fs-tshoot-loop.md)|Information on how to determine and prevent users from being bounced back and forth between the IdP and a relying party.|
|[Certificates](ad-fs-tshoot-certs.md)|Typical certificate issues that can arise.|
|[Fiddler](ad-fs-tshoot-fiddler.md)|Information on how to install and use Fiddler.|
|[WS-Federation with Fiddler](ad-fs-tshoot-fiddler-ws-fed.md)|Detailed Fiddler trace of a WS-Federation interaction.|
|[Claim rules syntax](ad-fs-tshoot-claims-rules.md)|Information on how to troubleshoot claim rules and their syntax.|
|[Integrated Windows Authentication](ad-fs-tshoot-iwa.md)|Information on how to troubleshoot integrated authentication.|
|[Microsoft Entra ID](ad-fs-tshoot-azure.md)|Information on how to troubleshoot AD FS interaction with Microsoft Entra ID.|
