---
title: Accounts: Administrator account status
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-policy-settings
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 09d57026-f8fc-465a-8038-5292f0682c80
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Accounts: Administrator account status

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This security policy reference topic for the IT professional describes the best practices, location, values, and security considerations for this policy setting.  
  
## Reference  
This security setting determines whether the local Administrator account is enabled or disabled.  
  
If you try to enable the Administrator account after it has been disabled, and if the current Administrator password does not meet the password requirements, you cannot enable the account. In this case, an alternative member of the Administrators group must reset the password on the Administrator account.  
  
If you disable this policy setting, and one of the following conditions exists on the computer, the Administrator account is not disabled.  
  
1.  No other local Administrator account exists  
  
2.  The Administrator account is currently in use  
  
3.  All other local Administrator accounts are:  
  
    1.  Disabled  
  
    2.  Listed in the **Deny log on locally** User Rights Assignment  
  
If the current Administrator password does not meet the password requirements, you will not be able to enable the Administrator account again after it has been disabled. In this case, another member of the Administrators group must set the password on the Administrator account by using the Local Users and Groups tool.  
  
### Possible values  
  
-   Enabled  
  
-   Disabled  
  
-   Not defined  
  
By default, this setting is **Not defined** on domain controllers and **Enabled** on stand-alone servers.  
  
### Best practices  
  
1.  Disabling the Administrator account can become a maintenance issue under certain circumstances. For example, in a domain environment, if the secure channel that constitutes your connection fails for any reason, and there is no other local Administrator account, you must restart the computer in safe mode to fix the problem that broke your connection status.  
  
### Location  
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options  
  
### Default values  
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy’s property page.  
  
|Server type or GPO|Default value|  
|----------------------|-----------------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Not defined|  
|Stand-Alone Server Default Settings|Enabled|  
|DC Effective Default Settings|Enabled|  
|Member Server Effective Default Settings|Enabled|  
|Client Computer Effective Default Settings|Disabled|  
  
### Operating system version differences  
There are no differences in this policy setting between operating systems for the versions designated in the **Applies to** list at the beginning of this topic.  
  
## Policy management  
Disabling the Administrator account can become a maintenance issue under certain circumstances. Reasons that an organization might consider disabling the built-in Administrator account include:  
  
-   For some organizations, periodically changing the passwords for local accounts can be a daunting management challenge.  
  
-   By default, the Administrator account cannot be locked—no matter how many failed attempts to sign in a user accrues. This makes it a prime target for brute-force, password-guessing attacks.  
  
-   This account has a well-known security identifier (SID). Some non-Microsoft tools allow you to authenticate over the network by specifying the SID rather than the account name. This means that even if you rename the Administrator account, a malicious user could start a brute-force attack by using the SID.  
  
### Restart requirement  
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.  
  
### Safe mode considerations  
When you start a computer in safe mode, the disabled Administrator account is enabled only if the computer is non-domain joined and there are no other active local Administrator accounts. If the computer is joined to a domain, the disabled Administrator account is not enabled.  
  
If the Administrator account is disabled, you can still access the computer by using safe mode with the current administrative credentials. For example, if a failure occurs using a secure channel with a domain-joined computer, and there is no other local Administrator account, you must restart the computer in safe mode to fix the failure.  
  
### How to access a disabled Administrator account  
  
> [!NOTE]  
> The following conditions and remedies apply to computers running Windows Server 2012, Windows Server 2008 R2, or Windows Server 2008.  
  
You can use the following methods to access a disabled Administrator account:  
  
-   When there is only one local Administrator accountthat is disabled, start the computer in safe mode (locally or over a network), and sign in by using the credentials for the Administrator account on that computer.  
  
-   When there are local Administrator accounts in addition to the built-in account, start the computer in safe mode (locally or over a network), and sign in by using the credentials for the Administrator account on that computer. An alternate method is to sign in to Windows by using another local Administrator account that was created.  
  
-   When multiple domain-joined servers have a disabled local Administrator account that can be accessed in safe mode, you can remotely run the Sysinternals tool, PsExec, by using the following command: net user administrator /active: no.  
  
-   You can update a Group Policy Object (GPO) by using the **Group Policy Management Editor** as follows:  
  
##### To access a disabled Administrator account  
  
1.  Under **Computer Configuration**, click **Preferences**, and then click **Control Panel Settings**.  
  
2.  Right-click **Local Users and Groups**, select **New**, and then click **Local User**.  
  
3.  In the **User name** field, type **Administrator**.  
  
4.  Enter and remember an acceptable password, if required.  
  
5.  Clear the **User must change password at next logon** check box.  
  
6.  Select **Account is disabled.**  
  
7.  Click **OK**.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
The built-in Administrator account cannot be locked out no matter how many failed logons it accrues, which makes it a prime target for brute-force attacks that attempt to guess passwords. Also, this account has a well-known security identifier (SID), and there are non-Microsoft tools that allow authentication by using the SID rather than the account name. Therefore, even if you rename the Administrator account, an attacker could launch a brute-force attack by using the SID to log on. All other accounts that are members of the Administrator's group have the safeguard of locking out the account if the number of failed logons exceeds its configured maximum.  
  
### Countermeasure  
Disable the **Accounts: Administrator account status** setting so that the built-in Administrator account cannot be used in a normal system startup.  
  
If it is very difficult to maintain a regular schedule for periodic password changes for local accounts, you can disable the built-in Administrator account instead of relying on regular password changes to protect it from attack.  
  
### Potential impact  
Maintenance issues can arise under certain circumstances if you disable the Administrator account. For example, if the secure channel between a member computer and the domain controller fails in a domain environment for any reason and there is no other local Administrator account, you must restart in safe mode to fix the problem that caused the secure channel to fail.  
  
If the current Administrator password does not meet the password requirements, you cannot enable the Administrator account after it is disabled. If this situation occurs, another member of the Administrators group must set the password on the Administrator account with the Local Users and Groups tool.  
  

