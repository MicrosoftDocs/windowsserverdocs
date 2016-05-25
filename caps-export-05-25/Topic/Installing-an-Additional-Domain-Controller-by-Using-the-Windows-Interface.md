---
title: Installing an Additional Domain Controller by Using the Windows Interface
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: c33ba005-b583-40cb-b7f5-311567cb7679
author: Femila
---
# Installing an Additional Domain Controller by Using the Windows Interface
  The Windows interface provides two wizards that guide you through the process of installing Active Directory Domain Services \(AD DS\). The first wizard is the Add Roles Wizard, which you can access in Server Manager. The second wizard is the Active Directory Domain Services Installation Wizard, which you can access in the following ways:  
  
-   When you complete the Add Roles Wizard in Server Manager, click the link to start the Active Directory Domain Services Installation Wizard.  
  
-   Click **Start**, click **Run**, type **dcpromo.exe**, and then click **OK**.  
  
 If you use the advanced options in the Active Directory Domain Services Installation Wizard, you can control how AD DS is installed on the server, either by installation from media \(IFM\) or by replication:  
  
-   IFM: You can provide a location for installation media that you have created by using Ntdsutil.exe or that you have created by restoring a critical\-volume backup of a similar domain controller in the same domain to an alternate location. If you create the installation media by using Ntdsutil, you have the option to create secure installation media for a read\-only domain controller \(RODC\). In this case, the Ntdsutil process removes cached secrets \(such as passwords\) from the installation media. For information about using IFM to install an RODC, see Planning and Deploying Read\-Only Domain Controllers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=120840](http://go.microsoft.com/fwlink/?LinkId=120840)\). You can also create installation media by restoring an Active Directory backup to an alternate location. For information about creating installation media by restoring a critical\-volume backup to an alternate location, see Restoring a Critical\-Volume Backup to an Alternate Location \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=120612](http://go.microsoft.com/fwlink/?LinkId=120612)\).  
  
-   Replication: You can specify a domain controller in the domain from which to replicate AD DS.  
  
 To complete this task, perform one of the following procedures:  
  
-   [Install an Additional Domain Controller by Using the Windows Interface](../Topic/Install-an-Additional-Domain-Controller-by-Using-the-Windows-Interface.md)  
  
## See Also  
 [Installing an Additional Domain Controller by Using Unattend Parameters](../Topic/Installing-an-Additional-Domain-Controller-by-Using-Unattend-Parameters.md)   
 [Installing an Additional Domain Controller by Using Unattend Parameters](../Topic/Installing-an-Additional-Domain-Controller-by-Using-Unattend-Parameters.md)  
  
  