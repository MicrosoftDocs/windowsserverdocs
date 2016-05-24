---
title: Install an Additional Domain Controller by Using an Answer File
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: d21cb087-f425-46b1-a211-55df97796e7a
author: Femila
---
# Install an Additional Domain Controller by Using an Answer File
  You can use this procedure to install an additional domain controller in an existing domain. To perform this procedure, you must have created an answer file. You can create an answer file automatically when you install a domain controller using the Active Directory Domain Services Installation Wizard by selecting the option to export the installation information to a file. For information about creating an answer file manually, see [Create an Answer File for Unattended Domain Controller Installation](../Topic/Create-an-Answer-File-for-Unattended-Domain-Controller-Installation.md).  
  
> [!NOTE]  
>  You can also use an answer file to create a new domain.  
  
 After you create the answer file, use the following procedure to perform the unattended installation. You can use this procedure to install Active Directory Domain Services \(AD DS\) on either a full installation of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or a Server Core installation of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To install a new domain controller by using an answer file  
  
-   Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, if required, and then click **Continue**.  
  
-   At the command prompt, type the following command, and then press ENTER:  
  
     `dcpromo /unattend:"<path to the answer file>"`  
  
## See Also  
 [Preparing for Active Directory Installation](../Topic/Preparing-for-Active-Directory-Installation.md)   
 [Create an Answer File for Unattended Domain Controller Installation](../Topic/Create-an-Answer-File-for-Unattended-Domain-Controller-Installation.md)   
 [Verifying Active Directory Installation](../Topic/Verifying-Active-Directory-Installation.md)  
  
  