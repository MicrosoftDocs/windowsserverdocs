---
title: Prepare a Windows 2000 or Windows Server 2003 Forest Schema for a Domain Controller That Runs Windows Server 2008 or Windows Server 2008 R2
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 1d502209-cdb9-4e13-9a6c-57ad6c9d1e8b
author: Femila
---
# Prepare a Windows 2000 or Windows Server 2003 Forest Schema for a Domain Controller That Runs Windows Server 2008 or Windows Server 2008 R2
  Before you can add a domain controller that is running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] to an Active Directory environment running Windows 2000 Server or Windows Server 2003, you must update the Active Directory schema. To update the schema, you must run Adprep.exe from the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] installation DVD on your existing domain controller that hosts the schema operations master role. In [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], Adprep.exe is located in the \/Sources\/adprep folder of the operating system installation DVD. In [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], adprep.exe is located in the \/Support\/adprep folder.  
  
 Review the list of operations that are performed by Adprep.exe, and test the schema updates in a lab environment to ensure that they will not conflict with any applications that run in your environment. There should not be any conflicts if your applications use Request for Comments \(RFC\)–compliant object and attribute definitions. For a list of specific operations that are performed when you update the Active Directory schema, see [Windows Server 2008: Appendix of Changes to Adprep.exe to Support AD DS](../Topic/Windows-Server-2008--Appendix-of-Changes-to-Adprep.exe-to-Support-AD-DS.md) and [Windows Server 2008 R2: Appendix of Changes to Adprep.exe to Support AD DS](../Topic/Windows-Server-2008-R2--Appendix-of-Changes-to-Adprep.exe-to-Support-AD-DS.md).  
  
 After you prepare the forest, prepare any domain where you plan to install a domain controller that runs [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. For more information, see [Prepare a Windows 2000 or Windows Server 2003 Domain for a Domain Controller That Runs Windows Server 2008 or Windows Server 2008 R2](../Topic/Prepare-a-Windows-2000-or-Windows-Server-2003-Domain-for-a-Domain-Controller-That-Runs-Windows-Server-2008-or-Windows-Server-2008-R2.md).  
  
 If you are creating a new forest, you do not have to prepare the schema or any of the domains in the forest.  
  
 Use the following procedure to update the Windows Server 2003 or Windows 2000 Server Active Directory schema for [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
 **Administrative credentials**  
  
 To perform this procedure, you must use an account that has membership in all of the following groups:  
  
-   Enterprise Admins  
  
-   Schema Admins  
  
-   Domain Admins for the domain that contains the schema master  
  
### To prepare the forest schema for Windows Server 2008 or Windows Server 2008 R2  
  
1.  Log on to the schema master as a member of the Enterprise Admins, Schema Admins, and Domain Admins groups.  
  
    > [!NOTE]  
    >  If you are unsure which domain controller hosts the schema master role, you can run **netdom query fsmo** on any domain controller.  
  
2.  Insert the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] DVD into the CD or DVD drive.  
  
3.  Click **Start**, click **All Programs**, click **Accessories**, right\-click **Command prompt**, and then click **Run as administrator**.  
  
4.  If you are using the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] DVD, type the following command, and then press ENTER:  
  
     `D:\sources\adprep\adprep /forestprep`  
  
     If you are using the [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] DVD, type the following command, and then press ENTER:  
  
    > [!IMPORTANT]  
    >  [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] includes a 32\-bit and 64\-bit version of Adprep.exe. The 64\-bit version runs by default. If you want to run one of the Adprep.exe commands on a 32\-bit computer, use the 32\-bit version of Adprep.exe \(Adprep32.exe\).  
  
     `D:\support\adprep\adprep /forestprep`  
  
5.  Allow the operation to complete, and then allow the changes to replicate throughout the forest before you prepare any domains for a domain controller that runs [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. For more information about running **adprep \/domainprep**, see [Prepare a Windows 2000 or Windows Server 2003 Domain for a Domain Controller That Runs Windows Server 2008 or Windows Server 2008 R2](../Topic/Prepare-a-Windows-2000-or-Windows-Server-2003-Domain-for-a-Domain-Controller-That-Runs-Windows-Server-2008-or-Windows-Server-2008-R2.md).  
  
    > [!NOTE]  
    >  If you plan to add a read\-only domain controller \(RODC\) to the forest, you can run **adprep \/rodcprep** right after you run **adprep \/forestprep** and then verify that both operations have replicated throughout the forest. Both commands require Enterprise Admin credentials; therefore, you might prefer to run them consecutively.  
  
 For more information about how to troubleshoot Adprep errors, see [Troubleshooting errors with Adprep.exe](../Topic/Running-Adprep.exe.md#BKMK_TshootAdprep). For more information about running **adprep \/rodcprep**, see [Prepare a Forest for a Read-Only Domain Controller](../Topic/Prepare-a-Forest-for-a-Read-Only-Domain-Controller.md).  
  
  