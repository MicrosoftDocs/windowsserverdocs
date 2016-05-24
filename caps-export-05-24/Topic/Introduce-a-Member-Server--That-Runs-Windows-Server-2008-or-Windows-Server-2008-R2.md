---
title: Introduce a Member Server  That Runs Windows Server 2008 or Windows Server 2008 R2
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 6f0c766d-661b-4fd6-8192-6a76d56ff530
author: Femila
---
# Introduce a Member Server  That Runs Windows Server 2008 or Windows Server 2008 R2
You can upgrade your Active Directory environment in the following ways:  
  
-   Introduce newly installed domain controllers that run [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] into the forest, and then retire or upgrade all existing domain controllers.  
  
-   Perform an in\-place upgrade of all existing domain controllers.  
  
    > [!IMPORTANT]  
    > If you want to upgrade the operating system of a Windows 2000 domain controller to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you must first perform an in\-place upgrade of a Windows 2000 operating system to a Windows Server 2003 operating system. Then, perform an in\-place upgrade of this Windows Server 2003 operating system to a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] operating system. A direct Windows 2000–to–[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] operating system upgrade is not supported.  
  
    The information in this guide also applies to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. If you perform an in\-place upgrade of the existing domain controllers running Windows Server 2003 in the forest to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], remember that [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] is an x64\-based operating system. If your server is running an x64\-based version of Windows Server 2003, you can successfully perform an in\-place upgrade of this computer's operating system to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. If your server is running an x86\-based version of Windows Server 2003, you cannot upgrade this computer to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
Use the following procedure to introduce a member server that runs [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] into your environment.  
  
Membership in the local **Administrator** account, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To install Windows Server 2008 or Windows Server 2008 R2  
  
1.  Insert the operating system DVD into the DVD drive, and then select the option to install the operating system.  
  
    As an alternative, you can use an unattended installation method.  
  
2.  Use the NTFS file system to format the partitions.  
  
    Enter the computer name, static IP address, and subnet mask that are specified by your design. Enter a strong administrator password.  
  
3.  Enable Remote Desktop to enable administrators to log on remotely, if necessary.  
  
    To enable Remote Desktop, in **Server Manager**, click **Configure Remote Desktop**, and then click **Allow connections from computers running any version of Remote Desktop \(less secure\)** or **Allow connections only from computers running Remote Desktop with Network Level Authentication \(more secure\)**.  
  
You can introduce this member server to any domain in the forest. However, if your forest root domain is a dedicated root, introduce the member server into the forest root domain. Placing this member server into a dedicated root domain has the lowest impact on your environment because users generally do not log on to a dedicated forest root domain. Therefore, user authentications are minimal.  
  
After you prepare your forest and domains for the upgrade \(see [Prepare Your Infrastructure for Upgrade](../Topic/Prepare-Your-Infrastructure-for-Upgrade.md)\), install AD DS on the new member server \(see [Install Active Directory Domain Services on the Member Server  That Runs Windows Server 2008 or Windows Server 2008 R2](../Topic/Install-Active-Directory-Domain-Services-on-the-Member-Server--That-Runs-Windows-Server-2008-or-Windows-Server-2008-R2.md)\).  
  
