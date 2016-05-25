---
title: Create the Exception Group
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6bba75d8-68e5-43af-9b42-e2072908846d
author: coreyp
---
# Create the Exception Group
Use this procedure to create an exception group. Members of this group are prevented from applying a GPO.  
  
Membership in **Domain Admins**, or equivalent, is the minimum required to perform this procedure.  
  
### To create an exception group  
  
1.  On AD\-DNS\-01, in Server Manager, click **Tools**, and then click **Active Directory Users and Computers**. The Active Directory Users and Computers MMC opens. If it is not already selected, click the node for your domain. For example, if your domain is corp.contoso.com, click **corp.contoso.com**.  
  
2.  In the details pane, right\-click the folder in which you want to add a new group.  
  
    **Where?**  
  
    -   Active Directory Users and Computers\/*domain node*\/*folder*  
  
3.  Point to **New**, and then click **Group**.  
  
4.  In **New Object – Group**, in **Group name**, type the name of the new group.  
  
    By default, the name you type is also entered as the pre\-Windows 2000 name of the new group.  
  
5.  In **Group scope**, select **Global**, unless you have a specific reason for chosing another option.  
  
6.  In **Group type**, select **Security**.  
  
7.  Click **OK**.  
  
