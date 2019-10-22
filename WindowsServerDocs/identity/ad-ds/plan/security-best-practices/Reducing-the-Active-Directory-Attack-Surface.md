---
ms.assetid: 864ad4bc-8428-4a8b-8671-cb93b68b0c03
title: Reducing the Active Directory Attack Surface
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Reducing the Active Directory Attack Surface

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This section focuses on technical controls to implement to reduce the attack surface of the Active Directory installation. The section contains the following information:  
  
-   [Implementing Least-Privilege Administrative Models](../../../ad-ds/plan/security-best-practices/../../../ad-ds/plan/security-best-practices/Implementing-Least-Privilege-Administrative-Models.md) focuses on identifying the risk that the use of highly privileged accounts for day-to-day administration presents, in addition to providing recommendations to implement to reduce the risk that privileged accounts present.  
  
-   [Implementing Secure Administrative Hosts](../../../ad-ds/plan/security-best-practices/Implementing-Secure-Administrative-Hosts.md) describes principles for deployment of dedicated, secure administrative systems, in addition to some sample approaches to a secure administrative host deployment.  
  
-   [Securing Domain Controllers Against Attack](../../../ad-ds/plan/security-best-practices/Securing-Domain-Controllers-Against-Attack.md) discusses policies and settings that, although similar to the recommendations for the implementation of secure administrative hosts, contain some domain controller-specific recommendations to help ensure that the domain controllers and the systems used to manage them are well-secured.  
  
## Privileged Accounts and Groups in Active Directory  
This section provides background information about privileged accounts and groups in Active Directory intended to explain the commonalities and differences between privileged accounts and groups in Active Directory. By understanding these distinctions, whether you implement the recommendations in [Implementing Least-Privilege Administrative Models](../../../ad-ds/plan/security-best-practices/../../../ad-ds/plan/security-best-practices/Implementing-Least-Privilege-Administrative-Models.md) verbatim or choose to customize them for your organization, you have the tools you need to secure each group and account appropriately.  
  
### Built-in Privileged Accounts and Groups  
Active Directory facilitates delegation of administration and supports the principle of least privilege in assigning rights and permissions. "Regular" users who have accounts in a domain are, by default, able to read much of what is stored in the directory, but are able to change only a very limited set of data in the directory. Users who require additional privilege can be granted membership in various "privileged" groups that are built into the directory so that they may perform specific tasks related to their roles, but cannot perform tasks that are not relevant to their duties. Organizations can also create groups that are tailored to specific job responsibilities and are granted granular rights and permissions that allow IT staff to perform day-to-day administrative functions without granting rights and permissions that exceed what is required for those functions.  
  
Within Active Directory, three built-in groups are the highest privilege groups in the directory: Enterprise Admins, Domain Admins, and Administrators. The default configuration and capabilities of each of these groups are described in the following sections:  
  
#### Highest Privilege Groups in Active Directory  
  
##### Enterprise Admins  
Enterprise Admins (EA) is a group that exists only in the forest root domain, and by default, it is a member of the Administrators group in all domains in the forest. The built-in Administrator account in the forest root domain is the only default member of the EA group. EAs are granted rights and permissions that allow them to implement forest-wide changes (that is, changes that affect all domains in the forest), such as adding or removing domains, establishing forest trusts, or raising forest functional levels. In a properly designed and implemented delegation model, EA membership is required only when first constructing the forest or when making certain forest-wide changes such as establishing an outbound forest trust. Most of the rights and permissions granted to the EA group can be delegated to lesser-privileged users and groups.  
  
##### Domain Admins  

Each domain in a forest has its own Domain Admins (DA) group, which is a member of that domain's Administrators group and a member of the local Administrators group on every computer that is joined to the domain. The only default member of the DA group for a domain is the built-in Administrator account for that domain. DAs are "all-powerful" within their domains, while EAs have forest-wide privilege. In a properly designed and implemented delegation model, Domain Admins membership should be required only in "break glass" scenarios (such as situations in which an account with high levels of privilege on every computer in the domain is needed). Although native Active Directory delegation mechanisms allow delegation to the extent that it is possible to use DA accounts only in emergency scenarios, constructing an effective delegation model can be time consuming, and many organizations leverage third-party tools to expedite the process.  
  
##### Administrators  
The third group is the built-in domain local Administrators (BA) group into which DAs and EAs are nested. This group is granted many of the direct rights and permissions in the directory and on domain controllers. However, the Administrators group for a domain has no privileges on member servers or on workstations. It is via membership in the computers' local Administrators group that local privilege is granted.  
  
> [!NOTE]  
> Although these are the default configurations of these privileged groups, a member of any of the three groups can manipulate the directory to gain membership in any of the other groups. In some cases, it is trivial to obtain membership in the other groups, while in others it is more difficult, but from the perspective of potential privilege, all three groups should be considered effectively equivalent.  
  
##### Schema Admins  

A fourth privileged group, Schema Admins (SA), exists only in the forest root domain and has only that domain's built-in Administrator account as a default member, similar to the Enterprise Admins group. The Schema Admins group is intended to be populated only temporarily and occasionally (when modification of the AD DS schema is required).  
  
