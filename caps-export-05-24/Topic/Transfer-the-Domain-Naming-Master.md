---
title: Transfer the Domain Naming Master
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 9fcc1312-f25e-4fc0-9e4d-7922937ac235
author: Femila
---
# Transfer the Domain Naming Master
  You can use this procedure to transfer the domain naming operations master role if the domain controller that currently hosts the role is inadequate, has failed, or is being decommissioned. The domain naming master is a forest\-wide operations master \(also known as flexible single master operations or FSMO\) role.  
  
 Before you perform this procedure, you must identify the domain controller to which you will transfer the domain naming operations master role.  
  
> [!NOTE]  
>  You perform this procedure by using a Microsoft Management Console \(MMC\) snap\-in, although you can also transfer this role by using Ntdsutil.exe. For information about using Ntdsutil.exe to transfer operations master roles, see Ntdsutil \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=120970](http://go.microsoft.com/fwlink/?LinkId=120970)\). For information about the **ntdsutil** command, you can also type **?** at the Ntdsutil.exe command prompt.  
  
 Membership in **Enterprise Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To transfer the domain naming master  
  
1.  Open Active Directory Domains and Trusts: On the **Start** menu, point to **Administrative Tools**, and then click **Active Directory Domains and Trusts**. If the **User Account Control** dialog box appears, provide Enterprise Admins credentials, if required, and then click **Continue**.  
  
2.  In the console tree, right\-click **Active Directory Domains and Trusts**, and then click **Change Active Directory Domain Controller**.  
  
3.  Ensure that the correct domain name is entered in **Look in this domain**.  
  
     The available domain controllers from this domain are listed.  
  
4.  In the **Name** column, click the domain controller to which you want to transfer the domain naming master role, and then click **OK**.  
  
5.  At the top of the console tree, right\-click **Active Directory Domains and Trusts**, and then click **Operations Master**.  
  
6.  The name of the current domain naming master appears in the first text box. The domain controller to which you want to transfer the domain naming master role should appear in the second text box. If this is not the case, repeat steps 1 through 4.  
  
7.  Click **Change**. To confirm the role transfer, click **Yes**. Click **OK** again to close the message box indicating that the transfer took place. Click **Close** to close the **Operations Master** dialog box.  
  
  