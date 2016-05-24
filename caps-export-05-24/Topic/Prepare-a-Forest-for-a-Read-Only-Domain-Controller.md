---
title: Prepare a Forest for a Read-Only Domain Controller
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 326d19da-0157-4518-abe4-7aeab27e20b7
author: Femila
---
# Prepare a Forest for a Read-Only Domain Controller
  Before you can install a read\-only domain controller \(RODC\) in a Windows Server 2003 forest or in a forest in which you have upgraded the domain controller to Windows Server 2008 or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], you must prepare the forest by running the **adprep \/rodcprep** command. You can run **adprep \/rodcprep** from the installation DVD on any computer in the forest. In [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], Adprep.exe is located in the \/Sources\/adprep folder of the operating system installation DVD. In [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], Adprep.exe is located in the \/Support\/adprep folder.  
  
 This operation runs remotely. It contacts the infrastructure master for each domain and for each application directory partition to update the permissions. This includes the infrastructure master for the two default Domain Name System \(DNS\) application directory partitions \(ForestDNSZones and DomainDNSZones\) that are created in an Active Directory–integrated DNS environment. For a list of specific operations that are performed when you prepare a forest for an RODC, see [Windows Server 2008: Read-Only Domain Controller Updates](../Topic/Windows-Server-2008--Read-Only-Domain-Controller-Updates.md).  
  
 If you are attempting to run **adprep \/rodcprep** in an isolated environment, the infrastructure master for each domain and for each application directory partition must be available within the environment for the operation to succeed. This requirement can cause **adprep** to generate an error if, for example, the infrastructure master for an application directory partition is offline or if it has been forcefully removed from a domain without metadata cleanup being performed. For more information about how to resolve such errors, see article 949257 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=114419](http://go.microsoft.com/fwlink/?LinkId=114419)\).  
  
 You have to run this command only once in the forest. However, you can rerun this command any time if it fails to complete successfully because an infrastructure master is not available.  
  
 Use the following procedure to prepare a forest for an RODC.  
  
 **Administrative credentials**  
  
 To perform this procedure, you must be a member of the Enterprise Admins group.  
  
### To prepare a forest for an RODC  
  
1.  Log on to any computer in the forest as a member of the Enterprise Admins group.  
  
2.  Insert the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] DVD into the CD or DVD drive.  
  
3.  Click **Start**, right\-click **Command prompt**, and then click **Run as administrator**.  
  
4.  If you are using the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] DVD, type the following command, and then press ENTER:  
  
     `D:\sources\adprep\adprep /rodcprep`  
  
     If you are using the [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] DVD, type the following command, and then press ENTER:  
  
    > [!IMPORTANT]  
    >  [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] includes 32\-bit and 64\-bit versions of Adprep.exe. The 64\-bit version runs by default. If you want to run one of the Adprep.exe commands on a 32\-bit computer, use the 32\-bit version of Adprep.exe \(Adprep32.exe\).  
  
     `D:\support\adprep\adprep /rodcprep`  
  
     Where D: is the drive letter of your CD or DVD drive.  
  
5.  Allow the operation to complete, and then allow the changes to replicate throughout the forest before you try to install an RODC.  
  
  