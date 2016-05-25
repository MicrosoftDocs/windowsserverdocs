---
title: Windows Server 2003 Authentication Architecture
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 82788170-5217-4653-b138-5890ea311699
---
# Windows Server 2003 Authentication Architecture
This reference topic describes the authentication architecture including the LSA security subsystem architecture for Windows Server 2003  
  
## <a name="w2k3tr_sec_authn_over"></a>  
The Windows Server 2003 operating system implements a default set of authentication security support providers, including Negotiate, the Kerberos protocol, NTLM, Schannel \(secure channel\), and Digest, as part of an extensible architecture. The protocols used by these providers enable authentication of users, computers, and services; the authentication process, in turn, enables authorized users and services to access resources in a secure manner.  
  
**Windows Server 2003 authentication services**  
  
Windows Server 2003 provides a method for applications to authenticate users by using the Security Support Provider Interface \(SSPI\) to abstract calls to authentication. Thus, developers do not need to understand the complexities of specific authentication protocols or build authentication protocols into their applications.  
  
For best results, however, before starting the application design process, developers should understand the different types of authentication, the effects of using different protocols, and the interfaces they support. Then they can specify their preferred authentication protocol and use the authentication protocols provided by the Windows platform.  
  
If the preferred protocol is not in Windows Server 2003, developers can use a custom Security Support Provider \(SSP\). Implementing authentication protocols on an application\-by\-application basis is inefficient and can introduce security flaws across the organization.  
  
**Security subsystem architecture**  
  
Windows Server 2003 operating systems include a set of security components that make up the Windows security model. These components ensure that applications cannot gain access to resources without authentication and authorization.  
  
The Local Security Authority \(LSA\) is a protected subsystem that authenticates and logs users on to the local computer. In addition, LSA maintains information about all aspects of local security on a computer \(these aspects are collectively known as the local security policy\), and it provides various services for translation between names and security identifiers \(SIDs\). There are two domains in which logon attempts are trusted. The local account domain is used on a standalone computer, and the domain account is used on a domain\-joined computer.  
  
The security subsystem keeps track of the security policies and the accounts that are in effect on a computer system. In the case of a domain controller, these policies and accounts are the ones that are in effect for the domain in which the domain controller is located. These policies and accounts are stored in Active Directory.  
  
The local security policy identifies the following:  
  
-   Who can have access to the system and in what way \(for example, interactively, over the network, or as a service\).  
  
-   Who is assigned what rights.  
  
-   What security auditing is performed.  
  
-   What the default memory quotas are for paged and non\-paged memory pool usage.  
  
The following diagram shows the interactions of LSA components on the local computer and domain controller with those additional components that are just on the domain controller, as indicated by the grey objects.  
  
**LSA architecture**  
  
Eric…there was a graphic following this. I had to delete it because I could not provide a proper GUID.  
  
The LSA security subsystem provides services for validating access to objects, checking user rights, and generating audit messages. A local procedure call \(LPC\) occurs between components on the same system. A remote procedure call \(RPC\) can occur between components on different systems \(as do LDAP communications\) or between components on the same system.  
  
In general, the LSA performs the following functions:  
  
-   Manages local security policy.  
  
-   Provides interactive user authentication services.  
  
-   Generates access tokens.  
  
-   Manages the audit policy and settings.  
  
**LSA components for all systems**  
  
