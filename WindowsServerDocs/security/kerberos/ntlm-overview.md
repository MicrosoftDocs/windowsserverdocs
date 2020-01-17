---
title: NTLM Overview
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: security-kerberos
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 773909fd-c0bc-498a-95fc-bb452ec04d90
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# NTLM Overview

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic for the IT professional describes NTLM, any changes in functionality, and provides links to technical resources to Windows Authentication and NTLM for Windows Server 2012 and previous versions.

## <a name="BKMK_OVER"></a>Feature description
NTLM authentication is a family of authentication protocols that are encompassed in the Windows Msv1\_0.dll. The NTLM authentication protocols include LAN Manager version 1 and 2, and NTLM version 1 and 2. The NTLM authentication protocols authenticate users and computers based on a challenge\/response mechanism that proves to a server or domain controller that a user knows the password associated with an account. When the NTLM protocol is used, a resource server must take one of the following actions to verify the identity of a computer or user whenever a new access token is needed:

-   Contact a domain authentication service on the domain controller for the computer's or user's account domain, if the account is a domain account.

-   Look up the computer's or user's account in the local account database, if the account is a local account.

## <a name="BKMK_APP"></a>Current applications
NTLM authentication is still supported and must be used for Windows authentication with systems configured as a member of a workgroup. NTLM authentication is also used for local logon authentication on non\-domain controllers. Kerberos version 5 authentication is the preferred authentication method for Active Directory environments, but a non\-Microsoft or Microsoft application might still use NTLM.

Reducing the usage of the NTLM protocol in an IT environment requires both the knowledge of deployed application requirements on NTLM and the strategies and steps necessary to configure computing environments to use other protocols. New tools and settings have been added to help you discover how NTLM is used in order to selectively restrict NTLM traffic. For information about how to analyze and restrict NTLM usage in your environments, see [Introducing the Restriction of NTLM Authentication](https://technet.microsoft.com/library/dd560653(v=ws.10).aspx) to access the Auditing and restricting NTLM usage guide.

## <a name="BKMK_NEW"></a>New and changed functionality
There are no changes in functionality for NTLM for  Windows Server 2012 .

## <a name="BKMK_DEP"></a>Removed or deprecated functionality
There is no removed or deprecated functionality for NTLM for  Windows Server 2012 .

## <a name="BKMK_INSTALL"></a>Server Manager information
NTLM cannot be configured from Server Manager. You can use Security Policy settings or Group Policies to manage NTLM authentication usage between computer systems. In a domain, Kerberos is the default authentication protocol.

## <a name="BKMK_LINKS"></a>See also
The following table lists relevant resources for NTLM and other Windows authentication technologies.

|Content type|References|
|--------|-------|
|**Product evaluation**|[Introducing the Restriction of NTLM Authentication](https://technet.microsoft.com/library/dd560653.aspx)<br /><br />[Changes in NTLM Authentication](https://technet.microsoft.com/library/dd566199.aspx)|
|**Planning**|[IT Infrastructure Threat Modeling Guide](https://technet.microsoft.com/library/dd941826.aspx)<br /><br />[Threats and Countermeasures: Security Settings in Windows Server 2003 and Windows XP](https://technet.microsoft.com/library/dd162275.aspx)<br /><br />[Threats and Countermeasures Guide: Security Settings in Windows Server 2008 and Windows Vista](https://technet.microsoft.com/library/dd349791.aspx)<br /><br />[Threats and Countermeasures Guide: Security Settings in Windows Server 2008 R2 and Windows 7](https://technet.microsoft.com/library/hh125921.aspx)|
|**Deployment**|[Extended Protection for Authentication](https://support.microsoft.com/kb/968389)<br /><br />[Auditing and restricting NTLM usage guide](https://technet.microsoft.com/library/jj865674(v=ws.10).aspx)<br /><br />[Ask the Directory Services Team : NTLM Blocking and You: Application Analysis and Auditing Methodologies in Windows 7](https://blogs.technet.com/askds/archive/2009/10/08/ntlm-blocking-and-you-application-analysis-and-auditing-methodologies-in-windows-7.aspx)<br /><br />[Windows Authentication Blog](https://blogs.technet.com/authentication/)<br /><br />[Configuring MaxConcurrentAPI for NTLM pass\-through authentication](https://social.technet.microsoft.com/wiki/contents/articles/9759.configuring-maxconcurrentapi-for-ntlm-pass-through-authentication.aspx)|
|**Development**|[Microsoft NTLM \(Windows\)](https://msdn.microsoft.com/library/aa378749(VS.85).aspx)<br /><br />[\[MS\-NLMP\]: NT LAN Manager \(NTLM\) Authentication Protocol Specification](https://msdn.microsoft.com/library/cc236621(PROT.10).aspx)<br /><br />[\[MS\-NNTP\]: NT LAN Manager \(NTLM\) Authentication: Network News Transfer Protocol \(NNTP\) Extension](https://msdn.microsoft.com/library/cc236774(PROT.10).aspx)<br /><br />[\[MS\-NTHT\]: NTLM Over HTTP Protocol Specification](https://msdn.microsoft.com/library/cc237488(PROT.10).aspx)|
|**Troubleshooting**|Not yet available|
|**Community resources**|[Is this horse dead yet: NTLM Bottlenecks and the RPC runtime](https://blogs.technet.com/b/askds/archive/2011/09/15/is-this-horse-dead-yet-ntlm-bottlenecks-and-the-rpc-runtime.aspx)|



