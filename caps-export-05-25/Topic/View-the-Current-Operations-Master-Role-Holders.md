---
title: View the Current Operations Master Role Holders
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: d7fcc73a-2dfd-4ba4-a268-15413acf7f89
author: Femila
---
# View the Current Operations Master Role Holders
  To view the current operations master \(also known as flexible single master operations or FSMO\) role holders, use the Ntdsutil.exe command\-line tool with the **roles** option. This option displays a list of all current role holders.  
  
 After you transfer an operations master role, use this procedure to verify that the transfer has occurred successfully throughout the domain. To have full effect, the change must replicate to all domain controllers in the domain for a domain\-level role and to all domain controllers in the forest for a forest\-level role.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To view the current operations master role holders  
  
1.  Open Ntdsutil as an administrator: Click **Start**, and then, in **Start Search**, type **ntdsutil**. At the top of the **Start** menu, right\-click **ntdsutil**, and then click **Run as administrator**. In the **User Account Control** dialog box, provide Domain Admins credentials, and then click **OK**.  
  
2.  At the `ntdsutil:` prompt, type `roles`, and then press ENTER.  
  
3.  At the `fsmo maintenance:` prompt, type `connections`, and then press ENTER.  
  
4.  At the `server connections:` prompt, type `connect to server <servername>`, where `<servername>` is the name of the domain controller that belongs to the domain that contains the operations masters.  
  
5.  After you receive confirmation of the connection, type `quit`, and then press ENTER to exit this menu.  
  
6.  At the `fsmo maintenance:` prompt, type `select operation target`, and then press ENTER.  
  
7.  At the select operations target: prompt, type `list roles for connected server`, and then press ENTER.  
  
     The system responds with a list of the current roles and the Lightweight Directory Access Protocol \(LDAP\) name of the domain controllers that are currently assigned to host each role.  
  
8.  Type `quit`, and then press ENTER to exit each prompt in Ntdsutil.exe. At the `ntdsutil:` prompt, type `quit`, and then press ENTER to close the window.  
  
  