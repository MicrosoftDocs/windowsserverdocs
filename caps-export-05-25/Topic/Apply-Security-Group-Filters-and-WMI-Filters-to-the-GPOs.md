---
title: Apply Security Group Filters and WMI Filters to the GPOs
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 79e94787-c10d-4fce-9d92-e72e58ce2d01
author: coreyp
---
# Apply Security Group Filters and WMI Filters to the GPOs
Use this procedure to assign the WMI and security group filters that you created earlier to restrict each GPO to the computers in the membership group that are running the version of Windows for which the GPO is intended.  
  
Membership in **Domain Admins** is the minimum required to complete this procedure.  
  
### To assign the security group and WMI filters to your GPOs  
  
1.  On AD\-DNS\-01, in Server Manager, click **Tools**, and then click **Group Policy Management**. The Group Policy Management Console \(GPMC\) opens.  
  
2.  In the GPMC navigation pane, expand **Forest:** *your forest name*, expand **Domains**, and then expand your domain.  
  
3.  For each of the GPOs that contains settings for a different zone and version of Windows, click the GPO and perform the following steps on the **Scope** tab in the results pane:  
  
    1.  Remove the default security group filter that allows any computer to apply the GPO. In **Security Filtering**, click **Authenticated Users**, and then click **Remove**.  
  
    2.  Add a security group filter that permits only accounts in the membership group to apply the GPO. In **Security Filtering**, click **Add**, enter the membership group account name that you created for the zone, and then click **OK**.  
  
        > [!NOTE]  
        > We recommend that you use the GPMC to remove **Authenticated Users** from **Security Filtering** in order to automatically remove both the Apply Group Policy permission and read access permission. If the Apply Group Policy permission is not set, but the Read permission is, the GPO is still inspected \(although not applied\) by any user or computer that is in the OU hierarchy where the GPO is linked. This inspection process increases logon time slightly for each GPO with read access still set after removal of the Apply Group Policy permission.  
  
    3.  Add a security group filter that prevents members of an exception group from applying the GPO. Click the **Delegation** tab, click **Advanced**, click **Add**, enter the exception group account name, and then click **OK**. In the **Group or user names** list, select the group you just added, in the **Permissions for***Exception Group Name* list, clear all of the **Allow** check boxes, select the **Deny** check boxes for **Read** and **Apply Group Policy**, click **OK** and then **Yes** in **Windows Security**.  
  
    4.  Assign the WMI filter that limits the GPO to only computers running the specified versions of Windows. Click the **Scope** tab, and then in the **WMI Filtering** list, select the WMI filter you created earlier. In the confirmation dialog box, click **Yes**.  
  
        > [!NOTE]  
        > We recommend that you use WMI filters primarily for exception management. They can provide a powerful solution for targeting GPOs to specific users and computers, but because WMI filters are evaluated every time Group Policy is processed, they increase startup and logon time. Also, there is no time\-out for WMI filters. Therefore, you should use them only when necessary.  
  
