---
title: Seize the Operations Master Role
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 5346d06e-1df9-4449-893f-e524040e428c
author: Femila
---
# Seize the Operations Master Role
  You can use the Ntdsutil.exe command\-line tool to transfer and seize any operations master \(also known as flexible single master operations or FSMO\) role. You must use Ntdsutil.exe to seize the schema operations master, domain naming operations master, and relative ID \(RID\) operations master roles. When you use Ntdsutil.exe to seize an operations master role, the tool first attempts a transfer from the current role owner. If the current role owner is not available, the tool seizes the role.  
  
 When you use Ntdsutil.exe to seize an operations master role, the procedure is nearly identical for all roles. There is a minor change in the command syntax for versions of Ntdsutil.exe that run on [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], as noted in the following table. For more information about using Ntdsutil.exe, type **?** at the **ntdsutil:** command prompt.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To seize an operations master role  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Continue**.  
  
2.  At the command prompt, type `ntdsutil`, and then press ENTER.  
  
3.  At the `ntdsutil:` prompt, type `roles`, and then press ENTER.  
  
4.  At the `fsmo maintenance:` prompt, type `connections`, and then press ENTER.  
  
5.  At the `server connections:` prompt, type `connect to server` `<servername>` \(where `<servername>` is the name of the domain controller that will assume the operations master role\), and then press ENTER.  
  
6.  After you receive confirmation of the connection, type `quit`, and then press ENTER.  
  
7.  Depending on the role that you want to seize, at the `fsmo maintenance:` prompt, type the appropriate command, and then press ENTER.  
  
    |Role|Credentials|Command|  
    |----------|-----------------|-------------|  
    |Domain naming master|Enterprise Admins|For [!INCLUDE[group2003](../Token/group2003_md.md)]: **Seize domain naming master**<br /><br /> For [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]: **Seize naming master**|  
    |Schema master|Schema Admins|Seize schema master|  
    |Infrastructure master|Domain Admins|Seize infrastructure master|  
    |Primary domain controller \(PDC\) emulator|Domain Admins|Seize pdc|  
    |RID master|Domain Admins|Seize rid master|  
  
     The system asks for confirmation. It then attempts to transfer the role. When the transfer fails, some error information appears and the system proceeds with the seizure of the role. After the seizure of the role is complete, a list of the roles and the Lightweight Directory Access Protocol \(LDAP\) name of the server that currently holds each role appears.  
  
     During seizure of the relative ID \(RID\) operations master role, the current role holder attempts to synchronize with its replication partners. If it cannot establish a connection with a replication partner during the seizure operation, it displays a warning and asks for confirmation that you want the seizure of the role to proceed. Click **Yes** to proceed.  
  
8.  Type `quit`, and then press ENTER. Type `quit` again, and then press ENTER to exit Ntdsutil.exe.  
  
  