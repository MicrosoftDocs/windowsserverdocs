---
title: Perform Attribute Cleanup
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 97b3fdbb-3b38-455f-8472-865304392335
author: Femila
---
# Perform Attribute Cleanup
  You can use this procedure to perform attribute cleanup after a domain rename operation. This post\-domain\-rename cleanup procedure removes all values of the **msDS\-DnsRootAlias** and **msDS\-UpdateScript** attributes from Active Directory Domain Services \(AD DS\) that were written during the domain rename operation.  
  
> [!IMPORTANT]  
>  Perform this cleanup procedure only after all member computers in the renamed domains have been restarted as described in [Restart Member Computers](../Topic/Restart-Member-Computers.md). If smart card logon is used in your environment, make sure that all authentication certificates have been renewed before this step; otherwise, authentication will start to fail for the certificates.  
  
 Membership in the **Enterprise Admins** group in the target forest \(with write access to the Partitions container object and the cross\-reference objects that are its children in the configuration directory partition\) and the **Local Administrators** group \(or write access to the domain rename C:\\domren working directory\) on the control station computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
> [!NOTE]  
>  You can use credentials other than the credentials with which you are currently logged on. To use alternative credentials, use the **\/user** and **\/pwd** command\-line switches of **rendom**, as described in [Appendix A: Command-Line Syntax for the Rendom Tool](../Topic/Appendix-A--Command-Line-Syntax-for-the-Rendom-Tool.md).  
  
### To perform attribute cleanup after a domain rename  
  
1.  On the control station, click **Start**, click **Run**, type **cmd**, and then click **OK**.  
  
2.  At the command prompt, type the following command to change to the working directory, and then press ENTER:  
  
    ```  
    C:\domren  
    ```  
  
3.  From within the working directory, type the following command, and then press ENTER:  
  
    ```  
    rendom /clean  
    ```  
  
     The `rendom /clean` command removes the values for the **msDS\-DnsRootAlias** and **msDS\-UpdateScript** attributes from AD DS by connecting to the domain controller that has the domain naming operations master role.  
  
 After the steps in this procedure are complete, the new forest is ready for another domain rename \(or forest restructuring\) operation, if necessary.  
  
  