Although the SA group is the only group that can modify the Active Directory schema (that is., the directory's underlying data structures such as objects and attributes), the scope of the SA group's rights and permissions is more limited than the previously described groups. It is also common to find that organizations have developed appropriate practices for the management of the membership of the SA group because membership in the group is typically infrequently needed, and only for short periods of time. This is technically true of the EA, DA, and BA groups in Active Directory, as well, but it is far less common to find that organizations have implemented similar practices for these groups as for the SA group.  
  
#### Protected Accounts and Groups in Active Directory  
Within Active Directory, a default set of privileged accounts and groups called "protected" accounts and groups are secured differently than other objects in the directory. Any account that has direct or transitive membership in any protected group (regardless of whether the membership is derived from security or distribution groups) inherits this restricted security.  

  
For example, if a user is a member of a distribution group that is, in turn, a member of a protected group in Active Directory, that user object is flagged as a protected account. When an account is flagged as a protected account, the value of the adminCount attribute on the object is set to 1.  
  
> [!NOTE]
> Although transitive membership in a protected group includes nested distribution and nested security groups, accounts that are members of nested distribution groups will not receive the protected group's SID in their access tokens. However, distribution groups can be converted to security groups in Active Directory, which is why distribution groups are included in protected group member enumeration. Should a protected nested distribution group ever be converted to a security group, the accounts that are members of the former distribution group will subsequently receive the parent protected group's SID in their access tokens at the next logon.  
  
The following table lists the default protected accounts and groups in Active Directory by operating system version and service pack level.  
  
**Default Protected Accounts and Groups in Active Directory by Operating System and Service Pack (SP) Version**  
  
|||||  
|-|-|-|-|  
|**Windows 2000 <SP4**|**Windows 2000 SP4 -Windows Server 2003**|**Windows Server 2003 SP1+**|**Windows Server 2008 -Windows Server 2012**|  
|Administrators|Account Operators|Account Operators|Account Operators|  
||Administrator|Administrator|Administrator|  
||Administrators|Administrators|Administrators|  
|Domain Admins|Backup Operators|Backup Operators|Backup Operators|  
||Cert Publishers|||  
||Domain Admins|Domain Admins|Domain Admins|  
|Enterprise Admins|Domain Controllers|Domain Controllers|Domain Controllers|  
||Enterprise Admins|Enterprise Admins|Enterprise Admins|  
||Krbtgt|Krbtgt|Krbtgt|  
||Print Operators|Print Operators|Print Operators|  
||||Read-only Domain Controllers|  
||Replicator|Replicator|Replicator|  
|Schema Admins|Schema Admins||Schema Admins|  
  
##### AdminSDHolder and SDProp  
In the System container of every Active Directory domain, an object called AdminSDHolder is automatically created. The purpose of the AdminSDHolder object is to ensure that the permissions on protected accounts and groups are consistently enforced, regardless of where the protected groups and accounts are located in the domain.  

Every 60 minutes (by default), a process known as Security Descriptor Propagator (SDProp) runs on the domain controller that holds the domain's PDC Emulator role. SDProp compares the permissions on the domain's AdminSDHolder object with the permissions on the protected accounts and groups in the domain. If the permissions on any of the protected accounts and groups do not match the permissions on the AdminSDHolder object, the permissions on the protected accounts and groups are reset to match those of the domain's AdminSDHolder object.  
  
Permissions inheritance is disabled on protected groups and accounts, which means that even if the accounts or groups are moved to different locations in the directory, they do not inherit permissions from their new parent objects. Inheritance is also disabled on the AdminSDHolder object so that permissions changes to the parent objects do not change the permissions of AdminSDHolder.  
  
> [!NOTE]
> When an account is removed from a protected group, it is no longer considered a protected account, but its adminCount attribute remains set to 1 if it is not manually changed. The result of this configuration is that the object's ACLs are no longer updated by SDProp, but the object still does not inherit permissions from its parent object. Therefore, the object may reside in an organizational unit (OU) to which permissions have been delegated, but the formerly protected object will not inherit these delegated permissions. A script to locate and reset formerly protected objects in the domain can be found in the [Microsoft Support article 817433](https://support.microsoft.com/?id=817433).  
  
###### AdminSDHolder Ownership  
Most objects in Active Directory are owned by the domain's BA group. However, the AdminSDHolder object is, by default, owned by the domain's DA group. (This is a circumstance in which DAs do not derive their rights and permissions via membership in the Administrators group for the domain.)  
  
In versions of Windows earlier than Windows Server 2008, owners of an object can change permissions of the object, including granting themselves permissions that they did not originally have. Therefore, the default permissions on a domain's AdminSDHolder object prevent users who are members of BA or EA groups from changing the permissions for a domain's AdminSDHolder object. However, members of the Administrators group for the domain can take ownership of the object and grant themselves additional permissions, which means that this protection is rudimentary and only protects the object against accidental modification by users who are not members of the DA group in the domain. Additionally, the BA and EA (where applicable) groups have permission to change the attributes of the AdminSDHolder object in the local domain (root domain for EA).  
  
> [!NOTE]  
> An attribute on the AdminSDHolder object, dSHeuristics, allows limited customization (removal) of groups that are considered protected groups and are affected by AdminSDHolder and SDProp. This customization should be carefully considered if it is implemented, although there are valid circumstances in which modification of dSHeuristics on AdminSDHolder is useful. More information about modification of the dSHeuristics attribute on an AdminSDHolder object can be found in the Microsoft Support articles [817433](https://support.microsoft.com/?id=817433) and [973840](https://support.microsoft.com/kb/973840), and in [Appendix C: Protected Accounts and Groups in Active Directory](Appendix-C--Protected-Accounts-and-Groups-in-Active-Directory.md).  
  
Although the most privileged groups in Active Directory are described here, there are a number of other groups that have been granted elevated levels of privilege. For more information about all of the default and built-in groups in Active Directory and the user rights assigned to each, see [Appendix B: Privileged Accounts and Groups in Active Directory](../../../ad-ds/plan/security-best-practices/Appendix-B--Privileged-Accounts-and-Groups-in-Active-Directory.md).  
  


