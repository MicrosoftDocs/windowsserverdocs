---
title: Windows Server 2008 and Windows Vista Authentication Architecture
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b79c4421-6458-470c-97da-8ba26c888248
---
# Windows Server 2008 and Windows Vista Authentication Architecture
This reference topic describes the authentication architecture including the Local Security Authority \(LSA\) security subsystem architecture for [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)].  
  
[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] authentication services, with its security subsystem architecture, allows your organization to provide a standard or custom logon experience. With the implementation of the Credential Security Support Provider \(CredSSP\), the authentication service does not depend on the Graphical Identification and Authentication \(GINA\). The credential provider passes the credential information directly from the logon screen to Winlogon.exe, which interacts with LSA to communicate with a remote authentication source, such as a domain controller, and the protocol layer within the LSA architecture.  
  
In addition, [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] provide a method for applications to authenticate users by using the Security Support Provider Interface \(SSPI\) to abstract calls to authentication protocols. Developers should understand the different types of authentication, the effects of using different protocols, and the interfaces they support. Then they can specify their preferred authentication protocol and use the authentication protocols provided by the Windows platform. If the preferred protocol is not in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)], developers can use a custom Security Support Provider.  
  
[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] operating system includes a set of security components that makes up part of the Windows security model. These components ensure that applications cannot gain access to resources without authentication and authorization.  
  
The Local Security Authority \(LSA\) is a protected subsystem that authenticates and logs users on to the local computer. In addition, LSA maintains information about all aspects of local security on a computer \(these aspects are collectively known as the local security policy\), and it provides various services for translation between names and security identifiers \(SIDs\). There are two domains in which logon attempts are trusted. The local account domain is used on a standalone computer, and the domain account is used on a domain\-joined computer.  
  
The security subsystem keeps track of the security policies and the accounts that are in effect on a computer system. In the case of a domain controller, these policies and accounts are the ones that are in effect for the domain in which the domain controller is located. These policies and accounts are stored in Active Directory.  
  
The local security policy identifies the following:  
  
-   Who can have access to the system and in what way \(for example, interactively, over the network, or as a service\).  
  
-   Who is assigned what rights.  
  
-   What security auditing is performed.  
  
-   What the default memory quotas are for paged and non\-paged memory pool usage.  
  
**LSA architecture**  
  
The LSA security subsystem provides services for validating access to objects, checking user rights, and generating audit messages. A local procedure call \(LPC\) occurs between components on the same system. A remote procedure call \(RPC\) can occur between components on different systems \(as do LDAP communications\) or between components on the same system.  
  
In general, the LSA performs the following functions:  
  
-   Manages local security policy.  
  
-   Provides interactive user authentication services.  
  
-   Generates access tokens.  
  
-   Manages the audit policy and settings.  
  
The following illustrations show the architecture for [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] authentication services on the local system, whether a client computer of member server, and those distinct components on the domain controller.  
  
![](../Image/AuthN_LSA_Architecture_Client.gif)  
  
The following illustration shows the components on the domain controller involved in handling the authentication request from the client.  
  
![](../Image/AuthN_LSA_Architecture_DC.gif)  
  
**LSA components for all systems**  
  
