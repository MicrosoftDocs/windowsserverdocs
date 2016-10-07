---
title: Back up files and directories
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-policy-settings
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 48959ab6-a4ba-4399-a87b-f166f7417a97
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Back up files and directories

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.  
  
## Reference  
This user right determines which users can bypass file and directory, registry, and other persistent object permissions for the purposes of backing up the system. This user right is effective only when an application attempts access through the NTFS backup application programming interface (API) through a backup tool such as NTBACKUP.EXE. Otherwise, standard file and directory permissions apply.  
  
This user right is similar to granting the following permissions to the user or group you have selected on all files and folders on the system:  
  
-   Traverse Folder/Execute File  
  
-   List Folder/Read Data  
  
-   Read Attributes  
  
-   Read Extended Attributes  
  
-   Read Permissions  
  
Default on workstations and servers:  
  
-   Administrators  
  
-   Backup Operators  
  
Default on domain controllers:  
  
-   Administrators  
  
-   Backup Operators  
  
-   Server Operators  
  
This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
Constant: SeBackupPrivilege  
  
### Possible values  
  
-   User-defined list of accounts  
  
-   Not Defined  
  
### Best practices  
  
1.  Restrict the **Back up files and directories** user right to members of the IT team who must back up organizational data as part of their daily job responsibilities. Because there is no way to be sure that a user is backing up data, stealing data, or copying data to be distributed, only assign this user right to trusted users.  
  
2.  If you are using backup software that runs under specific service accounts, only these accounts (and not the IT staff) should have the **Back up files and directories** user right.  
  
### Location  
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment  
  
### Default values  
By default, this right is granted to Administrators and Backup Operators on workstations and servers. On domain controllers, Administrators, Backup Operators, and Server Operators have this right.  
  
The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy’s property page.  
  
|Server type or GPO|Default value|  
|----------------------|-----------------|  
|Default Domain Policy|Not Defined|  
|Default Domain Controller Policy|Administrators<br /><br />Backup Operators<br /><br />Server Operators|  
|Stand-Alone Server Default Settings|Administrators<br /><br />Backup Operators|  
|Domain Controller Effective Default Settings|Administrators<br /><br />Backup Operators<br /><br />Server Operators|  
|Member Server Effective Default Settings|Administrators<br /><br />Backup Operators|  
|Client Computer Effective Default Settings|Administrators<br /><br />Backup Operators|  
  
### Operating system version differences  
There are no differences in the way this policy setting works between the supported versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
## Policy management  
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
Users who can back up data from a computer could take the backup media to a non-domain computer on which they have administrative privileges, and then restore the data. They could take ownership of the files and view any unencrypted data that is contained within the backup set.  
  
### Countermeasure  
Restrict the **Back up files and directories** user right to members of the IT team who must back up organizational data as part of their daily job responsibilities. If you are using backup software that runs under specific service accounts, only these accounts (and not the IT staff) should have the **Back up files and directories** user right.  
  
### Potential impact  
Changes in the membership of the groups that have the **Back up files and directories** user right could limit the abilities of users who are assigned to specific administrative roles in your environment. You should confirm that authorized backup administrators can still perform backup operations.  
  
## See Also  
[User Rights Assignment](User-Rights-Assignment.md)  
  

