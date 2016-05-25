---
title: Installing an Additional Domain Controller
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: dc4dfacc-7771-4a31-8113-6e57c090987b
author: Femila
---
# Installing an Additional Domain Controller
  This topic explains how to install an additional Active Directory domain controller in an existing domain. The steps apply to domain controllers that run [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. If the domain controller that you plan to install will be the first that runs [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] in your domain or forest, you need to prepare the domain before you can install the domain controller. Otherwise, follow the links later in this topic for the different methods \(using the GUI, command\-line, or an answer file\) to install the new domain controller.  
  
 To prepare the domain and forest, you need to run Adprep.exe \(or adprep32.exe\) commands. If you want to understand all the details about what Adprep.exe does, see [Running Adprep.exe](http://go.microsoft.com/fwlink/?LinkID=142597) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=142597\).  The Adprep commands that need to be completed are:  
  
-   If you are installing the first [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controller in the forest, run the **adprep \/forestprep** command on the server that holds the schema master operations master \(also known as flexible single master operations or FSMO\) role. For more information, see [Prepare a Windows 2000 or Windows Server 2003 Forest Schema for a Domain Controller That Runs Windows Server 2008 or Windows Server 2008 R2](../Topic/Prepare-a-Windows-2000-or-Windows-Server-2003-Forest-Schema-for-a-Domain-Controller-That-Runs-Windows-Server-2008-or-Windows-Server-2008-R2.md).  
  
-   If you are installing the first [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controller in the domain, run the **adprep \/domainprep \/gpprep** command on the server that holds the infrastructure operations master role. For more information, see [Prepare a Windows 2000 or Windows Server 2003 Domain for a Domain Controller That Runs Windows Server 2008 or Windows Server 2008 R2](../Topic/Prepare-a-Windows-2000-or-Windows-Server-2003-Domain-for-a-Domain-Controller-That-Runs-Windows-Server-2008-or-Windows-Server-2008-R2.md).  
  
-   If you are installing the first read\-only domain controller \(RODC\) in the domain, run the **adprep \/rodcprep** command on any computer in the forest. For more information, see [Prepare a Forest for a Read-Only Domain Controller](../Topic/Prepare-a-Forest-for-a-Read-Only-Domain-Controller.md).  
  
 Use one of the following procedures as necessary to install an additional domain controller that runs [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] in an existing domain:  
  
-   [Installing an Additional Domain Controller by Using the Graphical User Interface &#40;GUI&#41;](../Topic/Installing-an-Additional-Domain-Controller-by-Using-the-Graphical-User-Interface--GUI-.md)  
  
-   [Installing an Additional Domain Controller by Using the Command Line](../Topic/Installing-an-Additional-Domain-Controller-by-Using-the-Command-Line.md)  
  
-   [Installing an Additional Domain Controller by Using an Answer file](../Topic/Installing-an-Additional-Domain-Controller-by-Using-an-Answer-file.md)  
  
> [!NOTE]  
>  Regardless of which method you use, you must be a member of the Domain Admins group in the domain that is being installed.  
  
 You also have the option to use the install from media \(IFM\) method of installation. For this option, you must have prepared installation media, either by using the improved Ntdsutil.exe command\-line tool or, if necessary, from a restored backup of a domain controller in the same domain. For information about using IFM to install a domain controller in an existing domain, see [Installing AD DS from Media_deleted](../Topic/Installing-AD-DS-from-Media_deleted.md).  
  
> [!NOTE]  
>  By default, when a domain controller account is added to the existing Active Directory domain, it is assigned an "Account Ops\-FC" access control entry \(ACE\) that gives members of the Account Operators group full control over this domain controller account, which is not a recommended configuration. For example, members of Account Operators group will be able to reset this domain controller’s password. Because the Account Operators group has significant power in the domain, we recommend that you add members to it with caution. For a detailed description of the Account Operators group, see Default groups \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=131422](http://go.microsoft.com/fwlink/?LinkID=131422)\). To modify permissions for Account Operators on a computer account, you can use the Active Directory Users and Computers snap\-in and complete the following steps:  
>   
>  1.  To open Active Directory Users and Computers, click **Start**, click **Administrative Tools**, and then click **Active Directory Users and Computers**.  
> 2.  In the console tree, right\-click the affected domain controller account, and then click **Properties**.  
> 3.  On the **Security** tab, select **Account Operators** in the **Group or user names** list, and then modify permissions according to the specifications of your environment.  
  
  