|Component|Description|  
|-------------|---------------|  
|Credssp.dll|The default dynamic\-link library \(DLL\) module that operates in the security context of Winlogon.<br /><br />For information about this new component for [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)], see [Credential Security Service Provider and SSO for Terminal Services Logon](https://technet.microsoft.com/library/cc749211(v=ws.10).aspx).<br /><br />For information about credential management in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)], see [Credentials Management in Windows Authentication](https://technet.microsoft.com/library/dn169014(v=ws.10).aspx).|  
|Netlogon.dll|Some of the services that Net Logon performs include:<br /><br />-   Net Logon maintains the computer’s secure channel \(not to be confused with Schannel\) to a domain controller.<br />-   Net Logon passes the user’s credentials through a secure channel to the domain controller and returns the domain SIDs and user rights for the user.|  
|Msv1\_0.dll|The NTLM authentication protocol. This protocol authenticates clients that do not use Kerberos authentication.|  
|Schannel.dll|The Secure Sockets Layer \(SSL\) and Transport Layer Security \(TLS\) authentication protocol. This protocol provides authentication over an encrypted channel instead of a less\-secure clear channel.|  
|Kerberos.dll|The Kerberos V5 authentication protocol. This protocol provides authentication using Kerberos protocol instead of plaintext, NTLM, or digest method.|  
|Wdigest.dll|Simple challenge\-and\-response protocol that provides increased security over basic authentication.|  
|Lsasrv.dll|The LSA Server service, which both enforces security policies and acts as the security package manager for the LSA.|  
|Samsrv.dll|The Security Accounts Manager \(SAM\), which stores local security accounts, enforces locally stored policies, and supports APIs.|  
|Secur32.dll|The authentication provider that exposes the SSP interfaces to applications.|  
  
**LSA components unique to domain controllers**  
  
|Component|Description|  
|-------------|---------------|  
|Kdcsvc.dll|The Kerberos Key Distribution Center \(KDC\) service, which is responsible for the Kerberos authentication service and the ticket granting service.|  
|Ntdsa.dll|The directory service module, which supports the Windows replication protocol and LDAP, and manages partitions of data|  
|Ntdsapi.dll|A directory service module which can communicate over RPC through a set of COM interfaces used for accessing directory services to manage network resources.|  
  
**Security Support Provider Interface \(SSPI\) and authentication protocols**  
  
The Security Support Provider Interface \(SSPI\) is the foundation for authentication in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)]. The default Security Support Providers \(SSPs\) are implemented with the SSPI in the form of DLLs. Additional SSPs, such as customized ones, can be plugged in if they are interoperable with the SSPI. The SSPs contain one or more authentication protocols.  
  
Each authentication protocol is composed of a series of steps, used by two or more parties, that verifies the identity of one or more of the parties.  
  
The authentication protocols are designed to address potential security threats by verifying the identities of one or more of the communicating parties. The following topics describe each SSP included with these versions of Windows and link to additional information about the authentication protocol:  
  
-   [Credential Security Support Provider](assetId:///799bc2cd-4452-4286-8127-a5753912e17f#BKMK_CredSSP)  
  
-   [Digest Security Support Provider](assetId:///799bc2cd-4452-4286-8127-a5753912e17f#BKMK_DigestSSP)  
  
-   [Kerberos Security Support Provider](assetId:///799bc2cd-4452-4286-8127-a5753912e17f#BKMK_KerbSSP)  
  
-   [Negotiate Security Support Provider](assetId:///799bc2cd-4452-4286-8127-a5753912e17f#BKMK_NegoSSP)  
  
-   [NTLM Security Support Provider](assetId:///799bc2cd-4452-4286-8127-a5753912e17f#BKMK_NTLMSSP)  
  
-   [Schannel Security Support Provider](assetId:///799bc2cd-4452-4286-8127-a5753912e17f#BKMK_SchannelSSP)  
  
For information about the Security Support Provider Interface in Windows, see [Security Support Provider Interface Architecture](https://technet.microsoft.com/library/dn169026(v=ws.10).aspx).  
  
For developer resources for the Security Support Provider Interface, see [SSPI](http://msdn.microsoft.com/library/aa380493(VS.85).aspx).  
  
## Changes in authentication architecture from previous version  
For a list and description of changes in architecture and functionality, see [Windows Vista Authentication Features](https://technet.microsoft.com/library/cc749590(v=ws.10).aspx).  
  
## Additional resources  
For information about the Local Security Policy and new policy settings in [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)], see [Security Policy Settings New for Vista](https://technet.microsoft.com/library/cc766301(v=ws.10).aspx).  
  
For information about Security Identifiers, see [Security Identifiers Technical Reference](https://technet.microsoft.com/library/cc782090(v=ws.10).aspx).  
  
For information about access to resources, see [What Are Access Tokens?](https://technet.microsoft.com/library/cc759267(v=ws.10).aspx).  
  
For information about rights, see [About user rights](https://technet.microsoft.com/library/cc773115.aspx).  
  
## See Also  
[Windows Authentication Architecture](https://technet.microsoft.com/library/dn169024(v=ws.10).aspx)  
  
