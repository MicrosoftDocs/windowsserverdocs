---
title: Windows Authentication Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 485a0774-0785-457f-a964-0e9403c12bb1
---
# Windows Authentication Overview
This navigation topic for the IT professional lists documentation resources for Windows authentication and logon technologies that include product evaluation, getting started guides, procedures, design and deployment guides, technical references, and command references.  
  
## Feature description  
Authentication is a process for verifying the identity of an object, service or person. When you authenticate an object, the goal is to verify that the object is genuine. When you authenticate a service or person, the goal is to verify that the credentials presented are authentic.  
  
In a networking context, authentication is the act of proving identity to a network application or resource. Typically, identity is proven by a cryptographic operation that uses either a key only the user knows — as with public key cryptography — or a shared key. The server side of the authentication exchange compares the signed data with a known cryptographic key to validate the authentication attempt.  
  
Storing the cryptographic keys in a secure central location makes the authentication process scalable and maintainable. Active Directory Domain Services is the recommended and default technology for storing identity information \(including the cryptographic keys that are the user’s’ credentials\). Active Directory is required for default NTLM and Kerberos implementations.  
  
Authentication techniques range from a simple logon, which identifies users based on something that only the user knows — like a password, to more powerful security mechanisms that use something that the user has — like tokens, public key certificates, and biometrics. In a business environment, services or users might access multiple applications or resources on many types of servers within a single location or across multiple locations. For these reasons, authentication must support environments for other platforms and for other Windows operating systems.  
  
The Windows operating system implements a default set of authentication protocols, including Kerberos, NTLM, Transport Layer Security\/Secure Sockets Layer \(TLS\/SSL\), and Digest, as part of an extensible architecture. In addition, some protocols are combined into authentication packages such as Negotiate and the Credential Security Support Provider. These protocols and packages enable authentication of users, computers, and services; the authentication process, in turn, enables authorized users and services to access resources in a secure manner.  
  
For more information about Windows Authentication including  
  
-   [Differences in Windows Authentication Between Windows Operating Systems](../Topic/Differences-in-Windows-Authentication-Between-Windows-Operating-Systems.md)  
  
-   [Windows Authentication Concepts](../Topic/Windows-Authentication-Concepts.md)  
  
-   [Windows Logon Scenarios](../Topic/Windows-Logon-Scenarios.md)  
  
-   [Windows Authentication Architecture](../Topic/Windows-Authentication-Architecture.md)  
  
-   [Security Support Provider Interface Architecture](../Topic/Security-Support-Provider-Interface-Architecture.md)  
  
-   [Credentials Processes in Windows Authentication](../Topic/Credentials-Processes-in-Windows-Authentication.md)  
  
-   [Group Policy Settings Used in Windows Authentication](../Topic/Group-Policy-Settings-Used-in-Windows-Authentication.md)  
  
see the [Windows Authentication Technical Overview](../Topic/Windows-Authentication-Technical-Overview.md).  
  
## Practical applications  
Windows Authentication is used to verify that the information comes from a trusted source, whether from a person or computer object, such as another computer. Windows provides many different methods to achieve this goal as described below.  
  
