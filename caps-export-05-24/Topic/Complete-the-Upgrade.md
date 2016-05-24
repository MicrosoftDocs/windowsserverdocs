---
title: Complete the Upgrade
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 92e809cb-91e6-4b7d-ae7a-545d530e7b89
author: Femila
---
# Complete the Upgrade
Complete the following tasks to finalize the process:  
  
-   Review, update, and document the domain architecture to reflect any changes that you made during the domain upgrade process.  
  
-   Verify that the NETLOGON and SYSVOL shared folders exist and that the File Replication Service \(FRS\) or Distributed File Service \(DFS\) Replication is functioning without error by checking Event Viewer.  
  
-   Verify that Group Policy is being applied successfully by checking the application log in Event Viewer for Event ID 1704.  
  
-   Verify that all service \(SRV\), alias \(CNAME\), and host \(A\) resource records have been registered in Domain Name System \(DNS\).  
  
-   Verify Windows Firewall status.  
  
    > [!IMPORTANT]  
    > Although the default behavior for [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] is that Windows Firewall is turned on, if you upgrade a Windows Server 2003 computer that had Windows Firewall turned off, the firewall will remain off after the upgrade unless you turn it on using the Windows Firewall control panel.  
  
-   Continuously monitor your domain controllers and Active Directory Domain Services \(AD DS\). Using a monitoring solution \(such as Microsoft Operations Manager \(MOM\)\) to monitor distributed Active Directory Domain Services \(AD DS\)—and the services that it relies on—helps maintain consistent directory data and a consistent level of service throughout the forest.  
  
After these tasks have been completed successfully, you will have completed the in\-place upgrade process.  
  
