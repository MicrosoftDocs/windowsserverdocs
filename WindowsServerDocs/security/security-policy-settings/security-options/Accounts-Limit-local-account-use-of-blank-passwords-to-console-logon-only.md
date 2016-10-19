---
title: Accounts: Limit local account use of blank passwords to console logon only
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-policy-settings
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 196142cb-bd7d-47e2-b18c-11d83220b15c
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Accounts: Limit local account use of blank passwords to console logon only

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This security policy reference topic for the IT professional describes the best practices, location, values, and security considerations for this policy setting.  
  
## Reference  
The **Accounts: Limit local account use of blank passwords to console logon only** policy setting determines whether remote interactive logons by network services such as Remote Desktop Services (formerly Terminal Services), Telnet, and File Transfer Protocol (FTP) are allowed for local accounts that have blank passwords. If this policy setting is enabled, a local account must have a nonblank password to be used to perform an interactive or network logon from a remote client.  
  
This policy setting does not affect interactive logons that are performed physically at the console or logons that use domain accounts. It is possible for non-Microsoft applications that use remote interactive logons to bypass this policy setting.  
  
Blank passwords are a serious threat to computer security and they should be forbidden through both corporate policy and suitable technical measures. Nevertheless, if a user with the ability to create new accounts creates one that has bypassed your domain-based password policy settings, that account might have a blank password. For example, a user could build a stand-alone system, create one or more accounts with blank passwords, and then join the computer to the domain. The local accounts with blank passwords would still function. Anyone who knows the account name can then use accounts with blank passwords to log on to systems.  
  
Computers that are not in physically secure locations should always enforce strong password policies for all local user accounts. Otherwise, anyone with physical access to the computer can log on by using a user account that does not have a password. This is especially important for portable computers.  
  
If you apply this security policy to the Everyone group, no one will be able to log on through Remote Desktop Services.  
  
### Possible values  
  
-   Enabled  
  
-   Disabled  
  
-   Not defined  
  
### Best practices  
  
1.  It is advisable to set **Accounts: Limit local account use of blank passwords to console logon only** to Enabled.  
  
### Location  
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options  
  
### Default values  
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy???s property page.  
  
|Server type or GPO|Default value|  
|-----------|---------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Not defined|  
|Stand-Alone Server Default Settings|Enabled|  
|DC Effective Default Settings|Enabled|  
|Member Server Effective Default Settings|Enabled|  
|Client Computer Effective Default Settings|Enabled|  
  
### Operating system version differences  
There are no differences in this policy between operating systems beginning with Windows Server 2003.  
  
## Policy management  
This section describes features and tools that are available to help you manage this policy.  
  
### Restart requirement  
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.  
  
### Policy conflict considerations  
The policy as distributed through the GPO takes precedence over the locally configured policy setting on a computer joined to a domain. On the domain controller, use ADSI Edit or the dsquery command to determine effective minimum password length.  
  
### Group Policy  
This policy setting can be configured by using the Group Policy Management Console (GPMC) to be distributed through Group Policy Objects (GPOs). If this policy is not contained in a distributed GPO, this policy can be configured on the local computer by using the Local Security Policy snap-in.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
Blank passwords are a serious threat to computer security, and they should be forbidden through organizational policy and suitable technical measures.The default settings for Active Directory?? domains in Windows Server 2003 require complex passwords of at least seven characters, and eight characters for  Windows Server 2008 R2  and  Windows Server 2008 . However, if users with the ability to create new accounts bypass your domain-based password policies, they could create accounts with blank passwords. For example, a user could build a stand-alone computer, create one or more accounts with blank passwords, and then join the computer to the domain. The local accounts with blank passwords would still function. Anyone who knows the name of one of these unprotected accounts could then use it to log on.  
  
### Countermeasure  
Enable the **Accounts: Limit local account use of blank passwords to console logon only** setting.  
  
### Potential impact  
None. This is the default configuration.  
  

