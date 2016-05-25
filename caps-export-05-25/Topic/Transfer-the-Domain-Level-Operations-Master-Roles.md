---
title: Transfer the Domain-Level Operations Master Roles
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: f585bc32-5d96-4bd0-acbe-886fa06d0ead
author: Femila
---
# Transfer the Domain-Level Operations Master Roles
  You can use this procedure to transfer the following three domain\-level operations master \(also known as flexible single master operations or FSMO\) roles:  
  
-   Primary domain controller \(PDC\) emulator operations master  
  
-   Relative ID \(RID\) operations master  
  
-   Infrastructure operations master  
  
 You might want to transfer a domain\-level operations master role if the domain controller that currently hosts the role is inadequate, has failed, or is being decommissioned. You can transfer all domain roles by using the Active Directory Users and Computers snap\-in.  
  
> [!NOTE]  
>  You perform these procedures by using a Microsoft Management Console \(MMC\) snap\-in, although you can also transfer these roles by using Ntdsutil.exe. For information about using Ntdsutil.exe to transfer the operations master roles, see Ntdsutil \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=120970](http://go.microsoft.com/fwlink/?LinkID=120970).\) For information about the **ntdsutil** command, can also type **?** at the Ntdsutil.exe command prompt.  
  
 Before you perform this procedure, you must identify the domain controller to which you will transfer the operations master role.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To transfer a domain\-level operations master role  
  
1.  Open Active Directory Users and Computers: On the **Start** menu, point to **Administrative Tools**, and then click **Active Directory Users and Computers**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, if required, and then click **Continue**.  
  
2.  At the top of the console tree, right\-click **Active Directory Users and Computers**, and then click **Change Active Directory Domain Controller**.  
  
3.  Ensure that the correct domain name is entered in **Look in this domain**.  
  
     The available domain controllers from this domain are listed.  
  
4.  In the **Name** column, click the name of the domain controller to which you want to transfer the role, and then click **OK**.  
  
5.  At the top of the console tree, right\-click **Active Directory Users and Computers**, click **All Tasks**, and then click **Operations Masters**.  
  
     The name of the current operations master role holder appears in the **Operations master** box. The name of the domain controller to which you want to transfer the role appears in the lower box.  
  
6.  Click the tab for the operations master role that you want to transfer: **RID**, **PDC**, or **Infrastructure**. Verify the computer names that appear, and then click **Change**. Click **Yes** to transfer the role, and then click **OK**.  
  
7.  Repeat steps 5 and 6 for each role that you want to transfer.  
  
  