|Component|Description|  
|-------------|---------------|  
|Msgina.dll|The default dynamic\-link library \(DLL\) module that operates in the security context of Winlogon. The Graphical Identification and Authentication \(GINA\) is responsible for processing secure attention sequence \(SAS\) events and activating the user’s shell. The GINA can generate SAS events in some instances.|  
|Netlogon.dll|Some of the services that Net Logon performs include:<br /><br />-   Net Logon maintains the computer’s secure channel \(not to be confused with Schannel\) to a domain controller.<br />-   Net Logon passes the user’s credentials through a secure channel to the domain controller and returns the domain SIDs and user rights for the user.<br />-   In Windows Server 2003, the Net Logon service publishes service resource records in the Domain Name System \(DNS\) and uses DNS to resolve names to the Internet Protocol \(IP\) addresses of domain controllers.<br />-   Net Logon also implements the replication protocol based on RPC for synchronizing primary domain controllers \(PDCs\) and backup domain controllers \(BDCs\).|  
|Msv1\_0.dll|The NTLM authentication protocol. This protocol authenticates clients that do not use Kerberos authentication.|  
|Schannel.dll|The Secure Sockets Layer \(SSL\) and Transport Layer Security \(TLS\) authentication protocol. This protocol provides authentication over an encrypted channel instead of a less\-secure clear channel.|  
|Kerberos.dll|The Kerberos V5 authentication protocol. This protocol provides authentication using Kerberos protocol instead of plaintext, NTLM, or digest method.|  
|Wdigest.dll|Simple challenge\-and\-response protocol that provides increased security over basic authentication.|  
|Lsasrv.dll|The LSA Server service, which both enforces security policies and acts as the security package manager for the LSA.|  
|Samsrv.dll|The Security Accounts Manager \(SAM\), which stores local security accounts, enforces locally stored policies, and supports APIs.|  
|Secur32.dll|The multiple authentication provider that holds all of the components together.|  
  
**LSA components unique to domain controllers**  
  
|Component|Description|  
|-------------|---------------|  
|Kdcsvc.dll|The Kerberos Key Distribution Center \(KDC\) service, which is responsible for providing ticket\-granting tickets to clients.|  
|Ntdsa.dll|The directory service module in Windows Server 2003, which supports the replication protocol and LDAP, and manages partitions of data.|  
  
**Security Support Provider Interface \(SSPI\)**  
  
The Security Support Provider Interface \(SSPI\) is the foundation for authentication in Windows Server 2003. SSPI is the implementation of the Generic Security Service API \(GSSAPI\) in Windows Server 2003. For more information about GSSAPI, see RFCs 2743 and 2744 in the IETF RFC Database.  
  
The default Security Support Providers in Windows Server 2003—Negotiate \(SPNEGO\), Kerberos, NTLM, Schannel, and Digest authentication protocols—are plugged into the SSPI in the form of DLLs. Additional SSPs can be plugged in if they are interoperable with the SSPI.  
  
The SSPI in Windows Server 2003 provides a mechanism by which a distributed application can call one of several security providers to obtain an authenticated connection without knowledge of the details of the security protocol. When two parties need to be authenticated so that they can communicate, the requests for authentication are routed to the SSPI, which completes the authentication process, regardless of the network transport currently in use.  
  
**SSPI architecture**  
  
Eric…there was a graphic following this. I had to delete it because I could not provide a proper GUID.  
  
Any application can make a request of the SSPI. Each of these requests goes through the SSPI, for example:  
  
-   Winlogon sends requests to the Local Security Authority \(LSA\), which obtains tickets to access the local computer.  
  
-   Internet Explorer obtains tickets to access information about a website.  
  
-   An LDAP client authenticates to Active Directory using the specific authentication mechanism.  
  
Some applications integrate use of the SSPI into their authentication designs. When such applications need to authenticate a user, they ask the SSPI to complete the authentication by using specific parameters, such as the user’s name and secret key \(if they were not cached from a previous logon\), and the service that the user wants to access. The SSPI receives the request, examines its contents, and passes the request to the SSP specified in the request. The SSP handles the details of the authentication and sends a success or failure message back to the SSPI, which relays the message back to the application that initially requested authentication. SSPI enables an application to use various security models available on a computer or network without changing the interface to the security system.  
  
For example, if a client computer has a service ticket for a server for which the preferred authentication protocol is Kerberos, and the client computer wants to issue that server a remote procedure call \(RPC\), the client’s Kerberos SSP generates a request message based on standard GSS\-API \(RFC 1964\) calls, which the application sends to the server. When the server receives the request, the server passes the ticket to the Kerberos SSP. The client computer routes the reply token to its SSP, which then evaluates and manages the contents of the reply. The server and the client computer know nothing about the contents of the message that is used to enable secure communication, because this information is handled by the SSP. The details of authentication are handled behind the scenes, and the results of the authentication process are passed back to the applications.  
  
For an explanation how the applicable SSP is selected during the authentication process, see [Security Support Provider Interface Architecture](https://technet.microsoft.com/library/dn169026(v=ws.10).aspx).  
  
## See Also  
[Windows Authentication Architecture](https://technet.microsoft.com/library/dn169024(v=ws.10).aspx)  
  
