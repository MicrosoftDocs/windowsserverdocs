---
title: Create the Membership Group
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f21613c2-b834-4b92-bd3b-b4e771f1d484
author: coreyp
---
# Create the Membership Group
You can use this procedure to create a new group in Active Directory Users and Computers Microsoft Management Console \(MMC\).  
  
Membership in **Domain Admins**, or equivalent, is the minimum required to perform this procedure.  
  
### To create a membership group  
  
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
  
