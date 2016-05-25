---
title: User Account Control: Behavior of the elevation prompt for administrators in Admin Approval Mode
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5a7501c2-835c-4d15-b164-d716a7c44221
---
# User Account Control: Behavior of the elevation prompt for administrators in Admin Approval Mode
This security policy reference topic for the IT professional describes the best practices, location, values, policy management and security considerations for this policy setting.  
  
## Reference  
This policy setting determines the behavior of the elevation prompt for accounts that have administrative credentials.  
  
### Possible values  
  
-   Elevate without prompting  
  
    Assumes that the administrator will permit an operation that requires elevation, and additional consent or credentials are not required.  
  
    > [!NOTE]  
    > Selecting **Elevate without prompting** minimizes the protection that is provided by the UAC feature. We do not recommend selecting this value unless administrator accounts are tightly controlled and the operating environment is highly secure.  
  
-   Prompt for credentials on the secure desktop  
  
    When an operation requires elevation of privilege, the user is prompted on the secure desktop to enter a privileged user name and password. If the user enters valid credentials, the operation continues with the user's highest available privilege.  
  
-   Prompt for consent on the secure desktop  
  
    When an operation requires elevation of privilege, the user is prompted on the secure desktop to select **Permit** or **Deny**. If the user selects **Permit**, the operation continues with the user's highest available privilege.  
  
-   Prompt for credentials  
  
    An operation that requires elevation of privilege prompts the administrator to type the user name and password. If the administrator enters valid credentials, the operation continues with the applicable privilege.  
  
-   Prompt for consent  
  
    An operation that requires elevation of privilege prompts the administrator to select **Permit** or **Deny**. If the administrator selects **Permit**, the operation continues with the administrator's highest available privilege.  
  
-   Prompt for consent for non\-Windows binaries  
  
    This is the default. When an operation for a non\-Microsoft application requires elevation of privilege, the user is prompted on the secure desktop to select **Permit** or **Deny**. If the user selects **Permit**, the operation continues with the user's highest available privilege.  
  
### Best practices  
  
1.  Selecting the option **Elevate without prompting** minimizes the protection that is provided by the UAC feature. We do not recommend selecting this value unless administrator accounts are tightly controlled and the operating environment is highly secure.  
  
### Location  
*GPO\_name*\\Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\Security Options  
  
### Default values  
The following table lists the actual and effective default values for this policy. Default values are also listed on the policy’s property page.  
  
|Server type or GPO|Default value|  
|----------------------|-----------------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Not defined|  
|Stand\-Alone Server Default Settings|Prompt for consent for non\-Windows binaries|  
|DC Effective Default Settings|Prompt for consent for non\-Windows binaries|  
|Member Server Effective Default Settings|Prompt for consent for non\-Windows binaries|  
|Client Computer Effective Default Settings|Prompt for consent for non\-Windows binaries|  
  
### Operating system version differences  
The default in Windows Vista and Windows Server 2008 was **Prompt for consent**. In [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], the default was changed and three options were added:  
  
-   **Prompt for credentials on the secure desktop**  
  
-   **Prompt for consent on the secure desktop**  
  
-   **Prompt for consent for non\-Windows binaries** \(default\)  
  
## Policy management  
This section describes features and tools that are available to help you manage this policy.  
  
### Restart requirement  
None. Changes to this policy become effective without a computer restart when they are saved locally or distributed through Group Policy.  
  
### Group Policy  
Distributing this policy through Group Policy to computers running at least the Windows Vista or Windows Server 2008 operating systems will have no impact \(because UAC was first introduced in Windows Vista\).  
  
Distributing this policy to computers running Windows Vista and Windows Server 2008 will change the default option to **Prompt for consent for non\-Windows binaries**. You will need to test that the resultant behavior is as you expect.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
One of the risks that the UAC feature  tries to mitigate is that of malicious software running under elevated credentials without the user or administrator being aware of its activity. This setting raises awareness to the administrator of elevated privilege operations, and it permits the administrator to prevent a malicious program from elevating its privilege when the program attempts to do so.  
  
### Countermeasure  
Configure the **User Account Control: Behavior of the elevation prompt for administrators in Admin Approval Mode** setting to **Prompt for consent**.  
  
### Potential impact  
Administrators should be made aware that they will be prompted for consent when all binaries attempt to run.  
  
