---
title: Modify an object label
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a92ac161-7cc5-4a99-9027-8cdb99b05b4a
---
# Modify an object label
This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.  
  
## Reference  
This privilege determines which user accounts can modify the integrity label of objects, such as files, registry keys, or processes owned by other users. Processes running under a user account can modify the label of an object owned by that user to a lower level without this privilege.  
  
The integrity label is used by the Windows Integrity Controls (WIC) feature, which was introduced in Windows Server 2008 and Windows Vista. WIC keeps lower integrity processes from modifying higher integrity processes by assigning one of six possible labels to objects on the system. Although similar to NTFS file and folder permissions, which are discretionary controls on objects, the WIC integrity levels are mandatory controls that are put in place and enforced by the operating system. The following list describes the integrity levels from lowest to highest:  
  
-   **Untrusted** Default assignment for processes that are logged on anonymously.  
  
-   **Low** Default assignment for processes that interact with the Internet.  
  
-   **Medium** Default assignment for standard user accounts and any object that is not explicitly designated with a lower or higher integrity level.  
  
-   **High** Default assignment for administrator accounts and processes that request to run using administrative rights.  
  
-   **System** Default assignment for Windows kernel and core services.  
  
-   **Installer** Used by setup programs to install software. It is important that only trusted software is installed on computers because objects that are assigned the Installer integrity level can install, modify, and uninstall all other objects.  
  
This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
Constant: SeRelabelPrivilege  
  
### Possible values  
  
-   User-defined list of accounts  
  
-   Not Defined  
  
### Best practices  
  
1.  Do not give any group this user right.  
  
### Location  
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment  
  
### Default values  
By default this setting is Not defined on domain controllers and on stand-alone servers.  
  
The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy’s property page.  
  
|Server type or GPO|Default value|  
|----------------------|-----------------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Not defined|  
|Stand-Alone Server Default Settings|Not defined|  
|Domain Controller Effective Default Settings|Not defined|  
|Member Server Effective Default Settings|Not defined|  
|Client Computer Effective Default Settings|Not defined|  
  
### Operating system version differences  
This policy setting was introduced in Windows Server 2008 and Windows Vista and has no effect on earlier versions. There are no differences in the way this policy setting works between the supported versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
## Policy management  
This section describes features, tools, and guidance to help you manage this policy.  
  
A restart of the computer is not required for this policy setting to be effective.  
  
Any change to the user rights assignment for an account becomes effective the next time the owner of the account logs on.  
  
### Group Policy  
Settings are applied in the following order through a Group Policy Object (GPO), which will overwrite settings on the local computer at the next Group Policy update:  
  
1.  Local policy settings  
  
2.  Site policy settings  
  
3.  Domain policy settings  
  
4.  OU policy settings  
  
When a local setting is greyed out, it indicates that a GPO currently controls that setting.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
Anyone with the **Modify an object label** user right can change the integrity level of a file or process so that it becomes elevated or decreased to a point where it can be deleted by lower integrity processes. Either of these states effectively circumvents the protection that is offered by Windows Integrity Controls and makes your system vulnerable to attacks by malicious software.  
  
If malicious software is set with an elevated integrity level such as Trusted Installer or System, administrator accounts do not have sufficient integrity levels to delete the program from the system. In that case, use of the **Modify an object label** right is mandated so that the object can be relabeled. However, the relabeling must occur by using a process that is at the same or a higher level of integrity than the object that you are attempting to relabel.  
  
### Countermeasure  
Do not give any group this right. If necessary, implement it for a constrained period of time to a trusted individual to respond to a specific organizational need.  
  
### Potential impact  
None. Not defined is the default configuration.  
  
## See Also  
[User Rights Assignment](User-Rights-Assignment.md)  
  

