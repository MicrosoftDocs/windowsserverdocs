---
title: Install an Additional Domain Controller by Using Installation Media
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 755dc3ec-ff62-4406-8c4b-3acd5c23eb11
author: Femila
---
# Install an Additional Domain Controller by Using Installation Media
  You can use this procedure to install Active Directory Domain Services \(AD DS\) from media. You can use the install from media \(IFM\) method to create an additional domain controller in an existing domain.  
  
 When you create an additional domain controller in the domain, you can specify sourcing the installation from the shared folder or removable media where you created the installation media by using one of the following methods:  
  
-   Windows interface: Provide the location on the **Install from Media** page in the Active Directory Domain Services Installation Wizard.  
  
-   Unattended installation: Use the **\/ReplicationSourcePath** parameter in the answer file for an unattended installation.  
  
-   Command line: Use the **\/ReplicationSourcePath** unattend parameter at the command line.  
  
 Membership in the **Domain Admins** group in the domain into which you are installing the additional domain controller, or the equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To install AD DS from IFM media by using the Windows interface  
  
1.  Use the procedure [Install an Additional Domain Controller by Using the Windows Interface](../Topic/Install-an-Additional-Domain-Controller-by-Using-the-Windows-Interface.md). In step 8, select **Use advanced mode installation**.  
  
2.  In step 15, select the install from media option and provide the location of the installation media.  
  
3.  Complete the remaining pages of the Active Directory Domain Services Installation Wizard.  
  
4.  After the installation operation completes successfully and the computer is restarted, remove the folder that contains the IFM media from the local disk.  
  
### To install AD DS from IFM media by using an answer file  
  
1.  Create an answer file by using one of the following methods:  
  
    -   During the procedure [Install an Additional Domain Controller by Using the Windows Interface](../Topic/Install-an-Additional-Domain-Controller-by-Using-the-Windows-Interface.md), select the **Export settings** option to save the installation settings to a file. This file is an answer file that you can use to install an additional domain controller in the same domain.  
  
    -   Use the procedure [Create an Answer File for Unattended Domain Controller Installation](../Topic/Create-an-Answer-File-for-Unattended-Domain-Controller-Installation.md) to create an answer file. Include the **\/ReplicationSourcePath** parameter to specify the location of the IFM media.  
  
2.  Use the procedure [Install an Additional Domain Controller by Using an Answer File](../Topic/Install-an-Additional-Domain-Controller-by-Using-an-Answer-File.md) to install AD DS.  
  
### To install AD DS from IFM media by using unattend parameters from the command line  
  
1.  Use the procedure [Install an Additional Domain Controller by Using Unattend Parameters from the Command Line](../Topic/Install-an-Additional-Domain-Controller-by-Using-Unattend-Parameters-from-the-Command-Line.md) to install AD DS.  
  
2.  During the procedure, use the **\/ReplicationSourcePath** parameter to specify the location of the IFM media.  
  
## See Also  
 [Preparing for Active Directory Installation](../Topic/Preparing-for-Active-Directory-Installation.md)   
 [Verifying Active Directory Installation](../Topic/Verifying-Active-Directory-Installation.md)  
  
  