---
title: Group Policy Deployment Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6c9fff7f-9a01-4e50-88c7-2dd7a1e2ea31
author: coreyp
---
# Group Policy Deployment Overview
The following illustration shows the components that are required to deploy Group Policy by using a membership group.  
  
![](../Image/NetFndtn_GroupPolicy_Requirements_.gif)  
  
## Group Policy deployment components  
The components include:  
  
### Domain controller: AD\-DNS\-01  
The domain controller is a computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and Active Directory Domain Services \(AD DS\). The illustration shows a domain controller named AD\-DNS\-01 configured in the corp.contoso.com forest and domain.  
  
### Group Policy: GPO\_Membership  
Group Policy is configured in AD DS on the domain controller. You create one or more GPOs that are associated with the membership group and configure the settings required by the set of computers that must receive each GPO. For example, you can create a GPO named GPO\_Membership, as shown in the illustration.  
  
### WMI Filters  
Windows Management Instrumentation \(WMI\) filters allow Group Policy to query the computer for conditions that must be true for the GPO to apply. In this guide, WMI filters are used to query for the version of Windows to ensure that only a GPO designed for that version will apply.  
  
### Membership group: GRP\_Membership  
The membership group contains the user or computer accounts that will receive one of the GPOs associated with the group. The choice of GPO depends on the WMI filters used for checking the version of Windows and any membership in an exception group. For example, you can create a group named GRP\_Membership, as shown in the above illustration.  
  
### Exception group: GRP\_Exception  
The exception group contains the user or computer accounts that might be in the membership group, but must not be allowed to apply a particular membership GPO. Exception groups are assigned deny permissions on the membership GPOs. For example, you can create a group named GRP\_Exception, as shown in the above illustration.  
  
Exception groups are used for the following reasons:  
  
-   When a computer or user is in two membership groups but must apply only one of the two GPOs. You use one of the membership groups as if it were an exception group for the GPOs that pertain to the other membership group. For example, consider membership groups Group A and Group B, each with a GPO, GPO A and GPO B. Only one of the GPOs must apply to any computer. Members of Group B must receive only the GPO B, even if they are also members of Group A. To do this, treat the Group B membership group as an exception group for Group A. On GPO A, deny Apply Group Policy permissions to Group B. Because deny permissions override allow permissions, members of Group B will only be allowed to apply GPO B.  
  
-   When a WMI filter cannot be used.  
  
## Group Policy deployment process  
The process for configuring Group Policy based on a membership group occurs in these stages:  
  
1.  Create the membership group in AD DS.  
  
2.  Create the exception group in AD DS.  
  
3.  Create the GPOs, one for each version of Windows that requires different settings to achieve the desired configuration. Remember that often you can copy a GPO for one version of Windows to serve as a starting point for another version. This can save a lot of time if your GPOs contain a large number of settings. For example, [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and Windows 7 support almost the same collection of settings. You could create the GPO for Windows 7, configure it, and then make a copy of it for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)]. Then you only need to change the few settings that are different between Windows 7 and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
  
4.  Create the WMI filters that allow you to distinguish between different versions of Windows. In theory, you could have six GPOs for a single membership group, one each for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], Windows Server 2003, [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], Windows 7, [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)], and Windows XP. Each GPO must have a WMI filter that prevents it from being applied to any version of Windows except the one for which it is designed.  
  
5.  Grant Read and Apply Group Policy permissions on the GPOs to the membership group. Remove the default entry for Authenticated Users. Deny Apply Group Policy permissions to the exception group. Assign the corresponding WMI filter to each GPO.  
  
    > [!IMPORTANT]  
    > If you have membership groups in which a computer might be a member of more than one membership group, and only one of the GPOs must be applied, then treat one of the membership groups as an exception group for the other.  
  
6.  Link the GPOs to the domain container to make it visible to all of the computers in the domain. The security group and WMI filters limit their application to only the specified set of computers.  
  
7.  Add a small number of test computers to the membership and exception groups. Refresh Group Policy on the test computers and make sure that each receives the correct GPO and applies the correct settings.  
  
8.  After testing is complete, add the production computers to the membership and exception groups.  
  
