---
title: Security Policy Settings Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2fdcbb11-8037-45b1-9015-665393268e36
---
# Security Policy Settings Overview
This topic provides high-level information about security settings in, and links to more detailed reference topics, procedures, and guides about security policy settings.

**Did you mean…**

-   Group Policy (see [Group Policy Overview](Group-Policy-Overview.md))

-   Threats and Countermeasures Guide (see the resources on [Windows Server Security](http://technet.microsoft.com/windowsserver/ff843381))

## <a name="BKMK_OVER"></a>Security policy settings description
Security settings incorporated into policies are rules that administrators configure on a computer or multiple computers for the purpose of protecting resources on a computer or network. The Security Settings extension of the Local Group Policy Object Editor snap-in allows you to define security configurations as part of a Group Policy Object (GPO). The GPOs are linked to Active Directory containers such as sites, domains, or organizational units, and enable administrators to manage security settings for multiple computers from any computer joined to the domain. Security settings are used as part of your overall security implementation to help secure domain controllers, servers, clients and other resources in your organization.

## <a name="BKMK_APP"></a>Practical applications
Security settings can control:

-   User authentication to a network or computer.

-   The resources that users are permitted to access.

-   Whether to record a user’s or group’s actions in the Event log.

-   Membership in a group.

## <a name="BKMK_NEW"></a>New and changed functionality
There are no changes in functionality to the tools and snap-ins used to administer security policy settings on the local computer or throughout the domain using Group Policy.

There were no policy settings added in  Windows Server 2012 R2  and Windows 8.1.

The following table lists the Security Settings new for  Windows Server 2012  and Windows 8. For detailed descriptions of these and other settings, see [Security Policy Settings Reference](Security-Policy-Settings-Reference.md).

|Security policy|Location|Description|
|-------------------|------------|---------------|
|Accounts: Block Microsoft accounts|Windows Settings/Security Settings/Local Policies/Security Options|This policy setting prevents users from adding new Microsoft accounts on this computer.|
|Interactive logon: Machine account threshold.|Windows Settings/Security Settings/Local Policies/Security Options|The computer lockout policy is enforced only on those computers that have BitLocker enabled for protecting operating system volumes. Please ensure that appropriate recovery password backup policies are enabled.|
|Interactive logon: Machine inactivity limit.|Windows Settings/Security Settings/Local Policies/Security Options|Windows notices inactivity of a logon session, and if the amount of inactive time exceeds the inactivity limit, then the screen saver will run, locking the session.|
|Microsoft network server: Attempt S4U2Self to obtain claim information|Windows Settings/Security Settings/Local Policies/Security Options|This security setting is to support clients running a version of Windows prior to Windows 8 that are trying to access a file share that requires user claims. This setting determines whether the local file server will attempt to use Kerberos Service-For-User-To-Self (S4U2Self) functionality to obtain a network client principal’s claims from the client’s account domain|
|Packaged app Rules|Windows Settings/Security Settings/Application Control Policies/AppLocker|AppLocker rules that apply to files that share the same attributes: publisher name, package name, and package version.|

## <a name="BKMK_DEP"></a>Deprecated functionality
No functionality to set or maintain security settings has been deprecated in the versions designated in the **Applies to** list at the top of this page.

## <a name="BKMK_LINKS"></a>See also
For information about methods to administer security policies and policy settings, see [Administer Security Policy Settings](Administer-Security-Policy-Settings.md).

The following table provides links to additional resources that can help you understand and implement security policies using security settings in the versions designated in the **Applies to** list at the top of this page.

||References|
|-|--------------|
|**Deployment**|[Group Policy Settings Reference for Windows and Windows Server from Official Microsoft Download Center](http://www.microsoft.com/download/details.aspx?id=25250)|
|**Operations**|[Administer Security Policy Settings](Administer-Security-Policy-Settings.md)|
|**Troubleshooting**|For Windows Server 2003 and Windows XP, see [Security Settings Extension Technical Reference](http://technet.microsoft.com/library/cc775940(v=ws.10).aspx)<br /><br />For  Windows Server 2008 R2 ,  Windows Server 2008 ,  Windows 7 , and  Windows Vista, see [Server Security Policy Management Technical Reference](http://technet.microsoft.com/library/cc731459(v=ws.10).aspx).<br /><br />For others, see [Security Policy Settings Technical Overview](Security-Policy-Settings-Technical-Overview.md).|
|**Security**|[Windows Security Survival Guide](http://social.technet.microsoft.com/wiki/contents/articles/windows-security-survival-guide.aspx)<br /><br />[Threats and Countermeasures Guide: Security Settings in Windows Server 2008 R2 and Windows 7](http://technet.microsoft.com/library/hh125921(WS.10).aspx)<br /><br />For  Windows Server 2012  and Windows 8, see [Microsoft Security Compliance Manager (SCM)](http://social.technet.microsoft.com/wiki/contents/articles/774.microsoft-security-compliance-manager-scm.aspx) in the TechNet Wiki.|
|**Tools and settings**|[Security Policy Settings Technical Overview](Security-Policy-Settings-Technical-Overview.md)<br /><br />[Security Policy Settings Reference](Security-Policy-Settings-Reference.md)<br /><br />For Windows Server 2003, see [Security Settings Extension Technical Reference](http://technet.microsoft.com/library/cc775940(v=ws.10).aspx)<br /><br />[Download: Group Policy Settings Reference for Windows and Windows Server](http://www.microsoft.com/download/details.aspx?id=25250)|
|**Community resources**|[Windows Security Survival Guide](http://social.technet.microsoft.com/wiki/contents/articles/windows-security-survival-guide.aspx)|
|**Related technologies**|[Group Policy Overview](Group-Policy-Overview.md)|


