---
title: Password Policy
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-policy-settings
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cac99ec3-cb1d-447e-abe1-55705331f042
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Password Policy

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This security policy reference topic for the IT professional provides an overview of password policies for Windows and links to information for each policy setting.  
  
In many operating systems, the most common method to authenticate a user's identity is to use a secret passphrase or password. A secure network environment requires all users to use strong passwords, which have at least eight characters and include a combination of letters, numbers, and symbols. These passwords help prevent the compromise of user accounts and administrative accounts by unauthorized users who use manual methods or automated tools to guess weak passwords. Strong passwords that are changed regularly reduce the likelihood of a successful password attack.  
  
Introduced in  Windows Server 2008 R2  and  Windows Server 2008 , Windows supports fine-grained password policies. This feature provides organizations with a way to define different password and account lockout policies for different sets of users in a domain. In Windows 2000 Server and Windows Server 2003 Active Directory domains, only one password policy and account lockout policy could be applied to all users in the domain. Fine-grained password policies apply only to user objects (or inetOrgPerson objects if they are used instead of user objects) and global security groups.  
  
To apply a fine-grained password policy to users of an OU, you can use a shadow group. A shadow group is a global security group that is logically mapped to an OU to enforce a fine-grained password policy. You add users of the OU as members of the newly created shadow group and then apply the fine-grained password policy to this shadow group. You can create additional shadow groups for other OUs as needed. If you move a user from one OU to another, you must update the membership of the corresponding shadow groups.  
  
Fine-grained password policies include attributes for all the settings that can be defined in the default domain policy (except Kerberos settings) in addition to account lockout settings. When you specify a fine-grained password policy, you must specify all of these settings. By default, only members of the Domain Admins group can set fine-grained password policies. However, you can also delegate the ability to set these policies to other users. The domain must be running at least  Windows Server 2008 R2  or  Windows Server 2008  to use fine-grained password policies. Fine-grained password policies cannot be applied to an organizational unit (OU) directly.  
  
Fine-grained password policies do not interfere with custom password filters that you might use in the same domain. Organizations that have deployed custom password filters to domain controllers running Windows 2000 Server or Windows Server 2003 can continue to use those password filters to enforce additional restrictions for passwords. For more information about fine-grained password policies, see [AD DS: Fine-Grained Password Policies](http://go.microsoft.com/fwlink/?LinkId=130888).  
  
You can enforce the use of strong passwords through an appropriate password policy. There are password policy settings that control the complexity and lifetime of passwords, such as the **Passwords must meet complexity requirements** policy setting.  
  
You can configure the password policy settings in the following location by using the Group Policy Management Console on your domain controller:  
  
**Computer Configuration\Windows Settings\Security Settings\Account Policies\Password Policy**  
  
If individual groups require distinct password policies, these groups should be separated into another domain or forest, based on additional requirements.  
  
For information about setting security policies, see [How to Configure Security Policy Settings](how-to-configure-security-policy-settings.md).  
  
The following topics provide a discussion of password policy implementation and best practices considerations, policy location, default values for the server type or GPO, relevant differences in operating system versions, security considerations (including the possible vulnerabilities of each setting), countermeasures that you can take, and the potential impact for each setting.  
  
-   [Enforce password history](enforce-password-history.md)  
  
-   [Maximum password age](maximum-password-age.md)  
  
-   [Minimum password age](minimum-password-age.md)  
  
-   [Minimum password length](minimum-password-length.md)  
  
-   [Password must meet complexity requirements](password-must-meet-complexity-requirements.md)  
  
-   [Store passwords using reversible encryption](store-passwords-using-reversible-encryption.md)  
  

