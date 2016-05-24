---
title: Add Test Computers to the Membership Group
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a380b7ea-18e7-4d79-9402-7a3df354bd97
author: coreyp
---
# Add Test Computers to the Membership Group
Use this procedure to add test computers to membership groups, force GPO updates, and confirm the results. Be sure to add computers that represent the overall composition of your network, at least one for every GPO that you deploy.  
  
Membership in **Domain Admins** is the minimum required to complete this procedure.  
  
### To add the test computers to the membership groups  
  
1.  On AD\-DNS\-01, in Server Manager, click **Tools**, and then click **Active Directory Users and Computers**. The Active Directory Users and Computers MMC opens. If it is not already selected, click the node for your domain. For example, if your domain is corp.contoso.com, click *corp.contoso.com*.  
  
2.  In the navigation pane, expand **Active Directory Users and Computers**, expand your domain, and then select **Computers**. \(If you created the exception groups somewhere other than in the Computers container, select the appropriate container.\)  
  
3.  In the details pane, double\-click the GPO membership group to which you want to add computers.  
  
4.  Select the **Members** tab, and then click **Add**.  
  
5.  Type the name of the computer in the text box, and then click **OK**.  
  
6.  Repeat steps 5 and 6 for each additional computer account or group that you want to add.  
  
7.  Click **OK** to close the group properties dialog box.  
  
8.  Restart the client computers that were added to the membership groups. Changes in group membership do not take effect until after the computer is restarted.  
  
### To force a GPO update on the test computers  
  
1.  For a computer that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], Windows 7, [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)], open an elevated command prompt, and then type the following command:  
  
    ```  
    gpupdate /target:computer /force  
    ```  
  
2.  For a computer that is running Windows Server 2003 or Windows XP, open a command prompt, and then type the following command:  
  
    ```  
    gpupdate /target:computer /force  
    ```  
  
### To verify the GPO application on the test computers  
  
1.  For a computer that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], Windows 7, [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)], open an elevated command prompt, and then type the following command:  
  
    ```  
    gpresult /r /scope:computer  
    ```  
  
2.  For a computer that is running Windows Server 2003 or Windows XP, open a command prompt, and then type the following command:  
  
    ```  
    gpresult /scope:computer  
    ```  
  
