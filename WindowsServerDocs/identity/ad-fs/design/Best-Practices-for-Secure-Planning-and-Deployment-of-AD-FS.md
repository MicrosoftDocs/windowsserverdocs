---
ms.assetid: 963a3d37-d5f1-4153-b8d5-2537038863cb
title: Best Practices for Secure Planning and Deployment of AD FS
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---

# Best Practices for Secure Planning and Deployment of AD FS


This topic provides best-practice information to help you plan and evaluate security when you design your Active Directory Federation Services (AD FS) deployment. This topic is a starting point for reviewing and assessing considerations that affect the overall security of your use of AD FS. The information in this topic is meant to compliment and extend your existing security planning and other design best practices.  
  
## Core security best practices for AD FS  
The following core best practices are common to all AD FS installations where you want to improve or extend the security of your design or deployment:  

-   **Secure AD FS as a "Tier 0" system** 

    AD FS is, fundamentally, an authentication system.  Thus, it should be treated as a "Tier 0" system like other identity system on your network.  [Microsoft Docs](https://docs.microsoft.com/windows-server/identity/securing-privileged-access/securing-privileged-access-reference-material) has more information on the Active Directory administrative tier model. 


-   **Use the Security Configuration Wizard to apply AD FS-specific security best practices to federation servers and federation server proxy computers**  
  
    The Security Configuration Wizard (SCW) is a tool that comes preinstalled on all Windows Server 2008, Windows Server 2008 R2 and  Windows Server 2012  computers. You can use it to apply security best practices that can help reduce the attack surface for a server, based on the server roles that you are installing.  
  
    When you install AD FS, the setup program creates role extension files that you can use with the SCW to create a security policy that will apply to the specific AD FS server role (either federation server or federation server proxy) that you choose during setup.  
  
    Each role extension file that is installed represents the type of role and subrole for which each computer is configured. The following role extension files are installed in the C:WindowsADFSScw directory:  
  
    -   Farm.xml  
  
    -   SQLFarm.xml  
  
    -   StandAlone.xml  
  
    -   Proxy.xml (This file is present only if you configured the computer in the federation server proxy role.)  
  
    To apply the AD FS role extensions in the SCW, complete the following steps in order:  
  
    1.  Install AD FS and choose the appropriate server role for that computer. For more information, see [Install the Federation Service Proxy Role Service](../../ad-fs/deployment/Install-the-Federation-Service-Proxy-Role-Service.md) in the AD FS Deployment Guide.  
  
    2.  Register the appropriate role extension file using the Scwcmd command-line tool. See the following table for details about using this tool in the role for which your computer is configured.  
  
    3.  Verify that the command has completed successfully by examining the SCWRegister_log.xml file, which is located in the WindowssecurityMsscwLogs directory.  
  
    You must perform all these steps on each federation server or federation server proxy computer to which you want to apply AD FS–based SCW security policies.  
  
    The following table explains how to register the appropriate SCW role extension, based on the AD FS server role that you chose on the computer where you installed AD FS.  
  
    |AD FS server role|AD FS configuration database used|Type the following command at a command prompt:|  
    |---------------------|-------------------------------------|---------------------------------------------------|  
    |Stand-alone federation server|Windows Internal Database|`scwcmd register /kbname:ADFS2Standalone /kbfile:"WindowsADFSscwStandAlone.xml"`|  
    |Farm-joined federation server|Windows Internal Database|`scwcmd register /kbname:ADFS2Standalone /kbfile:"WindowsADFSscwFarm.xml"`|  
    |Farm-joined federation server|SQL Server|`scwcmd register /kbname:ADFS2Standalone /kbfile:"WindowsADFSscwSQLFarm.xml"`|  
    |Federation server proxy|N/A|`scwcmd register /kbname:ADFS2Standalone /kbfile:"WindowsADFSscwProxy.xml"`|  
  
    For more information about the databases that you can use with AD FS, see [The Role of the AD FS Configuration Database](../../ad-fs/technical-reference/The-Role-of-the-AD-FS-Configuration-Database.md).  
  
-   **Use token replay detection in situations in which security is a very important concern, for example, when kiosks are used.**  
    Token replay detection is a feature of AD FS that ensures that any attempt to replay a token request that is made to the Federation Service is detected and the request is discarded. Token replay detection is enabled by default. It works for both the WS-Federation passive profile and the Security Assertion Markup Language (SAML) WebSSO profile by ensuring that the same token is never used more than once.  
  
    When the Federation Service starts, it begins to build a cache of any token requests that it fulfills. Over time, as subsequent token requests are added to the cache, the ability to detect any attempts to replay a token request multiple times increases for the Federation Service. If you disable token replay detection and later choose to enable it again, remember that the Federation Service will still accept tokens for a period of time that may have been used previously, until the replay cache has been allowed enough time to rebuild its contents. For more information, see [The Role of the AD FS Configuration Database](../../ad-fs/technical-reference/The-Role-of-the-AD-FS-Configuration-Database.md).  
  
-   **Use token encryption, especially if you are using supporting SAML artifact resolution.**  
  
    Encryption of tokens is strongly advised to increase security and protection against potential man-in-the-middle (MITM) attacks that might be tried against your AD FS deployment. Using use encryption might have a slight impact on throughout but in general, it should not be usually noticed and in many deployments the benefits for greater security exceed any cost in terms of server performance.  
  
    To enable token encryption, first set add an encryption certificate for your relying party trusts. You can configure an encryption certificate either when creating a relying party trust or later. To add an encryption certificate later to an existing relying party trust, you can set a certificate for use on the **Encryption** tab within trust properties while using the AD FS snap-in. To specify a certificate for an existing trust using the AD FS cmdlets, use the EncryptionCertificate parameter of either the **Set-ClaimsProviderTrust** or **Set-RelyingPartyTrust** cmdlets. To set a certificate for the Federation Service to use when decrypting tokens, use the **Set-ADFSCertificate** cmdlet and specify "`Token-Encryption`" for the *CertificateType* parameter. Enabling and disabling encryption for specific relying party trust can be done by using the *EncryptClaims* parameter of the **Set-RelyingPartyTrust** cmdlet.  
  
-   **Utilize extended protection for authentication**  
  
    To help secure your deployments, you can set and use the extended protection for authentication feature with AD FS. This setting specifies the level of extended protection for authentication supported by a federation server.  
  
    Extended protection for authentication helps protect against man-in-the-middle (MITM) attacks, in which an attacker intercepts client credentials and forwards them to a server. Protection against such attacks is made possible through a Channel Binding Token (CBT) which can be either required, allowed, or not required by the server when it establishes communications with clients.  
  
    To enable the extended protection feature, use the **ExtendedProtectionTokenCheck** parameter on the **Set-ADFSProperties** cmdlet. Possible values for this setting and the level of security that the values provide are described in the following table.  
  
    |Parameter Value|Security level|Protection setting|  
    |-------------------|------------------|----------------------|  
    |Require|Server is fully hardened.|Extended protection is enforced and always required.|  
    |Allow|Server is partially hardened.|Extended protection is enforced where systems involved have been patched to support it.|  
    |None|Server is vulnerable.|Extended protection is not enforced.|  
  
-   **If you are using logging and tracing, ensure the privacy of any sensitive information.**  
  
    AD FS does not, by default, expose or track personally identifiable information (PII) directly as part of the Federation Service or normal operations. When event logging and debug trace logging are enabled in AD FS, however, depending on the claims policy that you configure some claims types and their associated values might contain PII that might be logged in the AD FS event or tracing logs.  
  
    Therefore, enforcing access control on the AD FS configuration and its log files is strongly advised. If you do not want this kind of information to be visible, you should disable loggin, or filter out any PII or sensitive data in your logs before you share them with others.  
  
    The following tips can help you prevent the content of a log file from being exposed unintentionally:  
  
    -   Ensure that the AD FS event log and trace log files are protected by access control lists (ACL) that limit access to only those trusted administrators who require access to them.  
  
    -   Do not copy or archive log files using file extensions or paths that can be easily served using a Web request. For example, the .xml file name extension is not a safe choice. You can check the Internet Information Services (IIS) administration guide to see a list of extensions that can be served.  
  
    -   If you revise the path to the log file, be sure to specify an absolute path for the log file location, which should be outside of the Web host virtual root (vroot) public directory to prevent it from being accessed by an external party using a Web browser.  

-   **AD FS Extranet Soft Lockout and AD FS Extranet Smart Lockout Protection**  
	
	In case of an attack in the form of authentication requests with invalid(bad) passwords that come through the Web Application Proxy, AD FS extranet lockout enables you to protect your users from an AD FS account lockout. In addition to protecting your users from an AD FS account lockout, AD FS extranet lockout also protects against brute force password guessing attacks.  
    
    For Extranet Soft Lockout for AD FS on Windows Server 2012 R2 see [AD FS Extranet Soft Lockout Protection](../../ad-fs/operations/Configure-AD-FS-Extranet-Soft-Lockout-Protection.md).  

	 For Extranet Smart Lockout for AD FS on Windows Server 2016 see [AD FS Extranet Smart Lockout Protection](../../ad-fs/operations/Configure-AD-FS-Extranet-Smart-Lockout-Protection.md).  
  
## SQL Server–specific security best practices for AD FS  
The following security best practices are specific to the use of Microsoft SQL Server® or Windows Internal Database (WID) when these database technologies are used to manage data in AD FS design and deployment.  
  
> [!NOTE]  
> These recommendations are meant to extend, but not replace, SQL Server product security guidance. For more information about planning a secure SQL Server installation, see [Security Considerations for a Secure SQL Installation](https://go.microsoft.com/fwlink/?LinkID=139831) (https://go.microsoft.com/fwlink/?LinkID=139831).  
  
-   **Always deploy SQL Server behind a firewall in a physically secure network environment.**  
  
    A SQL Server installation should never be exposed directly to the Internet. Only computers that are inside your datacenter should be able to reach your SQL server installation that supports AD FS. For more information, see [Security Best Practices Checklist](https://go.microsoft.com/fwlink/?LinkID=189229) (https://go.microsoft.com/fwlink/?LinkID=189229).  
  
-   **Run SQL Server under a service account instead of using the built-in default system service accounts.**  
  
    By default, SQL Server is often installed and configured to use one of the supported built-in system accounts, such as the LocalSystem or NetworkService accounts. To enhance the security of your SQL Server installation for AD FS, wherever possible use a separate service account for accessing your SQL Server service and enable Kerberos authentication by registering the security principal name (SPN) of this account in your Active Directory deployment. This enables mutual authentication between client and server. Without SPN registration of a separate service account, SQL Server will use NTLM for Windows-based authentication, where only the client is authenticated.  
  
-   **Minimize the surface area of SQL Server.**  
  
    Enable only those SQL Server endpoints that are necessary. By default, SQL Server provides a single built-in TCP endpoint that cannot be removed. For AD FS, you should enable this TCP endpoint for Kerberos authentication. To review the current TCP endpoints to see if additional user-defined TCP ports are added to a SQL installation, you can use the "SELECT * FROM sys.tcp_endpoints" query statement in a Transact-SQL (T-SQL) session. For more information about SQL Server endpoint configuration, see [How To: Configure the Database Engine to Listen on Multiple TCP Ports](https://go.microsoft.com/fwlink/?LinkID=189231) (https://go.microsoft.com/fwlink/?LinkID=189231).  
  
-   **Avoid using SQL-based authentication.**  
  
    To avoid having to transfer passwords as clear text over your network or storing passwords in configuration settings, use Windows authentication only with your SQL Server installation. SQL Server authentication is a legacy authentication mode. Storing Structured Query Language (SQL) login credentials (SQL user names and passwords) when you are using SQL Server authentication is not recommended. For more information, see [Authentication Modes](https://go.microsoft.com/fwlink/?LinkID=189232) (https://go.microsoft.com/fwlink/?LinkID=189232).  
  
-   **Evaluate the need for additional channel security in your SQL installation carefully.**  
  
    Even with Kerberos authentication in effect, the SQL Server Security Support Provider Interface (SSPI) does not provide channel-level security. However, for installations in which servers are securely located on a firewall-protected network, encrypting SQL communications may not be necessary.  
  
    Although encryption is a valuable tool to help ensure security, it should not be considered for all data or connections. When you are deciding whether to implement encryption, consider how users will access data. If users access data over a public network, data encryption might be required to increase security. However, if all access of SQL data by AD FS involves a secure intranet configuration, encryption might not be required. Any use of encryption should also include a maintenance strategy for passwords, keys, and certificates.  
  
    If there is a concern that any SQL data might be seen or tampered with over your network, use Internet Protocol security (IPsec) or Secure Sockets Layer (SSL) to help secure your SQL connections. However, this might have a negative effect on SQL Server performance, which might affect or limit AD FS performance in some situations. For example, AD FS performance in token issuance might degrade when attribute lookups from a SQL-based attribute store are critical for token issuance. You can better eliminate a SQL tampering threat by having a strong perimeter security configuration. For example, a better solution for securing your SQL Server installation is to ensure that it remains inaccessible for Internet users and computers and that it remains accessible only by users or computers within your datacenter environment.  
  
    For more information, see [Encrypting Connections to SQL Server](https://go.microsoft.com/fwlink/?LinkID=189234) or [SQL Server Encryption](https://go.microsoft.com/fwlink/?LinkID=189233).  
  
-   **Configure securely designed access by using stored procedures to perform all SQL-based lookups by AD FS of SQL-stored data.**  
  
    To provide better service and data isolation, you can create stored procedures for all attribute store lookup commands. You can create a database role to which you then grant permission to run the stored procedures. Assign the service identity of the AD FS Windows service to this database role. The AD FS Windows service should not be able to run any other SQL statement, other than the appropriate stored procedures that are used for attribute lookup. Locking down access to the SQL Server database in this way reduces the risk of an elevation-of-privilege attack.  
  
## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)
