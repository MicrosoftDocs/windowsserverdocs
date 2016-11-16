---
title: User Account Control: Admin Approval Mode for the Built-in Administrator account
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-policy-settings
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c52b5058-9170-411d-b079-86d5563c8af9
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# User Account Control: Admin Approval Mode for the Built-in Administrator account

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting.  
  
## Reference  
This policy setting determines the behavior of Admin Approval Mode for the built-in Administrator account.  
  
When the Admin Approval Mode is enabled, the local Administrator account functions like a standard user account, but it has the ability to elevate privileges without logging on by using a different account. In this mode, any operation that requires elevation of privilege displays a prompt that allows the administrator to permit or deny the elevation of privilege. If Admin Approval Mode is not enabled, the built-in Administrator account logs on in Windows XP Mode, and it runs all applications by default with full administrative privileges. By default, this setting is set to **Disabled**.  
  
> [!NOTE]  
> If a computer is upgraded from a previous version of the Windows operating system, and the Administrator account is the only account on the computer, the built-in Administrator account remains enabled, and this setting is also enabled.  
  
### Possible values  
  
-   Enabled  
  
    The built-in Administrator account logs on in Admin Approval Mode so that any operation that requires elevation of privilege displays a prompt that provides the administrator the option to permit or deny the elevation of privilege.  
  
-   Disabled  
  
    The built-in Administrator account logs on in Windows XP Mode, and it runs all applications by default with full administrative privileges.  
  
### Best practices  
  
1.  Do not enable the built-in Administrator account on the client computer, but use the Standard User account and User Account Control (UAC).  
  
### Location  
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options  
  
### Default values  
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy???s property page.  
  
|Server type or GPO|Default value|  
|-----------|---------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Not defined|  
|Stand-Alone Server Default Settings|Disabled|  
|DC Effective Default Settings|Disabled|  
|Member Server Effective Default Settings|Disabled|  
|Client Computer Effective Default Settings|Disabled|  
  
### Operating system version differences  
There are no differences in this policy between operating systems beginning with Windows Server 2008.  
  
## Policy management  
This section describes features and tools that are available to help you manage this policy.  
  
### Restart requirement  
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
One of the risks of the User Account Control (UAC) feature that is included in computers running at least Windows Vista or  Windows Server 2008  is that it is intended to mitigate malicious software running under elevated credentials without the user or administrator being aware of its activity. An attack vector for malicious programs is to discover the password of the Administrator account because that user account was created for all installations of the Windows operating system. To address this risk, the built-in Administrator account is disabled in computers running at least Windows Vista. In computers running at least  Windows Server 2008 , the Administrator account is enabled, and the password must be changed the first time the Administrator logs on. In a default installation of a computer running at least Windows Vista, accounts with administrative control over the computer are initially set up in one of two ways:  
  
-   If the computer is not joined to a domain, the first user account you create has the equivalent permissions as a local administrator.  
  
-   If the computer is joined to a domain, no local administrator accounts are created. The enterprise or domain administrator must log on to the computer and create a local administrator account if one is warranted.  
  
After Windows Vista or  Windows 7  is installed, you can enable the built-in Administrator account, but we strongly recommend that this account remain disabled.  
  
### Countermeasure  
Enable the **User Account Control: Admin Approval Mode for the Built-in Administrator account** setting if you have the built-in Administrator account enabled.  
  
### Potential impact  
Users who log on by using the local Administrator account are prompted for consent whenever a program requests an elevation in privilege.  
  

