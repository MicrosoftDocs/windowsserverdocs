---
title: Preventing Kerberos change password that use RC4 secret keys
ms.custom: na
ms.prod: windows-server
ms.topic: article
ms.assetid: de207d55-aa3d-4c16-bd3b-496db43663a4
manager: alanth
author: justinha
ms.technology: security-crdential-protection-and-management
ms.date: 11/09/2016
---

# Preventing Kerberos change password that uses RC4 secret keys

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2008 R2, and Windows Server 2008

This topic for the IT professional explains some limitations in the Kerberos protocol that could lead to a malicious user taking control of a user's account. There is a limitation in the Kerberos Network Authentication Service (V5) standard (RFC 4120), which is well-known within the industry, whereby an attacker can authenticate as a user or change that user's password if the attacker knows the user's secret key.

Possession of a user's password-derived Kerberos secret keys (RC4 and Advanced Encryption Standard [AES] by default) is validated during the Kerberos password change exchange per RFC 4757. The user's plaintext password is never provided to the Key Distribution Center (KDC), and by default, Active Directory domain controllers do not possess a copy of plaintext passwords for accounts. If the domain controller does not support a Kerberos encryption type, that secret key cannot be used to change the password. 

In the Windows operating systems designated in the Applies To list at the beginning of this topic, there are three ways to block the ability to change passwords by using Kerberos with RC4 secret keys:

- Configure the user account to include the account option Smart card is required for interactive logon. This limits the user to only signing in with a valid smart card so that RC4 authentication service requests (AS-REQs) are rejected. To set the account options on an account, right-click on the account, the click Properties, and click the Account tab. 

- Disable RC4 support for Kerberos on all domain controllers. This requires a minimum of a Windows Server 2008 domain functional level and an environment where all Kerberos clients, application servers, and trust relationships to and from the domain must support AES. Support for AES was introduced in Windows Server 2008 and Windows Vista.

    [!NOTE]
    There is a known issue with disabling RC4 which can cause the system to restart. See the following hotfixes:
    - [Windows Server 2012 R2](https://support.microsoft.com/kb/3038261)
    - [Windows Server 2012](https://support.microsoft.com/kb/3086213)
    - No hotfix is available for earlier versions of Windows Server

- Deploy domains set to Windows Server 2012 R2 domain functional level or higher, and configure users as members of the Protected Users security group. Because this feature disrupts more than just RC4 usage in the Kerberos protocol, see resources in the following [See also](#see-also) section.

## See Also

- For information about how to prevent the usage of the RC4 encryption type in Windows Server 2012 R2 domains, see [Protected Users Security Group](/../credentials-protection-and-management/protected-users-security-group.md), and [How to Configure Protected Accounts](/../credentials-protection-and-management/how-to-configure-protected-accounts.md).

- For explanations about RFC 4120 and RFC 4757, see [IETF Documents](http://tools.ietf.org/html/).