|To…|Feature|Description|  
|-------|-----------|---------------|  
|Authenticate within an Active Directory domain|Kerberos|The Microsoft Windows Server operating systems implement the Kerberos version 5 authentication protocol and extensions for public key authentication. The Kerberos authentication client is implemented as a security support provider \(SSP\) and can be accessed through the Security Support Provider Interface \(SSPI\). Initial user authentication is integrated with the Winlogon single sign\-on architecture. The Kerberos Key Distribution Center \(KDC\) is integrated with other Windows Server security services running on the domain controller. The KDC uses the domain’s Active Directory directory service database as its security account database. Active Directory is required for default Kerberos implementations.<br /><br />For additional resources, see [Kerberos Authentication Overview](../Topic/Kerberos-Authentication-Overview.md).|  
|Secure authentication on the web|TLS\/SSL as implemented in the Schannel Security Support Provider|The Transport Layer Security \(TLS\) protocol versions 1.0, 1.1, and 1.2, Secure Sockets Layer \(SSL\) protocol, versions 2.0 and 3.0, Datagram Transport Layer Security protocol version 1.0, and the Private Communications Transport \(PCT\) protocol, version 1.0, are based on public key cryptography. The Secure Channel \(Schannel\) provider authentication protocol suite provides these protocols. All Schannel protocols use a client and server model.<br /><br />For additional resources, see [TLS - SSL &#40;Schannel SSP&#41; Overview](../Topic/TLS---SSL--Schannel-SSP--Overview.md).|  
|Authenticate to a web service or application|Integrated Windows Authentication<br /><br />Digest Authentication|For additional resources, see [Integrated Windows Authentication](http://technet.microsoft.com/library/cc758557(v=WS.10).aspx) and [Digest Authentication](http://technet.microsoft.com/library/cc738318(v=ws.10).aspx), and [Advanced Digest Authentication](http://technet.microsoft.com/library/cc783131(v=ws.10).aspx).|  
|Authenticate to legacy applications|NTLM|NTLM is a challenge\-response style authentication protocol.In addition to authentication, the NTLM protocol optionally provides for session security—specifically message integrity and confidentiality through signing and sealing functions in NTLM.<br /><br />For additional resources, see [NTLM Overview](../Topic/NTLM-Overview.md).|  
|Leverage multifactor authentication|Smart card support<br /><br />Biometric support|Smart cards are a tamper\-resistant and portable way to provide security solutions for tasks such as client authentication, logging on to domains, code signing, and securing e\-mail.<br /><br />Biometrics relies on measuring an unchanging physical characteristic of a person to uniquely identify that person. Fingerprints are one of the most frequently used biometric characteristics, with millions of fingerprint biometric devices that are embedded in personal computers and peripherals.<br /><br />For additional resources, see [Smart Card Overview](../Topic/Smart-Card-Overview.md) and [Windows Biometric Framework Overview \[W8\]](assetId:///211cfabe-c5bd-4562-ac67-2493a9dd390d).|  
|Provide local management, storage and reuse of credentials|Credentials management<br /><br />Local Security Authority<br /><br />Passwords|Credential  management in Windows ensures that credentials are stored securely. Credentials are collected on the Secure Desktop \(for local or domain access\), through apps or through websites so that the correct credentials are presented every time a resource is accessed.<br /><br />For additional resources, see [Cached and Stored Credentials Technical Overview](assetId:///3fdafdf0-2a80-449d-b4d2-e91dcd729717) and [Passwords Overview](../Topic/Passwords-Overview.md).|  
|Extend modern authentication protection to legacy systems|Extended Protection for Authentication|This feature enhances the protection and handling of credentials when authenticating network connections by using Integrated Windows Authentication \(IWA\).<br /><br />For additional resources, see [Extended Protection for Authentication](http://support.microsoft.com/kb/968389).|  
  
## Software requirements  
Windows Authentication is designed to be compatible with previous versions of the Windows operating system. However, improvements with each release are not necessarily applicable to previous versions. Refer to documentation about specific features for more information.  
  
## Server Manager information  
Many authentication features can be configured using Group Policy, which can be installed using Server Manager. The Windows Biometric Framework feature is installed using Server Manager. Other server roles which are dependent upon authentication methods, such as Web Server \(IIS\) and Active Directory Domain Services, can also be installed using Server Manager.  
  
## Related resources  
  
|Authentication technologies|Resources|  
|-------------------------------|-------------|  
|Windows authentication|[Windows Authentication Technical Overview](../Topic/Windows-Authentication-Technical-Overview.md)<br />Includes topics addressing differences between versions, general authentication concepts, logon scenarios, architectures for supported versions, and applicable settings.|  
|Kerberos|[Kerberos Authentication Overview](../Topic/Kerberos-Authentication-Overview.md)<br /><br />[Kerberos Constrained Delegation Overview](../Topic/Kerberos-Constrained-Delegation-Overview.md)<br /><br />[Kerberos Authentication Technical Reference](http://technet.microsoft.com/library/cc739058(v=ws.10).aspx)\(2003\)<br /><br />[Kerberos Survival Guide](http://social.technet.microsoft.com/wiki/contents/articles/4209.kerberos-survival-guide.aspx) \(TechNet Wiki\)|  
|TLS\/SSL and DTLS \(Schannel security support provider\)|[TLS - SSL &#40;Schannel SSP&#41; Overview](../Topic/TLS---SSL--Schannel-SSP--Overview.md)<br /><br />[Schannel Security Support Provider Technical Reference](../Topic/Schannel-Security-Support-Provider-Technical-Reference.md)|  
|Digest authentication|[Digest Authentication Technical Reference](http://technet.microsoft.com/library/cc782794(v=ws.10).aspx)\(2003\)|  
|NTLM|[NTLM Overview](../Topic/NTLM-Overview.md)<br />Contains links to current and past resources|  
|PKU2U|[Introducing PKU2U in Windows](http://technet.microsoft.com/library/dd560634(v=ws.10).aspx)|  
|Smart Card|[Smart Card Overview](../Topic/Smart-Card-Overview.md)<br /><br />[Windows Smart Card Technical Reference](assetId:///d2761e8c-5980-4077-a341-ab3cb5dec955)|  
|Virtual smart card|[Virtual Smart Card Overview](assetId:///eaf01ad1-2b9d-4c26-a0ff-5199bbcd1e8a)<br /><br />[Understanding and Evaluating Virtual Smart Cards](assetId:///58d268bf-d13f-4136-b5cb-0d9a5d402558)|  
|Biometrics|[Windows Biometric Framework Overview \[W8\]](assetId:///211cfabe-c5bd-4562-ac67-2493a9dd390d)Windows Biometric Framework Overview \[W8\]|  
|Credentials|[Credentials Protection and Management](../Topic/Credentials-Protection-and-Management.md)<br />Contains links to current and past resources<br /><br />[Passwords Overview](../Topic/Passwords-Overview.md)<br />Contains links to current and past resources|  
  
