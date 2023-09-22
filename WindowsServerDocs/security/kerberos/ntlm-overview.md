---
title: NTLM Overview
description: Learn about NTLM, any changes in functionality, and find links to technical resources to Windows Authentication and NTLM for Windows Server.
ms.topic: article
ms.assetid: 773909fd-c0bc-498a-95fc-bb452ec04d90
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 09/21/2023
---
# NTLM Overview

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

This topic for the IT professional describes NTLM, any changes in functionality, and provides links to technical resources to Windows Authentication and NTLM for Windows Server.

## <a name="BKMK_OVER"></a>Feature description
NTLM authentication is a family of authentication protocols that are encompassed in the Windows Msv1\_0.dll. The NTLM authentication protocols include LAN Manager version 1 and 2, and NTLM version 1 and 2. The NTLM authentication protocols authenticate users and computers based on a challenge\/response mechanism that proves to a server or domain controller that a user knows the password associated with an account. When the NTLM protocol is used, a resource server must take one of the following actions to verify the identity of a computer or user whenever a new access token is needed:

-   Contact a domain authentication service on the domain controller for the computer's or user's account domain, if the account is a domain account.

-   Look up the computer's or user's account in the local account database, if the account is a local account.

## <a name="BKMK_APP"></a>Current applications
NTLM authentication is still supported and must be used for Windows authentication with systems configured as a member of a workgroup. NTLM authentication is also used for local logon authentication on non\-domain controllers. Kerberos version 5 authentication is the preferred authentication method for Active Directory environments, but a non\-Microsoft or Microsoft application might still use NTLM.

Reducing the usage of the NTLM protocol in an IT environment requires both the knowledge of deployed application requirements on NTLM and the strategies and steps necessary to configure computing environments to use other protocols. New tools and settings have been added to help you discover how NTLM is used in order to selectively restrict NTLM traffic. For information about how to analyze and restrict NTLM usage in your environments, see [Introducing the Restriction of NTLM Authentication](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd560653(v=ws.10)) to access the Auditing and restricting NTLM usage guide.

## <a name="BKMK_NEW"></a>New and changed functionality
There are no changes in functionality for NTLM for  Windows Server.

## <a name="BKMK_DEP"></a>Removed or deprecated functionality
There is no removed or deprecated functionality for NTLM for  Windows Server.

## <a name="BKMK_INSTALL"></a>Server Manager information
NTLM cannot be configured from Server Manager. You can use Security Policy settings or Group Policies to manage NTLM authentication usage between computer systems. In a domain, Kerberos is the default authentication protocol.

## <a name="BKMK_LINKS"></a>See also
The following table lists relevant resources for NTLM and other Windows authentication technologies.

|Content type|References|
|--------|-------|
|**Product evaluation**|[Introducing the Restriction of NTLM Authentication](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd560653(v=ws.10))<p>[Changes in NTLM Authentication](/previous-versions/windows/it-pro/windows-7/dd566199(v=ws.10))|
|**Planning**|[IT Infrastructure Threat Modeling Guide](/previous-versions/tn-archive/dd941826(v=technet.10))<p>[Threats and Countermeasures: Security Settings in Windows Server 2003 and Windows XP](/previous-versions/tn-archive/dd162275(v=technet.10))<p>[Threats and Countermeasures Guide: Security Settings in Windows Server 2008 and Windows Vista](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd349791(v=ws.10))<p>[Threats and Countermeasures Guide: Security Settings in Windows Server 2008 R2 and Windows 7](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/hh125921(v=ws.10))|
|**Deployment**|[Extended Protection for Authentication](/dotnet/framework/wcf/feature-details/extended-protection-for-authentication-overview)<p>[Auditing and restricting NTLM usage guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/jj865674(v=ws.10))<p>[Ask the Directory Services Team : NTLM Blocking and You: Application Analysis and Auditing Methodologies in Windows 7](https://blogs.technet.com/askds/archive/2009/10/08/ntlm-blocking-and-you-application-analysis-and-auditing-methodologies-in-windows-7.aspx)<p>[Windows Authentication Blog](https://blogs.technet.com/authentication/)<p>[Configuring MaxConcurrentAPI for NTLM pass-through authentication](https://support.microsoft.com/help/2688798/how-to-do-performance-tuning-for-ntlm-authentication-by-using-the-maxc)|
|**Development**|[Microsoft NTLM \(Windows\)](/windows/win32/secauthn/microsoft-ntlm)<p>[\[MS\-NLMP\]: NT LAN Manager \(NTLM\) Authentication Protocol Specification](/openspecs/windows_protocols/ms-nlmp/b38c36ed-2804-4868-a9ff-8dd3182128e4)<p>[\[MS\-NNTP\]: NT LAN Manager \(NTLM\) Authentication: Network News Transfer Protocol \(NNTP\) Extension](/openspecs/windows_protocols/ms-nntp/73ae7d96-30fe-4750-807c-bfe7c38b3a0a)<p>[\[MS\-NTHT\]: NTLM Over HTTP Protocol Specification](/openspecs/windows_protocols/ms-ntht/f09cf6e1-529e-403b-a8a5-7368ee096a6a)|
|**Updates**|[New NTLM pass-through authentication protections for CVE-2022-21857](/troubleshoot/windows-server/windows-security/windows-updates-add-new-ntlm-pass-through-authentication-protections)|
