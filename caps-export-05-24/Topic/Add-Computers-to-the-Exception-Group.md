---
title: Add Computers to the Exception Group
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a3264438-1d70-4de9-b527-2d75bd4431f4
author: coreyp
---
# Add Computers to the Exception Group
Before you add any computers to the membership groups, use this procedure to add computers to the appropriate exception groups. This will prevent the computer accounts in the exception group from applying GPOs that are not intended for them.  
  
Membership in **Domain Admins** is the minimum required to complete this procedure.  
  
### To add computers to the exception groups  
  
1.  On AD\-DNS\-01, in Server Manager, click **Tools**, and then click **Active Directory Users and Computers**. The Active Directory Users and Computers MMC opens. If it is not already selected, click the node for your domain. For example, if your domain is corp.contoso.com, click *corp.contoso.com*.  
  
2.  In the navigation pane, expand **Active Directory Users and Computers**, expand your domain, and then select **Computers**. \(If you created the exception groups somewhere other than in the Computers container, select the appropriate container.\)  
  
3.  In the details pane, double\-click the exception group to which you want to add computers.  
  
4.  Select the **Members** tab, and then click **Add**.  
  
5.  Type the name of the computer in the text box, and then click **OK**.  
  
6.  Repeat steps 5 and 6 for each additional computer account or group that you want to add.  
  
7.  Click **OK** to close the group properties dialog box.  
  
8.  Restart the client computers that were added to the exception groups. Changes in group membership do not take effect until after the computer is restarted.  
  
