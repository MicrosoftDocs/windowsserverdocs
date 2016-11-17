---
title: Take ownership of files or other objects
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-policy-settings
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: aceca087-13fd-4729-a379-ecb620072b86
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Take ownership of files or other objects

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.  
  
## Reference  
This policy setting determines which users can take ownership of any securable object in the computer, including Active Directory objects, NTFS files and folders, printers, registry keys, services, processes, and threads.  
  
Every object has an owner, whether the object resides in an NTFS volume or Active Directory database. The owner controls how permissions are set on the object and to whom permissions are granted.  
  
By default, the owner is the person who or the process which created the object. Owners can always change permissions to objects, even when they are denied all access to the object.  
  
This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
Constant: SeTakeOwnershipPrivilege  
  
### Possible values  
  
-   User-defined list of accounts  
  
-   Not defined  
  
### Best practices  
  
1.  Assigning this user right can be a security risk. Because owners of objects have full control of them, only assign this user right to trusted users.  
  
### Location  
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment  
  
### Default values  
By default this setting is Administrators on domain controllers and on stand-alone servers.  
  
The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy???s property page.  
  
|Server type or GPO|Default value|  
|-----------|---------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Administrators|  
|Stand-Alone Server Default Settings|Administrators|  
|Domain Controller Effective Default Settings|Administrators|  
|Member Server Effective Default Settings|Administrators|  
|Client Computer Effective Default Settings|Administrators|  
  
### Operating system version differences  
There are no differences in the way this policy setting works between the supported versions of Windows that are designated in the**Applies To** list at the beginning of this topic.  
  
## Policy management  
This section describes features, tools, and guidance to help you manage this policy.  
  
A restart of the computer is not required for this policy setting to be effective.  
  
Any change to the user rights assignment for an account becomes effective the next time the owner of the account logs on.  
  
Ownership can be taken by:  
  
-   An administrator. By default, the Administrators group is given the **Take ownership of files or other objects** user right.  
  
-   Anyone or any group who has the **Take ownership** user right on the object.  
  
-   A user who has the **Restore files and directories** user right.  
  
Ownership can be transferred in the following ways:  
  
-   The current owner can grant the **Take ownership** user right to another user if that user is a member of a group defined in the current owner's access token. The user must take ownership to complete the transfer.  
  
-   An administrator can take ownership.  
  
-   A user who has the **Restore files and directories** user right can double-click **Other users and groups** and choose any user or group to assign ownership to.  
  
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
Any users with the **Take ownership of files or other objects user right** can take control of any object, regardless of the permissions on that object, and then make any changes that they want to make to that object. Such changes could result in exposure of data, corruption of data, or a denial-of-service condition.  
  
### Countermeasure  
Ensure that only the local Administrators group has the **Take ownership of files or other objects** user right.  
  
### Potential impact  
None. Restricting the **Take ownership of files or other objects** user right to the local Administrators group is the default configuration.  
  
## See Also  
[User Rights Assignment](user-rights-assignment.md)  
  

