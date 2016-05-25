---
title: Add Production Computers to the Membership Group
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 01d4cc97-eb62-4336-8ea5-5427ee95e9fc
author: coreyp
---
# Add Production Computers to the Membership Group
After you have thoroughly tested your GPO deployment, use this procedure to add the production computers to the membership groups.  
  
### To add production computers to the membership groups  
  
1.  On AD\-DNS\-01, in Server Manager, click **Tools**, and then click **Active Directory Users and Computers**. The Active Directory Users and Computers MMC opens. If it is not already selected, click the node for your domain. For example, if your domain is corp.contoso.com, click *corp.contoso.com*.  
  
2.  In the navigation pane, expand **Active Directory Users and Computers**, expand your domain, and then select **Computers**. \(If you created the exception groups somewhere other than in the Computers container, select the appropriate container.\)  
  
3.  In the details pane, double\-click the GPO membership group to which you want to add computers.  
  
    > [!CAUTION]  
    > If you choose to add a large group like Domain Computers to the membership group, make sure that your exception groups are fully populated and tested before adding the large group.  
  
4.  Select the **Members** tab, and then click **Add**.  
  
5.  Type the name of the computer in the text box, and then click **OK**.  
  
6.  Repeat steps 5 and 6 for each additional computer account or group that you want to add.  
  
7.  Click **OK** to close the group properties dialog box.  
  
8.  Restart the client computers that were added to the membership groups. Changes in group membership do not take effect until after the computer is restarted.  
  
