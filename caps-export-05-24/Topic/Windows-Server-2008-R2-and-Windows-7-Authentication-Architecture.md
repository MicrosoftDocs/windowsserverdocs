---
title: Windows Server 2008 R2 and Windows 7 Authentication Architecture
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0314edd9-e3c3-4350-8bbf-87a34883b1cd
---
# Windows Server 2008 R2 and Windows 7 Authentication Architecture
This reference topic describes the authentication architecture including the Local Security Authority \(LSA\) security subsystem architecture for [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)].  
  
[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] authentication services, with its security subsystem architecture, allows your organization to provide a standard or custom logon experience, whether to the local or remote computer. The credential provider passes the credential information directly from the logon screen to Winlogon.exe, which interacts with LSA to communicate with a remote authentication source, such as a domain controller, and the protocol layer within the LSA architecture.  
  
In addition, [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] provide a method for applications to authenticate users by using the Security Support Provider Interface \(SSPI\) to abstract calls to authentication protocols. Developers should understand the different types of authentication, the effects of using different protocols, and the interfaces they support. Then they can specify their preferred authentication protocol and use the authentication protocols provided by the Windows platform. If the preferred protocol is not in this version of Windows, developers can use a custom Security Support Provider if it meets interoperability requirements.  
  
The [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] operating systems include a set of security components that makes up part of the Windows security model. These components ensure that applications cannot gain access to resources without authentication and authorization.  
  
The Local Security Authority \(LSA\) is a protected subsystem that authenticates and logs users on to the local computer. In addition, LSA maintains information about all aspects of local security on a computer \(these aspects are collectively known as the local security policy\), and it provides various services for translation between names and security identifiers \(SIDs\).  
  
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
  
The following illustrations show the architecture for [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] authentication services on the local system, whether a client computer of member server, and those distinct components on the domain controller.  
  
![](../Image/AuthN_LSA_Architecture_Client.gif)  
  
The following illustration shows the components on the domain controller involved in handling the authentication request from the client.  
  
![](../Image/AuthN_LSA_Architecture_DC.gif)  
  
**LSA components for all systems**  
  
