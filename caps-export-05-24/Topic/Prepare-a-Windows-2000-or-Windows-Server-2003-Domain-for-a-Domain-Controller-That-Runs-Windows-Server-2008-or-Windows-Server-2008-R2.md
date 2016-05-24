---
title: Prepare a Windows 2000 or Windows Server 2003 Domain for a Domain Controller That Runs Windows Server 2008 or Windows Server 2008 R2
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 83cd65ef-1923-448b-8f58-4c922cae04e7
author: Femila
---
# Prepare a Windows 2000 or Windows Server 2003 Domain for a Domain Controller That Runs Windows Server 2008 or Windows Server 2008 R2
  Use the following procedure to prepare a Windows 2000 or Windows Server 2003 domain for domain controllers that run [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. To prepare the domain, run Adprep.exe from the installation DVD on your existing domain controller that hosts the infrastructure master role. In [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], Adprep.exe is located in the \/Sources\/adprep folder of the operating system installation DVD. In [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], Adprep.exe is located in the \/Support\/adprep folder.  
  
 Review the list of operations that are performed by Adprep.exe and test the updates in a lab environment to ensure that they will not conflict with any applications that run in your environment. For a list of specific operations that are performed when you update the Active Directory domain, see [Windows Server 2008: Domain-Wide Updates](../Topic/Windows-Server-2008--Domain-Wide-Updates.md) and [Windows Server 2008 R2: Domain-Wide Updates](../Topic/Windows-Server-2008-R2--Domain-Wide-Updates.md).  
  
 **Administrative credentials**  
  
 To perform this procedure, you must be a member of the Domain Admins group. Membership in the Enterprise Admins group is not sufficient to perform this procedure.  
  
### To prepare a domain for Windows Server 2008 or Windows Server 2008 R2  
  
1.  Identify the domain infrastructure operations master \(also known as flexible single master operations or FSMO\) role holder as follows:  
  
    -   In the Active Directory Users and Computers snap\-in, right\-click the domain object, click **Operations Masters**, and then click **Infrastructure**.  
  
2.  Log on to the infrastructure master as a member of the Domain Admins group.  
  
3.  Insert the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] DVD into the CD or DVD drive.  
  
4.  Click **Start**, click **All Programs**, click **Accessories**, right click **Command prompt**, and then click **Run as administrator**.  
  
5.  If you are using the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] DVD, type the following command, and then press ENTER:  
  
     `D:\sources\adprep\adprep /domainprep /gpprep`  
  
     Where D: is the drive letter of your CD or DVD drive.  
  
     If you are using the [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] DVD, type the following command, and then press ENTER:  
  
    > [!IMPORTANT]  
    >  [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] includes 32\-bit and 64\-bit versions of Adprep.exe. The 64\-bit version runs by default. If you want to run one of the Adprep.exe commands on a 32\-bit computer, use the 32\-bit version of Adprep.exe \(Adprep32.exe\).  
  
     `D:\support\adprep\adprep /domainprep /gpprep`  
  
6.  Allow the operation to complete, and then allow the changes to replicate throughout the forest before you install a domain controller that runs [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
  