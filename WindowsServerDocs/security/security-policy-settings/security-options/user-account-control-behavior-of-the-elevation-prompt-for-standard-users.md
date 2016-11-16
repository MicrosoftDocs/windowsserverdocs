---
title: User Account Control: Behavior of the elevation prompt for standard users
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-policy-settings
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cb834bb5-20ba-4e11-a91f-a17fb745376b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# User Account Control: Behavior of the elevation prompt for standard users

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting.  
  
## Reference  
This policy setting determines the behavior of the elevation prompt for standard users.  
  
### Possible values  
  
-   **Automatically deny elevation requests**  
  
    This option returns an ???Access denied??? error message to standard users when they try to perform an operation that requires elevation of privilege. Most enterprises that run desktops as standard users configure this policy to reduce Help Desk calls.  
  
-   **Prompt for credentials on the secure desktop**  
  
    This is the default. When an operation requires elevation of privilege, the user is prompted on the secure desktop to enter a different user name and password. If the user enters valid credentials, the operation continues with the applicable privilege.  
  
-   **Prompt for credentials**  
  
    An operation that requires elevation of privilege prompts the user to type an administrative user name and password. If the user enters valid credentials, the operation continues with the applicable privilege.  
  
### Best practices  
  
1.  Configure the **User Account Control: Behavior of the elevation prompt for standard users** to **Automatically deny elevation requests**. This setting requires the user to log on with an administrative account to run programs that require elevation of privilege.  
  
2.  As a security best practice, standard users should not have knowledge of administrative passwords. However, if your users have both standard and administrator-level accounts, set **Prompt for credentials** so that the users do not choose to always log on with their administrator accounts, and they shift their behavior to use the standard user account.  
  
### Location  
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options  
  
### Default values  
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy???s property page.  
  
|Server type or GPO|Default value|  
|-----------|---------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Not defined|  
|Stand-Alone Server Default Settings|Prompt for credentials on the secure desktop|  
|DC Effective Default Settings|Prompt for credentials on the secure desktop|  
|Member Server Effective Default Settings|Prompt for credentials on the secure desktop|  
|Client Computer Effective Default Settings|Prompt for credentials on the secure desktop|  
  
### Operating system version differences  
The default in Windows Vista and Windows Server 2008 is **Prompt for credentials**. In  Windows Server 2008 R2  and  Windows 7 , the default is changed to **Prompt for credentials on the secure desktop**.  
  
## Policy management  
This section describes features and tools that are available to help you manage this policy.  
  
### Restart requirement  
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.  
  
### Group Policy  
Distributing this policy through Group Policy to operating systems earlier than Windows Vista and Windows Server 2008 will have no impact (because UAC was first introduced in Windows Vista).  
  
Distributing this policy to computers running Windows Vista and Windows Server 2008 will change the default option to **Prompt for credentials on the secure desktop**. You will need to test that the resultant behavior is as you expect.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
One of the risks that the UAC feature tries to mitigate is that of malicious programs running under elevated credentials without the user or administrator being aware of their activity. This setting raises awareness to the user that a program requires the use of elevated privilege operations, and it requires that the user supply administrative credentials for the program to run.  
  
### Countermeasure  
Configure the **User Account Control: Behavior of the elevation prompt for standard users** to **Automatically deny elevation requests**. This setting requires the user to log on with an administrative account to run programs that require elevation of privilege. As a security best practice, standard users should not have knowledge of administrative passwords. However, if your users have both standard and administrator-level accounts, we recommend setting **Prompt for credentials** so that the users do not choose to always log on with their administrator accounts,and they shift their behavior to use the standard user account.  
  
### Potential impact  
Users must provide administrative passwords to run programs with elevated privileges. This could cause an increased load on IT staff while the programs that are affected are identified and standard operating procedures are modified to support least privilege operations.  
  

