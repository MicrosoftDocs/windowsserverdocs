---
title: Adjust memory quotas for a process
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cd3590ff-c5ae-4ce0-b4e0-0e5013f442a1
---
# Adjust memory quotas for a process
This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.  
  
## Reference  
This privilege determines who can change the maximum memory that can be consumed by a process. This privilege is useful for system tuning on a group or user basis.  
  
This user right is defined in the Default Domain Controller Group Policy Object \(GPO\) and in the local security policy of workstations and servers.  
  
This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
Constant: SeIncreaseQuotaPrivilege  
  
### Possible values  
  
-   User\-defined list of accounts  
  
-   Not Defined  
  
### Best practices  
  
1.  Restrict the **Adjust memory quotas for a process** user right to only users who require the ability to adjust memory quotas to perform their jobs.  
  
2.  If this user right is necessary for a user account, it can be assigned to a local computer account instead of to a domain account.  
  
### Location  
*GPO\_name*\\Computer Configuration\\Windows Settings\\Security Settings\\User Rights Assignment\\  
  
### Default values  
By default, members of the Administrators, Local Service, and Network Service groups have this right.  
  
The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy’s property page.  
  
|Server type or GPO|Default value|  
|----------------------|-----------------|  
|Default Domain Policy|Administrators<br /><br />Local Service<br /><br />Network Service|  
|Default Domain Controller Policy|Administrators<br /><br />Local Service<br /><br />Network Service|  
|Stand\-Alone Server Default Settings|Administrators<br /><br />Local Service<br /><br />Network Service|  
|Domain Controller Effective Default Settings|Administrators<br /><br />Local Service<br /><br />Network Service|  
|Member Server Effective Default Settings|Administrators<br /><br />Local Service<br /><br />Network Service|  
|Client Computer Effective Default Settings|Administrators<br /><br />Local Service<br /><br />Network Service|  
  
### Operating system version differences  
There are no differences in the way this policy setting works between the supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
## Policy management  
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
A user with the **Adjust memory quotas for a process** privilege can reduce the amount of memory that is available to any process, which could cause business\-critical network applications to become slow or to fail. This privilege could be used by a malicious user to start a denial\-of\-service \(DoS\) attack.  
  
### Countermeasure  
Restrict the **Adjust memory quotas for a process** user right to users who require it to perform their jobs, such as application administrators who maintain database management systems or domain administrators who manage the organization's directory and its supporting infrastructure.  
  
### Potential impact  
Organizations that have not restricted users to roles with limited privileges may find it difficult to impose this countermeasure. Also, if you have installed optional components such as ASP.NET or IIS, you may need to assign the **Adjust memory quotas for a process** user right to additional accounts that are required by those components. IIS requires that this privilege be explicitly assigned to the IWAM\_<ComputerName>, Network Service, and Service accounts. Otherwise, this countermeasure should have no impact on most computers. If this user right is necessary for a user account, it can be assigned to a local computer account instead of to a domain account.  
  
## See Also  
[User Rights Assignment](user-rights-assignment.md)  
  