|Component|Description|  
|-------------|---------------|  
|Credssp.dll|The default dynamic\-link library \(DLL\) module that operates in the security context of Winlogon.|  
|Netlogon.dll|Some of the services that Net Logon performs include:<br /><br />-   Net Logon maintains the computer’s secure channel \(not to be confused with Schannel\) to a domain controller.<br />-   Net Logon passes the user’s credentials through a secure channel to the domain controller and returns the domain SIDs and user rights for the user.<br />-   The Net Logon service publishes service resource records in the Domain Name System \(DNS\) and uses DNS to resolve names to the Internet Protocol \(IP\) addresses of domain controllers.<br /><br />For information about changes to Net Logon from the previous version, see [Changes in NetLogon](assetId:///174dea23-0fe9-48f2-8122-92d48081b797).|  
|Msv1\_0.dll|The NTLM authentication protocol. This protocol authenticates clients that do not use Kerberos authentication.<br /><br />Extended Protection for Authentication is enabled using the channel binding token. For information about Extended Protection in NTLM, see [NTLM v2 Authentication Architecture](assetId:///2c63740e-b525-429a-a9a2-08aec2fac163). For other changes, see [Changes in NTLM Authentication](assetId:///c60e53b2-ca76-4dee-b591-eba5c1b24a4f).|  
|Schannel.dll|The Secure Sockets Layer \(SSL\) and Transport Layer Security \(TLS\) authentication protocol. This protocol provides authentication over an encrypted channel instead of a less\-secure clear channel.<br /><br />For changes in the Schannel SSP, see [Introducing TLS v1.2](assetId:///42056566-053e-4313-93a6-f40bb071ed6a).|  
|Kerberos.dll|The Kerberos V5 authentication protocol. This protocol provides authentication using Kerberos protocol instead of plaintext, NTLM, or digest method.<br /><br />Extended Protection for Authentication is enabled using the channel binding token.<br /><br />For other changes in Kerberos, see [Changes in Kerberos Authentication](assetId:///e4b7a867-44b3-4ae7-8933-a6bcaeb614db).|  
|Wdigest.dll|Simple challenge\-and\-response protocol that provides increased security over basic authentication.<br /><br />Extended Protection for Authentication is enabled using the channel binding token. For information about Extended Protection in Digest, see [Digest Authentication Processes and Interactions](assetId:///b6968d76-9256-43b0-a594-688bfad4d0eb).|  
|Pku2u.dll|The SSP enables peer\-to\-peer authentication, particularly through the [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] media and file sharing feature called Homegroup, which permits sharing between computers that are not members of a domain.<br /><br />For more information about this protocol, see [PKU2U Security Support Provider](assetId:///799bc2cd-4452-4286-8127-a5753912e17f#BKMK_PKU2USSP).|  
|Negoexts.dll|An authentication package that negotiates the use of SSPs for applications and scenarios implemented by Microsoft and other software companies.<br /><br />For information about this security support provider, see [Introducing Extensions to the Negotiate Authentication Package](assetId:///4431e0fd-d62d-455e-81be-b58c6fd65f7d) and [Negotiate Extensions Security Support Provider](assetId:///799bc2cd-4452-4286-8127-a5753912e17f#BKMK_NegoExtsSSP).|  
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
  
The Security Support Provider Interface \(SSPI\) is the foundation for authentication in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)]. The default Security Support Providers \(SSPs\) are implemented with the SSPI in the form of DLLs. Additional SSPs, such as customized ones, can be plugged in if they are interoperable with the SSPI. The SSPs contain one or more authentication protocols.  
  
Each authentication protocol is composed of a series of steps, used by two or more parties, that verifies the identity of one or more of the parties.  
  
The authentication protocols are designed to address potential security threats by verifying the identities of one or more of the communicating parties. The following topics describe each SSP included with [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] and link to additional information about the authentication protocol:  
  
-   [Credential Security Support Provider](assetId:///799bc2cd-4452-4286-8127-a5753912e17f#BKMK_CredSSP)  
  
-   [Digest Security Support Provider](assetId:///799bc2cd-4452-4286-8127-a5753912e17f#BKMK_DigestSSP)  
  
-   [Kerberos Security Support Provider](assetId:///799bc2cd-4452-4286-8127-a5753912e17f#BKMK_KerbSSP)  
  
-   [Negotiate Security Support Provider](assetId:///799bc2cd-4452-4286-8127-a5753912e17f#BKMK_NegoSSP)  
  
-   [Negotiate Extensions Security Support Provider](assetId:///799bc2cd-4452-4286-8127-a5753912e17f#BKMK_NegoExtsSSP)  
  
-   [NTLM Security Support Provider](assetId:///799bc2cd-4452-4286-8127-a5753912e17f#BKMK_NTLMSSP)  
  
-   [PKU2U Security Support Provider](assetId:///799bc2cd-4452-4286-8127-a5753912e17f#BKMK_PKU2USSP)  
  
-   [Schannel Security Support Provider](assetId:///799bc2cd-4452-4286-8127-a5753912e17f#BKMK_SchannelSSP)  
  
For information about the Security Support Provider Interface in Windows, see [Security Support Provider Interface Architecture](assetId:///799bc2cd-4452-4286-8127-a5753912e17f).  
  
For developer resources for the Security Support Provider Interface, see [SSPI](http://msdn.microsoft.com/library/aa380493(VS.85).aspx).  
  
## Changes in authentication architecture from previous version  
The following topics describe the changes from [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] in the Windows authentication architecture.  
  
-   [What's New in Security in Windows Server 2008 R2](assetId:///30877823-53c5-49d8-840f-42ad28293fec)  
  
-   [What's New in Client Security](assetId:///f5a4fe11-fdd0-4ea8-9b39-a593cc165604) for [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)].  
  
## Additional resources  
For information about viewing the Local Security Policy settings in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], see [Viewing Local Security Policy Settings](assetId:///48f93647-4d0f-42f6-9772-315ccb7a6a57).  
  
For information about Security Identifiers, see [Security Identifiers Technical Reference](assetId:///a320b892-f678-490d-adf0-fb97984c2bd7).  
  
For information about access to resources, see [What Are Access Tokens?](assetId:///9364c4b8-38a0-4aa5-b1d7-c9b42cb4df94).  
  
For information about rights, see [About user rights](assetId:///a7542c97-46f4-4a64-ab42-85a8786544e9).  
  
For information about security auditing, see [Security auditing](assetId:///fdc64339-f4eb-4be6-8b78-8f193dccae10).  
  
## See Also  
[Windows Authentication Architecture](assetId:///6bdc14c1-ff25-490a-9408-ab28679ac5e3)  
  
