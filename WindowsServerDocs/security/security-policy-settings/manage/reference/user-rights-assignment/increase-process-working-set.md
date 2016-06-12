---
title: Increase a process working set
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1f100c2c-650b-4484-bf79-682426b0ecee
---
# Increase a process working set
This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.  
  
## Reference  
This policy setting determines which users can increase or decrease the size of the working set of a process. The working set of a process is the set of memory pages currently visible to the process in physical RAM. These pages are resident, and they are available for an application to use without triggering a page fault. The minimum and maximum working set sizes affect the virtual memory paging behavior of a process.  
  
This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
Constant: SeIncreaseWorkingSetPrivilege  
  
### Possible values  
  
-   User\-defined list of accounts  
  
-   Not Defined  
  
### Best practices  
  
1.  You should make users aware that adverse performance issues may occur if they modify this security setting.  
  
### Location  
*GPO\_name*\\Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\User Rights Assignment  
  
### Default values  
By default, standard users have this right.  
  
The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy’s property page.  
  
|Server type or GPO|Default value|  
|----------------------|-----------------|  
|Default Domain Policy|Not Defined|  
|Default Domain Controller Policy|Users|  
|Stand\-Alone Server Default Settings|Users|  
|Domain Controller Effective Default Settings|Users|  
|Member Server Effective Default Settings|Users|  
|Client Computer Effective Default Settings|Users|  
  
### Operating system version differences  
There are no differences in the way this policy setting works between the supported versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
## Policy management  
This section describes features, tools, and guidance to help you manage this policy.  
  
A restart of the computer is not required for this policy setting to be effective.  
  
Any change to the user rights assignment for an account becomes effective the next time the owner of the account logs on.  
  
### Group Policy  
Settings are applied in the following order through a Group Policy Object \(GPO\), which will overwrite settings on the local computer at the next Group Policy update:  
  
1.  Local policy settings  
  
2.  Site policy settings  
  
3.  Domain policy settings  
  
4.  OU policy settings  
  
When a local setting is greyed out, it indicates that a GPO currently controls that setting.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
Increasing the working set size for a process decreases the amount of physical memory that is available to the rest of the system.  
  
### Countermeasure  
Increase user’s awareness about the impact of increasing the working set of a process and how to recognize that their system is adversely affected if they change this setting.  
  
### Potential impact  
None. Allowing standard users to increase the working set of a process is the default configuration.  
  
## See Also  
[User Rights Assignment](user-rights-assignment.md)  
  

