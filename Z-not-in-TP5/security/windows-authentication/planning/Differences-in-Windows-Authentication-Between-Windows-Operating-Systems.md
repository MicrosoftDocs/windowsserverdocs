---
title: Differences in Windows Authentication Between Windows Operating Systems
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e83560cb-577b-4fdf-ad54-ca9894cd549a
---
# Differences in Windows Authentication Between Windows Operating Systems
This reference topic describes the significant differences between operating system versions in the Windows authentication architecture and processes.

The following sections list the significant differences in Windows authentication for each of the Windows versions and points to the relevant documentation. The Windows Server 2003 and Windows XP operating systems are used as baselines.

### Windows Server 2012 R2 and Windows 8.1 authentication architecture
For a summary of security changes including authentication architecture and processes for  Windows Server 2012 R2  and Windows 8.1, see [Security and Protection](Security-and-Protection.md) and [What's Changed in Security Technologies in Windows 8.1 \[Win 8.1\]](assetId:///b92b04bc-95db-4732-b4ec-d35b3f639275).

**Architecture changes from previous version**

-   Additional protections for credential management have been implemented for security groups, Kerberos, Remote Desktop Connection, and the Local Security Authority \(LSA\). For information about these changes, see [Credentials Protection and Management](../../Credentials-Protection-and-Management.md).

-   Changes to the Windows implementation of the Transport Layer Security \(TLS\) and Secure Sockets Layer \(SSL\) protocols include:

    -   TLS session resumption

    -   Application protocol negotiation

    For more information, see [What's New in TLS - SSL &#40;Schannel SSP&#41;](../../tls/ssl-schannel-ssp/get-started/What-s-New-in-TLS---SSL--Schannel-SSP-.md).

### Windows Server 2012 and Windows 8 authentication architecture
For a summary of security changes including authentication architecture and processes for  Windows Server 2012  and Windows 8, see [Security and Protection](Security-and-Protection.md) and [What's Changed in Security Technologies in Windows 8 \[Win 8\]](assetId:///18ddcd57-265c-494e-a9e4-acd1de7e9677).

**Architecture changes from previous version**

-   Changes to the Windows implementation of the Kerberos protocol include:

    -   [Improvements to reduce authentication failures due to large service tickets](../../kerboros/get-started/What-s-New-in-Kerberos-Authentication.md#BKMK_ImprovementsToReduceFailures)

    -   [Branch office support for authentication to resources outside the branch office](../../kerboros/get-started/What-s-New-in-Kerberos-Authentication.md#BKMK_BranchOfficeSupport)

    -   [Support for claims, compound authentication, and Kerberos armoring](../../kerboros/get-started/What-s-New-in-Kerberos-Authentication.md#BKMK_Sup4ClaimsCAarmoring)

    -   [Resource\-based constrained delegation across domains and forest](../../kerboros/get-started/What-s-New-in-Kerberos-Authentication.md#BKMK_CD)

    -   [Enforcement for forest boundary for Kerberos full delegation](../../kerboros/get-started/What-s-New-in-Kerberos-Authentication.md#BKMK_EnforcementForForestBoundary)

    -   [KDC proxy service](../../kerboros/get-started/What-s-New-in-Kerberos-Authentication.md#BKMK_KDCproxyService)

-   Changes to the Windows implementation of the TLS and SSL protocols include:

    -   [Management of trusted issuers for client authentication](../../tls/ssl-schannel-ssp/get-started/What-s-New-in-TLS---SSL--Schannel-SSP-.md#BKMK_TrustedIssuers)

    -   [TLS support for Server Name Indicator (SNI) Extensions](../../tls/ssl-schannel-ssp/get-started/What-s-New-in-TLS---SSL--Schannel-SSP-.md#BKMK_SNI)

    -   [Datagram Transport Layer Security (DTLS)](../../tls/ssl-schannel-ssp/get-started/What-s-New-in-TLS---SSL--Schannel-SSP-.md#BKMK_DTLS)

-   Expansion of the standalone managed service account to include group managed service accounts. For information, see [Group Managed Service Accounts Overview](Group-Managed-Service-Accounts-Overview.md).

### Windows Server 2008 R2 and Windows 7 authentication architecture
**Architecture changes from previous version**

-   [Introducing TLS v1.2](http://technet.microsoft.com/library/dd560644(v=ws.10).aspx)

    TLS has been improved to support hash negotiation, certificate hash or signature control, and Suite B−compliant cipher suites.

-   Credential management

    Credential management in  Windows 7  has changed to give more responsibility to the end user and to let the operating system store and present credentials by using Credential Locker. Users can compose a list of credential associations that through a single logon experience access a variety of systems, programs, or other legitimate resources.

    For more information, see [Credential Locker Overview](assetId:///f1220132-a5a9-47c3-a4e9-116ce17b2bf2).

-   [Changes in Kerberos Authentication](http://technet.microsoft.com/library/dd560670(v=ws.10).aspx)

    Both Data Encryption Standard \(DES\) cipher suites \(DES\-CBC\-MD5 and DES\-CBC\-CRC\) are disabled by default in  Windows 7 . The following cipher suites are enabled by default in  Windows 7  and  Windows Server 2008 R2 :

    -   AES256\-CTS\-HMAC\-SHA1\-96

    -   AES128\-CTS\-HMAC\-SHA1\-96

    -   RC4\-HMAC

-   Changes in the Net Logon service

    The Net Logon service maintains trust relationships and connections \(called secure channel\) between client computers and domain controllers in domains or between domain controllers in trusted domains. It is implemented as a Security Support Provider \(SSP\) and, prior to  Windows 7 , used MD5 and RC4 as cryptography algorithms for remote procedure calls and MD5 and DES for the client.

     Windows 7  adds the capability of using AES\-128 and SHA\-256 to the Net Logon client and to the Net Logon SSP.

-   [Changes in NTLM Authentication](http://technet.microsoft.com/library/dd566199(v=ws.10).aspx)

    In  Windows Server 2008 R2  and  Windows 7 , NTLM\-based minimum session security policy is set to require a minimum of 128\-bit encryption for both client computers and servers for new installations of the Windows operating system. This security policy requires that all network devices and operating systems that are using NTLM support 128\-bit encryption. Existing session security is retained when you upgrade a Windows operating system from an earlier Windows version.

-   [Introducing the Restriction of NTLM Authentication](http://technet.microsoft.com/library/dd560653(v=ws.10).aspx)

    New Group Policy settings in  Windows Server 2008 R2  and  Windows 7  support the auditing and restriction of NTLM protocol usage on clients, servers, and domain controllers. These policies can be configured on computers running  Windows Server 2008 R2  and  Windows 7 , which can affect NTLM usage on computers running earlier versions of Windows.

-   [Introducing Extensions to the Negotiate Authentication Package](http://technet.microsoft.com/library/dd560645(v=ws.10).aspx)

    NegoExts \(NegoExts.dll\) is an authentication package that negotiates the use of Security Support Providers \(SSPs\) for applications and scenarios implemented by Microsoft and other software companies. This extension to the Negotiate package supports the following scenarios:

    -   Rich client availability within a federated system.

    -   Rich client support for Microsoft Office 365.

    -   Hosted Microsoft Exchange Server and Outlook.

    -   Rich client availability between client computers and servers.

-   [Introducing Online Identity Integration](http://technet.microsoft.com/library/dd560662(v=ws.10).aspx)

    In  Windows 7 , users in a small network, such as a home network, can elect to share data, such as media files, between selected computers on a per\-user basis. This feature complements the Homegroup feature in  Windows 7  by using online IDs to identify individuals within the home networks. Users must explicitly link their Windows user account to an online ID to support this authentication. The inclusion of the Public Key Cryptography Based User\-to\-User \(PKU2U\) protocol in Windows permits the authentication to occur by using certificates.

-   [Introducing PKU2U in Windows](http://technet.microsoft.com/library/dd560634(v=ws.10).aspx)

    Public Key Cryptography Based User\-to\-User \(PKU2U\) Security Support Provider \(SSP\) enables peer\-to\-peer authentication, particularly through the  Windows 7  media and file sharing feature called Homegroup, which permits sharing between computers that are not members of a domain.

-   [Introducing the Windows Biometric Service](http://technet.microsoft.com/library/dd566198(v=ws.10).aspx)

    In  Windows Server 2008 R2  and  Windows 7 , administrators and users use fingerprint biometric devices to log on to computers and perform basic management of the fingerprint devices. \(Users might require elevation of permissions through User Account Control.\) Administrators can manage fingerprint biometric devices in Group Policy settings by enabling, limiting, or blocking their use.

-   **Extended authentication protection**

    Extended Protection for Authentication enhances the protection and handling of credentials when authenticating network connections by using Integrated Windows authentication \(IWA\) and NTLM. Extended Protection was introduced in  Windows Server 2008 R2  and  Windows 7  but still available for some earlier versions of Windows and Windows Server. For information about how to update these older systems, see [Extended Protection for Authentication](http://support.microsoft.com/kb/968389).

### Windows Server 2008  and Windows Vista authentication architecture
**Changes from previous version**

-   [Backup and Restore of Stored User Names and Passwords](http://technet.microsoft.com/library/cc749431(v=ws.10).aspx)

    Windows Vista includes a Backup and Restore Wizard that lets users back up user names and passwords that they have requested Windows to remember for them. This new functionality lets users restore the user names and passwords on any computer running Windows Vista. Restoring a backup file on a different computer lets users effectively roam or move their saved user names and passwords.

-   [Credential Security Service Provider and SSO for Terminal Services Logon](http://technet.microsoft.com/library/cc749211(v=ws.10).aspx)

    By using Credential Security Service Provider \(CredSSP\), applications can delegate user credentials from the client computer \(by using the client\-side security service provider\) to the target server \(through the server\-side security service provider\) that is based on client policies. CredSSP policies are configured through Group Policy, and delegation of credentials is turned off by default in this version of Windows Server.

-   [TLS\/SSL Cryptographic Enhancements](http://technet.microsoft.com/library/cc766285(v=ws.10).aspx)

    Advanced Encryption Standard \(AES\) has become a standard for National Institute of Standards and Technology \(NIST\). To ease the process of bulk encryption, cipher suites that support AES have been added.

-   [Kerberos Enhancements](http://technet.microsoft.com/library/cc749438(v=ws.10).aspx)

    Advanced Encryption Standard: The improvement enables the use of AES\-128 and AES\-256 encryption with the Kerberos authentication protocol. In  Windows Server 2008  and Windows Vista, the base Kerberos protocol supports AES for encryption of ticket\-granting tickets \(TGTs\), service tickets, and session keys. In addition, Generic Security Service \(GSS\) messages, which conduct client\/server communications, support AES.

-   [Smart Card Authentication Changes](http://technet.microsoft.com/library/cc721959(v=ws.10).aspx)

    To better support smart card deployments, the range of compatible certificates has been increased.

-   [Previous Logon Information](http://technet.microsoft.com/library/cc749292(v=ws.10).aspx)

    This security policy setting enables users to determine whether their accounts were used or were attempted to be used without their knowledge.

-   [Extended Protection for Authentication](http://support.microsoft.com/kb/968389)

    Extended Protection for Authentication enhances the protection and handling of credentials when authenticating network connections by using Integrated Windows authentication \(IWA\).

## See also
[Windows Authentication Technical Overview](../get-started/Windows-Authentication-Technical-Overview.md)


