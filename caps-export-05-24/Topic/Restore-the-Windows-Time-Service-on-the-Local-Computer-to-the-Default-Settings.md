---
title: Restore the Windows Time Service on the Local Computer to the Default Settings
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: f715b315-d225-4d49-8389-b12443615e5c
author: Femila
---
# Restore the Windows Time Service on the Local Computer to the Default Settings
  You can use this procedure to restore the Windows Time service \(W32time\) on the local computer to the default settings. If you are experiencing a problem, returning to the default settings might be more efficient than troubleshooting the problem.  
  
> [!NOTE]  
>  The following procedure uses the **w32tm** command\-line tool. For more information about the **w32tm** command, type **w32tm \/?** at a command prompt or see Windows Time Service Tools and Settings \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=112116](http://go.microsoft.com/fwlink/?LinkId=112116)\).  
  
 Membership in the local **Administrators** group, or equivalent, is the minimum required to complete this procedure locally. Membership in **the Domain Admins** group, or equivalent, is the minimum required to complete this procedure remotely. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To restore the Windows Time service on the local computer to the default settings  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Continue**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    net stop w32time  
    ```  
  
3.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    w32tm /unregister  
    ```  
  
4.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    w32tm /register  
    ```  
  
5.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    net start w32time  
    ```  
  
  