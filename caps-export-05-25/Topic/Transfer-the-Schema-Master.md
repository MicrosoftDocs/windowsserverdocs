---
title: Transfer the Schema Master
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 1bd3278f-fa9f-44ff-bcbb-e2b3e7c8c744
author: Femila
---
# Transfer the Schema Master
  You can use this procedure to transfer the schema operations master role if the domain controller that currently hosts the role is inadequate, has failed, or is being decommissioned. The schema master is a forest\-wide operations master \(also known as flexible single master operations or FSMO\) role.  
  
 Before you perform this procedure, you must identify the domain controller to which you will transfer the schema operations master role.  
  
 Before you can use the Active Directory Schema snap\-in for the first time, you must register it with the system. If you have not yet prepared the Active Directory Schema snap\-in, see [Install the Schema Snap-In](../Topic/Install-the-Schema-Snap-In.md) before you begin this procedure.  
  
> [!NOTE]  
>  You perform this procedure by using a Microsoft Management Console \(MMC\) snap\-in, although you can also transfer this role by using Ntdsutil.exe. For information about using Ntdsutil.exe to transfer operations master roles, see Ntdsutil \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=120970](http://go.microsoft.com/fwlink/?LinkId=120970)\). For information about the **ntdsutil** command, you can type **?** at the Ntdsutil.exe command prompt.  
  
 Membership in **Schema Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### Transfer the schema master  
  
1.  Open the Active Directory Schema snap\-in.  
  
2.  In the console tree, right\-click **Active Directory Schema**, and then click **Change Active Directory Domain Controller**.  
  
3.  In the **Change Directory Server** dialog box, under **Change to**, click **This domain Controller or AD LDS instance**.  
  
4.  In the list of domain controllers, click the name of the domain controller to which you want to transfer the schema master role, and then click **OK**.  
  
5.  In the console tree, right\-click **Active Directory Schema**, and then click **Operations Master**. The **Change Schema Master** box displays the name of the server that is currently holding the schema master role. The targeted domain controller is listed in the second box.  
  
6.  Click **Change**. Click **Yes** to confirm your choice. The system confirms the operation. Click **OK** again to confirm that the operation succeeded.  
  
7.  Click **Close** to close the **Change Schema Master** dialog box.  
  
  