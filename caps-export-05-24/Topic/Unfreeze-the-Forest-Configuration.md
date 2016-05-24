---
title: Unfreeze the Forest Configuration
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 2e387fa1-2d5c-4349-bcd0-135a370aeb40
author: Femila
---
# Unfreeze the Forest Configuration
  You can use this procedure to unfreeze the forest configuration after a domain rename operation. After you generated the domain rename instructions \(see [Generate Domain Rename Instructions](../Topic/Generate-Domain-Rename-Instructions.md)\), your forest configuration was frozen with respect to certain types of changes. In this frozen configuration, addition or removal of domains, addition or removal of domain controllers \(DCs\), and addition or removal of trusts were not allowed within the forest. For more information, see [Freeze the Forest Configuration](../Topic/Freeze-the-Forest-Configuration.md).  
  
 In this procedure, you use the **rendom** command to unfreeze the forest so that changes that were not allowed can once again be made.  
  
> [!IMPORTANT]  
>  All the procedures in [Run Domain Rename Instructions](../Topic/Run-Domain-Rename-Instructions.md), including the automatic domain controller restart, must have been completed on all domain controllers in the renamed domains.  
  
 Membership in the **Enterprise Admins** group in the target forest \(with write access to the Partitions container object\) is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
> [!NOTE]  
>  You can use credentials other than the credentials with which you are currently logged on. To use alternative credentials, use the **\/user** and **\/pwd** command\-line switches of **Rendom**, as described in [Appendix A: Command-Line Syntax for the Rendom Tool](../Topic/Appendix-A--Command-Line-Syntax-for-the-Rendom-Tool.md).  
  
### To unfreeze the forest configuration  
  
1.  Restart the control station computer twice to ensure that all services that are running on it learn of the new name \(Domain Name System \(DNS\) name or NetBIOS name\) of the domain of which the control station is a member. Do not restart the control station by turning its power off and then back on.  
  
2.  On the control station, click **Start**, click **Run**, type **cmd**, and then click **OK**.  
  
3.  At the command prompt, type the following command to change to the working directory, and then press ENTER:  
  
    ```  
    C:\domren  
    ```  
  
4.  From within the working directory, type the following command, and then press ENTER:  
  
    ```  
    rendom /end  
    ```  
  
     The **rendom \/end** command connects to the domain controller that holds the domain naming operations master role and removes the attribute **msDS\-UpdateScript** on the Partitions container.  
  
  