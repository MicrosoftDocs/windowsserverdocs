---
title: Update Group Policy Permissions
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 1d67c5c9-0005-431c-b72b-8526e8ff2ff0
author: Femila
---
# Update Group Policy Permissions
Group Policy Modeling is a feature of the Group Policy Management Console \(GPMC\) that simulates the resultant set of policy for a particular configuration. The simulation is performed by a service that runs on domain controllers. To perform the simulation across domains, the service must have read access to all Group Policy objects \(GPOs\) in the forest.  
  
> [!NOTE]  
> The procedure in this topic is required only if you are upgrading Windows 2000 Active Directory domains. If you are upgrading Windows Server 2003 Active Directory domains or creating a new domain with domain controllers that run [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], the Enterprise Domain Controllers group will automatically have read access to all newly created GPOs and all GPOs that were created before the upgrade.  
  
However, if the domain was upgraded from Windows 2000, the Enterprise Domain Controllers group will not have read access to any existing GPOs that were created before the upgrade. The GPMC detects this when you click a GPO, and then it notifies the user that the Enterprise Domain Controllers group does not have read access to all GPOs in this domain. To solve this problem, use the sample script named GrantPermissionOnAllGPOs.wsf that is provided with the GPMC. This script will update the permissions on all GPOs in the domain. To download GPMC sample scripts \(including GrantPermissionOnAllGPOs.wsf\), see Group Policy Management Console Sample Scripts \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=106342](http://go.microsoft.com/fwlink/?LinkId=106342)\). After the download is complete, %programfiles%\\Microsoft Group Policy\\GPMC Sample Scripts folder will be created.  
  
Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To update permissions on all GPOs in a domain  
  
1.  At a command prompt, type the following, and then press ENTER:  
  
    **cd \/d %programfiles%\\Microsoft Group Policy\\GPMC Sample Scripts**  
  
2.  Type the following, and then press ENTER:  
  
    **Cscript GrantPermissionOnAllGPOs.wsf “Enterprise Domain Controllers” \/permission:read \/domain:DNSDomainName \/Replace**  
  
    Using the **Replace** switch removes existing permissions for the group or user before making the change. If a group or user is already granted a permission type that is higher than the new permission type, and you do not specify **Replace**, no change is made.  
  
