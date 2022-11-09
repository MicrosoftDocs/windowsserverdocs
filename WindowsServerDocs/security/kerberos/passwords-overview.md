---
title: Passwords Overview
description: Learn about passwords as they are used in the Windows operating systems, and find links to documentation and discussions about the use of passwords in a credential management strategy.
ms.topic: article
ms.assetid: f608960e-2039-4c91-9c8c-9b81053c675e
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/12/2016
---
# Passwords Overview

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

This topic for the IT professional describes passwords as used in the Windows operating systems, and links to documentation and discussions about the use of passwords in a credential management strategy.

## <a name="BKMK_OVER"></a>Feature description
Operating systems and applications today are architected around passwords and even if you use smart cards or biometric systems, all accounts still have passwords and they can still be used in some circumstances. Some accounts, notably accounts used to run services, cannot even use smart cards and biometric tokens and therefore must use a password to authenticate. Windows protects passwords using cryptographic hashes.

For more information about Windows passwords, see [Passwords Technical Overview](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/hh994558(v=ws.10)).

## <a name="BKMK_APP"></a>Practical applications
In Windows and many other operating systems, the most common method for authenticating a user's identity is to use a secret passphrase or password. Securing your network environment requires that strong passwords be used by all users. This helps avoid the threat of a malicious user guessing a weak password, whether through manual methods or by using tools, to acquire the credentials of a compromised user account. This is especially true for administrative accounts. When you change a complex password regularly, it reduces the likelihood of a password attack compromising that account.

## <a name="BKMK_NEW"></a>New and changed functionality
In Windows Server 2012 and Windows 8, picture passwords are new. Picture passwords are a combination of a user selected image coupled with a series of gestures. Picture password functionality is disabled on domain\-joined computers. Links to more information about picture passwords are listed in [See Also](#BKMK_LINKS) below.

There has been no change to password functionality in Windows Server 2012 and Windows 8. No new Group Policy settings have been added. However, improvements and enhancements have been made in credential \(and password\) management, such as with picture passwords, Credential Locker and signing in to Windows 8 with a Microsoft account, formerly known as a Windows Live ID.

## <a name="BKMK_DEP"></a>Deprecated functionality
No password functionality has been deprecated in Windows Server 2012 and Windows 8.

## <a name="BKMK_SOFT"></a>Software requirements
In enterprise environments, passwords are typically managed with Active Directory Domain Services. Passwords can also be managed on the local computer using the settings in local Security Settings, Account Policies, Password Policy.

## <a name="BKMK_LINKS"></a>See also
This table lists additional resources for password features, technology and credential management.

|Content type|References|
|--------|-------|
|**Scenario documentation**|[Protecting your digital identity](https://blogs.msdn.com/b/b8/archive/2011/12/14/protecting-your-digital-identity.aspx)|
|**Operations**|[Active Directory Users and Computers](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754217(v=ws.11))|
|**Troubleshooting**|[Find out when your Password Expires \- Active Directory PowerShell Blog](https://blogs.msdn.com/b/adpowershell/archive/2010/08/09/9970198.aspx)|
|**Security**| Windows Server 2008 R2  and  Windows 7 [Threats and Countermeasures Guide: Account Policies](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/hh125920(v=ws.10))<p>Guidance to [change and create strong passwords](https://support.microsoft.com/en-us/windows/create-and-use-strong-passwords-c5cebb49-8c53-4f5e-2bc4-fe357ca048eb)|
|**Tools and settings**|[Group Policy Settings Reference for Windows and Windows Server on the Microsoft Download Center](https://www.microsoft.com/download/en/details.aspx?amp;displaylang=en&displaylang=en&id=25250)|
|**Community resources**|[Protecting your digital identity](https://blogs.msdn.com/b/b8/archive/2011/12/14/protecting-your-digital-identity.aspx)<p>[Signing in to Windows 8 with a Windows Live ID](https://blogs.msdn.com/b/b8/archive/2011/09/26/signing-in-to-windows-8-with-a-windows-live-id.aspx)<p>[Signing in with a picture password](/archive/blogs/b8/signing-in-with-a-picture-password)<p>[Optimizing picture password security](/archive/blogs/b8/optimizing-picture-password-security)|
